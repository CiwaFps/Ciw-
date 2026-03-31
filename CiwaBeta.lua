if _G.CiwaLoading then 
    return
end

_G.CiwaLoading = true

local VERSION = "1.0"
local HUB_NAME = "Ciwa Notifikasi"
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local MainGui = Instance.new("ScreenGui", CoreGui)
MainGui.Name = HUB_NAME
local Holder = Instance.new("Frame", MainGui)
Holder.Size = UDim2.new(0, 250, 1, -20)
Holder.Position = UDim2.new(1, -10, 0, 10)
Holder.AnchorPoint = Vector2.new(1, 0)
Holder.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", Holder)
Layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
Layout.Padding = UDim.new(0, 8)

local function Notify(text, color)
    color = color or Color3.fromRGB(30, 30, 30)
    
    local f = Instance.new("Frame", Holder)
    f.BackgroundColor3 = color
    f.BackgroundTransparency = 0.2
    f.AutomaticSize = Enum.AutomaticSize.X 
    f.Size = UDim2.new(0, 0, 0, 45)
    f.Position = UDim2.new(2, 0, 0, 0) 
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local sizeConstraint = Instance.new("UISizeConstraint", f)
    sizeConstraint.MinSize = Vector2.new(120, 45)
    sizeConstraint.MaxSize = Vector2.new(350, 45)

    local loading = Instance.new("Frame", f)
    loading.Size = UDim2.new(0, 20, 0, 20)
    loading.Position = UDim2.new(0, 12, 0.5, 0)
    loading.AnchorPoint = Vector2.new(0, 0.5)
    loading.BackgroundColor3 = Color3.new(1, 1, 1)
    loading.BackgroundTransparency = 0.8 
    Instance.new("UICorner", loading).CornerRadius = UDim.new(1, 0) 
    
    local spinner = Instance.new("Frame", loading)
    spinner.Size = UDim2.new(0, 4, 0, 10)
    spinner.BorderSizePixel = 0
    spinner.Position = UDim2.new(0.5, 0, 0, 0)
    spinner.AnchorPoint = Vector2.new(0.5, 0)
    spinner.BackgroundColor3 = Color3.new(1, 1, 1)
    
    task.spawn(function()
        while f.Parent do
            loading.Rotation = loading.Rotation + 10
            task.wait(0.02)
        end
    end)

    local l = Instance.new("TextLabel", f)
    l.AutomaticSize = Enum.AutomaticSize.X
    l.Size = UDim2.new(0, 0, 1, 0)
    l.Position = UDim2.new(0, 40, 0, 0)
    l.Text = text
    l.TextColor3 = Color3.new(1, 1, 1)
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.GothamBold
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Left

    local padding = Instance.new("UIPadding", f)
    padding.PaddingRight = UDim.new(0, 15)

    TweenService:Create(f, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()

    task.delay(4, function()
        local slideOut = TweenService:Create(f, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(2, 0, 0, 0),
            BackgroundTransparency = 1
        })
        slideOut:Play()
        slideOut.Completed:Connect(function()
    f:Destroy()
    if #Holder:GetChildren() <= 1 then
        MainGui:Destroy()
        warn(string.format("[%s] Sudah Di Hapus Ya Kontol: %s", HUB_NAME, tostring(err)))
    end
end)
    end)
end

Notify("Memeriksa ID: " .. tostring(universeId), Color3.fromRGB(204, 255, 255))
task.wait(2)

local games = {
    [6739698191] = "https://raw.githubusercontent.com/CiwaFps/Ciw-/refs/heads/main/Game/Ciwa%20x%20VD.lua",
}

local UNIVERSAL_SCRIPT = "https://raw.githubusercontent.com/Username/Repo/main/ScriptBebas.lua"

local universeId = game.GameId
local scriptURL  = games[universeId]

if scriptURL then
    Notify("Game Terdaftar", Color3.fromRGB(153, 153, 255))
    local ok, err = pcall(function()
        loadstring(game:HttpGet(scriptURL))()
    end)

    if not ok then
        warn(string.format("[%s] Gagal load script khusus: %s", HUB_NAME, tostring(err)))
    end
else
    Notify("Game Tidak Terdaftar", Color3.fromRGB(204, 255, 204))
    local ok, err = pcall(function()
        loadstring(game:HttpGet(UNIVERSAL_SCRIPT))()
    end)

    if not ok then
        warn(string.format("[%s] Gagal load script bebas: %s", HUB_NAME, tostring(err)))
    end
end

task.wait(5)
_G.CiwaLoading = false
