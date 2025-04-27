--[[
Roblox's Animations Script Initiator
]]

local Animation = {}

function Animation:Init(Character)
    local script = Character:FindFirstChild("Animate") or nil

    if not script then
        return
    end

    local u1 = script.Parent
    local u2 = u1:WaitForChild("Humanoid")
    local u3 = "Standing"
    local v4, v5 = pcall(function() --[[Anonymous function at line 7]]
        return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop")
    end)
    local u6 = v4 and v5
    local v7, v8 = pcall(function() --[[Anonymous function at line 10]]
        return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun")
    end)
    local u9 = v7 and v8
    local function u10() --[[Anonymous function at line 13]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u1
        --]]
        return not u9 and 1 or u1:GetScale()
    end
    local u11 = script:FindFirstChild("ScaleDampeningPercent")
    local u12 = ""
    local u13 = nil
    local u14 = nil
    local u15 = nil
    local u16 = 1
    local u17 = nil
    local u18 = nil
    local u19 = {}
    local u20 = {}
    local u21 = {
        ["idle"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507766666",
                ["weight"] = 1
            },
            {
                ["id"] = "http://www.roblox.com/asset/?id=507766951",
                ["weight"] = 1
            },
            {
                ["id"] = "http://www.roblox.com/asset/?id=507766388",
                ["weight"] = 9
            }
        },
        ["walk"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507777826",
                ["weight"] = 10
            }
        },
        ["run"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507767714",
                ["weight"] = 10
            }
        },
        ["swim"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507784897",
                ["weight"] = 10
            }
        },
        ["swimidle"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507785072",
                ["weight"] = 10
            }
        },
        ["jump"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507765000",
                ["weight"] = 10
            }
        },
        ["fall"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507767968",
                ["weight"] = 10
            }
        },
        ["climb"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507765644",
                ["weight"] = 10
            }
        },
        ["sit"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=2506281703",
                ["weight"] = 10
            }
        },
        ["toolnone"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507768375",
                ["weight"] = 10
            }
        },
        ["toolslash"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=522635514",
                ["weight"] = 10
            }
        },
        ["toollunge"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=522638767",
                ["weight"] = 10
            }
        },
        ["wave"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507770239",
                ["weight"] = 10
            }
        },
        ["point"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507770453",
                ["weight"] = 10
            }
        },
        ["dance"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507771019",
                ["weight"] = 10
            },
            {
                ["id"] = "http://www.roblox.com/asset/?id=507771955",
                ["weight"] = 10
            },
            {
                ["id"] = "http://www.roblox.com/asset/?id=507772104",
                ["weight"] = 10
            }
        },
        ["dance2"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507776043",
                ["weight"] = 10
            },
            {
                ["id"] = "http://www.roblox.com/asset/?id=507776720",
                ["weight"] = 10
            },
            {
                ["id"] = "http://www.roblox.com/asset/?id=507776879",
                ["weight"] = 10
            }
        },
        ["dance3"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507777268",
                ["weight"] = 10
            },
            {
                ["id"] = "http://www.roblox.com/asset/?id=507777451",
                ["weight"] = 10
            },
            {
                ["id"] = "http://www.roblox.com/asset/?id=507777623",
                ["weight"] = 10
            }
        },
        ["laugh"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507770818",
                ["weight"] = 10
            }
        },
        ["cheer"] = {
            {
                ["id"] = "http://www.roblox.com/asset/?id=507770677",
                ["weight"] = 10
            }
        }
    }
    local u22 = {
        ["wave"] = false,
        ["point"] = false,
        ["dance"] = true,
        ["dance2"] = true,
        ["dance3"] = true,
        ["laugh"] = false,
        ["cheer"] = false
    }
    math.randomseed(tick())
    function findExistingAnimationInSet(p23, p24)
        if p23 == nil or p24 == nil then
            return 0
        end
        for v25 = 1, p23.count do
            if p23[v25].anim.AnimationId == p24.AnimationId then
                return v25
            end
        end
        return 0
    end
    function configureAnimationSet(u26, u27)
        --[[
        Upvalues:
            [1] = u20
            [2] = u19
            [3] = u2
        --]]
        if u20[u26] ~= nil then
            for _, v28 in pairs(u20[u26].connections) do
                v28:disconnect()
            end
        end
        u20[u26] = {}
        u20[u26].count = 0
        u20[u26].totalWeight = 0
        u20[u26].connections = {}
        local u29 = true
        local v30, _ = pcall(function() --[[Anonymous function at line 138]]
            --[[
            Upvalues:
                [1] = u29
            --]]
            u29 = game:GetService("StarterPlayer").AllowCustomAnimations
        end)
        u29 = not v30 and true or u29
        local v31 = script:FindFirstChild(u26)
        if u29 and v31 ~= nil then
            local v32 = u20[u26].connections
            local v33 = v31.ChildAdded
            table.insert(v32, v33:connect(function(_) --[[Anonymous function at line 146]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u27
                --]]
                configureAnimationSet(u26, u27)
            end))
            local v34 = u20[u26].connections
            local v35 = v31.ChildRemoved
            table.insert(v34, v35:connect(function(_) --[[Anonymous function at line 147]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u27
                --]]
                configureAnimationSet(u26, u27)
            end))
            for _, v36 in pairs(v31:GetChildren()) do
                if v36:IsA("Animation") then
                    local v37 = v36:FindFirstChild("Weight")
                    local v38 = v37 == nil and 1 or v37.Value
                    u20[u26].count = u20[u26].count + 1
                    local v39 = u20[u26].count
                    u20[u26][v39] = {}
                    u20[u26][v39].anim = v36
                    u20[u26][v39].weight = v38
                    u20[u26].totalWeight = u20[u26].totalWeight + u20[u26][v39].weight
                    local v40 = u20[u26].connections
                    local v41 = v36.Changed
                    table.insert(v40, v41:connect(function(_) --[[Anonymous function at line 163]]
                        --[[
                        Upvalues:
                            [1] = u26
                            [2] = u27
                        --]]
                        configureAnimationSet(u26, u27)
                    end))
                    local v42 = u20[u26].connections
                    local v43 = v36.ChildAdded
                    table.insert(v42, v43:connect(function(_) --[[Anonymous function at line 164]]
                        --[[
                        Upvalues:
                            [1] = u26
                            [2] = u27
                        --]]
                        configureAnimationSet(u26, u27)
                    end))
                    local v44 = u20[u26].connections
                    local v45 = v36.ChildRemoved
                    table.insert(v44, v45:connect(function(_) --[[Anonymous function at line 165]]
                        --[[
                        Upvalues:
                            [1] = u26
                            [2] = u27
                        --]]
                        configureAnimationSet(u26, u27)
                    end))
                end
            end
        end
        if u20[u26].count <= 0 then
            for v46, v47 in pairs(u27) do
                u20[u26][v46] = {}
                u20[u26][v46].anim = Instance.new("Animation")
                u20[u26][v46].anim.Name = u26
                u20[u26][v46].anim.AnimationId = v47.id
                u20[u26][v46].weight = v47.weight
                u20[u26].count = u20[u26].count + 1
                u20[u26].totalWeight = u20[u26].totalWeight + v47.weight
            end
        end
        for _, v48 in pairs(u20) do
            for v49 = 1, v48.count do
                if u19[v48[v49].anim.AnimationId] == nil then
                    u2:LoadAnimation(v48[v49].anim)
                    u19[v48[v49].anim.AnimationId] = true
                end
            end
        end
    end
    function configureAnimationSetOld(u50, u51)
        --[[
        Upvalues:
            [1] = u20
            [2] = u2
        --]]
        if u20[u50] ~= nil then
            for _, v52 in pairs(u20[u50].connections) do
                v52:disconnect()
            end
        end
        u20[u50] = {}
        u20[u50].count = 0
        u20[u50].totalWeight = 0
        u20[u50].connections = {}
        local u53 = true
        local v54, _ = pcall(function() --[[Anonymous function at line 209]]
            --[[
            Upvalues:
                [1] = u53
            --]]
            u53 = game:GetService("StarterPlayer").AllowCustomAnimations
        end)
        u53 = not v54 and true or u53
        local v55 = script:FindFirstChild(u50)
        if u53 and v55 ~= nil then
            local v56 = u20[u50].connections
            local v57 = v55.ChildAdded
            table.insert(v56, v57:connect(function(_) --[[Anonymous function at line 217]]
                --[[
                Upvalues:
                    [1] = u50
                    [2] = u51
                --]]
                configureAnimationSet(u50, u51)
            end))
            local v58 = u20[u50].connections
            local v59 = v55.ChildRemoved
            table.insert(v58, v59:connect(function(_) --[[Anonymous function at line 218]]
                --[[
                Upvalues:
                    [1] = u50
                    [2] = u51
                --]]
                configureAnimationSet(u50, u51)
            end))
            local v60 = 1
            for _, v61 in pairs(v55:GetChildren()) do
                if v61:IsA("Animation") then
                    local v62 = u20[u50].connections
                    local v63 = v61.Changed
                    table.insert(v62, v63:connect(function(_) --[[Anonymous function at line 222]]
                        --[[
                        Upvalues:
                            [1] = u50
                            [2] = u51
                        --]]
                        configureAnimationSet(u50, u51)
                    end))
                    u20[u50][v60] = {}
                    u20[u50][v60].anim = v61
                    local v64 = v61:FindFirstChild("Weight")
                    if v64 == nil then
                        u20[u50][v60].weight = 1
                    else
                        u20[u50][v60].weight = v64.Value
                    end
                    u20[u50].count = u20[u50].count + 1
                    u20[u50].totalWeight = u20[u50].totalWeight + u20[u50][v60].weight
                    v60 = v60 + 1
                end
            end
        end
        if u20[u50].count <= 0 then
            for v65, v66 in pairs(u51) do
                u20[u50][v65] = {}
                u20[u50][v65].anim = Instance.new("Animation")
                u20[u50][v65].anim.Name = u50
                u20[u50][v65].anim.AnimationId = v66.id
                u20[u50][v65].weight = v66.weight
                u20[u50].count = u20[u50].count + 1
                u20[u50].totalWeight = u20[u50].totalWeight + v66.weight
            end
        end
        for _, v67 in pairs(u20) do
            for v68 = 1, v67.count do
                u2:LoadAnimation(v67[v68].anim)
            end
        end
    end
    function scriptChildModified(p69)
        --[[
        Upvalues:
            [1] = u21
        --]]
        local v70 = u21[p69.Name]
        if v70 ~= nil then
            configureAnimationSet(p69.Name, v70)
        end
    end
    script.ChildAdded:connect(scriptChildModified)
    script.ChildRemoved:connect(scriptChildModified)
    local v71
    if u2 then
        v71 = u2:FindFirstChildOfClass("Animator")
    else
        v71 = nil
    end
    if v71 then
        local v72 = v71:GetPlayingAnimationTracks()
        for _, v73 in ipairs(v72) do
            v73:Stop(0)
            v73:Destroy()
        end
    end
    for v74, v75 in pairs(u21) do
        configureAnimationSet(v74, v75)
    end
    local u76 = "None"
    local u77 = 0
    local u78 = 0
    local u79 = false
    function stopAllAnimations()
        --[[
        Upvalues:
            [1] = u12
            [2] = u22
            [3] = u79
            [4] = u13
            [5] = u15
            [6] = u14
            [7] = u18
            [8] = u17
        --]]
        local v80 = u12
        local v81 = u22[v80] ~= nil and u22[v80] == false and "idle" or v80
        if u79 then
            v81 = "idle"
            u79 = false
        end
        u12 = ""
        u13 = nil
        if u15 ~= nil then
            u15:disconnect()
        end
        if u14 ~= nil then
            u14:Stop()
            u14:Destroy()
            u14 = nil
        end
        if u18 ~= nil then
            u18:disconnect()
        end
        if u17 ~= nil then
            u17:Stop()
            u17:Destroy()
            u17 = nil
        end
        return v81
    end
    function getHeightScale()
        --[[
        Upvalues:
            [1] = u2
            [2] = u10
            [3] = u11
        --]]
        if not u2 then
            return u10()
        end
        if not u2.AutomaticScalingEnabled then
            return u10()
        end
        local v82 = u2.HipHeight / 2
        if u11 == nil then
            u11 = script:FindFirstChild("ScaleDampeningPercent")
        end
        if u11 ~= nil then
            v82 = 1 + (u2.HipHeight - 2) * u11.Value / 2
        end
        return v82
    end
    local function u88(p83) --[[Anonymous function at line 369]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u17
        --]]
        local v84 = p83 * 1.25 / getHeightScale()
        local v85 = 0.0001
        local v86 = 0.0001
        local v87 = 1
        if v84 <= 0.5 then
            v87 = v84 / 0.5
            v85 = 1
        elseif v84 < 1 then
            v86 = (v84 - 0.5) / 0.5
            v85 = 1 - v86
        else
            v87 = v84 / 1
            v86 = 1
        end
        u14:AdjustWeight(v85)
        u17:AdjustWeight(v86)
        u14:AdjustSpeed(v87)
        u17:AdjustSpeed(v87)
    end
    function setAnimationSpeed(p89)
        --[[
        Upvalues:
            [1] = u12
            [2] = u88
            [3] = u16
            [4] = u14
        --]]
        if u12 == "walk" then
            u88(p89)
        elseif p89 ~= u16 then
            u16 = p89
            u14:AdjustSpeed(u16)
        end
    end
    function keyFrameReachedFunc(p90)
        --[[
        Upvalues:
            [1] = u12
            [2] = u6
            [3] = u17
            [4] = u14
            [5] = u22
            [6] = u79
            [7] = u16
            [8] = u2
        --]]
        if p90 == "End" then
            if u12 == "walk" then
                if u6 ~= true then
                    u17.TimePosition = 0
                    u14.TimePosition = 0
                    return
                end
                if u17.Looped ~= true then
                    u17.TimePosition = 0
                end
                if u14.Looped ~= true then
                    u14.TimePosition = 0
                    return
                end
            else
                local v91 = u12
                local v92 = u22[v91] ~= nil and u22[v91] == false and "idle" or v91
                if u79 then
                    if u14.Looped then
                        return
                    end
                    v92 = "idle"
                    u79 = false
                end
                local v93 = u16
                playAnimation(v92, 0.15, u2)
                setAnimationSpeed(v93)
            end
        end
    end
    function rollAnimation(p94)
        --[[
        Upvalues:
            [1] = u20
        --]]
        local v95 = math.random(1, u20[p94].totalWeight)
        local v96 = 1
        while u20[p94][v96].weight < v95 do
            v95 = v95 - u20[p94][v96].weight
            v96 = v96 + 1
        end
        return v96
    end
    local function u102(p97, p98, p99, p100) --[[Anonymous function at line 455]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u14
            [3] = u17
            [4] = u6
            [5] = u16
            [6] = u12
            [7] = u15
            [8] = u20
            [9] = u18
        --]]
        if p97 ~= u13 then
            if u14 ~= nil then
                u14:Stop(p99)
                u14:Destroy()
            end
            if u17 ~= nil then
                u17:Stop(p99)
                u17:Destroy()
                if u6 == true then
                    u17 = nil
                end
            end
            u16 = 1
            u14 = p100:LoadAnimation(p97)
            u14.Priority = Enum.AnimationPriority.Core
            u14:Play(p99)
            u12 = p98
            u13 = p97
            if u15 ~= nil then
                u15:disconnect()
            end
            u15 = u14.KeyframeReached:connect(keyFrameReachedFunc)
            if p98 == "walk" then
                local v101 = rollAnimation("run")
                u17 = p100:LoadAnimation(u20.run[v101].anim)
                u17.Priority = Enum.AnimationPriority.Core
                u17:Play(p99)
                if u18 ~= nil then
                    u18:disconnect()
                end
                u18 = u17.KeyframeReached:connect(keyFrameReachedFunc)
            end
        end
    end
    function playAnimation(p103, p104, p105)
        --[[
        Upvalues:
            [1] = u20
            [2] = u102
            [3] = u79
        --]]
        local v106 = rollAnimation(p103)
        u102(u20[p103][v106].anim, p103, p104, p105)
        u79 = false
    end
    function playEmote(p107, p108, p109)
        --[[
        Upvalues:
            [1] = u102
            [2] = u79
        --]]
        u102(p107, p107.Name, p108, p109)
        u79 = true
    end
    local u110 = ""
    local u111 = nil
    local u112 = nil
    local u113 = nil
    function toolKeyFrameReachedFunc(p114)
        --[[
        Upvalues:
            [1] = u110
            [2] = u2
        --]]
        if p114 == "End" then
            playToolAnimation(u110, 0, u2)
        end
    end
    function playToolAnimation(p115, p116, p117, p118)
        --[[
        Upvalues:
            [1] = u20
            [2] = u112
            [3] = u111
            [4] = u110
            [5] = u113
        --]]
        local v119 = rollAnimation(p115)
        local v120 = u20[p115][v119].anim
        if u112 ~= v120 then
            if u111 ~= nil then
                u111:Stop()
                u111:Destroy()
                p116 = 0
            end
            u111 = p117:LoadAnimation(v120)
            if p118 then
                u111.Priority = p118
            end
            u111:Play(p116)
            u110 = p115
            u112 = v120
            u113 = u111.KeyframeReached:connect(toolKeyFrameReachedFunc)
        end
    end
    function stopToolAnimations()
        --[[
        Upvalues:
            [1] = u110
            [2] = u113
            [3] = u112
            [4] = u111
        --]]
        local v121 = u110
        if u113 ~= nil then
            u113:disconnect()
        end
        u110 = ""
        u112 = nil
        if u111 ~= nil then
            u111:Stop()
            u111:Destroy()
            u111 = nil
        end
        return v121
    end
    function onRunning(p122)
        --[[
        Upvalues:
            [1] = u9
            [2] = u79
            [3] = u2
            [4] = u3
            [5] = u22
            [6] = u12
        --]]
        local v123 = not u9 and 1 or getHeightScale()
        local v124 = u79
        if v124 then
            v124 = u2.MoveDirection == Vector3.new(0, 0, 0)
        end
        if (v124 and (u2.WalkSpeed / v123 or 0.75) or 0.75) * v123 < p122 then
            playAnimation("walk", 0.2, u2)
            setAnimationSpeed(p122 / 16)
            u3 = "Running"
        elseif u22[u12] == nil and not u79 then
            playAnimation("idle", 0.2, u2)
            u3 = "Standing"
        end
    end
    function onDied()
        --[[
        Upvalues:
            [1] = u3
        --]]
        u3 = "Dead"
    end
    function onJumping()
        --[[
        Upvalues:
            [1] = u2
            [2] = u78
            [3] = u3
        --]]
        playAnimation("jump", 0.1, u2)
        u78 = 0.31
        u3 = "Jumping"
    end
    function onClimbing(p125)
        --[[
        Upvalues:
            [1] = u9
            [2] = u2
            [3] = u3
        --]]
        if u9 then
            p125 = p125 / getHeightScale()
        end
        playAnimation("climb", 0.1, u2)
        setAnimationSpeed(p125 / 5)
        u3 = "Climbing"
    end
    function onGettingUp()
        --[[
        Upvalues:
            [1] = u3
        --]]
        u3 = "GettingUp"
    end
    function onFreeFall()
        --[[
        Upvalues:
            [1] = u78
            [2] = u2
            [3] = u3
        --]]
        if u78 <= 0 then
            playAnimation("fall", 0.2, u2)
        end
        u3 = "FreeFall"
    end
    function onFallingDown()
        --[[
        Upvalues:
            [1] = u3
        --]]
        u3 = "FallingDown"
    end
    function onSeated()
        --[[
        Upvalues:
            [1] = u3
        --]]
        u3 = "Seated"
    end
    function onPlatformStanding()
        --[[
        Upvalues:
            [1] = u3
        --]]
        u3 = "PlatformStanding"
    end
    function onSwimming(p126)
        --[[
        Upvalues:
            [1] = u9
            [2] = u2
            [3] = u3
        --]]
        if u9 then
            p126 = p126 / getHeightScale()
        end
        if p126 > 1 then
            playAnimation("swim", 0.4, u2)
            setAnimationSpeed(p126 / 10)
            u3 = "Swimming"
        else
            playAnimation("swimidle", 0.4, u2)
            u3 = "Standing"
        end
    end
    function animateTool()
        --[[
        Upvalues:
            [1] = u76
            [2] = u2
        --]]
        if u76 == "None" then
            playToolAnimation("toolnone", 0.1, u2, Enum.AnimationPriority.Idle)
            return
        elseif u76 == "Slash" then
            playToolAnimation("toolslash", 0, u2, Enum.AnimationPriority.Action)
            return
        elseif u76 == "Lunge" then
            playToolAnimation("toollunge", 0, u2, Enum.AnimationPriority.Action)
        end
    end
    function getToolAnim(p127)
        for _, v128 in ipairs(p127:GetChildren()) do
            if v128.Name == "toolanim" and v128.className == "StringValue" then
                return v128
            end
        end
        return nil
    end
    local u129 = 0
    function stepAnimate(p130)
        --[[
        Upvalues:
            [1] = u129
            [2] = u78
            [3] = u3
            [4] = u2
            [5] = u1
            [6] = u76
            [7] = u77
            [8] = u112
        --]]
        local v131 = p130 - u129
        u129 = p130
        if u78 > 0 then
            u78 = u78 - v131
        end
        if u3 == "FreeFall" and u78 <= 0 then
            playAnimation("fall", 0.2, u2)
        else
            if u3 == "Seated" then
                playAnimation("sit", 0.5, u2)
                return
            end
            if u3 == "Running" then
                playAnimation("walk", 0.2, u2)
            elseif u3 == "Dead" or (u3 == "GettingUp" or (u3 == "FallingDown" or (u3 == "Seated" or u3 == "PlatformStanding"))) then
                stopAllAnimations()
            end
        end
        local v132 = u1:FindFirstChildOfClass("Tool")
        if v132 and v132:FindFirstChild("Handle") then
            local v133 = getToolAnim(v132)
            if v133 then
                u76 = v133.Value
                v133.Parent = nil
                u77 = p130 + 0.3
            end
            if u77 < p130 then
                u77 = 0
                u76 = "None"
            end
            animateTool()
        else
            stopToolAnimations()
            u76 = "None"
            u112 = nil
            u77 = 0
        end
    end
    u2.Died:connect(onDied)
    u2.Running:connect(onRunning)
    u2.Jumping:connect(onJumping)
    u2.Climbing:connect(onClimbing)
    u2.GettingUp:connect(onGettingUp)
    u2.FreeFalling:connect(onFreeFall)
    u2.FallingDown:connect(onFallingDown)
    u2.Seated:connect(onSeated)
    u2.PlatformStanding:connect(onPlatformStanding)
    u2.Swimming:connect(onSwimming)
    game:GetService("Players").LocalPlayer.Chatted:connect(function(p134) --[[Anonymous function at line 756]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u22
            [3] = u2
        --]]
        local v135 = ""
        if string.sub(p134, 1, 3) == "/e " then
            v135 = string.sub(p134, 4)
        elseif string.sub(p134, 1, 7) == "/emote " then
            v135 = string.sub(p134, 8)
        end
        if u3 == "Standing" and u22[v135] ~= nil then
            playAnimation(v135, 0.1, u2)
        end
    end)
    script:WaitForChild("PlayEmote").OnInvoke = function(p136) --[[Anonymous function at line 770]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u22
            [3] = u2
            [4] = u14
        --]]
        if u3 == "Standing" then
            if u22[p136] ~= nil then
                playAnimation(p136, 0.1, u2)
                return true, u14
            end
            if typeof(p136) ~= "Instance" or not p136:IsA("Animation") then
                return false
            end
            playEmote(p136, 0.1, u2)
            return true, u14
        end
    end
    if u1.Parent ~= nil then
        playAnimation("idle", 0.1, u2)
        local _ = "Standing"
    end
    while u1.Parent ~= nil do
        local _, v137 = wait(0.1)
        stepAnimate(v137)
    end
end

return Animation
