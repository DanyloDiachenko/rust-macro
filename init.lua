require("hs.ipc")

local rifle = require("rifle")

rifle:init()

-- Sync enabled state from the menu (file watcher)
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
        print("[Menu] " .. label)
        hs.alert.show("Assist: " .. label, 0.8)
        if not data.enabled then rifle:stopShooting() end
    end
end

menuWatcher = hs.pathwatcher.new(stateFile, readMenuState):start()

print("Ctrl+F1 — toggle assist")
