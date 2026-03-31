local M = {}
local SGui, FGui, CategoryTab, ContentTab

function M.CreateWindows()
local CoreGui = game:GetService("CoreGui")
local oldGui = CoreGui:FindFirstChild(WoGuiName)
if oldGui then
    oldGui:Destroy()
end
SGui = Instance.new("ScreenGui", CoreGui)
SGui.Name = WoGuiName
SGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
FGui = Instance.new("CanvasGroup", SGui)
FGui.Size = UDim2.new(0, 400, 0, 254)
FGui.GroupTransparency = 0.1
FGui.ClipsDescendants = true
FGui.Position = UDim2.new(0.5, -168, 0.5, -117)
FGui.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
FGui.Active = true
FGui.Visible = true
FGui.Draggable = true
local FGuiCorner = Instance.new("UICorner", FGui)
FGuiCorner.CornerRadius = UDim.new(0, 5)

local MiniBtn = Instance.new("TextButton", FGui)
MiniBtn.Size = UDim2.new(0, 25, 0, 25)
MiniBtn.Position = UDim2.new(1, -35, 0, 7)
MiniBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MiniBtn.BackgroundTransparency = 1
MiniBtn.Text = "—"
MiniBtn.ZIndex = 20
MiniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniBtn.Font = Enum.Font.GothamBold
MiniBtn.TextSize = 18
local MiniCorner = Instance.new("UICorner", MiniBtn)
MiniCorner.CornerRadius = UDim.new(0, 5)
local LineFrame = Instance.new("Frame", FGui)
LineFrame.Size = UDim2.new(1, 0, 0, 1)
LineFrame.Position = UDim2.new(0, 0, 0, 37)
LineFrame.BorderSizePixel = 0
LineFrame.ZIndex = 21
LineFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
local OpenBtn = Instance.new("TextButton", SGui)
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0, 20, 0.5, -25)
OpenBtn.BackgroundTransparency = 1
OpenBtn.Text = "🧐"
OpenBtn.TextSize = 28
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true
local OpenCorner = Instance.new("UICorner", OpenBtn)
OpenCorner.CornerRadius = UDim.new(1, 0)
MiniBtn.MouseButton1Click:Connect(function()
    FGui.Visible = false
    OpenBtn.Visible = true
end)
OpenBtn.MouseButton1Click:Connect(function()
    FGui.Visible = true
    OpenBtn.Visible = false
end)
CategoryTab = Instance.new("Frame", FGui)
CategoryTab.BackgroundTransparency = 1
CategoryTab.BorderSizePixel = 0
CategoryTab.Size = UDim2.new(0, 110, 1, -50)
CategoryTab.Position = UDim2.new(0, 5, 0, 40)
local CaTabCorner = Instance.new("UICorner", CategoryTab)
CaTabCorner.CornerRadius = UDim.new(0, 5)
local ListLayout = Instance.new("UIListLayout", CategoryTab)
    ListLayout.Padding = UDim.new(0, 5)
    ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder  
ContentTab = Instance.new("Frame", FGui)
ContentTab.BackgroundTransparency = 1
ContentTab.BorderSizePixel = 0
ContentTab.ClipsDescendants = true
ContentTab.Size = UDim2.new(1, -130, 1, -50)
ContentTab.Position = UDim2.new(0, 120, 0, 40)
local CoTabCorner = Instance.new("UICorner", ContentTab)
CoTabCorner.CornerRadius = UDim.new(0, 5)
end

function M.CreateTitle(name)
local UItext = Instance.new("TextLabel", FGui)
UItext.Size = UDim2.new(1, 0, 0, 40)
UItext.Position = UDim2.new(0, 0, 0, 0)
UItext.TextColor3 = Color3.fromRGB(205, 153, 255)
UItext.Text = "     Ciwa  さん      |          " .. name
UItext.BackgroundTransparency = 1
UItext.BorderSizePixel = 0
UItext.TextSize = 13
UItext.ZIndex = 18
UItext.TextXAlignment = Enum.TextXAlignment.Left
UItext.Font = Enum.Font.GothamBold
local UICorner = Instance.new("UICorner", UItext)
UICorner.CornerRadius = UDim.new(0, 5)
end


function M.CreateScroll(name, visible)
    local ScrollMenu = Instance.new("ScrollingFrame", ContentTab)
    ScrollMenu.Name = name
    ScrollMenu.Size = UDim2.new(1, 0, 1, 0)
    ScrollMenu.BackgroundTransparency = 1
    ScrollMenu.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollMenu.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollMenu.ScrollBarThickness = 0
    ScrollMenu.VerticalScrollBarInset = Enum.ScrollBarInset.None
    ScrollMenu.Visible = visible
    ScrollMenu.ClipsDescendants = true
    local ScrollLayout = Instance.new("UIListLayout", ScrollMenu)
    ScrollLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ScrollLayout.Padding = UDim.new(0, 5)
    ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
    local ScrollLayoutP = Instance.new("UIPadding", ScrollMenu)
    ScrollLayoutP.PaddingTop = UDim.new(0, 2)
    ScrollLayoutP.PaddingBottom = UDim.new(0, 5)    
    return ScrollMenu
end
function M.CreateButtonTab(name, order, callback)
    local Btn = Instance.new("TextButton")
    Btn.Name = name
    Btn.Parent = CategoryTab
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Btn.BackgroundTransparency = 1
    Btn.Text = "      " .. name
    Btn.TextColor3 = Color3.fromRGB(224, 224, 224)
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 13
    Btn.LayoutOrder = order
    Btn.Activated:Connect(function()
        for _, v in pairs(ContentTab:GetChildren()) do
            if v:IsA("TextButton") then
                v.BackgroundTransparency = 1
                v.TextColor3 = Color3.fromRGB(224, 224, 224)
            end
        end
        Btn.BackgroundTransparency = 0
        Btn.TextColor3 = Color3.fromRGB(205, 153, 255)
        callback()
    end)
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    return Btn
end
function M.CreateCollapse(title, parent, layoutOrder)
    local Main = Instance.new("Frame")
    Main.Name = title
    Main.Size = UDim2.new(1, 0, 0, 35) 
    Main.Parent = parent
    Main.LayoutOrder = layoutOrder
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.BackgroundTransparency = 0.1
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 5) 
    local Header = Instance.new("TextButton", Main)
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 35)
    Header.BackgroundTransparency = 1
    Header.Text = "     " .. title
    Header.TextColor3 = Color3.new(255, 255, 255)
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Font = Enum.Font.Gotham
    Header.TextSize = 13
    local Arrow = Instance.new("TextLabel", Header)
    Arrow.Name = "Arrow"
    Arrow.Size = UDim2.new(0, 30, 1, 0)
    Arrow.Position = UDim2.new(1, -30, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "▼"
    Arrow.ZIndex = 1
    Arrow.TextColor3 = Color3.new(1, 1, 1)
    Arrow.TextSize = 8
    local ContentList = Instance.new("Frame", Main)
    ContentList.Name = "ContentList"
    ContentList.Position = UDim2.new(0, 0, 0, 35)
    ContentList.Size = UDim2.new(1, 0, 0, 0)
    ContentList.BackgroundTransparency = 1
    ContentList.Visible = false
    local ListLayout = Instance.new("UIListLayout", ContentList)
    ListLayout.Padding = UDim.new(0, 5)
    ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    local isOpen = false
    local function updateSize()
        local contentHeight = ListLayout.AbsoluteContentSize.Y
        local targetMainSize = isOpen and UDim2.new(1, 0, 0, contentHeight + 45) or UDim2.new(1, 0, 0, 35)
        local targetContentSize = isOpen and UDim2.new(1, 0, 0, contentHeight + 5) or UDim2.new(1, 0, 0, 0)    
        local info = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        game:GetService("TweenService"):Create(Main, info, {Size = targetMainSize}):Play()
        game:GetService("TweenService"):Create(ContentList, info, {Size = targetContentSize}):Play()
    end
    ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        if isOpen then updateSize() end
    end)
    Header.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    Arrow.Text = isOpen and "▲" or "▼"  
    if isOpen then ContentList.Visible = true end     
    updateSize()  
    task.delay(0.3, function()
        if not isOpen then ContentList.Visible = false end
    end)
end)
    return ContentList
end
function M.CreateInput(name, parent, order)
    local InputRow = Instance.new("Frame", parent)
    InputRow.Size = UDim2.new(0.95, 0, 0, 30)
    InputRow.BackgroundTransparency = 1
    InputRow.LayoutOrder = order
    local InputLabel = Instance.new("TextLabel", InputRow)
    InputLabel.Size = UDim2.new(0.7, 0, 1, 0)
    InputLabel.Position = UDim2.new(0, 5, 0, 0)
    InputLabel.BackgroundTransparency = 1
    InputLabel.Text = name
    InputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputLabel.TextXAlignment = Enum.TextXAlignment.Left
    InputLabel.TextSize = 10
    InputLabel.Font = Enum.Font.Gotham
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
    InputBox.Font = Enum.Font.Gotham
    InputBox.ClipsDescendants = true 
    Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 4)
    return InputBox
end
function M.CreateToggle(name, parent, order, callback)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(0.95, 0, 0, 30)
    Row.BackgroundTransparency = 1
    Row.LayoutOrder = order
    local Label = Instance.new("TextLabel", Row)
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 5, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextSize = 10
    local Btn = Instance.new("TextButton", Row)
    Btn.Size = UDim2.new(0, 40, 0, 20)
    Btn.Position = UDim2.new(1, -5, 0.5, 0)
    Btn.AnchorPoint = Vector2.new(1, 0.5)
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Btn.Text = "O     "
    Btn.AutoButtonColor = false
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", Btn)
    local enabled = false
    Btn.Activated:Connect(function()
        enabled = not enabled
        Btn.Text = enabled and "     O" or "O     "
        Btn.TextColor3 = enabled and Color3.fromRGB(205, 153, 255) or Color3.fromRGB(255, 255, 255)
        callback(enabled)
    end)
end
_G.Toggles = {}
function M.CreateButtonOnOff(name, parent, order, callback)
    local Btn = Instance.new("TextButton")
    Btn.Name = name 
    Btn.Size = UDim2.new(1, -10, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Btn.BackgroundTransparency = 0
    Btn.Text = name .. " : OFF"
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 10
    Btn.LayoutOrder = order
    Btn.AutoButtonColor = false
    Btn.Parent = parent
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 6)
    BCorner.Parent = Btn
    _G.Toggles[name] = false 
    Btn.MouseButton1Click:Connect(function()
        _G.Toggles[name] = not _G.Toggles[name]
        local state = _G.Toggles[name]
        Btn.Text = name .. (state and " : ON" or " : OFF")
        Btn.BackgroundColor3 = state and Color3.fromRGB(205, 153, 255) or Color3.fromRGB(50, 50, 50)
        Btn.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200) 
        callback(state)
    end)
end
function M.CreateButton(name, parent, order, callback)
    local Btn = Instance.new("TextButton")
    Btn.Name = name .. "_ClickBtn"
    Btn.Parent = parent
    Btn.Size = UDim2.new(1, -10, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Btn.BackgroundTransparency = 0
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 10
    Btn.AutoButtonColor = false
    Btn.LayoutOrder = order
    Btn.MouseButton1Click:Connect(function()
        Btn.BackgroundColor3 = Color3.fromRGB(205, 153, 255)
        task.wait(0.1)
        Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)     
        callback()
    end)
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)
    return Btn
end
return M
