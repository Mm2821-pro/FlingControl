
-- FLING CONTROL V1.8 BLACK EDITION
-- Mobile GUI demonstration
-- For your own Roblox project

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")

local old = guiParent:FindFirstChild("FlingControlV18")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "FlingControlV18"
gui.ResetOnSpawn = false
gui.Parent = guiParent

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0.88, 0, 0.78, 0)
main.Position = UDim2.new(0.06, 0, 0.11, 0)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(35, 100, 220)
outline.Thickness = 1
outline.Parent = main

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 48)
top.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
top.BorderSizePixel = 0
top.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "FLING CONTROL  V1.8"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local function topButton(text, x)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 34, 0, 30)
    b.Position = UDim2.new(1, x, 0, 9)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 16
    b.Parent = top

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 7)
    c.Parent = b

    return b
end

local minimize = topButton("-", -82)
local close = topButton("X", -42)

local body = Instance.new("Frame")
body.Position = UDim2.new(0, 8, 0, 56)
body.Size = UDim2.new(1, -16, 1, -64)
body.BackgroundTransparency = 1
body.Parent = main

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0.29, 0, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(9, 9, 9)
sidebar.BorderSizePixel = 0
sidebar.Parent = body

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 8)
sideCorner.Parent = sidebar

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 8)
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = sidebar

local sidePadding = Instance.new("UIPadding")
sidePadding.PaddingTop = UDim.new(0, 9)
sidePadding.PaddingLeft = UDim.new(0, 6)
sidePadding.PaddingRight = UDim.new(0, 6)
sidePadding.Parent = sidebar

local content = Instance.new("Frame")
content.Position = UDim2.new(0.29, 8, 0, 0)
content.Size = UDim2.new(0.71, -8, 1, 0)
content.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
content.BorderSizePixel = 0
content.Parent = body

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 8)
contentCorner.Parent = content

local pages = {}
local tabButtons = {}

local function makePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.new(1, -12, 1, -12)
    page.Position = UDim2.new(0, 6, 0, 6)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(50, 110, 220)
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false
    page.Parent = content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 12)
    end)

    pages[name] = page
    return page
end

local function addLabel(page, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -4, 0, 34)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = page
    return label
end

local function addToggle(page, text)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -4, 0, 42)
    button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    button.TextColor3 = Color3.fromRGB(230, 230, 230)
    button.Font = Enum.Font.Gotham
    button.TextSize = 13
    button.Text = text .. "  [OFF]"
    button.Parent = page

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = button

    local enabled = false
    button.Activated:Connect(function()
        enabled = not enabled
        button.Text = text .. (enabled and "  [ON]" or "  [OFF]")
        button.BackgroundColor3 = enabled
            and Color3.fromRGB(20, 55, 95)
            or Color3.fromRGB(25, 25, 25)
    end)

    return button
end

local function addTab(name, order)
    local button = Instance.new("TextButton")
    button.Name = name .. "Tab"
    button.LayoutOrder = order
    button.Size = UDim2.new(1, 0, 0, 42)
    button.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = name
    button.Font = Enum.Font.GothamBold
    button.TextSize = 12
    button.Parent = sidebar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = button

    local page = makePage(name)
    tabButtons[name] = button

    button.Activated:Connect(function()
        for pageName, otherPage in pairs(pages) do
            otherPage.Visible = pageName == name
            tabButtons[pageName].BackgroundColor3 =
                pageName == name
                and Color3.fromRGB(25, 75, 130)
                or Color3.fromRGB(22, 22, 22)
        end
    end)

    return page
end

-- SETTINGS is deliberately the second tab.
local flingPage = addTab("FLING", 1)
local settingsPage = addTab("SETTINGS", 2)
local antiPage = addTab("ANTI", 3)
local funPage = addTab("FUN", 4)

addLabel(flingPage, "FLING")
addLabel(flingPage, "Strength")
local strength = 100
local strengthLabel = addLabel(flingPage, "Strength: 100")

local function strengthButton(text, amount)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.Parent = flingPage

    b.Activated:Connect(function()
        strength = math.clamp(strength + amount, 100, 10000)
        strengthLabel.Text = "Strength: " .. strength
    end)
end

strengthButton("+ 100", 100)
strengthButton("- 100", -100)
strengthButton("+ 1000", 1000)
strengthButton("- 1000", -1000)

addLabel(antiPage, "ANTI — DEMO")
addToggle(antiPage, "Anti Grab (demo)")
addToggle(antiPage, "Anti Ragdoll (demo)")
addToggle(antiPage, "Anti Snowball (demo)")
addToggle(antiPage, "Anti Explosion (demo)")

addLabel(funPage, "FUN — DEMO")
addToggle(funPage, "Wings (demo)")
addToggle(funPage, "Dynamic Wings (demo)")
addToggle(funPage, "Extra Wings (demo)")
addToggle(funPage, "Mech Suit (demo)")

addLabel(settingsPage, "SETTINGS")
addToggle(settingsPage, "Show Notifications (demo)")

local reset = Instance.new("TextButton")
reset.Size = UDim2.new(1, -4, 0, 42)
reset.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
reset.TextColor3 = Color3.new(1, 1, 1)
reset.Text = "RESET INTERFACE"
reset.Font = Enum.Font.GothamBold
reset.TextSize = 13
reset.Parent = settingsPage

reset.Activated:Connect(function()
    strength = 100
    strengthLabel.Text = "Strength: 100"
end)

pages.FLING.Visible = true
tabButtons.FLING.BackgroundColor3 = Color3.fromRGB(25, 75, 130)

minimize.Activated:Connect(function()
    body.Visible = not body.Visible
    main.Size = body.Visible
        and UDim2.new(0.88, 0, 0.78, 0)
        or UDim2.new(0.88, 0, 0, 48)
end)

close.Activated:Connect(function()
    gui:Destroy()
end)

-- Drag window using touch or mouse.
local dragging = false
local dragStart
local startPosition

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
