-- Scale weapon pattern × modifiers and drive start/stop via HID.
local config = require("rifle.config")
local state = require("rifle.state")
local modifiers = require("rifle.modifiers")
local registry = require("rifle.registry")
local hid = require("rifle.core.hid")

local M = {}
local focusTimer = nil

local function log(msg)
    if config.debug then
        print("[rifle] " .. msg)
    end
end

function M.isGameActive()
    local app = hs.application.frontmostApplication()
    if not app then return false end
    local name = app:name() or ""
    return name == "Rust" or name:find("RustClient", 1, true) ~= nil
end

function M.detectGameMode()
    local rustApp = hs.application.get("Rust") or hs.application.get("RustClient")
    if rustApp then
        local mainWindow = rustApp:mainWindow()
        if mainWindow then
            state.isInGameMode = mainWindow:isFullScreen()
            return
        end
    end
    state.isInGameMode = false
end

--- Load steps from a .dat file (dx dy delay per line) or pass through a table.
function M.loadPatternData(source)
    if type(source) == "table" then
        return source
    end
    if type(source) ~= "string" then
        return {}
    end

    local path = source
    if path:sub(1, 1) ~= "/" then
        path = hs.configdir .. "/" .. source
    end

    local f = io.open(path, "r")
    if not f then
        print("[rifle] pattern not found: " .. path)
        return {}
    end

    local steps = {}
    for line in f:lines() do
        local dx, dy, delay = line:match("^%s*([%-%d%.]+)%s+([%-%d%.]+)%s+([%-%d%.]+)")
        if dx then
            steps[#steps + 1] = {
                dx = tonumber(dx),
                dy = tonumber(dy),
                delay = tonumber(delay),
            }
        end
    end
    f:close()
    return steps
end

function M.modifierContext()
    return {
        posture = state.posture,
        ads = state.ads,
        moving = state.moving,
        scope = state.scope,
        barrel = state.barrel,
    }
end

--- Build scaled curve for the active weapon and stash it on state.
function M.rebuildPattern()
    local weapon = state.weapon or registry.get(config.weapon)
    if not weapon then
        print("[rifle] no weapon: " .. tostring(config.weapon))
        state.currentPattern = {}
        state.patternLength = 0
        state.patternSent = false
        return {}
    end

    local raw = M.loadPatternData(weapon.pattern)
    local strength = tonumber(config.strength) or 1.0
    if weapon.defaultStrength then
        strength = strength * (tonumber(weapon.defaultStrength) or 1.0)
    end
    local mod = modifiers.resolve(weapon, M.modifierContext())
    local multiplier = strength * mod

    log(string.format("[CALC] weapon=%s strength=%.3f mod=%.3f total=%.3f steps=%d",
        weapon.id, strength, mod, multiplier, #raw))

    local scaled = {}
    for i, step in ipairs(raw) do
        scaled[i] = {
            dx = step.dx * multiplier,
            dy = step.dy * multiplier,
            delay = step.delay,
        }
    end

    state.currentPattern = scaled
    state.patternLength = #scaled
    state.patternSent = false
    return scaled
end

function M.setWeapon(id)
    local weapon = registry.get(id)
    if not weapon then
        print("[rifle] unknown weapon: " .. tostring(id))
        return false
    end
    config.weapon = id
    state.weapon = weapon
    M.rebuildPattern()
    if hid.connected() then
        hid.uploadPattern(state.currentPattern)
    end
    state.writePublic()
    return true
end

function M.startFocusWatchdog()
    if focusTimer then
        focusTimer:stop()
    end
    focusTimer = hs.timer.new(0.1, function()
        if state.shooting and not M.isGameActive() then
            M.stop()
        end
    end)
    focusTimer:start()
end

function M.start()
    if not state.enabled or state.shooting or not M.isGameActive() then
        return
    end

    state.shooting = true

    log(string.format("run start | n=%d | hid=%s | strength=%.2f",
        state.patternLength, tostring(hid.connected()), tonumber(config.strength) or 1))

    if not state.patternSent then
        hid.uploadPattern(state.currentPattern)
    end
    hid.cmd("start\n")
    M.startFocusWatchdog()

    if not hid.connected() then
        hs.timer.doAfter(0, function()
            if not state.shooting then return end
            if not state.hidAvailable then
                hid.ensureDaemon()
            else
                hid.connect()
            end
            if state.shooting then
                hid.cmd("start\n")
            end
        end)
    end
end

function M.stop()
    if not state.shooting then
        return
    end

    state.shooting = false
    hid.cmd("stop\n")

    if focusTimer then
        focusTimer:stop()
        focusTimer = nil
    end

    log("run stop")
end

return M
