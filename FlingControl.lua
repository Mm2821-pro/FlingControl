
--[[
    FLING CONTROL V1.9 BLACK EDITION
    Mobile Interface Edition
    Safe GUI demonstration for own Roblox project

    Features:
    - Four working navigation tabs
    - Black interface
    - Compact minimize / restore
    - Draggable header
    - Mobile-friendly scrolling
    - Strength display controls
    - Settings and reset
    - Demo toggles
]]

--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIGURATION
--==================================================

local CONFIG = {
    Title = "FLING CONTROL",
    Version = "V1.9",

    MainWidth = 0.88,
    MainHeight = 0.78,

    CompactWidth = 230,
    CompactHeight = 48,

    Background = Color3.fromRGB(0, 0, 0),
    Panel = Color3.fromRGB(9, 9, 9),
    Button = Color3.fromRGB(24, 24, 24),

    Accent = Color3.fromRGB(35, 100, 220),
    AccentDark = Color3.fromRGB(20, 65, 125),

    Text = Color3.fromRGB(255, 255, 255),
    MutedText = Color3.fromRGB(160, 160, 160),
}

--==================================================
-- STATE
--==================================================

local State = {
    Minimized = false,
    CurrentTab = "FLING",

    Strength = 100,

    Notifications = true,
    DarkMode = true,

    Toggles = {},
}

--==================================================
-- CLEAN OLD GUI
--==================================================

local OldGui = PlayerGui:FindFirstChild("FlingControlV19")

if OldGui then
    OldGui:Destroy()
end

--==================================================
-- GUI CREATION
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlingControlV19"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

--==================================================
-- HELPER FUNCTIONS
--==================================================

local function CreateCorner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = object
    return corner
end

local function CreateStroke(object, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or CONFIG.Accent
    stroke.Thickness = thickness or 1
    stroke.Parent = object
    return stroke
end

local function CreatePadding(object, top, left, bottom, right)
    local padding = Instance.new("UIPadding")

    padding.PaddingTop = UDim.new(0, top or 0)
    padding.PaddingLeft = UDim.new(0, left or 0)
    padding.PaddingBottom = UDim.new(0, bottom or 0)
    padding.PaddingRight = UDim.new(0, right or 0)

    padding.Parent = object
    return padding
end

local function CreateLabel(parent, text, height, size)
    local label = Instance.new("TextLabel")

    label.Size = UDim2.new(1, -4, 0, height or 32)
    label.BackgroundTransparency = 1

    label.Text = text
    label.TextColor3 = CONFIG.Text

    label.Font = Enum.Font.GothamBold
    label.TextSize = size or 14

    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent

    return label
end

local function CreateButton(parent, text, height)
    local button = Instance.new("TextButton")

    button.Size = UDim2.new(1, -4, 0, height or 42)

    button.BackgroundColor3 = CONFIG.Button
    button.BorderSizePixel = 0

    button.Text = text
    button.TextColor3 = CONFIG.Text

    button.Font = Enum.Font.Gotham
    button.TextSize = 13

    button.AutoButtonColor = true
    button.Parent = parent

    CreateCorner(button, 7)

    return button
end

local function CreatePage(name)
    local page = Instance.new("ScrollingFrame")

    page.Name = name
    page.Size = UDim2.new(1, -12, 1, -12)
    page.Position = UDim2.new(0, 6, 0, 6)

    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0

    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = CONFIG.Accent

    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false

    page.Parent = Content

    CreatePadding(page, 4, 4, 8, 4)

    local layout = Instance.new("UIListLayout")

    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    layout.Parent = page

    layout:GetPropertyChangedSignal(
        "AbsoluteContentSize"
    ):Connect(function()

        page.CanvasSize = UDim2.new(
            0,
            0,
            0,
            layout.AbsoluteContentSize.Y + 15
        )
    end)

    Pages[name] = page

    return page
end

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Instance.new("Frame")

Main.Name = "Main"
Main.Size = UDim2.new(
    CONFIG.MainWidth,
    0,
    CONFIG.MainHeight,
    0
)

Main.Position = UDim2.new(0.06, 0, 0.11, 0)

Main.BackgroundColor3 = CONFIG.Background
Main.BorderSizePixel = 0

Main.ClipsDescendants = true
Main.Parent = ScreenGui

CreateCorner(Main, 11)
CreateStroke(Main, CONFIG.Accent, 1)

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")

Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 48)

Header.BackgroundColor3 = CONFIG.Panel
Header.BorderSizePixel = 0

Header.Parent = Main

local Title = Instance.new("TextLabel")

Title.Size = UDim2.new(1, -105, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)

Title.BackgroundTransparency = 1

Title.Text = CONFIG.Title .. "  " .. CONFIG.Version
Title.TextColor3 = CONFIG.Text

Title.Font = Enum.Font.GothamBold
Title.TextSize = 13

Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local function HeaderButton(text, x)
    local button = Instance.new("TextButton")

    button.Size = UDim2.new(0, 34, 0, 30)
    button.Position = UDim2.new(1, x, 0, 9)

    button.BackgroundColor3 = CONFIG.Button
    button.TextColor3 = CONFIG.Text

    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 17

    button.Parent = Header

    CreateCorner(button, 6)

    return button
end

local MinimizeButton = HeaderButton("−", -82)
local CloseButton = HeaderButton("X", -42)

--==================================================
-- BODY
--==================================================

local Body = Instance.new("Frame")

Body.Name = "Body"

Body.Position = UDim2.new(0, 8, 0, 56)
Body.Size = UDim2.new(1, -16, 1, -64)

Body.BackgroundTransparency = 1
Body.Parent = Main

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")

Sidebar.Name = "Sidebar"

Sidebar.Size = UDim2.new(0.29, 0, 1, 0)

Sidebar.BackgroundColor3 = CONFIG.Panel
Sidebar.BorderSizePixel = 0

Sidebar.Parent = Body

CreateCorner(Sidebar, 8)
CreatePadding(Sidebar, 9, 6, 9, 6)

local SidebarLayout = Instance.new("UIListLayout")

SidebarLayout.Padding = UDim.new(0, 8)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder

SidebarLayout.Parent = Sidebar

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")

Content.Name = "Content"

Content.Position = UDim2.new(0.29, 8, 0, 0)
Content.Size = UDim2.new(0.71, -8, 1, 0)

Content.BackgroundColor3 = CONFIG.Panel
Content.BorderSizePixel = 0

Content.ClipsDescendants = true
Content.Parent = Body

CreateCorner(Content, 8)

--==================================================
-- PAGE STORAGE
--==================================================

local Pages = {}
local TabButtons = {}

--==================================================
-- TOGGLE CREATION
--==================================================

local function AddToggle(page, name, description, callback)
    State.Toggles[name] = false

    local container = Instance.new("Frame")

    container.Size = UDim2.new(1, -4, 0, 52)
    container.BackgroundColor3 = CONFIG.Button

    container.BorderSizePixel = 0
    container.Parent = page

    CreateCorner(container, 7)

    local label = Instance.new("TextLabel")

    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)

    label.BackgroundTransparency = 1

    label.Text = name
    label.TextColor3 = CONFIG.Text

    label.Font = Enum.Font.GothamBold
    label.TextSize = 12

    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local switch = Instance.new("TextButton")

    switch.Size = UDim2.new(0, 54, 0, 28)
    switch.Position = UDim2.new(1, -64, 0.5, -14)

    switch.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

    switch.Text = "OFF"
    switch.TextColor3 = CONFIG.Text

    switch.Font = Enum.Font.GothamBold
    switch.TextSize = 11

    switch.Parent = container

    CreateCorner(switch, 6)

    switch.Activated:Connect(function()
        State.Toggles[name] = not State.Toggles[name]

        local enabled = State.Toggles[name]

        switch.Text = enabled and "ON" or "OFF"

        switch.BackgroundColor3 = enabled
            and CONFIG.AccentDark
            or Color3.fromRGB(45, 45, 45)

        if callback then
            callback(enabled)
        end
    end)

    return container
end

--==================================================
-- TAB CREATION
--==================================================

local function AddTab(name, order)
    local button = Instance.new("TextButton")

    button.Name = name .. "Tab"
    button.LayoutOrder = order

    button.Size = UDim2.new(1, 0, 0, 42)

    button.BackgroundColor3 = CONFIG.Button
    button.BorderSizePixel = 0

    button.Text = name
    button.TextColor3 = CONFIG.Text

    button.Font = Enum.Font.GothamBold
    button.TextSize = 11

    button.Parent = Sidebar

    CreateCorner(button, 7)

    local page = CreatePage(name)

    TabButtons[name] = button

    button.Activated:Connect(function()
        State.CurrentTab = name

        for pageName, otherPage in pairs(Pages) do
            otherPage.Visible = pageName == name

            TabButtons[pageName].BackgroundColor3 =
                pageName == name
                and CONFIG.AccentDark
                or CONFIG.Button
        end
    end)

    return page
end

--==================================================
-- CREATE ALL FOUR TABS
--==================================================

local FlingPage = AddTab("FLING", 1)
local SettingsPage = AddTab("SETTINGS", 2)
local AntiPage = AddTab("ANTI", 3)
local FunPage = AddTab("FUN", 4)

--==================================================
-- FLING PAGE
--==================================================

CreateLabel(FlingPage, "FLING CONTROL", 34, 15)

CreateLabel(FlingPage, "Strength settings", 28, 12)

local StrengthLabel = CreateLabel(
    FlingPage,
    "Strength: " .. State.Strength,
    34,
    13
)

local function UpdateStrength(amount)
    State.Strength = math.clamp(
        State.Strength + amount,
        100,
        10000
    )

    StrengthLabel.Text = "Strength: " .. State.Strength
end

local StrengthPlus = CreateButton(
    FlingPage,
    "+ 100",
    40
)

StrengthPlus.Activated:Connect(function()
    UpdateStrength(100)
end)

local StrengthMinus = CreateButton(
    FlingPage,
    "- 100",
    40
)

StrengthMinus.Activated:Connect(function()
    UpdateStrength(-100)
end)

local StrengthPlusBig = CreateButton(
    FlingPage,
    "+ 1000",
    40
)

StrengthPlusBig.Activated:Connect(function()
    UpdateStrength(1000)
end)

local StrengthMinusBig = CreateButton(
    FlingPage,
    "- 1000",
    40
)

StrengthMinusBig.Activated:Connect(function()
    UpdateStrength(-1000)
end)

CreateLabel(
    FlingPage,
    "Interface demonstration only",
    30,
    10
)

--==================================================
-- ANTI PAGE
--==================================================

CreateLabel(AntiPage, "ANTI SETTINGS", 34, 15)

AddToggle(
    AntiPage,
    "Anti Grab Demo",
    nil
)

AddToggle(
    AntiPage,
    "Anti Ragdoll Demo",
    nil
)

AddToggle(
    AntiPage,
    "Anti Snowball Demo",
    nil
)

AddToggle(
    AntiPage,
    "Anti Explosion Demo",
    nil
)

AddToggle(
    AntiPage,
    "Anti Paint Demo",
    nil
)

AddToggle(
    AntiPage,
    "Anti Fire Demo",
    nil
)

CreateLabel(
    AntiPage,
    "These switches only demonstrate UI state.",
    42,
    10
)

--==================================================
-- FUN PAGE
--==================================================

CreateLabel(FunPage, "FUN SETTINGS", 34, 15)

AddToggle(
    FunPage,
    "Wings Demo",
    nil
)

AddToggle(
    FunPage,
    "Dynamic Wings Demo",
    nil
)

AddToggle(
    FunPage,
    "Extra Wings Demo",
    nil
)

AddToggle(
    FunPage,
    "Mech Suit Demo",
    nil
)

AddToggle(
    FunPage,
    "Effects Demo",
    nil
)

AddToggle(
    FunPage,
    "Animations Demo",
    nil
)

--==================================================
-- SETTINGS PAGE
--==================================================

CreateLabel(SettingsPage, "GENERAL SETTINGS", 34, 15)

AddToggle(
    SettingsPage,
    "Show Notifications",
    nil,
    function(enabled)
        State.Notifications = enabled
    end
)

AddToggle(
    SettingsPage,
    "Dark Mode",
    nil,
    function(enabled)
        State.DarkMode = enabled
    end
)

local VersionLabel = CreateLabel(
    SettingsPage,
    "Fling Control V1.9",
    34,
    12
)

VersionLabel.TextColor3 = CONFIG.MutedText

--==================================================
-- RESET BUTTON
--==================================================

local ResetButton = CreateButton(
    SettingsPage,
    "RESET INTERFACE",
    44
)

ResetButton.Activated:Connect(function()
    State.Strength = 100

    StrengthLabel.Text = "Strength: 100"

    for name in pairs(State.Toggles) do
        State.Toggles[name] = false
    end

    for _, page in pairs(Pages) do
        for _, object in ipairs(page:GetDescendants()) do
            if object:IsA("TextButton") then
                if object.Text == "ON" then
                    object.Text = "OFF"
                    object.BackgroundColor3 =
                        Color3.fromRGB(45, 45, 45)
                end
            end
        end
    end
end)

--==================================================
-- TAB INITIALIZATION
--==================================================

for name, page in pairs(Pages) do
    page.Visible = name == "FLING"
end

TabButtons.FLING.BackgroundColor3 = CONFIG.AccentDark

--==================================================
-- MINIMIZE / RESTORE
--==================================================

local ExpandedSize = UDim2.new(
    CONFIG.MainWidth,
    0,
    CONFIG.MainHeight,
    0
)

local CompactSize = UDim2.new(
    0,
    CONFIG.CompactWidth,
    0,
    CONFIG.CompactHeight
)

local function SetMinimized(value)
    State.Minimized = value

    local targetSize = value
        and CompactSize
        or ExpandedSize

    Body.Visible = not value
    CloseButton.Visible = not value

    MinimizeButton.Text = value and "+" or "−"

    MinimizeButton.Position = value
        and UDim2.new(1, -42, 0, 9)
        or UDim2.new(1, -82, 0, 9)

    TweenService:Create(
        Main,
        TweenInfo.new(
            0.2,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        {
            Size = targetSize
        }
    ):Play()
end

MinimizeButton.Activated:Connect(function()
    SetMinimized(not State.Minimized)
end)

--==================================================
-- CLOSE
--==================================================

CloseButton.Activated:Connect(function()
    ScreenGui:Destroy()
end)

--==================================================
-- DRAG SUPPORT
--==================================================

local Dragging = false
local DragInput = nil
local DragStart = nil
local StartPosition = nil

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        DragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and input == DragInput then
        local delta = input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + delta.Y
        )
    end
end)

--==================================================
-- RESPONSIVE SCALE
--==================================================

local UIScale = Instance.new("UIScale")
UIScale.Scale = 1
UIScale.Parent = Main

local function UpdateScale()
    local camera = workspace.CurrentCamera

    if not camera then
        return
    end

    local viewport = camera.ViewportSize

    if viewport.X < 450 then
        UIScale.Scale = 0.92
    else
        UIScale.Scale = 1
    end
end

UpdateScale()

if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal(
        "ViewportSize"
    ):Connect(UpdateScale)
end

--==================================================
-- NOTIFICATION HELPER
--==================================================

local function Notify(text)
    if not State.Notifications then
        return
    end

    pcall(function()
        game:GetService("StarterGui"):SetCore(
            "SendNotification",
            {
                Title = CONFIG.Title,
                Text = text,
                Duration = 3
            }
        )
    end)
end

--==================================================
-- INITIALIZATION
--==================================================

Notify("Interface loaded successfully")

print("--------------------------------")
print("FLING CONTROL V1.9")
print("BLACK EDITION")
print("Interface loaded")
print("--------------------------------")
