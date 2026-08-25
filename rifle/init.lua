-- Public API for the rifle package.
local config = require("rifle.config")
local state = require("rifle.state")
local registry = require("rifle.registry")
local profiles = require("rifle.profiles")
local engine = require("rifle.core.engine")
local hid = require("rifle.core.hid")
local input = require("rifle.core.input")

local rifle = {
    CONFIG = config,
    STATE = state,
}

local menuWatcher = nil

local function onIpcChange(key, value)
    if key == "enabled" and value == false then
        engine.stop()
    elseif key == "weapon" then
        engine.setWeapon(value)
    elseif key == "strength" or key == "posture" or key == "ads"
        or key == "moving" or key == "scope" or key == "barrel" then
        if not state.shooting then
            engine.rebuildPattern()
            if hid.connected() then
                hid.uploadPattern(state.currentPattern)
            end
        end
    end
end

local function syncFromMenu()
    local data = state.readPublic()
    if not data then return end

    local wasEnabled = state.enabled
    state.applyPublic(data)

    if data.enabled ~= nil and data.enabled ~= wasEnabled then
        local label = data.enabled and "ON" or "OFF"
        print("[Menu] " .. label)
        hs.alert.show("Assist: " .. label, 0.8)
        if not data.enabled then
            engine.stop()
        end
    end
end

function rifle:init()
    print("[rifle] starting…")

    registry.bootstrap()
    profiles.ensureDefault()

    local weapon = registry.get(config.weapon)
    if not weapon then
        local ids = registry.ids()
        if #ids > 0 then
            config.weapon = ids[1]
            weapon = registry.get(config.weapon)
        end
    end
    state.weapon = weapon

    -- Seed from menu file if present.
    local existing = state.readPublic()
    if existing then
        state.applyPublic(existing)
        if existing.weapon then
            state.weapon = registry.get(existing.weapon) or state.weapon
            config.weapon = (state.weapon and state.weapon.id) or config.weapon
        end
    end

    engine.rebuildPattern()
    hid.ensureDaemon()
    hid.startKeepalive()
    input.start()

    state.onChange(onIpcChange)

    if menuWatcher then
        menuWatcher:stop()
    end
    menuWatcher = hs.pathwatcher.new(config.stateFile, syncFromMenu):start()

    -- Initial public snapshot for the menu.
    state.writePublic()

    print(string.format(
        "[rifle] ready | weapon=%s | strength=%.2f | jitter=%.2f | hid=%s | weapons=%s",
        tostring(config.weapon),
        tonumber(config.strength) or 1,
        tonumber(config.humanJitter) or 0.10,
        tostring(state.hidAvailable),
        table.concat(registry.ids(), ",")
    ))
end

function rifle:setWeapon(id)
    return engine.setWeapon(id)
end

function rifle:setEnabled(enabled)
    state.enabled = not not enabled
    state.writePublic()
    if not state.enabled then
        engine.stop()
    end
end

function rifle:toggle()
    input.toggle()
end

function rifle:stopShooting()
    engine.stop()
end

function rifle:rebuild()
    engine.rebuildPattern()
    if hid.connected() then
        hid.uploadPattern(state.currentPattern)
    end
end

function rifle:saveProfile(name)
    return profiles.save(name)
end

function rifle:loadProfile(name)
    local ok = profiles.load(name)
    if ok then
        engine.setWeapon(config.weapon)
        if hid.connected() then
            hid.cmd(string.format("mul %.4f\n", tonumber(config.strafeMultiplier) or 1.25))
            hid.cmd(string.format("stand %.4f\n", tonumber(config.standMultiplier) or 2.0))
            hid.cmd(string.format("jit %.4f\n", tonumber(config.humanJitter) or 0.10))
        end
    end
    return ok
end

function rifle:listWeapons()
    return registry.list()
end

return rifle
