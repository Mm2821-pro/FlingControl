
--[[
    FlingControl V2.0
    GLOBAL UPDATE | BLACK EDITION
    GUI ONLY
    Designed for Roblox LocalScript
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- SETTINGS

local Config = {
    Background = Color3.fromRGB(12, 12, 14),
    Panel = Color3.fromRGB(19, 19, 22),
    Element = Color3.fromRGB(29, 29, 34),
    Accent = Color3.fromRGB(45, 115, 190),
    Text = Color3.fromRGB(240, 240, 245),
    Muted = Color3.fromRGB(145, 145, 155),
    Enabled = Color3.fromRGB(40, 145, 90)
}

local State = {
    CurrentTab = "FLING",
    Minimized = false,
    Toggles = {},
    Strength = 100
}

-- CLEANUP

local Old = PlayerGui:FindFirstChild("FlingControlV2")
if Old then
    Old:Destroy()
end

-- HELPERS

local function Create(class, properties, parent)
    local object = Instance.new(class)

    for property, value in pairs(properties) do
        object[property] = value
    end

    object.Parent = parent
    return object
end

local function Corner(parent, radius)
    return Create("UICorner", {
        CornerRadius = UDim.new(0, radius or 8)
    }, parent)
end

local function Stroke(parent, color)
    return Create("UIStroke", {
        Color = color or Color3.fromRGB(48, 48, 55),
        Thickness = 1
    }, parent)
end

local function Animate(object, properties)
    TweenService:Create(
        object,
        TweenInfo.new(0.18, Enum.EasingStyle.Quad),
        properties
    ):Play()
end

-- SCREEN GUI

local Screen = Create("ScreenGui", {
    Name = "FlingControlV2",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

-- MAIN WINDOW

local Main = Create("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(650, 430),
    Position = UDim2.new(0.5, -325, 0.5, -215),
    BackgroundColor3 = Config.Background,
    BorderSizePixel = 0
}, Screen)

Corner(Main, 12)
Stroke(Main, Color3.fromRGB(55, 55, 65))

-- TOP BAR

local Top = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0
}, Main)

Corner(Top, 12)

local Title = Create("TextLabel", {
    Position = UDim2.fromOffset(17, 0),
    Size = UDim2.new(1, -120, 1, 0),
    BackgroundTransparency = 1,
    Text = "FLING CONTROL  |  V2.0",
    TextColor3 = Config.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left
}, Top)

local Minimize = Create("TextButton", {
    Position = UDim2.new(1, -76, 0, 9),
    Size = UDim2.fromOffset(28, 28),
    Text = "—",
    TextColor3 = Config.Text,
    BackgroundColor3 = Config.Element,
    Font = Enum.Font.GothamBold,
    TextSize = 16
}, Top)

Corner(Minimize, 7)

local Close = Create("TextButton", {
    Position = UDim2.new(1, -39, 0, 9),
    Size = UDim2.fromOffset(28, 28),
    Text = "×",
    TextColor3 = Color3.fromRGB(255, 110, 110),
    BackgroundColor3 = Config.Element,
    Font = Enum.Font.GothamBold,
    TextSize = 19
}, Top)

Corner(Close, 7)

-- SIDEBAR

local Sidebar = Create("Frame", {
    Position = UDim2.fromOffset(10, 58),
    Size = UDim2.new(0, 155, 1, -68),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0
}, Main)

Corner(Sidebar, 9)

local Search = Create("TextBox", {
    Position = UDim2.fromOffset(9, 10),
    Size = UDim2.new(1, -18, 0, 34),
    BackgroundColor3 = Config.Element,
    Text = "",
    PlaceholderText = "Search functions...",
    PlaceholderColor3 = Config.Muted,
    TextColor3 = Config.Text,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    ClearTextOnFocus = false
}, Sidebar)

Corner(Search, 7)

local TabList = Create("Frame", {
    Position = UDim2.fromOffset(8, 54),
    Size = UDim2.new(1, -16, 1, -62),
    BackgroundTransparency = 1
}, Sidebar)

Create("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder
}, TabList)

-- CONTENT

local Content = Create("Frame", {
    Position = UDim2.fromOffset(175, 58),
    Size = UDim2.new(1, -185, 1, -68),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0
}, Main)

Corner(Content, 9)

local PageTitle = Create("TextLabel", {
    Position = UDim2.fromOffset(15, 9),
    Size = UDim2.new(1, -30, 0, 35),
    BackgroundTransparency = 1,
    Text = "FLING",
    TextColor3 = Config.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left
}, Content)

local Page = Create("ScrollingFrame", {
    Position = UDim2.fromOffset(10, 48),
    Size = UDim2.new(1, -20, 1, -58),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = Config.Accent,
    CanvasSize = UDim2.new()
}, Content)

local PageLayout = Create("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Page)

PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Page.CanvasSize = UDim2.new(
        0, 0, 0, PageLayout.AbsoluteContentSize.Y + 12
    )
end)

-- PAGE DATA

local Functions = {
    FLING = {
        "Strength",
        "Super Strength",
        "Fling Settings"
    },

    ANTI = {
        "Anti Grab",
        "Anti Ragdoll",
        "Anti Snowball",
        "Anti Explosion",
        "Anti Paint",
        "Anti Fire",
        "Anti Kick"
    },

    FUN = {
        "Wings",
        "Dynamic Wings",
        "Extra Wings",
        "Mech Suit"
    },

    SETTINGS = {
        "Dark Mode",
        "Show Notifications",
        "Interface Scale",
        "Reset Settings"
    }
}

-- FUNCTION CARDS

local function CreateCard(name)
    local Card = Create("Frame", {
        Size = UDim2.new(1, -5, 0, 65),
        BackgroundColor3 = Config.Element,
        BorderSizePixel = 0
    }, Page)

    Corner(Card, 8)

    local Label = Create("TextLabel", {
        Position = UDim2.fromOffset(12, 5),
        Size = UDim2.new(1, -90, 0, 27),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Description = Create("TextLabel", {
        Position = UDim2.fromOffset(12, 31),
        Size = UDim2.new(1, -90, 0, 20),
        BackgroundTransparency = 1,
        Text = "Demonstration setting",
        TextColor3 = Config.Muted,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Toggle = Create("TextButton", {
        Position = UDim2.new(1, -67, 0.5, -13),
        Size = UDim2.fromOffset(55, 26),
        BackgroundColor3 = Color3.fromRGB(55, 55, 60),
        Text = "OFF",
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 10
    }, Card)

    Corner(Toggle, 7)

    State.Toggles[name] = false

    Toggle.Activated:Connect(function()
        State.Toggles[name] = not State.Toggles[name]

        if State.Toggles[name] then
            Toggle.Text = "ON"
            Animate(Toggle, {
                BackgroundColor3 = Config.Enabled
            })
        else
            Toggle.Text = "OFF"
            Animate(Toggle, {
                BackgroundColor3 = Color3.fromRGB(55, 55, 60)
            })
        end
    end)

    return Card
end

-- STRENGTH CARD

local function CreateStrength()
    local Card = Create("Frame", {
        Size = UDim2.new(1, -5, 0, 92),
        BackgroundColor3 = Config.Element,
        BorderSizePixel = 0
    }, Page)

    Corner(Card, 8)

    Create("TextLabel", {
        Position = UDim2.fromOffset(12, 7),
        Size = UDim2.new(1, -24, 0, 25),
        BackgroundTransparency = 1,
        Text = "Strength",
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Value = Create("TextLabel", {
        Position = UDim2.new(1, -65, 0, 7),
        Size = UDim2.fromOffset(50, 25),
        BackgroundTransparency = 1,
        Text = tostring(State.Strength),
        TextColor3 = Config.Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 12
    }, Card)

    local Slider = Create("TextButton", {
        Position = UDim2.fromOffset(12, 48),
        Size = UDim2.new(1, -24, 0, 12),
        BackgroundColor3 = Color3.fromRGB(55, 55, 60),
        Text = ""
    }, Card)

    Corner(Slider, 6)

    local Fill = Create("Frame", {
        Size = UDim2.new(0.1, 0, 1, 0),
        BackgroundColor3 = Config.Accent,
        BorderSizePixel = 0
    }, Slider)

    Corner(Fill, 6)

    local function SetStrength(x)
        local percent = math.clamp(
            (x - Slider.AbsolutePosition.X) /
            Slider.AbsoluteSize.X,
            0, 1
        )

        State.Strength = math.floor(percent * 1000)
        Value.Text = tostring(State.Strength)

        Animate(Fill, {
            Size = UDim2.new(percent, 0, 1, 0)
        })
    end

    Slider.Activated:Connect(function()
        SetStrength(UserInputService:GetMouseLocation().X)
    end)
end

-- TABS

local Tabs = {}
local CurrentSearch = ""

local function LoadTab(tabName)
    State.CurrentTab = tabName
    PageTitle.Text = tabName

    for _, child in ipairs(Page:GetChildren()) do
        if child:IsA("GuiObject") then
            child:Destroy()
        end
    end

    if tabName == "FLING" then
        CreateStrength()
    end

    for _, name in ipairs(Functions[tabName]) do
        if name:lower():find(CurrentSearch:lower(), 1, true) then
            CreateCard(name)
        end
    end

    for name, button in pairs(Tabs) do
        button.BackgroundColor3 =
            name == tabName and Config.Accent or Config.Element
    end
end

local function CreateTab(name, order)
    local Button = Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = Config.Element,
        Text = name,
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        LayoutOrder = order
    }, TabList)

    Corner(Button, 7)
    Tabs[name] = Button

    Button.Activated:Connect(function()
        LoadTab(name)
    end)
end

CreateTab("FLING", 1)
CreateTab("ANTI", 2)
CreateTab("FUN", 3)
CreateTab("SETTINGS", 4)

-- SEARCH

Search:GetPropertyChangedSignal("Text"):Connect(function()
    CurrentSearch = Search.Text
    LoadTab(State.CurrentTab)
end)

-- MINIMIZE

local OldSize = Main.Size

Minimize.Activated:Connect(function()
    State.Minimized = not State.Minimized

    Sidebar.Visible = not State.Minimized
    Content.Visible = not State.Minimized

    if State.Minimized then
        Animate(Main, {
            Size = UDim2.fromOffset(260, 48)
        })
    else
        Animate(Main, {
            Size = OldSize
        })
    end
end)

-- CLOSE

Close.Activated:Connect(function()
    Screen:Destroy()
end)

-- DRAG

local Dragging = false
local DragStart
local StartPosition

Top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then

        local delta = input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

-- START

LoadTab("FLING")

print("FlingControl V2.0 loaded successfully")
