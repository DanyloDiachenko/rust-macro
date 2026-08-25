-- TCP client for the pointing helper daemon.
local config = require("rifle.config")
local state = require("rifle.state")

local M = {}

function M.connected()
    local sock = state.hidSock
    if not sock then return false end
    local ok, connected = pcall(function() return sock:connected() end)
    return ok and connected
end

function M.cmd(line)
    if not M.connected() then
        return false
    end
    local ok = pcall(function()
        state.hidSock:write(line)
    end)
    if not ok then
        state.hidAvailable = false
        state.patternSent = false
        pcall(function() state.hidSock:disconnect() end)
        state.hidSock = nil
        return false
    end
    return true
end

function M.uploadPattern(pattern)
    local path = hs.configdir .. "/hidmouse/curve.dat"
    local f = io.open(path, "w")
    if not f then
        print("[rifle] cannot write curve: " .. path)
        return false
    end

    pattern = pattern or state.currentPattern or {}
    local out = {}
    for _, step in ipairs(pattern) do
        out[#out + 1] = string.format(
            "%.4f %.4f %d",
            step.dx,
            step.dy,
            math.max(tonumber(step.delay) or 1, 1)
        )
    end
    f:write(table.concat(out, "\n"))
    f:write("\n")
    f:close()

    if M.cmd("pat " .. path .. "\n") then
        state.patternSent = true
        if config.debug then
            print(string.format("[rifle] curve uploaded: %d steps", #pattern))
        end
        return true
    end
    return false
end

function M.connect()
    if M.connected() then
        state.hidAvailable = true
        return true
    end

    local port = config.hidDaemonPort or 49173
    if state.hidSock then
        pcall(function() state.hidSock:disconnect() end)
        state.hidSock = nil
    end

    local sock
    sock = hs.socket.new(function(data)
        if data and (data:find("n=0", 1, true) or data:find("steps=0", 1, true)) then
            state.patternSent = false
        end
        pcall(function() sock:read("\n") end)
    end)
    sock:connect("127.0.0.1", port)

    for _ = 1, 10 do
        hs.timer.usleep(5000)
        local ok, connected = pcall(function() return sock:connected() end)
        if ok and connected then
            state.hidSock = sock
            state.hidAvailable = true
            state.patternSent = false
            pcall(function() sock:read("\n") end)
            M.cmd(string.format("mul %.4f\n", tonumber(config.strafeMultiplier) or 1.25))
            M.cmd(string.format("stand %.4f\n", tonumber(config.standMultiplier) or 2.0))
            M.cmd(string.format("jit %.4f\n", tonumber(config.humanJitter) or 0.10))
            if state.currentPattern and #state.currentPattern > 0 then
                M.uploadPattern(state.currentPattern)
            end
            return true
        end
    end
    state.hidAvailable = false
    return false
end

function M.status()
    local port = config.hidDaemonPort or 49173
    return hs.execute(string.format("echo ping | nc -w 1 127.0.0.1 %d", port)) or ""
end

function M.ensureDaemon()
    state.hidAvailable = false

    local status = M.status()
    if not status:find("pong", 1, true) then
        print("[rifle] helper not running — run hidmouse/install_daemons.sh (admin)")
        return false
    end

    if not M.connect() then
        print("[rifle] helper up but control socket refused")
        return false
    end

    if status:find("ready=1", 1, true) then
        if config.debug then
            print("[rifle] pointing device ready")
        end
    else
        print("[rifle] pointing not ready (" .. status:gsub("%s+$", "") .. ")")
    end
    return true
end

function M.startKeepalive()
    if state.hidKeepalive then
        state.hidKeepalive:stop()
    end
    state.hidKeepalive = hs.timer.new(5, function()
        if not M.connected() then
            M.connect()
        end
    end)
    state.hidKeepalive:start()
end

return M
