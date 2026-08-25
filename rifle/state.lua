-- Runtime state + JSON IPC with the menu.
local config = require("rifle.config")

local M = {
    enabled = false,
    shooting = false,
    currentPattern = {},
    patternLength = 0,
    patternSent = false,

    originalMousePosition = nil,
    isInGameMode = false,

    hidSock = nil,
    hidAvailable = false,
    hidKeepalive = nil,

    strafeA = false,
    strafeD = false,

    -- Modifier context (updated by input / menu IPC).
    posture = "stand", -- stand | crouch | prone
    ads = false,
    moving = false,
    scope = "none",
    barrel = "none",

    weapon = nil, -- resolved weapon table
}

local listeners = {}

function M.onChange(fn)
    listeners[#listeners + 1] = fn
end

local function emit(key, value)
    for _, fn in ipairs(listeners) do
        pcall(fn, key, value)
    end
end

function M.set(key, value)
    if M[key] == value then return end
    M[key] = value
    emit(key, value)
end

--- Snapshot written to disk for the menu / external tools.
function M.toPublic()
    return {
        enabled = M.enabled,
        weapon = config.weapon,
        strength = config.strength,
        profile = M.profile or "default",
        modifiers = {
            posture = M.posture,
            ads = M.ads,
            moving = M.moving,
            scope = M.scope,
            barrel = M.barrel,
        },
    }
end

function M.writePublic()
    local path = config.stateFile
    local ok, json = pcall(hs.json.encode, M.toPublic())
    if not ok or not json then return end
    local f = io.open(path, "w")
    if not f then return end
    f:write(json)
    f:close()
end

--- Apply a public IPC payload. Returns true if anything meaningful changed.
function M.applyPublic(data)
    if type(data) ~= "table" then return false end
    local changed = false

    if data.enabled ~= nil and data.enabled ~= M.enabled then
        M.enabled = data.enabled
        changed = true
        emit("enabled", M.enabled)
    end

    if data.weapon and data.weapon ~= config.weapon then
        config.weapon = data.weapon
        changed = true
        emit("weapon", config.weapon)
    end

    if data.strength ~= nil and tonumber(data.strength) ~= config.strength then
        config.strength = tonumber(data.strength)
        changed = true
        emit("strength", config.strength)
    end

    if data.profile then
        M.profile = data.profile
    end

    local mods = data.modifiers
    if type(mods) == "table" then
        for _, key in ipairs({ "posture", "ads", "moving", "scope", "barrel" }) do
            if mods[key] ~= nil and mods[key] ~= M[key] then
                M[key] = mods[key]
                changed = true
                emit(key, M[key])
            end
        end
    end

    return changed
end

function M.readPublic()
    local f = io.open(config.stateFile, "r")
    if not f then return nil end
    local raw = f:read("*a")
    f:close()
    local ok, data = pcall(hs.json.decode, raw)
    if not ok then return nil end
    return data
end

return M
