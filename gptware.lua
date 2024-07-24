local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

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

local MovementTab = Window:CreateTab("Movement", 7992557358)

local ClientTab = Window:CreateTab("Client", 7992557358)

--movement

--create a new section, everything under here will be for "Player section"
MovementTab:CreateSection("Player")

local SpeedSlider = MovementTab:CreateSlider({
    Name = "Speed",
    Range = {1, 10},
    Increment = 0.5,
    Suffix = "Modifier",
    CurrentValue = 1,
    Flag = "SpeedSlider",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value * 16
    end,
})

--client

local SelfDistructButton = ClientTab:CreateButton({
    Name = "Self Destruct",
    Callback = function()
        Rayfield:Destroy()
    end,
 })