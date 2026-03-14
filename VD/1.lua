    local function CreateInput(name, order)
    local InputRow = Instance.new("Frame", _G.ScrollTab1)
    InputRow.Size = UDim2.new(0.95, 0, 0, 30)
    InputRow.BackgroundTransparency = 1
    InputRow.LayoutOrder = order

    -- 2. Label Teks (Di Kiri)
    local InputLabel = Instance.new("TextLabel", InputRow)
    InputLabel.Size = UDim2.new(0.7, 0, 1, 0)
    InputLabel.Position = UDim2.new(0, 5, 0, 0)
    InputLabel.BackgroundTransparency = 1
    InputLabel.Text = name
    InputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputLabel.TextXAlignment = Enum.TextXAlignment.Left
    InputLabel.TextSize = 17
    InputLabel.Font = Enum.Font.SourceSans

    -- 3. Box Input (Di Kanan)
    local InputBox = Instance.new("TextBox", InputRow)
    InputBox.Size = UDim2.new(0, 80, 0, 25)
    InputBox.Position = UDim2.new(1, -5, 0.5, 0)
    InputBox.AnchorPoint = Vector2.new(1, 0.5)
    InputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    InputBox.BorderSizePixel = 0
    InputBox.ClearTextOnFocus = false
    InputBox.Text = ""
    InputBox.PlaceholderText = ""
    InputBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
    InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputBox.TextSize = 13
    InputBox.Font = Enum.Font.SourceSans
    InputBox.ClipsDescendants = true
    
    Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 4)

    return InputBox
end
     
    --HELLPER BUTTON--
    local function CreateToggle(name, order, callback)
    -- 1. Container Baris
    local Row = Instance.new("Frame", _G.ScrollTab1)
    Row.Size = UDim2.new(0.95, 0, 0, 30)
    Row.BackgroundTransparency = 1
    Row.LayoutOrder = order

    -- 2. Label Teks (Di Kiri)
    local Label = Instance.new("TextLabel", Row)
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 5, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextSize = 10

    -- 3. Tombol Toggle (Di Kanan Jauh)
    local Btn = Instance.new("TextButton", Row)
    Btn.Size = UDim2.new(0, 40, 0, 20)
    Btn.Position = UDim2.new(1, -5, 0.5, 0) -- Menempel ke kanan (index 1)
    Btn.AnchorPoint = Vector2.new(1, 0.5)   -- Titik tumpu di kanan tengah
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Btn.Text = "OFF"
    Btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    Instance.new("UICorner", Btn)

    -- Logika Klik
    local enabled = false
    Btn.Activated:Connect(function()
        enabled = not enabled
        Btn.Text = enabled and "ON" or "OFF"
        Btn.TextColor3 = enabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        callback(enabled) -- Menjalankan fungsi yang diinginkan
    end)
end


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")


_G.Speed = 45
_G.Move = false
_G.Fly = false
_G.NoClip = false


local NoClipLoop = RunService.Stepped:Connect(function()
    if _G.NoClip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

local SpeedInput = CreateInput("Move / Fly Speed", 1)
SpeedInput.FocusLost:Connect(function() _G.Speed = tonumber(SpeedInput.Text) or 50 end)

CreateToggle("Move Mode [All Game]", 2, function(state)
 _G.Move = state
    if _G.Move then
        bv = Instance.new("BodyVelocity", player.Character.HumanoidRootPart)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0, 0)
    else
        if bv then bv:Destroy() end
    end
end)

RunService.RenderStepped:Connect(function()
  if _G.Move and bv then
            local moveDir = player.Character.Humanoid.MoveDirection
            player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + (moveDir * (_G.Speed / 45))
        end
end)

CreateToggle("Fly Mode [All Game]", 3, function(state)
_G.Fly = state
  
  local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")

        if _G.Fly then
        hum.PlatformStand = true 
        local bg = Instance.new("BodyGyro", root)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = root.CFrame 
        local bv = Instance.new("BodyVelocity", root)
        bv.velocity = Vector3.new(0, 0, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)

task.spawn(function()
            while _G.Fly do
                local moveDir = hum.MoveDirection
                bg.cframe = camera.CFrame
                if moveDir.Magnitude > 0 then
                    local verticalInput = camera.CFrame.LookVector.Y
                    local flyVelocity = moveDir * _G.Speed
                    local yDirection = 0
                    if moveDir.Magnitude > 0 then
                        yDirection = camera.CFrame.LookVector.Y * _G.Speed
                    end 
                    bv.velocity = Vector3.new(flyVelocity.X, yDirection, flyVelocity.Z)
                else
                    bv.velocity = Vector3.new(0, 0.1, 0)
                end
                task.wait()
                if not _G.Fly or not root then break end
            end
            if bg then bg:Destroy() end
            if bv then bv:Destroy() end
            hum.PlatformStand = false
         end)
      end
end)

CreateToggle("No Clip [All Game]", 4, function(state)
_G.NoClip = state

local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
        if char then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
            
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Physics)
                task.wait(0.1)
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
            
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.Velocity = Vector3.new(0, 0, 0)
                root.RotVelocity = Vector3.new(0, 0, 0)
            end
       end
end)