-- Copy to <id>.lua and fill in. File is ignored by registry (name starts with _).
return {
    id = "example",
    name = "Example Weapon",
    -- Path relative to hs.configdir, OR an inline { {dx=,dy=,delay=}, ... } table.
    pattern = "rifle/patterns/example/default.dat",
    defaultStrength = 1.0,
    modifiers = {
        -- stand = 1.0,
        -- crouch = 0.5,
        -- prone = 0.3,
        -- ads = 1.0,
        -- moving = 1.0,
    },
}
