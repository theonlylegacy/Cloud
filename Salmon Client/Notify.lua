-- Notification System
local Notify = {}
local Utility = {}
local Notifications = {}
local Positions = {}
local Sounds = {}
local Colors = {
    [2] = Color3.fromRGB(38, 11, 11),
    [5] = Color3.fromRGB(70, 54, 35),
    [6] = Color3.fromRGB(11, 38, 11)
}

function Utility:Create(Class, Properties)
    local Object = Instance.new(Class)
    for Property, Value in pairs(Properties) do
        Object[Property] = Value
    end
    return Object
end

Sounds[1] = Utility:Create("Sound", {SoundId = "rbxassetid://405321226", Parent = gethui()})
Sounds[2] = Utility:Create("Sound", {SoundId = "rbxassetid://6432593850", Parent = gethui()})

local Gui = Utility:Create("ScreenGui", {
    Name = "Gui",
    DisplayOrder = 2,
    ResetOnSpawn = false,
    Parent = gethui()
})

local Frame = Utility:Create("Frame", {
    Name = "Frame",
    AnchorPoint = Vector2.new(1, 0),
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -10, 0.9852, -230),
    Size = UDim2.new(0, 300, 0, 100),
    ZIndex = 16,
    Parent = Gui
})

local Template = Utility:Create("Frame", {
    Name = "Template",
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.new(0, -180, 0, 0),
    Size = UDim2.new(0.9, 0, 0, 40),
    ZIndex = 16,
    Visible = false,
    Parent = gethui()
})

local Background = Utility:Create("Frame", {
    Name = "Background",
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.3,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    ZIndex = 16,
    Parent = Template
})

local Title = Utility:Create("TextLabel", {
    Name = "Title",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0.5, 0),
    ZIndex = 16,
    Font = Enum.Font.SourceSansBold,
    Text = "",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 18,
    TextWrapped = true,
    Parent = Background
})

local Message = Utility:Create("TextLabel", {
    Name = "Message",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 0.5, 0),
    Size = UDim2.new(1, 0, 0.5, 0),
    ZIndex = 16,
    Font = Enum.Font.SourceSansItalic,
    Text = "",
    TextColor3 = Color3.fromRGB(221, 221, 221),
    TextScaled = true,
    TextWrapped = true,
    TextYAlignment = Enum.TextYAlignment.Top,
    Parent = Background
})

function Notify.new(Message, SoundIndex)
	if #Frame:GetChildren() >= 5 then
		local OldestClone = Frame:GetChildren()[1]

		task.spawn(function()
			OldestClone.Background:TweenPosition(UDim2.new(1.5, 0, 0, 0), "Out", "Quad", 0.5, true)
			task.wait(1)
			OldestClone:Destroy()
			Positions[OldestClone] = nil
		end)
	end

    local Clone = Template:Clone()
    Clone.Visible = true
    Clone.Position = UDim2.new(0, 0, 0, 0)
    Clone.Background.Position = UDim2.new(1.5, 0, 0, 0)
    Positions[Clone] = Clone.Position
    Clone.Background.Message.Text = Message
    Clone.Background.Title.Text = "Salmon Client"

    for _, Existing in pairs(Frame:GetChildren()) do
        Positions[Existing] = Positions[Existing] - UDim2.new(0, 0, 0, 42)
        Existing:TweenPosition(Positions[Existing], "Out", "Quad", 0.35, true)
    end

    if SoundIndex == nil then
        Sounds[math.random(1, 2)]:Play()
    else
        Sounds[SoundIndex]:Play()
        if Colors[SoundIndex] then
            Clone.Background.BackgroundColor3 = Colors[SoundIndex]
        end
    end

    Clone.Parent = Frame
    Clone.Background:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.5, true)

    task.spawn(function()
		if Clone then
        	task.wait(8)
        	Clone.Background:TweenPosition(UDim2.new(1.5, 0, 0, 0), "Out", "Quad", 0.5, true)
        	task.wait(1)
        	Clone:Destroy()
        	Positions[Clone] = nil
		end
    end)
end

return Notify
