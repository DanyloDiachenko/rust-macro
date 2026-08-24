local rifle = require("rifle")

rifle:init()

local stateFile = os.getenv("HOME") .. "/.hammerspoon/macro_state.json"

local function readMenuState()
    local f = io.open(stateFile, "r")
    if not f then return end
    local ok, data = pcall(hs.json.decode, f:read("*a"))
    f:close()
    if not ok or not data then return end
    if data.enabled ~= rifle.STATE.enabled then
        rifle.STATE.enabled = data.enabled
        local label = data.enabled and "ON" or "OFF"
        print("[Menu] Sync: Macros " .. label)
        hs.alert.show("Macros: " .. label, 0.8)
        if not data.enabled then rifle:stopShooting() end
    end
end

menuWatcher = hs.pathwatcher.new(stateFile, readMenuState):start()
print("[Menu] Watching " .. stateFile)

print("========================================")
print("RIFLE MACROS FOR RUST")
print("========================================")
print("Ctrl+F1        - Enable/Disable")
print("")
print("HOW CUSTOMIZE:")
print("Change sensitivity, ads_sensitivity, fov in rifle.lua")
print("")
print("Pattern automatically scales to your settings!")
print("========================================")