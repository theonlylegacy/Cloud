if not Game:IsLoaded() then
    Game.Loaded:Wait()
end

local Ping = {}
local Stats = Game:GetService("Stats")

function Ping:Get()
    local ServerStatsItem = Stats.Network.ServerStatsItem
    local DataPing = ServerStatsItem and ServerStatsItem:FindFirstChild("Data Ping")

    if DataPing then
        return DataPing:GetValue()
    end

    return math.huge
end

function Ping:Connect(Callback)
    assert(typeof(Callback) == "function", "array #1 expects a function")

    task.spawn(function()
        local StableTime = 0
        local LastPing = Ping:Get()

        while StableTime < 5 and task.wait(0.5) do
            local Ping = Ping:Get()

            if math.abs(Ping - LastPing) <= 10 then
                StableTime += 0.5
            else
                StableTime = 0
            end

            LastPing = Ping
        end

        Callback(LastPing)
    end)
end

return Ping
