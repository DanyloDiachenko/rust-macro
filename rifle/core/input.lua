-- Event taps: toggle, LMB spray, optional posture keys.
local config = require("rifle.config")
local state = require("rifle.state")
local engine = require("rifle.core.engine")

local M = {
    mouseTap = nil,
    mouseEventWatcher = nil,
    keyWatcher = nil,
}

local function log(msg)
    if config.debug and engine.isGameActive() then
        print("[rifle] " .. msg)
    end
end

function M.toggle()
    state.enabled = not state.enabled
    local status = state.enabled and "ON" or "OFF"
    print("[rifle] " .. status)
    hs.alert.show("Assist: " .. status, 1)
    state.writePublic()

    if not state.enabled then
        engine.stop()
    end
end

function M.setupHotkeys()
    if M.mouseTap then
        M.mouseTap:stop()
    end

    -- Mouse button 4 (buttonNumber 3) toggles assist.
    M.mouseTap = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(event)
        if event:getProperty(hs.eventtap.event.properties.mouseEventButtonNumber) == 3 then
            M.toggle()
            return true
        end
        return false
    end)
    M.mouseTap:start()
end

function M.setupMouseDetection()
    if M.mouseEventWatcher then
        M.mouseEventWatcher:stop()
    end

    M.mouseEventWatcher = hs.eventtap.new(
        {
            hs.eventtap.event.types.leftMouseDown,
            hs.eventtap.event.types.leftMouseUp,
        },
        function(event)
            if not state.enabled then return false end
            if not engine.isGameActive() then return false end

            local eventType = event:getType()

            if eventType == hs.eventtap.event.types.leftMouseDown then
                if not state.shooting then
                    state.originalMousePosition = hs.mouse.absolutePosition()
                    engine.start()
                    hs.timer.doAfter(0, function()
                        engine.detectGameMode()
                        local pos = state.originalMousePosition or { x = 0, y = 0 }
                        log(string.format("[START] Pos: %.0f,%.0f | Mode: %s",
                            pos.x, pos.y,
                            state.isInGameMode and "Game" or "Menu"))
                    end)
                end
            elseif eventType == hs.eventtap.event.types.leftMouseUp then
                if state.shooting then
                    log("Left mouse button released - stop")
                    engine.stop()
                end
            end

            return false
        end
    )
    M.mouseEventWatcher:start()
end

--- Optional: Ctrl = crouch, RMB ads is left to the helper / future hooks.
function M.setupModifierKeys()
    if M.keyWatcher then
        M.keyWatcher:stop()
    end

    M.keyWatcher = hs.eventtap.new(
        {
            hs.eventtap.event.types.flagsChanged,
            hs.eventtap.event.types.keyDown,
            hs.eventtap.event.types.keyUp,
        },
        function(event)
            if not state.enabled then return false end

            local flags = event:getFlags()
            local crouch = flags and flags.ctrl
            local nextPosture = crouch and "crouch" or "stand"
            if nextPosture ~= state.posture then
                state.posture = nextPosture
                -- Rebuild only when idle; mid-spray keeps current curve.
                if not state.shooting then
                    engine.rebuildPattern()
                end
            end

            local keyCode = event:getKeyCode()
            local isDown = event:getType() == hs.eventtap.event.types.keyDown
            -- A=0, D=2 on US layout
            if keyCode == 0 then
                state.strafeA = isDown
            elseif keyCode == 2 then
                state.strafeD = isDown
            end
            state.moving = state.strafeA or state.strafeD

            return false
        end
    )
    M.keyWatcher:start()
end

function M.start()
    M.setupHotkeys()
    M.setupMouseDetection()
    M.setupModifierKeys()
end

function M.stop()
    if M.mouseTap then M.mouseTap:stop(); M.mouseTap = nil end
    if M.mouseEventWatcher then M.mouseEventWatcher:stop(); M.mouseEventWatcher = nil end
    if M.keyWatcher then M.keyWatcher:stop(); M.keyWatcher = nil end
end

return M
