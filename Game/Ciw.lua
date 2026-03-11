local Players = game:GetService("Players")
local LP = Players.LocalPlayer

_G.Master = false
_G.ShowGen = false
_G.ShowPallet = false
_G.ShowKiller = false
_G.ShowPlayer = false
_G.ShowExit = false
_G.ShowWindow = false

local MasterBtn = Instance.new("TextButton", _G.ScrollTab4)
MasterBtn.Size = UDim2.new(0.9, 0, 0, 35)
MasterBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
MasterBtn.Text = "ESP: OFF"
MasterBtn.TextColor3 = Color3.new(1, 1, 1)
MasterBtn.Font = Enum.Font.SourceSansBold
MasterBtn.LayoutOrder = 1
Instance.new("UICorner", MasterBtn).CornerRadius = UDim.new(0, 6)

MasterBtn.MouseButton1Click:Connect(function()
    _G.Master = not _G.Master
    MasterBtn.Text = "ESP: " .. (_G.Master and "ON" or "OFF")
    MasterBtn.BackgroundColor3 = _G.Master and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(150, 0, 0)
end)

local function CreateRow(display, var, defaultColor, order)
    local Row = Instance.new("Frame", _G.ScrollTab4)
    Row.Size = UDim2.new(0.9, 0, 0, 30)
    Row.BackgroundTransparency = 1
    Row.LayoutOrder = order

    local label = Instance.new("TextLabel", Row)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Text = display
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.SourceSans
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("TextButton", Row)
    box.Size = UDim2.new(0, 20, 0, 20)
    box.Position = UDim2.new(0.85, 0, 0.15, 0)
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    box.Text = ""
    box.TextColor3 = defaultColor
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)

    box.MouseButton1Click:Connect(function()
        _G[var] = not _G[var]
        box.Text = _G[var] and "X" or ""
        box.TextColor3 = _G[var] and defaultColor or Color3.fromRGB(40, 40, 40)
    end)
end

CreateRow("Generator", "ShowGen", Color3.fromRGB(255, 0, 0), 2)
CreateRow("Pallets", "ShowPallet", Color3.fromRGB(0, 170, 255), 3)
CreateRow("Killer", "ShowKiller", Color3.fromRGB(255, 0, 255), 4)
CreateRow("Players", "ShowPlayer", Color3.fromRGB(0, 255, 0), 5)
CreateRow("Exit Lever", "ShowExit", Color3.new(1, 1, 1), 6)
CreateRow("Windows", "ShowWindow", Color3.fromRGB(0, 255, 255), 7)

-- [[ FUNGSI WINDOW ESP ]] --
local function ApplyBoxESP(object, color, typeVar)
    if not object or object:FindFirstChild("Window_ESP") then return end
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "Window_ESP"
    box.Size = object.Size + Vector3.new(0.1, 0.1, 0.1)
    box.AlwaysOnTop = true
    box.ZIndex = 5
    box.Transparency = 0.5
    box.Color3 = color
    box.Adornee = object
    box.Visible = false
    box.Parent = object
    task.spawn(function()
        while object and object.Parent do
            box.Visible = (_G.Master and _G[typeVar])
            task.wait(1)
        end
    end)
end

-- [[ FUNGSI HIGHLIGHT ESP ]] --
local function ApplyGlow(object, color, typeVar)
    if not object or object:FindFirstChild("Glow_ESP") then return end
    local hl = Instance.new("Highlight")
    hl.Name = "Glow_ESP"
    hl.FillColor = color
    hl.OutlineColor = Color3.new(1, 1, 1)
    hl.FillTransparency = 0.5
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Enabled = false
    hl.Parent = object
    task.spawn(function()
        while object and object.Parent do
            hl.Enabled = (_G.Master and _G[typeVar])
            task.wait(1)
        end
    end)
end

-- [[ SCANNER DINAMIS ]] --
local function ProcessObject(item)
    if item.Name == "Bottom" and item.Parent.Name == "Window" then
        ApplyBoxESP(item, Color3.fromRGB(0, 255, 255), "ShowWindow")
    elseif item.Name == "PrimaryPartPallet" then
        ApplyGlow(item.Parent, Color3.fromRGB(0, 170, 255), "ShowPallet")
    elseif item.Name == "ExitLever" then
        ApplyGlow(item, Color3.new(1, 1, 1), "ShowExit")
    elseif (item.Name == "HitBox" or item.Name == "Hitbox") and item:FindFirstChild("PointLight") then
        ApplyGlow(item.Parent, Color3.fromRGB(255, 0, 0), "ShowGen")
    end
end

-- [[ MONITOR PLAYER & KILLER ]] --
local function MonitorPlayer(p)
    if p == LP then return end
    
    local function Setup(char)
        if not char then return end
        
        task.spawn(function()
            while char and char.Parent do
                local isKiller = char:FindFirstChild("Weapon")
                
                local color = isKiller and Color3.fromRGB(255, 0, 255) or Color3.fromRGB(0, 255, 0)
                local typeVar = isKiller and "ShowKiller" or "ShowPlayer"
                if not char:FindFirstChild("Glow_ESP") then
                    ApplyGlow(char, color, typeVar)
                else
                    local hl = char.Glow_ESP
                    hl.FillColor = color
                    hl.Enabled = (_G.Master and _G[typeVar])
                end

                task.wait(1)
            end
        end)
    end
    p.CharacterAdded:Connect(Setup)
    if p.Character then Setup(p.Character) end
end

-- [[ RUNNING SCRIPT ]] --
workspace.DescendantAdded:Connect(ProcessObject)

for _, p in pairs(Players:GetPlayers()) do 
    MonitorPlayer(p) 
end
Players.PlayerAdded:Connect(MonitorPlayer)

-- Scan Map Awal
for _, item in pairs(workspace:GetDescendants()) do 
    ProcessObject(item) 
end
