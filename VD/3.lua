local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer

_G.SkillHelper = false 

-- [[ SCANNER ]] --
local function getNearbyGen()
    local char = LP.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local camera = workspace.CurrentCamera
    if not root then return nil, nil end

    local bestTarget = nil
    local bestScore = -1

    local folder = workspace:FindFirstChild("Map") or workspace
    
    for _, v in pairs(folder:GetDescendants()) do
        if v.Name:find("GeneratorPoint") and v:IsA("BasePart") then
            local dist = (v.Position - root.Position).Magnitude
            
            if dist < 5 then
                local directionToPoint = (v.Position - camera.CFrame.Position).Unit
                local lookDirection = camera.CFrame.LookVector
                local dotProduct = directionToPoint:Dot(lookDirection)
                if dotProduct > bestScore then
                    bestScore = dotProduct
                    bestTarget = v
                end
            end
        end
    end

    if bestTarget then
        return bestTarget, bestTarget.Parent
    end
    return nil, nil
end

local function CreateToggle(name, order, callback)
    -- 1. Container Baris
    local Row = Instance.new("Frame", _G.ScrollTab3)
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
        callback(enabled)
    end)
end

CreateToggle("Bypass Gene", 1, function(state)
_G.SkillHelper = state
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        
        if _G.SkillHelper then
            local point, folder = getNearbyGen()
            
            if point and folder then
                pcall(function()
                    local remotes = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("Generator")
                    if remotes then
                        remotes.SkillCheckResultEvent:FireServer("success", 1, folder, point)
                    end
                end)
            end
        end
    end
end)