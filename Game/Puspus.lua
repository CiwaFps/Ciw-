local M = {}

function M.CreateScroll(name, parent, chight, visible)
    local ScrollMenu = Instance.new("ScrollingFrame", parent)
    ScrollMenu.Name = name
    ScrollMenu.Size = UDim2.new(1, 0, 1, 0)
    ScrollMenu.BackgroundTransparency = 1
    ScrollMenu.CanvasSize = UDim2.new(0, 0, 0, chight)
    ScrollMenu.ScrollBarThickness = 0
    ScrollMenu.VerticalScrollBarInset = Enum.ScrollBarInset.None
    ScrollMenu.Visible = visible
    local ScrollLayout = Instance.new("UIListLayout", ScrollMenu)
    ScrollLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ScrollLayout.Padding = UDim.new(0, 5)
    ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
    local ScrollLayoutP = Instance.new("UIPadding", ScrollMenu)
    ScrollLayoutP.PaddingTop = UDim.new(0, 5)
    ScrollLayoutP.PaddingBottom = UDim.new(0, 5)    
    return ScrollMenu
end
function M.CreateButtonTab(name, parent, order, callback)
    local Btn = Instance.new("TextButton")
    Btn.Name = name
    Btn.Parent = parent
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Btn.BackgroundTransparency = 1
    Btn.Text = "      " .. name
    Btn.TextColor3 = Color3.fromRGB(224, 224, 224)
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 13
    Btn.LayoutOrder = order
    Btn.Activated:Connect(function()
        for _, v in pairs(parent:GetChildren()) do
            if v:IsA("TextButton") then
                v.BackgroundTransparency = 1
                v.TextColor3 = Color3.fromRGB(224, 224, 224)
            end
        end
        Btn.BackgroundTransparency = 0.4
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
    Main.BackgroundTransparency = 0.4
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 5) 
    local Header = Instance.new("TextButton", Main)
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 35)
    Header.BackgroundTransparency = 1
    Header.Text = "     " .. title
    Header.TextColor3 = Color3.new(1, 1, 1)
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Font = Enum.Font.Gotham
    Header.TextSize = 13
    local Arrow = Instance.new("TextLabel", Header)
    Arrow.Name = "Arrow"
    Arrow.Size = UDim2.new(0, 30, 1, 0)
    Arrow.Position = UDim2.new(1, -30, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "▼"
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
        if isOpen then ContentList.Visible = true end     
        updateSize()
        game:GetService("TweenService"):Create(Arrow, TweenInfo.new(0.3), {Rotation = isOpen and 180 or 0}):Play()    
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
    InputLabel.Font = Enum.Font.SourceSansBold
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
    Label.Font = Enum.Font.SourceSansBold
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextSize = 10
    local Btn = Instance.new("TextButton", Row)
    Btn.Size = UDim2.new(0, 40, 0, 20)
    Btn.Position = UDim2.new(1, -5, 0.5, 0)
    Btn.AnchorPoint = Vector2.new(1, 0.5)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Btn.Text = "O     "
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
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Btn.BackgroundTransparency = 0.2
    Btn.Text = name .. " : OFF"
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 10
    Btn.LayoutOrder = order
    Btn.Parent = parent
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 6)
    BCorner.Parent = Btn
    _G.Toggles[name] = false 
    Btn.MouseButton1Click:Connect(function()
        _G.Toggles[name] = not _G.Toggles[name]
        local state = _G.Toggles[name]
        Btn.Text = name .. (state and " : ON" or " : OFF")
        Btn.BackgroundColor3 = state and Color3.fromRGB(205, 153, 255) or Color3.fromRGB(40, 40, 40)
        Btn.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200) 
        callback(state)
    end)
end
function M.CreateButton(name, parent, order, callback)
    local Btn = Instance.new("TextButton")
    Btn.Name = name .. "_ClickBtn"
    Btn.Parent = parent
    Btn.Size = UDim2.new(1, -10, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Btn.BackgroundTransparency = 0.2
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 10
    Btn.LayoutOrder = order
    Btn.MouseButton1Click:Connect(function()
        Btn.BackgroundColor3 = Color3.fromRGB(205, 153, 255)
        task.wait(0.1)
        Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)     
        callback()
    end)
    Btn.MouseEnter:Connect(function() Btn.BackgroundTransparency = 0.2 end)
    Btn.MouseLeave:Connect(function() Btn.BackgroundTransparency = 0.5 end)
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)
    return Btn
end
return M
