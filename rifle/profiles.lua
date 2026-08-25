-- Simple profile load/save (JSON under rifle/profiles/).

local config = require("rifle.config")
local state = require("rifle.state")

local M = {}

local function profilePath(name)
    name = name or "default"
    name = name:gsub("[^%w%._%-]", "")
    return hs.configdir .. "/rifle/profiles/" .. name .. ".json"
end

function M.save(name)
    name = name or state.profile or "default"
    local payload = {
        weapon = config.weapon,
        strength = config.strength,
        strafeMultiplier = config.strafeMultiplier,
        standMultiplier = config.standMultiplier,
        humanJitter = config.humanJitter,
        modifiers = {
            posture = state.posture,
            ads = state.ads,
            moving = state.moving,
            scope = state.scope,
            barrel = state.barrel,
        },
    }
    local dir = hs.configdir .. "/rifle/profiles"
    hs.fs.mkdir(dir)
    local path = profilePath(name)
    local f = io.open(path, "w")
    if not f then
        print("[rifle] cannot write profile: " .. path)
        return false
    end
    f:write(hs.json.encode(payload))
    f:close()
    state.profile = name
    return true
end

function M.load(name)
    name = name or "default"
    local path = profilePath(name)
    local f = io.open(path, "r")
    if not f then return false end
    local ok, data = pcall(hs.json.decode, f:read("*a"))
    f:close()
    if not ok or type(data) ~= "table" then return false end

    if data.weapon then config.weapon = data.weapon end
    if data.strength ~= nil then config.strength = tonumber(data.strength) or config.strength end
    if data.strafeMultiplier ~= nil then config.strafeMultiplier = tonumber(data.strafeMultiplier) end
    if data.standMultiplier ~= nil then config.standMultiplier = tonumber(data.standMultiplier) end
    if data.humanJitter ~= nil then config.humanJitter = tonumber(data.humanJitter) end

    state.applyPublic({
        weapon = config.weapon,
        strength = config.strength,
        profile = name,
        modifiers = data.modifiers,
    })
    state.profile = name
    return true
end

function M.ensureDefault()
    local path = profilePath("default")
    if not hs.fs.attributes(path) then
        M.save("default")
    end
end

return M
