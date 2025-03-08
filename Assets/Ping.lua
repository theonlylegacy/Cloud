--[=[

]=]


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

if Callback then
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
