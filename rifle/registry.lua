-- Weapon registry: the only place that knows how to add / look up weapons.

local M = {
    _byId = {},
    _order = {},
}

function M.register(weapon)
    assert(type(weapon) == "table", "weapon must be a table")
    assert(type(weapon.id) == "string" and weapon.id ~= "", "weapon.id required")
    assert(weapon.pattern, "weapon.pattern required (relative .dat path or step table)")

    if not M._byId[weapon.id] then
        M._order[#M._order + 1] = weapon.id
    end
    M._byId[weapon.id] = weapon
    return weapon
end

function M.get(id)
    return M._byId[id]
end

function M.list()
    local out = {}
    for _, id in ipairs(M._order) do
        out[#out + 1] = M._byId[id]
    end
    return out
end

function M.ids()
    local out = {}
    for _, id in ipairs(M._order) do
        out[#out + 1] = id
    end
    return out
end

--- Load every *.lua under rifle/weapons/ (except template names).
function M.bootstrap()
    local dir = hs.configdir .. "/rifle/weapons"
    if not hs.fs.attributes(dir) then
        print("[rifle] weapons dir missing: " .. dir)
        return
    end

    for file in hs.fs.dir(dir) do
        if file:match("%.lua$")
            and not file:match("^_")
            and file ~= "init.lua"
            and not file:match("template") then
            local modName = "rifle.weapons." .. file:gsub("%.lua$", "")
            local ok, weapon = pcall(require, modName)
            if ok and type(weapon) == "table" and weapon.id then
                M.register(weapon)
            else
                print("[rifle] skip weapon " .. tostring(file) .. ": " .. tostring(weapon))
            end
        end
    end
end

return M
