local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local userInputService = game:GetService('UserInputService')
local lighting = game:GetService('Lighting')

local isJumpFlying = false
local jumpFlyStartHeight = 0;
local teleportToTargetName
local isFlying = false
local originalVelocity = Vector3.new()
local bodyVelocity = Instance.new('BodyVelocity')
local VClipAmountValue = 75
local HClipAmountValue = 75

local hud
local hudframe1
local hudframe2
local hudicorner1
local hudicorner2
local hudtextlabel1
local hudtextlabel2

local spacePressed = false
local shiftPressed = false

local originalAmbient = lighting.Ambient
local originalOutdoorAmbient = lighting.OutdoorAmbient
local originalBrightness = lighting.Brightness
local originalExposureCompensation = lighting.ExposureCompensation

local loadedInfiniteYield = false
local loadedSimpleBypass = false
local loadedVehicleLegendsAutoFarmer = false

local SpeedSlider
local SpeedStudsSlider
local speedIsUpdating = false

bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
bodyVelocity.Velocity = Vector3.new(0, 0, 0)

local clientTheme = Color3.fromRGB(134, 26, 240)

Rayfield:Notify({
   Title = 'GPTWare Executed!',
   Content = 'GPTWare has been Successfully executed!',
   Duration = 3,
   Image = 18635540561,
   Actions = {
      Ignore = {
         Name = 'Okay!',
         Callback = function()
      end
   },
},
})

local Window = Rayfield:CreateWindow({
   Name = 'GPTWare',
   LoadingTitle = 'GPTWare',
   LoadingSubtitle = 'by Lncvrt & Loqrp',
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = 'GPTWare'
   },
   Discord = {
      Enabled = true,
      Invite = 'EZTTvr27cA',
      RememberJoins = true
   },
})

local MovementTab = Window:CreateTab('Movement', 18659527523)

local MovementPlusTab = Window:CreateTab('Movement Plus', 18633204761)

local PlayerTab = Window:CreateTab('Player', 18633259530)

local ExploitTab = Window:CreateTab('Exploit', 18661856176)

local VisualTab = Window:CreateTab('Visual', 18635495051)

local ClientTab = Window:CreateTab('Client', 18633194275)

local ScriptsTab = Window:CreateTab('Scripts', 18636073939)

--movement

SpeedSlider = MovementTab:CreateSlider({
    Name = 'Speed',
    Range = {1, 25},
    Increment = 0.25,
    Suffix = 'Modifier',
    CurrentValue = 1,
    Flag = 'SpeedSlider',
    Callback = function(Value)
        if not speedIsUpdating then
            speedIsUpdating = true
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value * 16
            SpeedStudsSlider:Set(Value * 16)
            speedIsUpdating = false
        end
    end,
})

MovementTab:CreateSlider({
    Name = 'Jump Power Modifier',
    Range = {1, 10},
    Increment = 0.5,
    Suffix = 'Modifier',
    CurrentValue = 1,
    Flag = 'JumpPowerSlider',
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value * 50
    end,
})

MovementTab:CreateSlider({
    Name = 'Gravity Modifier',
    Range = {-25, 25},
    Increment = 0.25,
    Suffix = 'Modifier',
    CurrentValue = 1,
    Flag = 'GravitySlider',
    Callback = function(Value)
        game.Workspace.Gravity = Value * 196.2
    end,
})

MovementTab:CreateToggle({
    Name = 'Fly',
    CurrentValue = false,
    Flag = 'FlyToggle',
    Callback = function(Value)
        local character = game.Players.LocalPlayer.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild('HumanoidRootPart')
        if not humanoidRootPart then return end
        
        if Value then
            if not isFlying then
                isFlying = true
                originalVelocity = humanoidRootPart.Velocity

                bodyVelocity.Parent = humanoidRootPart

                while isFlying do
                    local currentVelocity = humanoidRootPart.Velocity
                    bodyVelocity.Velocity = Vector3.new(currentVelocity.X, 0, currentVelocity.Z)
                    wait()
                end
            end
        else
            if isFlying then
                isFlying = false
                bodyVelocity.Parent = nil
                humanoidRootPart.Velocity = Vector3.new(originalVelocity.X, originalVelocity.Y, originalVelocity.Z)
            end
        end
    end,
})

MovementTab:CreateToggle({
    Name = 'Jump Fly',
    CurrentValue = false,
    Flag = 'JumpFlyToggle',
    Callback = function(Value)
        isJumpFlying = Value
        if Value then
            local player = game.Players.LocalPlayer
            local character = player and player.Character
            local humanoidRootPart = character and character:FindFirstChild('HumanoidRootPart')
            
            if humanoidRootPart then
                jumpFlyStartHeight = humanoidRootPart.Position.Y
                while isJumpFlying do
                    local humanoidRootPart = character and character:FindFirstChild('HumanoidRootPart')
                    
                    if humanoidRootPart then
                        if humanoidRootPart.Position.Y <= jumpFlyStartHeight then
                            player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                    end
                    
                    wait(0.01)
                end
            end
        end
    end,
})

MovementTab:CreateButton({
    Name = 'Long Jump',
    Callback = function()
        if game.Players.LocalPlayer.Character.Humanoid.FloorMaterial.Name == 'Air' then
            Rayfield:Notify({
                Title = 'Error running Long Jump',
                Content = 'You must be on the ground to use this module!',
                Duration = 3,
                Image = 18635540561,
                Actions = {
                   Ignore = {
                      Name = 'Okay!',
                      Callback = function()
                   end
                },
            },
            })
        else
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:FindFirstChild('HumanoidRootPart')

            if hrp then
                local camera = game.Workspace.CurrentCamera
                local lookVector = camera.CFrame.LookVector

                local bodyVelocity = Instance.new('BodyVelocity')
                bodyVelocity.Velocity = lookVector * 200 + Vector3.new(0, 200, 0)
                bodyVelocity.MaxForce = Vector3.new(50000, 10000, 50000)
                bodyVelocity.P = 20000
                bodyVelocity.Parent = hrp

                game:GetService('Debris'):AddItem(bodyVelocity, 0.1)
            end
        end
    end,
})

MovementTab:CreateToggle({
    Name = 'Infinite Jump',
    CurrentValue = false,
    Flag = 'InfiniteJumpToggle',
    Callback = function(Value)
        local runService = game:GetService('RunService')
        local player = game.Players.LocalPlayer
        
        local function onRenderStepped()
            if not player.Character or not player.Character:FindFirstChild('Humanoid') then return end
            
            local humanoid = player.Character.Humanoid
            if humanoid.Jump then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
        
        local connection
        
        if Value then
            connection = runService.RenderStepped:Connect(onRenderStepped)
        else
            if connection then
                connection:Disconnect()
            end
        end
        
        while Value do
            wait()
            if not player.Character or not player.Character:FindFirstChild('Humanoid') then return end
            
            local humanoid = player.Character.Humanoid
            if humanoid.Jump then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
        
        if connection then
            connection:Disconnect()
        end
    end,
})

MovementTab:CreateButton({
    Name = 'Reset Speed',
    Callback = function()
        speedIsUpdating = true
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        SpeedSlider:Set(1)
        SpeedStudsSlider:Set(16)
        speedIsUpdating = false
    end,
})

--movement plus

SpeedStudsSlider = MovementPlusTab:CreateSlider({
    Name = 'Speed',
    Range = {1, 400},
    Increment = 1,
    Suffix = 'Studs',
    CurrentValue = 16,
    Flag = 'SpeedStudsSlider',
    Callback = function(Value)
        if not speedIsUpdating then
            speedIsUpdating = true
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
            SpeedSlider:Set(constrainToRange(roundIncremental(Value / 16, 0.25), 1, 25))
            speedIsUpdating = false
        end
    end,
})

MovementPlusTab:CreateSlider({
    Name = 'VClip Amount',
    Range = {-400, 400},
    Increment = 0.25,
    Suffix = 'Amount',
    CurrentValue = 75,
    Flag = 'VClipAmountSlider',
    Callback = function(Value)
        VClipAmountValue = Value
    end,
})

MovementPlusTab:CreateButton({
    Name = 'Confirm VClip',
    Callback = function()
        local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        local humanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart')

        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y + VClipAmountValue, pos.Z)
        end
    end,
})

MovementPlusTab:CreateSlider({
    Name = 'HClip Amount',
    Range = {-400, 400},
    Increment = 0.25,
    Suffix = 'Amount',
    CurrentValue = 75,
    Flag = 'HClipAmountSlider',
    Callback = function(Value)
        HClipAmountValue = Value
    end,
})

MovementPlusTab:CreateButton({
    Name = 'Confirm HClip',
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoidRootPart = character:FindFirstChild('HumanoidRootPart')
        local camera = workspace.CurrentCamera

        if humanoidRootPart and camera then
            local playerPosition = humanoidRootPart.Position
            local cameraCFrame = camera.CFrame

            local forwardVector = cameraCFrame.LookVector
            local moveDirection = forwardVector * HClipAmountValue
            local newPosition = playerPosition + moveDirection

            humanoidRootPart.CFrame = CFrame.new(newPosition.X, playerPosition.Y, newPosition.Z)
        end
    end,
})

--player

PlayerTab:CreateToggle({
    Name = 'Sit State',
    CurrentValue = false,
    Flag = 'SitStateButton',
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.Sit = Value
    end,
})

PlayerTab:CreateButton({
    Name = 'Jump',
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end,
})

PlayerTab:CreateButton({
    Name = 'Suicide',
    Callback = function()
        local head = game.Players.LocalPlayer.Character:FindFirstChild('Head')
        if head then
            head:Destroy()
        else
            Rayfield:Notify({
                Title = 'Error running Suicide',
                Content = 'Unable to suicide',
                Duration = 3,
                Image = 18635540561,
                Actions = {
                   Ignore = {
                      Name = 'Okay!',
                      Callback = function()
                   end
                },
            },
            })
        end
    end,
})

PlayerTab:CreateButton({
    Name = 'Ragdoll',
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
    end,
})

PlayerTab:CreateButton({
    Name = 'More Animated (R15)',
    Callback = function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild('Humanoid') then
            local humanoid = game.Players.LocalPlayer.Character.Humanoid
            
            humanoid.RigType = Enum.HumanoidRigType.R15
        end
    end,
})

PlayerTab:CreateButton({
    Name = 'Less Animated (R6)',
    Callback = function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild('Humanoid') then
            local humanoid = game.Players.LocalPlayer.Character.Humanoid
            
            humanoid.RigType = Enum.HumanoidRigType.R6
        end
    end,
})

--exploit

ExploitTab:CreateInput({
    Name = 'Teleport To Player Name',
    PlaceholderText = 'Target Player Name',
    Callback = function(Text)
        teleportToTargetName = Text
    end,
})

ExploitTab:CreateButton({
    Name = 'Confirm Teleport',
    Callback = function()
        teleportToPlayer(teleportToTargetName)
    end,
})

--visual

VisualTab:CreateToggle({
    Name = 'Fullbright',
    CurrentValue = false,
    Flag = 'FullbrightToggle',
    Callback = function(Value)
        if Value then
            lighting.Ambient = Color3.fromRGB(255, 255, 255)
            lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            lighting.Brightness = 1
            lighting.ExposureCompensation = 1
        else
            lighting.Ambient = originalAmbient
            lighting.OutdoorAmbient = originalOutdoorAmbient
            lighting.Brightness = originalBrightness
            lighting.ExposureCompensation = originalExposureCompensation
        end
    end,
})

--client

ClientTab:CreateButton({
    Name = 'Self Destruct',
    Callback = function()
        Rayfield:Notify({
            Title = 'Are you sure?',
            Content = 'Please confirm you would like to self destruct GPTWare',
            Duration = 3,
            Image = 18635540561,
            Actions = {
                Destruct = {
                    Name = 'Destruct',
                    Callback = function()
                        Rayfield:Destroy()
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
                        game.Workspace.Gravity = 196.2
                        isJumpFlying = false
                        isFlying = false
                        destroyHUDS()
                    end
                },
                Ignore = {
                    Name = 'Cancel',
                    Callback = function()
                    end
                },
            }
        })
    end
})

ClientTab:CreateDropdown({
    Name = 'HUD',
    Options = {'GPTWare', 'Sigma Jello', 'LiquidBounce', 'None'},
    CurrentOption = 'GPTWare',
    MultipleOptions = false,
    Flag = 'HUDSelectionDropdown',
    Callback = function(Option)
        local optionFound = false
        for _, value in ipairs(Option) do
            if value == 'GPTWare' then
                optionFound = true
                destroyHUDS()
                useGPTWareHud()
                break
            elseif value == 'Sigma Jello' then
                optionFound = true
                destroyHUDS()
                useSigmaJelloHud()
                break
            elseif value == 'LiquidBounce' then
                optionFound = true
                destroyHUDS()
                useLiquidBounceHUD()
                break
            elseif value == 'None' then
                optionFound = true
                destroyHUDS()
                break
            end
        end
        if not optionFound then
            destroyHUDS()
        end
    end,
})

ClientTab:CreateColorPicker({
    Name = "Client Theme",
    Color = Color3.fromRGB(134, 26, 240),
    Flag = "ClientThemeColorPicker",
    Callback = function(Color)
        clientTheme = Color
        if hudframe2 and hudframe2.BackgroundColor3 then hudframe2.BackgroundColor3 = Color end
        if hudtextlabel2 and hudtextlabel2.TextColor3 then hudtextlabel2.TextColor3 = Color end
    end
})

--scripts

ScriptsTab:CreateButton({
    Name = 'GPTWare: LT2 Edition',
    Callback = function()
        Rayfield:Destroy()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        game.Workspace.Gravity = 196.2
        isJumpFlying = false
        isFlying = false
        destroyHUDS()
        loadstring(game:HttpGet("https://www.lncvrt.xyz/api/gptware/script?type=lt2"))()
    end,
})

ScriptsTab:CreateButton({
    Name = 'Infinite Yield',
    Callback = function()
        if not loadedInfiniteYield then
            print('Loading Infinite Yield')
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
            Rayfield:Notify({
                Title = 'Successfully loaded external script!',
                Content = 'Infinite Yield has been loaded successfully!',
                Duration = 3,
                Image = 18635540561,
                Actions = {
                Ignore = {
                    Name = 'Okay!',
                    Callback = function()
                end
                },
            },
            })
            loadedInfiniteYield = true
        else
            Rayfield:Notify({
                Title = 'Failed to load external script!',
                Content = 'Infinite Yield has already been loaded!',
                Duration = 3,
                Image = 18635540561,
                Actions = {
                Ignore = {
                    Name = 'Okay!',
                    Callback = function()
                end
                },
            },
            })
        end
    end,
})

ScriptsTab:CreateButton({
    Name = 'SimpleBypass',
    Callback = function()
        if not loadedSimpleBypass then
            print('Loading SimpleBypass')
            loadstring(game:HttpGet('https://raw.githubusercontent.com/SkireScripts/Ouxie/main/Projects/simplebypass.lua'))()
            Rayfield:Notify({
                Title = 'Successfully loaded external script!',
                Content = 'SimpleBypass has been loaded successfully!',
                Duration = 3,
                Image = 18635540561,
                Actions = {
                Ignore = {
                    Name = 'Okay!',
                    Callback = function()
                end
                },
            },
            })
            loadedSimpleBypass = true
        else
            Rayfield:Notify({
                Title = 'Failed to load external script!',
                Content = 'SimpleBypass has already been loaded!',
                Duration = 3,
                Image = 18635540561,
                Actions = {
                Ignore = {
                    Name = 'Okay!',
                    Callback = function()
                end
                },
            },
            })
        end
    end,
})

ScriptsTab:CreateButton({
    Name = 'Vehicle Legends Auto Farmer',
    Callback = function()
        if not loadedVehicleLegendsAutoFarmer then
            print('Loading Vehicle Legends Auto Farmer')
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Marco8642/science/main/Vehicle%20legends'))()
            Rayfield:Notify({
                Title = 'Successfully loaded external script!',
                Content = 'Vehicle Legends Auto Farmer has been loaded successfully!',
                Duration = 3,
                Image = 18635540561,
                Actions = {
                Ignore = {
                    Name = 'Okay!',
                    Callback = function()
                end
                },
            },
            })
            loadedVehicleLegendsAutoFarmer = true
        else
            Rayfield:Notify({
                Title = 'Failed to load external script!',
                Content = 'Vehicle Legends Auto Farmer has already been loaded!',
                Duration = 3,
                Image = 18635540561,
                Actions = {
                Ignore = {
                    Name = 'Okay!',
                    Callback = function()
                end
                },
            },
            })
        end
    end,
})

--actions

local function onInputBegan(input, gameProcessedEvent)
    if not gameProcessedEvent then
        if input.KeyCode == Enum.KeyCode.Space then
            spacePressed = true
        elseif input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
            shiftPressed = true
        end
    end
end

local function onInputEnded(input)
    if input.KeyCode == Enum.KeyCode.Space then
        spacePressed = false
    elseif input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
        shiftPressed = false
    end
end

local function updateJumpFlyHeight()
    while true do
        local character = game.Players.LocalPlayer.Character
        local characterPosition = character.PrimaryPart.Position
        local groundHeight = workspace.Terrain:WorldToCellPreferFull(characterPosition).Y * workspace.Terrain.CellSize.Y
        if spacePressed then
            jumpFlyStartHeight = jumpFlyStartHeight + 4
        elseif shiftPressed then
            jumpFlyStartHeight = jumpFlyStartHeight - 4
        end

        if jumpFlyStartHeight < groundHeight then
            jumpFlyStartHeight = groundHeight
        end

        character:SetPrimaryPartCFrame(CFrame.new(character.PrimaryPart.Position.X, jumpFlyStartHeight, character.PrimaryPart.Position.Z))

        wait(0.1)
    end
end

userInputService.InputBegan:Connect(onInputBegan)
userInputService.InputEnded:Connect(onInputEnded)

spawn(updateJumpFlyHeight)

--huds

function destroyHUDS()
    if hud and hud.Parent then hud:Destroy() end
    if hudframe1 and hudframe1.Parent then hudframe1:Destroy() end
    if hudframe2 and hudframe2.Parent then hudframe2:Destroy() end
    if hudicorner1 and hudicorner1.Parent then hudicorner1:Destroy() end
    if hudicorner2 and hudicorner2.Parent then hudicorner2:Destroy() end
    if hudtextlabel1 and hudtextlabel1.Parent then hudtextlabel1:Destroy() end
    if hudtextlabel2 and hudtextlabel2.Parent then hudtextlabel2:Destroy() end
end

function useGPTWareHud()
    hud = Instance.new('ScreenGui')
    hudframe1 = Instance.new('Frame')
    hudframe2 = Instance.new('Frame')
    hudicorner1 = Instance.new('UICorner')
    hudicorner2 = Instance.new('UICorner')
    hudtextlabel1 = Instance.new('TextLabel')
    
    hud.Name = 'GPTWare HUD'
    hud.Parent = game.Players.LocalPlayer:WaitForChild('PlayerGui')
    hud.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    hudframe1.Parent = hud
    hudframe1.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    hudframe1.BackgroundTransparency = 0.500
    hudframe1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    hudframe1.BorderSizePixel = 0
    hudframe1.Position = UDim2.new(0.0172413867, 0, 0.932330906, 0)
    hudframe1.Size = UDim2.new(0, 251, 0, 33)

    hudicorner1.Parent = hudframe1

    hudtextlabel1.Parent = hudframe1
    hudtextlabel1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hudtextlabel1.BackgroundTransparency = 1.00
    hudtextlabel1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    hudtextlabel1.BorderSizePixel = 0
    hudtextlabel1.Position = UDim2.new(0, 0, 0.32294035, 0)
    hudtextlabel1.Size = UDim2.new(0, 250, 0, 20)
    hudtextlabel1.Font = Enum.Font.Sarpanch
    hudtextlabel1.Text = 'GPTWare | Free Version | v0.0.1'
    hudtextlabel1.TextColor3 = Color3.fromRGB(255, 255, 255)
    hudtextlabel1.TextScaled = true
    hudtextlabel1.TextSize = 30.000
    hudtextlabel1.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    hudtextlabel1.TextWrapped = true

    hudframe2.Parent = hudframe1
    hudframe2.BackgroundColor3 = clientTheme
    hudframe2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    hudframe2.BorderSizePixel = 0
    hudframe2.Position = UDim2.new(0.0270000007, 0, 0.200000003, 0)
    hudframe2.Size = UDim2.new(0, 240, 0, 5)

    hudicorner2.Parent = hudframe2
end

function useSigmaJelloHud()
    hud = Instance.new('ScreenGui')
    hudframe1 = Instance.new('Frame')
    hudtextlabel1 = Instance.new('TextLabel')
    hudtextlabel2 = Instance.new('TextLabel')

    hud.Name = 'Sigma Jello HUD'
    hud.Parent = game.Players.LocalPlayer:WaitForChild('PlayerGui')
    hud.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    hudframe1.Parent = hud
    hudframe1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hudframe1.BackgroundTransparency = 1.00
    hudframe1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    hudframe1.BorderSizePixel = 0
    hudframe1.Position = UDim2.new(0.0209999997, 0, 0.0209999997, 0)
    hudframe1.Size = UDim2.new(0, 228, 0, 104)

    hudtextlabel1.Parent = hudframe1
    hudtextlabel1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hudtextlabel1.BackgroundTransparency = 1.00
    hudtextlabel1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    hudtextlabel1.BorderSizePixel = 0
    hudtextlabel1.Position = UDim2.new(-0.122807018, 0, 0.00961538497, 0)
    hudtextlabel1.Size = UDim2.new(0, 200, 0, 50)
    hudtextlabel1.Font = Enum.Font.SourceSansLight
    hudtextlabel1.Text = 'G P T'
    hudtextlabel1.TextColor3 = Color3.fromRGB(255, 255, 255)
    hudtextlabel1.TextSize = 69.000
    hudtextlabel1.TextTransparency = 0.500

    hudtextlabel2.Parent = hudframe1
    hudtextlabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hudtextlabel2.BackgroundTransparency = 1.00
    hudtextlabel2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    hudtextlabel2.BorderSizePixel = 0
    hudtextlabel2.Position = UDim2.new(-0.232456148, 0, 0.490384609, 0)
    hudtextlabel2.Size = UDim2.new(0, 200, 0, 24)
    hudtextlabel2.Font = Enum.Font.SourceSansLight
    hudtextlabel2.Text = 'Ware'
    hudtextlabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
    hudtextlabel2.TextSize = 37.000
    hudtextlabel2.TextTransparency = 0.500
end

function useLiquidBounceHUD()
    hud = Instance.new('ScreenGui')
    hudtextlabel1 = Instance.new('TextLabel')
    hudtextlabel2 = Instance.new('TextLabel')

    hud.Name = 'LiquidBounce HUD'
    hud.Parent = game.Players.LocalPlayer:WaitForChild('PlayerGui')
    hud.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    hudtextlabel1.Parent = hud
    hudtextlabel1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hudtextlabel1.BackgroundTransparency = 1.00
    hudtextlabel1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    hudtextlabel1.BorderSizePixel = 0
    hudtextlabel1.Position = UDim2.new(0.0164203607, 0, 0.012531328, 0)
    hudtextlabel1.Size = UDim2.new(0, 200, 0, 57)
    hudtextlabel1.Font = Enum.Font.SourceSansBold
    hudtextlabel1.Text = 'GPTBounce'
    hudtextlabel1.TextColor3 = Color3.fromRGB(0, 0, 0)
    hudtextlabel1.TextSize = 56.000
    hudtextlabel1.TextTransparency = 0.200

    hudtextlabel2.Parent = hud
    hudtextlabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hudtextlabel2.BackgroundTransparency = 1.00
    hudtextlabel2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    hudtextlabel2.BorderSizePixel = 0
    hudtextlabel2.Position = UDim2.new(0.0106732352, 0, -9.56064472e-09, 0)
    hudtextlabel2.Size = UDim2.new(0, 207, 0, 68)
    hudtextlabel2.Font = Enum.Font.SourceSansBold
    hudtextlabel2.Text = 'GPTBounce'
    hudtextlabel2.TextColor3 = clientTheme
    hudtextlabel2.TextSize = 56.000
end

useGPTWareHud()

--functions

function round(num, decimals)
    local multiplier = 10 ^ (decimals or 0)
    return math.floor(num * multiplier + 0.5) / multiplier
end

function roundIncremental(value, increment)
    return round(value / increment) * increment
end

function min(a, b)
    return a < b and a or b
end

function max(a, b)
    return a > b and a or b
end

function constrainToRange(value, minValue, maxValue)
    if value < minValue then
        return minValue
    end

    if value > maxValue then
        return maxValue
    end

    return value
end

function teleportToPlayer(targetPlayerName)
    local character = game.Players.LocalPlayer.Character
    local targetPlayer = nil

    for _, p in ipairs(game.Players:GetPlayers()) do
        if p.Name == targetPlayerName then
            targetPlayer = p
            break
        end
    end

    if targetPlayer then
        if targetPlayer == game.Players.LocalPlayer then
            Rayfield:Notify({
                Title = 'Failed to teleport to player!',
                Content = 'Cannot teleport to yourself',
                Duration = 3,
                Image = 18635540561,
                Actions = {
                Ignore = {
                    Name = 'Okay!',
                    Callback = function()
                end
                },
            },
            })
        else
            local targetChar = targetPlayer.Character
            if targetChar and targetChar:FindFirstChild('HumanoidRootPart') then
                local targetHRP = targetChar.HumanoidRootPart
                local targetPosition = targetHRP.Position
                local targetOrientation = targetHRP.CFrame - targetHRP.Position

                if character and character:FindFirstChild('HumanoidRootPart') then
                    local localHRP = character.HumanoidRootPart
                    localHRP.CFrame = CFrame.new(targetPosition) * targetOrientation
                end
            else
                Rayfield:Notify({
                    Title = 'Failed to teleport to player!',
                    Content = 'Target player does not have a HumanoidRootPart.',
                    Duration = 3,
                    Image = 18635540561,
                    Actions = {
                    Ignore = {
                        Name = 'Okay!',
                        Callback = function()
                    end
                    },
                },
                })
            end
        end
    else
        Rayfield:Notify({
            Title = 'Failed to teleport to player!',
            Content = 'Target not found',
            Duration = 3,
            Image = 18635540561,
            Actions = {
            Ignore = {
                Name = 'Okay!',
                Callback = function()
            end
            },
        },
        })
    end
end