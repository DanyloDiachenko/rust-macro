-- AK-47 weapon definition. Pattern data lives under rifle/patterns/.
return {
    id = "ak47",
    name = "AK-47",
    pattern = "rifle/patterns/ak47/default.dat",
    defaultStrength = 1.0,
    -- Optional per-weapon multiplier overrides (keys match modifiers.lua).
    modifiers = {
        -- crouch = 0.5,
        -- ads = 1.0,
    },
}
