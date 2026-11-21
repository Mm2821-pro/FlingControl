-- FLING CONTROL V1.6
-- Safe UI Demo for your own Roblox experience
-- Place inside a LocalScript

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("FlingControlV16")
if oldGui then
    oldGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "FlingControlV16"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromScale(0.92, 0.72)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(12, 17, 31)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(35, 105, 220)
mainStroke.Thickness = 1.5
mainStroke.Parent = main

-- TOP BAR

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 58)
top.BackgroundColor3 = Color3.fromRGB(20, 34, 61)
top.BorderSizePixel = 0
top.Parent = main

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 14)
topCorner.Parent = top

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.65, 0, 0, 29)
title.Position = UDim2.new(0, 13, 0, 5)
title.BackgroundTransparency = 1
title.Text = "FLING CONTROL"
title.TextColor3 = Color3.fromRGB(100, 170, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(0.65, 0, 0, 17)
subtitle.Position = UDim2.new(0, 13, 0, 32)
subtitle.BackgroundTransparency = 1
subtitle.Text = "VERSION 1.6  •  UI DEMO"
subtitle.TextColor3 = Color3.fromRGB(145, 155, 180)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 9
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = top

local function topButton(text, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(32, 32)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(35, 55, 90)
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.BorderSizePixel = 0
    button.Parent = top

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button

    return button
end

local minimize = topButton("–", UDim2.new(1, -76, 0, 13))
local close = topButton("X", UDim2.new(1, -39, 0, 13))

-- BODY

local body = Instance.new("Frame")
body.Name = "Body"
body.Position = UDim2.new(0, 0, 0, 65)
body.Size = UDim2.new(1, 0, 1, -65)
body.BackgroundTransparency = 1
body.Parent = main

local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.new(0, 9, 0, 5)
sidebar.Size = UDim2.new(0, 98, 1, -10)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 27, 47)
sidebar.BorderSizePixel = 0
sidebar.Parent = body

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 10)
sideCorner.Parent = sidebar

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 8)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = sidebar

local sidePadding = Instance.new("UIPadding")
sidePadding.PaddingTop = UDim.new(0, 12)
sidePadding.Parent = sidebar

local content = Instance.new("Frame")
content.Position = UDim2.new(0, 116, 0, 5)
content.Size = UDim2.new(1, -125, 1, -10)
content.BackgroundTransparency = 1
content.Parent = body

-- NOTIFICATION

local toast = Instance.new("TextLabel")
toast.Size = UDim2.new(1, -20, 0, 30)
toast.Position = UDim2.new(0, 10, 1, -38)
toast.BackgroundColor3 = Color3.fromRGB(30, 65, 115)
toast.TextColor3 = Color3.new(1, 1, 1)
toast.Text = "FLING CONTROL V1.6"
toast.Font = Enum.Font.Gotham
toast.TextSize = 11
toast.Visible = false
toast.BorderSizePixel = 0
toast.Parent = main

local toastCorner = Instance.new("UICorner")
toastCorner.CornerRadius = UDim.new(0, 7)
toastCorner.Parent = toast

local function showToast(message)
    toast.Text = message
    toast.Visible = true

    task.delay(2, function()
        if toast.Parent then
            toast.Visible = false
        end
    end)
end

-- PAGE CREATION

local pages = {}
local tabButtons = {}
local allToggles = {}

local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundColor3 = Color3.fromRGB(18, 27, 47)
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(65, 135, 235)
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Parent = content

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = page

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingBottom = UDim.new(0, 12)
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = page

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(
            0, 0, 0, layout.AbsoluteContentSize.Y + 25
        )
    end)

    pages[name] = page
    return page
end

local function heading(parent, text, description)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 54)
    label.BackgroundTransparency = 1
    label.Text = text .. "\n" .. description
    label.TextColor3 = Color3.fromRGB(225, 235, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
end

-- TOGGLE CREATION

local function addToggle(parent, name, description)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 61)
    row.BackgroundColor3 = Color3.fromRGB(27, 41, 68)
    row.BorderSizePixel = 0
    row.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = row

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Position = UDim2.new(0, 9, 0, 7)
    nameLabel.Size = UDim2.new(1, -83, 0, 20)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(230, 238, 255)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 11
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = row

    local desc = Instance.new("TextLabel")
    desc.Position = UDim2.new(0, 9, 0, 29)
    desc.Size = UDim2.new(1, -83, 0, 24)
    desc.BackgroundTransparency = 1
    desc.Text = description
    desc.TextColor3 = Color3.fromRGB(145, 160, 185)
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 8
    desc.TextWrapped = true
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = row

    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(59, 27)
    button.Position = UDim2.new(1, -67, 0.5, -13)
    button.BackgroundColor3 = Color3.fromRGB(65, 72, 90)
    button.Text = "OFF"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 10
    button.BorderSizePixel = 0
    button.Parent = row

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 7)
    buttonCorner.Parent = button

    local enabled = false

    local function setEnabled(value, silent)
        enabled = value
        button.Text = enabled and "ON" or "OFF"
        button.BackgroundColor3 = enabled
            and Color3.fromRGB(30, 135, 100)
            or Color3.fromRGB(65, 72, 90)

        if not silent then
            showToast(name .. ": " .. (enabled and "ON" or "OFF"))
        end
    end

    button.Activated:Connect(function()
        setEnabled(not enabled)
    end)

    table.insert(allToggles, setEnabled)
    return setEnabled
end

-- FLING PAGE

local flingPage = createPage("FLING")

heading(
    flingPage,
    "FLING CONTROL",
    "Настройки силы — демонстрационный режим"
)

local strength = 100

local strengthRow = Instance.new("Frame")
strengthRow.Size = UDim2.new(1, 0, 0, 65)
strengthRow.BackgroundColor3 = Color3.fromRGB(27, 41, 68)
strengthRow.BorderSizePixel = 0
strengthRow.Parent = flingPage

local strengthCorner = Instance.new("UICorner")
strengthCorner.CornerRadius = UDim.new(0, 8)
strengthCorner.Parent = strengthRow

local strengthLabel = Instance.new("TextLabel")
strengthLabel.Size = UDim2.new(0.35, 0, 1, 0)
strengthLabel.Position = UDim2.new(0, 9, 0, 0)
strengthLabel.BackgroundTransparency = 1
strengthLabel.Text = "STRENGTH"
strengthLabel.TextColor3 = Color3.fromRGB(220, 235, 255)
strengthLabel.Font = Enum.Font.GothamBold
strengthLabel.TextSize = 10
strengthLabel.Parent = strengthRow

local strengthValue = Instance.new("TextLabel")
strengthValue.Size = UDim2.new(0, 55, 1, 0)
strengthValue.Position = UDim2.new(1, -125, 0, 0)
strengthValue.BackgroundTransparency = 1
strengthValue.TextColor3 = Color3.fromRGB(100, 175, 255)
strengthValue.Font = Enum.Font.GothamBold
strengthValue.TextSize = 14
strengthValue.Parent = strengthRow

local function updateStrength()
    strengthValue.Text = tostring(strength)
end

local function strengthButton(text, x, change)
    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(27, 29)
    button.Position = UDim2.new(1, x, 0.5, -14)
    button.BackgroundColor3 = Color3.fromRGB(40, 90, 155)
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 15
    button.BorderSizePixel = 0
    button.Parent = strengthRow

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    button.Activated:Connect(function()
        strength = math.clamp(strength + change, 100, 10000)
        updateStrength()
    end)
end

strengthButton("-", -64, -100)
strengthButton("+", -32, 100)
updateStrength()

heading(
    flingPage,
    "INFORMATION",
    "Этот интерфейс не воздействует на других игроков."
)

-- ANTI PAGE

local antiPage = createPage("ANTI")

heading(antiPage, "ANTI SYSTEM", "Демонстрационные переключатели")

addToggle(antiPage, "Anti Grab", "Только отображение состояния")
addToggle(antiPage, "Anti Ragdoll", "Только отображение состояния")
addToggle(antiPage, "Anti Snowball", "Только отображение состояния")
addToggle(antiPage, "Anti Explosion", "Только отображение состояния")
addToggle(antiPage, "Anti Paint", "Только отображение состояния")
addToggle(antiPage, "Anti Fire", "Не отключает игровой урон")
addToggle(
    antiPage,
    "Anti Kick",
    "Декоративный режим — не отменяет кик сервера"
)

-- FUN PAGE

local funPage = createPage("FUN")

heading(funPage, "FUN FEATURES", "Визуальные функции — DEMO")

addToggle(
    funPage,
    "Wings",
    "Превью крыльев из 8 паллет"
)

addToggle(
    funPage,
    "Dynamic Wings",
    "Превью изменения движения крыльев"
)

addToggle(
    funPage,
    "Extra Wings",
    "Переключатель дополнительного эффекта"
)

addToggle(
    funPage,
    "Mech Suit",
    "Превью режима механического клона"
)

-- SETTINGS PAGE

local settingsPage = createPage("SETTINGS")

heading(settingsPage, "SETTINGS", "Настройки интерфейса")

addToggle(
    settingsPage,
    "Show Notifications",
    "Демо уведомления при нажатии"
)

local resetButton = Instance.new("TextButton")
resetButton.Size = UDim2.new(1, 0, 0, 45)
resetButton.BackgroundColor3 = Color3.fromRGB(135, 55, 65)
resetButton.Text = "RESET ALL"
resetButton.TextColor3 = Color3.new(1, 1, 1)
resetButton.Font = Enum.Font.GothamBold
resetButton.TextSize = 12
resetButton.BorderSizePixel = 0
resetButton.Parent = settingsPage

local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 8)
resetCorner.Parent = resetButton

resetButton.Activated:Connect(function()
    for _, setToggle in ipairs(allToggles) do
        setToggle(false, true)
    end

    strength = 100
    updateStrength()
    showToast("Settings reset!")
end)

-- TAB SYSTEM

local function createTab(name, order)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -12, 0, 39)
    button.LayoutOrder = order
    button.BackgroundColor3 = Color3.fromRGB(27, 42, 68)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(190, 210, 240)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 10
    button.BorderSizePixel = 0
    button.Parent = sidebar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = button

    tabButtons[name] = button

    button.Activated:Connect(function()
        for pageName, page in pairs(pages) do
            page.Visible = pageName == name
            tabButtons[pageName].BackgroundColor3 =
                pageName == name
                and Color3.fromRGB(35, 105, 190)
                or Color3.fromRGB(27, 42, 68)
        end
    end)
end

createTab("FLING", 1)
createTab("ANTI", 2)
createTab("FUN", 3)
createTab("SETTINGS", 4)

pages.FLING.Visible = true
tabButtons.FLING.BackgroundColor3 = Color3.fromRGB(35, 105, 190)

-- MINIMIZE / CLOSE

local minimized = false
local expandedSize = UDim2.fromScale(0.92, 0.72)

minimize.Activated:Connect(function()
    minimized = not minimized
    body.Visible = not minimized

    main.Size = minimized
        and UDim2.fromScale(0.92, 0.10)
        or expandedSize

    minimize.Text = minimized and "+" or "–"
end)

close.Activated:Connect(function()
    gui:Destroy()
end)

-- DRAG SUPPORT: TOUCH + MOUSE

local dragging = false
local dragInput
local dragStart
local startPosition

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

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

top.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

showToast("FLING CONTROL V1.6 loaded!")
