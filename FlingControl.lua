
-- FLING CONTROL V1.7
-- BLACK EDITION
-- LocalScript for your own Roblox experience

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("FlingControlV17")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "FlingControlV17"
gui.ResetOnSpawn = false
gui.DisplayOrder = 20
gui.Parent = playerGui

local black = Color3.fromRGB(0, 0, 0)
local panel = Color3.fromRGB(13, 13, 13)
local item = Color3.fromRGB(27, 27, 27)
local blue = Color3.fromRGB(35, 105, 210)
local white = Color3.fromRGB(245, 245, 245)
local gray = Color3.fromRGB(155, 155, 155)

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromScale(0.95, 0.85)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = black
main.BorderSizePixel = 0
main.Parent = gui

local stroke = Instance.new("UIStroke")
stroke.Color = blue
stroke.Thickness = 1.5
stroke.Parent = main

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 13)
corner.Parent = main

-- TOP BAR

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 65)
top.BackgroundColor3 = panel
top.BorderSizePixel = 0
top.Parent = main

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 13)
topCorner.Parent = top

local title = Instance.new("TextLabel")
title.Position = UDim2.new(0, 15, 0, 8)
title.Size = UDim2.new(0.7, 0, 0, 27)
title.BackgroundTransparency = 1
title.Text = "FLING CONTROL"
title.TextColor3 = white
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local version = Instance.new("TextLabel")
version.Position = UDim2.new(0, 16, 0, 36)
version.Size = UDim2.new(0.7, 0, 0, 17)
version.BackgroundTransparency = 1
version.Text = "VERSION 1.7  •  BLACK EDITION"
version.TextColor3 = gray
version.TextSize = 10
version.Font = Enum.Font.Gotham
version.TextXAlignment = Enum.TextXAlignment.Left
version.Parent = top

local function makeButton(parent, text, size, pos)
    local b = Instance.new("TextButton")
    b.Size = size
    b.Position = pos
    b.BackgroundColor3 = item
    b.Text = text
    b.TextColor3 = white
    b.TextSize = 15
    b.Font = Enum.Font.GothamBold
    b.BorderSizePixel = 0
    b.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b

    return b
end

local minimize = makeButton(
    top, "−",
    UDim2.fromOffset(38, 38),
    UDim2.new(1, -88, 0, 13)
)

local close = makeButton(
    top, "X",
    UDim2.fromOffset(38, 38),
    UDim2.new(1, -45, 0, 13)
)

-- BODY

local body = Instance.new("Frame")
body.Position = UDim2.new(0, 0, 0, 72)
body.Size = UDim2.new(1, 0, 1, -78)
body.BackgroundTransparency = 1
body.Parent = main

local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.new(0, 10, 0, 5)
sidebar.Size = UDim2.new(0.23, -12, 1, -10)
sidebar.BackgroundColor3 = panel
sidebar.BorderSizePixel = 0
sidebar.Parent = body

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 10)
sideCorner.Parent = sidebar

local content = Instance.new("Frame")
content.Position = UDim2.new(0.23, 5, 0, 5)
content.Size = UDim2.new(0.77, -15, 1, -10)
content.BackgroundColor3 = panel
content.BorderSizePixel = 0
content.Parent = body

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 10)
contentCorner.Parent = content

-- PAGES

local pages = {}
local tabs = {}
local toggles = {}

local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = blue
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false
    page.Parent = content

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 12)
    padding.PaddingLeft = UDim.new(0, 12)
    padding.PaddingRight = UDim.new(0, 12)
    padding.PaddingBottom = UDim.new(0, 12)
    padding.Parent = page

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 9)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    layout:GetPropertyChangedSignal(
        "AbsoluteContentSize"
    ):Connect(function()
        page.CanvasSize = UDim2.new(
            0, 0, 0,
            layout.AbsoluteContentSize.Y + 30
        )
    end)

    pages[name] = page
    return page
end

local function heading(page, name, description)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 55)
    label.BackgroundTransparency = 1
    label.Text = name .. "\n" .. description
    label.TextColor3 = white
    label.TextSize = 15
    label.Font = Enum.Font.GothamBold
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = page
end

local function addToggle(page, name, description)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 62)
    row.BackgroundColor3 = item
    row.BorderSizePixel = 0
    row.Parent = page

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = row

    local label = Instance.new("TextLabel")
    label.Position = UDim2.new(0, 10, 0, 7)
    label.Size = UDim2.new(1, -90, 0, 22)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = white
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local desc = Instance.new("TextLabel")
    desc.Position = UDim2.new(0, 10, 0, 31)
    desc.Size = UDim2.new(1, -90, 0, 22)
    desc.BackgroundTransparency = 1
    desc.Text = description
    desc.TextColor3 = gray
    desc.TextSize = 9
    desc.Font = Enum.Font.Gotham
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.TextWrapped = true
    desc.Parent = row

    local button = makeButton(
        row, "OFF",
        UDim2.fromOffset(60, 30),
        UDim2.new(1, -70, 0.5, -15)
    )

    local enabled = false

    local function setEnabled(value)
        enabled = value
        button.Text = enabled and "ON" or "OFF"
        button.BackgroundColor3 =
            enabled and blue or Color3.fromRGB(45, 45, 45)
    end

    button.Activated:Connect(function()
        setEnabled(not enabled)
    end)

    table.insert(toggles, setEnabled)
end

-- FLING

local fling = createPage("FLING")
heading(fling, "FLING", "Демонстрационные настройки")

local strength = 100

local strengthRow = Instance.new("Frame")
strengthRow.Size = UDim2.new(1, 0, 0, 60)
strengthRow.BackgroundColor3 = item
strengthRow.BorderSizePixel = 0
strengthRow.Parent = fling

local strengthText = Instance.new("TextLabel")
strengthText.Size = UDim2.new(0.4, 0, 1, 0)
strengthText.Position = UDim2.new(0, 10, 0, 0)
strengthText.BackgroundTransparency = 1
strengthText.Text = "STRENGTH"
strengthText.TextColor3 = white
strengthText.Font = Enum.Font.GothamBold
strengthText.TextSize = 12
strengthText.Parent = strengthRow

local value = Instance.new("TextLabel")
value.Size = UDim2.new(0, 65, 1, 0)
value.Position = UDim2.new(1, -130, 0, 0)
value.BackgroundTransparency = 1
value.TextColor3 = white
value.Text = tostring(strength)
value.Font = Enum.Font.GothamBold
value.TextSize = 15
value.Parent = strengthRow

local minus = makeButton(
    strengthRow, "−",
    UDim2.fromOffset(28, 30),
    UDim2.new(1, -62, 0.5, -15)
)

local plus = makeButton(
    strengthRow, "+",
    UDim2.fromOffset(28, 30),
    UDim2.new(1, -31, 0.5, -15)
)

minus.Activated:Connect(function()
    strength = math.max(100, strength - 100)
    value.Text = tostring(strength)
end)

plus.Activated:Connect(function()
    strength = math.min(10000, strength + 100)
    value.Text = tostring(strength)
end)

-- ANTI

local anti = createPage("ANTI")
heading(anti, "ANTI", "Демо-переключатели")

addToggle(anti, "Anti Grab", "Демонстрационный режим")
addToggle(anti, "Anti Ragdoll", "Демонстрационный режим")
addToggle(anti, "Anti Snowball", "Демонстрационный режим")
addToggle(anti, "Anti Explosion", "Демонстрационный режим")
addToggle(anti, "Anti Paint", "Демонстрационный режим")
addToggle(anti, "Anti Fire", "Не отключает игровой урон")
addToggle(anti, "Anti Kick", "Не отменяет кик сервера")

-- FUN

local fun = createPage("FUN")
heading(fun, "FUN", "Визуальные функции DEMO")

addToggle(fun, "Wings", "Превью крыльев")
addToggle(fun, "Dynamic Wings", "Превью динамической анимации")
addToggle(fun, "Extra Wings", "Дополнительный визуальный эффект")
addToggle(fun, "Mech Suit", "Превью механического костюма")

-- SETTINGS

local settings = createPage("SETTINGS")
heading(settings, "SETTINGS", "Настройки интерфейса")

local notifications = true

local notifyToggle = addToggle(
    settings,
    "Show Notifications",
    "Включить или выключить уведомления"
)

local reset = makeButton(
    settings, "RESET ALL",
    UDim2.new(1, 0, 0, 42),
    UDim2.new(0, 0, 0, 0)
)
reset.BackgroundColor3 = Color3.fromRGB(55, 35, 35)

reset.Activated:Connect(function()
    for _, setToggle in ipairs(toggles) do
        setToggle(false)
    end
    strength = 100
    value.Text = "100"
end)

-- TABS

local tabLayout = Instance.new("UIListLayout")
tabLayout.Padding = UDim.new(0, 9)
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Parent = sidebar

local tabPadding = Instance.new("UIPadding")
tabPadding.PaddingTop = UDim.new(0, 12)
tabPadding.PaddingLeft = UDim.new(0, 6)
tabPadding.PaddingRight = UDim.new(0, 6)
tabPadding.Parent = sidebar

local function createTab(name, order)
    local button = makeButton(
        sidebar,
        name,
        UDim2.new(1, 0, 0, 43),
        UDim2.new()
    )
    button.LayoutOrder = order
    button.TextSize = 10
    tabs[name] = button

    button.Activated:Connect(function()
        for pageName, page in pairs(pages) do
            page.Visible = pageName == name
            tabs[pageName].BackgroundColor3 =
                pageName == name and blue or item
        end
    end)
end

createTab("FLING", 1)
createTab("ANTI", 2)
createTab("FUN", 3)
createTab("SETTINGS", 4)

pages.FLING.Visible = true
tabs.FLING.BackgroundColor3 = blue

-- MINIMIZE / CLOSE

local minimized = false
local normalSize = UDim2.fromScale(0.95, 0.85)

minimize.Activated:Connect(function()
    minimized = not minimized
    body.Visible = not minimized
    main.Size = minimized
        and UDim2.fromScale(0.95, 0.12)
        or normalSize
end)

close.Activated:Connect(function()
    gui:Destroy()
end)

-- DRAG

local dragging = false
local dragStart
local startPosition

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true
        dragStart = input.Position
        startPosition = main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
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
