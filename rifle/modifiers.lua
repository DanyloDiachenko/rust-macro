-- Pure multiplier resolution from weapon + runtime context.
-- Attachments / posture / aim / movement live here as data tables — not separate modules.

local ATTACHMENTS = {
    scopes = {
        none = 1.0,
        holosight = 1.0,
        ["8x"] = 1.2,
        ["16x"] = 1.4,
    },
    barrels = {
        none = 1.0,
        silencer = 0.8,
        muzzle_brake = 1.0,
    },
}

-- Defaults are identity so existing curves behave like the old monolith
-- (strength-only scale). Tune per-weapon via weapon.modifiers or here.
local POSTURE = {
    stand = 1.0,
    crouch = 1.0,
    prone = 1.0,
}

local M = {}

M.ATTACHMENTS = ATTACHMENTS
M.POSTURE = POSTURE

--- Resolve final scale factor for the active weapon + context.
-- ctx: { posture, ads, moving, scope, barrel }
-- weapon.modifiers may override posture / named keys.
function M.resolve(weapon, ctx)
    ctx = ctx or {}
    local m = 1.0

    local posture = ctx.posture or "stand"
    local weaponMods = (weapon and weapon.modifiers) or {}

    if weaponMods[posture] then
        m = m * weaponMods[posture]
    else
        m = m * (POSTURE[posture] or 1.0)
    end

    local scope = ctx.scope or "none"
    m = m * (ATTACHMENTS.scopes[scope] or 1.0)
    if weaponMods.scopes and weaponMods.scopes[scope] then
        m = m * weaponMods.scopes[scope]
    end

    local barrel = ctx.barrel or "none"
    m = m * (ATTACHMENTS.barrels[barrel] or 1.0)
    if weaponMods.barrels and weaponMods.barrels[barrel] then
        m = m * weaponMods.barrels[barrel]
    end

    if ctx.ads and weaponMods.ads then
        m = m * weaponMods.ads
    end

    if ctx.moving and weaponMods.moving then
        m = m * weaponMods.moving
    end

    return m
end

return M
