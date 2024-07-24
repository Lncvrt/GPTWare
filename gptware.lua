local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local player = game.Players.LocalPlayer

local isJumpFlying = false
local jumpFlyStartHeight = 0.0;

Rayfield:Notify({
   Title = "GPTWare Executed!",
   Content = "GPTWare has been Successfully executed!",
   Duration = 3,
   Image = 4483362458,
   Actions = {
      Ignore = {
         Name = "Okay!",
         Callback = function()
      end
   },
},
})

local Window = Rayfield:CreateWindow({
   Name = "GPTWare",
   LoadingTitle = "GPTWare",
   LoadingSubtitle = "by Lncvrt & Loqrp",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "GPTWare"
   },
   Discord = {
      Enabled = true,
      Invite = "EZTTvr27cA",
      RememberJoins = true
   },
})

local MovementTab = Window:CreateTab("Movement", 18633204761)

local PlayerTab = Window:CreateTab("Player", 18633259530)

local ClientTab = Window:CreateTab("Client", 18633194275)

--movement

MovementTab:CreateSlider({
    Name = "Speed",
    Range = {1, 25},
    Increment = 0.5,
    Suffix = "Modifier",
    CurrentValue = 1,
    Flag = "SpeedSlider",
    Callback = function(Value)
        player.Character.Humanoid.WalkSpeed = Value * 16
    end,
})

MovementTab:CreateSlider({
    Name = "Jump Power Modifier",
    Range = {1, 10},
    Increment = 0.5,
    Suffix = "Modifier",
    CurrentValue = 1,
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        player.Character.Humanoid.JumpPower = Value * 50
    end,
})

MovementTab:CreateSlider({
    Name = "Gravity Modifier",
    Range = {-25, 25},
    Increment = 0.5,
    Suffix = "Modifier",
    CurrentValue = 1,
    Flag = "GravitySlider",
    Callback = function(Value)
        game.Workspace.Gravity = Value * 196.2
    end,
})

MovementTab:CreateToggle({
    Name = "Jump Fly",
    CurrentValue = false,
    Flag = "JumpFlyToggle",
    Callback = function(Value)
        isJumpFlying = Value
        if Value then
            jumpFlyStartHeight = player.Character:FindFirstChild("HumanoidRootPart").Position.Y
            checkJumpFlyingStatus()
        end
    end,
})

--player

PlayerTab:CreateToggle({
    Name = "Sit State",
    CurrentValue = false,
    Flag = "SitStateButton",
    Callback = function(Value)
        player.Character.Humanoid.Sit = Value
    end,
})

PlayerTab:CreateButton({
    Name = "Jump",
    Callback = function()
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end,
 })

--client

ClientTab:CreateButton({
    Name = "Self Destruct",
    Callback = function()
        Rayfield:Destroy()
        player.Character.Humanoid.WalkSpeed = 16
        player.Character.Humanoid.JumpPower = 50
        game.Workspace.Gravity = 196.2
        isJumpFlying = false
    end,
})

--actions

function checkJumpFlyingStatus()
    while isJumpFlying do
        local player = game.Players.LocalPlayer
        local character = player and player.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart then
            if humanoidRootPart.Position.Y <= jumpFlyStartHeight then
                player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end

        wait(0.01)
    end
end