local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = 'GPTWare: LT2 Edition', HidePremium = false, SaveConfig = true, ConfigFolder = 'GPTWareLT2', IntroEnabled = false})

local scriptIsLoading = true

local isSpeedHacking = true
local speedHackValue = 16

local PlayerTab = Window:MakeTab({
    Name = 'Player',
    Icon = 'rbxassetid://18633204761',
    PremiumOnly = false
})

local WoodTab = Window:MakeTab({
    Name = 'Wood',
    Icon = 'rbxassetid://18679570971',
    PremiumOnly = false
})

local VehicleTab = Window:MakeTab({
    Name = 'Vehicle',
    Icon = 'rbxassetid://18679527280',
    PremiumOnly = false
})

local BaseTab = Window:MakeTab({
    Name = 'Base',
    Icon = 'rbxassetid://18679544995',
    PremiumOnly = false
})

local ExploitTab = Window:MakeTab({
    Name = 'Exploit',
    Icon = 'rbxassetid://18661856176',
    PremiumOnly = false
})

local VisualTab = Window:MakeTab({
    Name = 'Visual',
    Icon = 'rbxassetid://18635495051',
    PremiumOnly = false
})

local ClientTab = Window:MakeTab({
    Name = 'Client',
    Icon = 'rbxassetid://18633194275',
    PremiumOnly = false
})

--player

PlayerTab:AddSlider({
    Name = 'Speed',
	Min = 1,
	Max = 100,
	Default = 1,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = 'Modifier',
    Callback = function(Value)
        speedHackValue = Value
    end,
})

PlayerTab:AddSlider({
    Name = 'Jump Power Modifier',
    Min = 1,
    Max = 10,
	Default = 1,
	Color = Color3.fromRGB(255,255,255),
	Increment = 0.5,
	ValueName = 'Modifier',
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value * 50
    end,
})

PlayerTab:AddToggle({
    Name = 'Waterwalk',
    Default = false,
    Callback = function(Value)
        if not scriptIsLoading then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA('BasePart') and obj.Name == 'Water' then
                    obj.CanCollide = Value
                end
            end
        end
    end
})

--client

ClientTab:AddButton({
    Name = 'Self Destruct',
    Callback = function()
        OrionLib:Destroy()
        isSpeedHacking = false
        speedHackValue = 16
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end
})

--actions

scriptIsLoading = false

while isSpeedHacking do
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speedHackValue * 16
    wait()
end