local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local DropdownBtn = Instance.new("TextButton")
local PlayerList = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local TeleportBtn = Instance.new("TextButton")
local AutoTeleToggle = Instance.new("TextButton")

-- 2. SETUP DROPDOWN
DropdownBtn.Name = "DropdownBtn"
DropdownBtn.Parent = _G.ScrollTab5
DropdownBtn.Size = UDim2.new(0.9, 0, 0, 35)
DropdownBtn.LayoutOrder = 2
DropdownBtn.Text = "v Pilih Player v"
DropdownBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
DropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", DropdownBtn)

-- Player List (Daftar yang muncul saat diklik)
PlayerList.Name = "PlayerList"
PlayerList.Parent = _G.ScrollTab5
PlayerList.Size = UDim2.new(0.9, 0, 0, 100) --Ukuran box list
PlayerList.CanvasSize = UDim2.new (0, 0, 0, 150)
PlayerList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PlayerList.Visible = false 
PlayerList.LayoutOrder = 3
Instance.new("UICorner", PlayerList)

UIListLayout.Parent = PlayerList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- 3. SETUP TOMBOL AKSI
TeleportBtn.Name = "TeleportBtn"
TeleportBtn.Parent = _G.ScrollTab5
TeleportBtn.Size = UDim2.new(0.9, 0, 0, 35)
TeleportBtn.LayoutOrder = 4
TeleportBtn.Text = "TELEPOT"
TeleportBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
TeleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TeleportBtn)

AutoTeleToggle.Name = "AutoTeleToggle"
AutoTeleToggle.Parent = _G.ScrollTab5
AutoTeleToggle.Size = UDim2.new(0.9, 0, 0, 35)
AutoTeleToggle.LayoutOrder = 5
AutoTeleToggle.Text = "AUTO-TELE: OFF"
AutoTeleToggle.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
AutoTeleToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", AutoTeleToggle)

--- LOGIC SISTEM ---
local selectedPlayer = nil
local autoTeleport = false
local dropdownOpen = false

local function updatePlayerList()
    -- Bersihkan list lama (kecuali UIListLayout)
    for _, child in pairs(PlayerList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer then
            local pBtn = Instance.new("TextButton")
            pBtn.Parent = PlayerList
            pBtn.Size = UDim2.new(1, 0, 0, 30)
            pBtn.Text = p.DisplayName or p.Name
            pBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.BorderSizePixel = 0
            
            pBtn.MouseButton1Click:Connect(function()
                selectedPlayer = p.Name
                DropdownBtn.Text = "Lock: " .. p.DisplayName
                PlayerList.Visible = false
                dropdownOpen = false
            end)
        end
    end
end

DropdownBtn.MouseButton1Click:Connect(function()
    dropdownOpen = not dropdownOpen
    PlayerList.Visible = dropdownOpen
    if dropdownOpen then updatePlayerList() end
end)

TeleportBtn.MouseButton1Click:Connect(function()
    if selectedPlayer and game.Players:FindFirstChild(selectedPlayer) then
        local targetChar = game.Players[selectedPlayer].Character
        local myChar = game.Players.LocalPlayer.Character
        if targetChar and targetChar:FindFirstChild("HumanoidRootPart") and myChar:FindFirstChild("HumanoidRootPart") then
            myChar.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
        end
    end
end)

AutoTeleToggle.MouseButton1Click:Connect(function()
    autoTeleport = not autoTeleport
    AutoTeleToggle.Text = "AUTO-TELE: " .. (autoTeleport and "ON" or "OFF")
    AutoTeleToggle.BackgroundColor3 = autoTeleport and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

task.spawn(function()
    while task.wait(0.1) do
        if autoTeleport and selectedPlayer and game.Players:FindFirstChild(selectedPlayer) then
            pcall(function()
                local targetChar = game.Players[selectedPlayer].Character
                local myRoot = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if targetChar and targetChar:FindFirstChild("HumanoidRootPart") and myRoot then
                    myRoot.CFrame = targetChar.HumanoidRootPart.CFrame
                end
            end)
        end
    end
end)