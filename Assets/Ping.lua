--[=[
local Ping = loadstring(http.request({Url = "https://raw.githubusercontent.com/theonlylegacy/Cloud/refs/heads/main/Assets/Ping.lua", Method = "GET"}).Body)(function()
    local Stats = game:GetService("Stats")
    local Ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()

    print("Ping has stabilized at:", Ping)
    
    if Ping > 110 then
        print("High ping detected, cheat might not run as expected")
    end
end)
]=]

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Stats = game:GetService("Stats")
local Callback = select(1, ...)

local GetPing = function()
    local ServerStatsItem = Stats.Network.ServerStatsItem
    local DataPing = ServerStatsItem and ServerStatsItem:FindFirstChild("Data Ping")

    if DataPing then
        return DataPing:GetValue()
    end

    return math.huge
end

if typeof(Callback) == "function" then
    task.spawn(function()

        local StableTime = 0
        local LastPing = GetPing()

        while StableTime < 5 and task.wait(0.5) do
            local Ping = GetPing()

            if math.abs(Ping - LastPing) <= 10 then
                StableTime += 0.5
            else
                StableTime = 0
            end

            LastPing = Ping
        end

        Callback()
    end)
end
