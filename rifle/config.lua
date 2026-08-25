-- User-tunable settings. Overrides can be layered via profiles.
local M = {
    debug = false,

    sensitivity = 0.6,
    fov = 90,
    dpi = 1600,
    screenResolutionHeight = 1200,

    -- Pattern scale baked into the uploaded curve; re-upload after change.
    strength = 3,
    -- While A/D is held the helper multiplies each step by this.
    strafeMultiplier = 2.25,
    -- Standing + RMB (ADS), Ctrl not held: × this. Hip-fire / crouch = 1.0.
    standMultiplier = 1.75,
    -- Per-step magnitude jitter (±). 0.10 ≈ 90% fidelity to the base curve.
    humanJitter = 0.10,

    hidDaemonPort = 49173,

    -- Active weapon id (registry key).
    weapon = "ak47",

    -- Shared IPC file with the menu app.
    stateFile = os.getenv("HOME") .. "/.hammerspoon/macro_state.json",
}

return M
