local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local SelectedPlayer = nil
_G.AntiBlind = false


local function CreateToggle(name, order, callback)
    -- 1. Container Baris
    local Row = Instance.new("Frame", _G.ScrollTab2)
    Row.Size = UDim2.new(0.95, 0, 0, 30)
    Row.BackgroundTransparency = 1
    Row.LayoutOrder = order

    local Label = Instance.new("TextLabel", Row)
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 5, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextSize = 10

    local Btn = Instance.new("TextButton", Row)
    Btn.Size = UDim2.new(0, 40, 0, 20)
    Btn.Position = UDim2.new(1, -5, 0.5, 0)
    Btn.AnchorPoint = Vector2.new(1, 0.5)
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

local Library = Instance.new("ScreenGui")
Library.Parent = CoreGui

local SantetFrame = Instance.new("Frame")
SantetFrame.Parent = Library
SantetFrame.BackgroundTransparency = 0.3
SantetFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
SantetFrame.Size = UDim2.new(0, 90, 0, 90)
SantetFrame.Active = true
SantetFrame.Draggable = true
SantetFrame.Visible = false

CreateToggle("Mode Santet (Hidden)", 1, function(state)
SantetFrame.Visible = state
end)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = _G.ScrollTab2
StatusLabel.Position = UDim2.new(0, 10, 0, 40)
StatusLabel.Size = UDim2.new(0, 200, 0, 40)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Mencari Target..."
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 10

local ExecuteBtn = Instance.new("TextButton")
ExecuteBtn.Name = "ExecuteBtn"
ExecuteBtn.Parent = SantetFrame
ExecuteBtn.Position = UDim2.new(0.2, 0, 0.2, 0)
ExecuteBtn.Size = UDim2.new(0.6, 0, 0.6, 0)
ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ExecuteBtn.Text = "😈"
ExecuteBtn.TextSize = 14
ExecuteBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", ExecuteBtn).CornerRadius = UDim.new(1, 0)


local function GetNearestPlayer()
	local closestPlayer = nil
	local shortestDistance = math.huge
	
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			
			local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
			
			if distance < shortestDistance then
				shortestDistance = distance
				closestPlayer = player
			end
		end
	end
	return closestPlayer, shortestDistance
end

RunService.RenderStepped:Connect(function()
	local target, dist = GetNearestPlayer()
	
	if target then
		SelectedPlayer = target
		StatusLabel.Text = "Santet: " .. target.Name .. "\nJarak: " .. math.floor(dist) .. " cm"
		ExecuteBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	else
		SelectedPlayer = nil
		StatusLabel.Text = "Tidak ada target di sekitar."
		ExecuteBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	end
end)

ExecuteBtn.MouseButton1Click:Connect(function()
	if SelectedPlayer and SelectedPlayer.Character then
		local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
		if remote then
			local m2 = remote:WaitForChild("Killers"):WaitForChild("Hidden"):WaitForChild("M2")
			
			local args = {
				{ SelectedPlayer.Character },
				false
			}
			
			m2:FireServer(unpack(args))
			print("M2 Fired to nearest: " .. SelectedPlayer.Name)
		end
	end
end)

local PersuitFrame = Instance.new("Frame")
PersuitFrame.Size = UDim2.new(0, 90, 0, 90)
PersuitFrame.Position = UDim2.new(0.5, -50, 0.4, -20)
PersuitFrame.BackgroundTransparency = 0.3
PersuitFrame.BorderSizePixel = 0
PersuitFrame.Active = true
PersuitFrame.Draggable = true 
PersuitFrame.Visible = false
PersuitFrame.Parent = Library

CreateToggle("Persuit (Jason)", 2, function(state)
PersuitFrame.Visible = state
end)

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = PersuitFrame

local actionBtn = Instance.new("TextButton")
actionBtn.Size = UDim2.new(0.6, 0, 0.6, 0)
actionBtn.Position = UDim2.new(0.3, 0, 0.3, 0)
actionBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
actionBtn.Text = "🤙"
actionBtn.TextColor3 = Color3.new(1, 1, 1)
actionBtn.Font = Enum.Font.GothamBold
actionBtn.TextSize = 14
actionBtn.Parent = PersuitFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(1, 0)
btnCorner.Parent = actionBtn

actionBtn.MouseButton1Click:Connect(function()
    local args = { true }
    
    local remote = game:GetService("ReplicatedStorage")
        :WaitForChild("Remotes")
        :WaitForChild("Killers")
        :WaitForChild("Jason")
        :WaitForChild("Pursuit")
    
    -- Eksekusi
    remote:FireServer(unpack(args))
end)


local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    
    if _G.AntiBlind and method == "FireServer" and self.Name == "GotBlinded" then
        return nil 
    end
    
    return oldNamecall(self, ...)
end)

CreateToggle("Anti Senter [Beta]", 3, function(state)
_G.AntiBlind = state
end)