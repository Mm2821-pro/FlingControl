
--========================================================
-- FLING CONTROL V2.1
-- BLACK EDITION | GUI DEMO
--========================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--========================================================
-- CLEANUP
--========================================================

local Old = PlayerGui:FindFirstChild("FlingControlV21")

if Old then
    Old:Destroy()
end

--========================================================
-- CONFIG
--========================================================

local Config = {
    Background = Color3.fromRGB(9, 10, 14),
    Sidebar = Color3.fromRGB(13, 15, 21),
    Panel = Color3.fromRGB(17, 19, 27),
    Card = Color3.fromRGB(23, 26, 36),
    Hover = Color3.fromRGB(31, 36, 49),
    Accent = Color3.fromRGB(35, 125, 255),
    AccentDark = Color3.fromRGB(22, 75, 155),
    Text = Color3.fromRGB(240, 243, 250),
    Muted = Color3.fromRGB(135, 143, 160),
    Green = Color3.fromRGB(45, 190, 115),
    Red = Color3.fromRGB(220, 65, 75),
    Border = Color3.fromRGB(42, 47, 62)
}

local State = {
    Language = "EN",
    CurrentTab = "FLING",
    Strength = 100,
    Search = "",
    Minimized = false,
    Toggles = {}
}

--========================================================
-- TRANSLATIONS
--========================================================

local Texts = {
    EN = {
        FLING = "FLING",
        ANTI = "ANTI",
        FUN = "FUN",
        SETTINGS = "SETTINGS",
        Strength = "Strength",
        SuperStrength = "Super Strength",
        FlingSettings = "Fling Settings",
        AntiGrab = "Anti Grab",
        AntiRagdoll = "Anti Ragdoll",
        AntiSnowball = "Anti Snowball",
        AntiExplosion = "Anti Explosion",
        AntiPaint = "Anti Paint",
        AntiFire = "Anti Fire",
        AntiKick = "Anti Kick",
        Wings = "Wings",
        DynamicWings = "Dynamic Wings",
        ExtraWings = "Extra Wings",
        MechSuit = "Mech Suit",
        DarkMode = "Dark Mode",
        Notifications = "Show Notifications",
        Language = "Language",
        InterfaceScale = "Interface Scale",
        ResetSettings = "Reset Settings",
        Search = "Search functions...",
        Enabled = "ENABLED",
        Disabled = "DISABLED",
        Appearance = "APPEARANCE",
        General = "GENERAL",
        SelectLanguage = "SELECT LANGUAGE",
        Demo = "DEMONSTRATION INTERFACE"
    },

    RU = {
        FLING = "БРОСОК",
        ANTI = "АНТИ",
        FUN = "РАЗВЛЕЧЕНИЯ",
        SETTINGS = "НАСТРОЙКИ",
        Strength = "Сила",
        SuperStrength = "Супер сила",
        FlingSettings = "Настройки броска",
        AntiGrab = "Анти захват",
        AntiRagdoll = "Анти регдолл",
        AntiSnowball = "Анти снежок",
        AntiExplosion = "Анти взрыв",
        AntiPaint = "Анти краска",
        AntiFire = "Анти огонь",
        AntiKick = "Анти кик",
        Wings = "Крылья",
        DynamicWings = "Динамические крылья",
        ExtraWings = "Дополнительные крылья",
        MechSuit = "Меха костюм",
        DarkMode = "Тёмная тема",
        Notifications = "Уведомления",
        Language = "Язык",
        InterfaceScale = "Размер интерфейса",
        ResetSettings = "Сброс настроек",
        Search = "Поиск функций...",
        Enabled = "ВКЛЮЧЕНО",
        Disabled = "ВЫКЛЮЧЕНО",
        Appearance = "ВНЕШНИЙ ВИД",
        General = "ОБЩЕЕ",
        SelectLanguage = "ВЫБЕРИ ЯЗЫК",
        Demo = "ДЕМОНСТРАЦИОННЫЙ ИНТЕРФЕЙС"
    }
}

local function T(Key)
    local Dictionary = Texts[State.Language]
    return Dictionary[Key] or Key
end

--========================================================
-- FEATURE DATA
--========================================================

local Features = {
    FLING = {
        "SuperStrength",
        "FlingSettings"
    },

    ANTI = {
        "AntiGrab",
        "AntiRagdoll",
        "AntiSnowball",
        "AntiExplosion",
        "AntiPaint",
        "AntiFire",
        "AntiKick"
    },

    FUN = {
        "Wings",
        "DynamicWings",
        "ExtraWings",
        "MechSuit"
    },

    SETTINGS = {
        "DarkMode",
        "Notifications",
        "Language",
        "InterfaceScale",
        "ResetSettings"
    }
}

--========================================================
-- DEFAULT VALUES
--========================================================

for _, List in pairs(Features) do
    for _, Key in ipairs(List) do
        State.Toggles[Key] = false
    end
end

--========================================================
-- UI HELPERS
--========================================================

local function Create(Class, Properties, Parent)
    local Object = Instance.new(Class)

    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end

    if Parent then
        Object.Parent = Parent
    end

    return Object
end

local function Round(Object, Radius)
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, Radius or 8)
    Corner.Parent = Object
    return Corner
end

local function Stroke(Object, Color, Transparency)
    local Line = Instance.new("UIStroke")
    Line.Color = Color or Config.Border
    Line.Transparency = Transparency or 0
    Line.Thickness = 1
    Line.Parent = Object
    return Line
end

local function Animate(Object, Properties, Duration)
    local Info = TweenInfo.new(
        Duration or 0.16,
        Enum.EasingStyle.Quart,
        Enum.EasingDirection.Out
    )

    local Tween = TweenService:Create(
        Object,
        Info,
        Properties
    )

    Tween:Play()
    return Tween
end

--========================================================
-- SCREEN GUI
--========================================================

local Screen = Create("ScreenGui", {
    Name = "FlingControlV21",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

--========================================================
-- MAIN WINDOW
--========================================================

local Main = Create("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(680, 460),
    Position = UDim2.new(0.5, -340, 0.5, -230),
    BackgroundColor3 = Config.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, Screen)

Round(Main, 13)
Stroke(Main, Config.Border)

--========================================================
-- TOP BAR
--========================================================

local Top = Create("Frame", {
    Name = "Top",
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0
}, Main)

local Logo = Create("TextLabel", {
    Position = UDim2.fromOffset(17, 0),
    Size = UDim2.fromOffset(175, 48),
    BackgroundTransparency = 1,
    Text = "FLING CONTROL",
    TextColor3 = Config.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left
}, Top)

local Version = Create("TextLabel", {
    Position = UDim2.fromOffset(190, 0),
    Size = UDim2.fromOffset(55, 48),
    BackgroundTransparency = 1,
    Text = "V2.1",
    TextColor3 = Config.Accent,
    Font = Enum.Font.GothamBold,
    TextSize = 11
}, Top)

local Minimize = Create("TextButton", {
    Position = UDim2.new(1, -78, 0, 8),
    Size = UDim2.fromOffset(30, 30),
    BackgroundColor3 = Config.Card,
    Text = "—",
    TextColor3 = Config.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    AutoButtonColor = false
}, Top)

Round(Minimize, 7)

local Close = Create("TextButton", {
    Position = UDim2.new(1, -40, 0, 8),
    Size = UDim2.fromOffset(30, 30),
    BackgroundColor3 = Config.Red,
    Text = "×",
    TextColor3 = Color3.new(1, 1, 1),
    Font = Enum.Font.GothamBold,
    TextSize = 19,
    AutoButtonColor = false
}, Top)

Round(Close, 7)

--========================================================
-- SIDEBAR
--========================================================

local Sidebar = Create("Frame", {
    Name = "Sidebar",
    Position = UDim2.fromOffset(0, 48),
    Size = UDim2.new(0, 165, 1, -48),
    BackgroundColor3 = Config.Sidebar,
    BorderSizePixel = 0
}, Main)

local TabList = Create("Frame", {
    Position = UDim2.fromOffset(10, 16),
    Size = UDim2.new(1, -20, 1, -32),
    BackgroundTransparency = 1
}, Sidebar)

local TabLayout = Create("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
}, TabList)

local Tabs = {}

--========================================================
-- CONTENT AREA
--========================================================

local Content = Create("Frame", {
    Name = "Content",
    Position = UDim2.fromOffset(165, 48),
    Size = UDim2.new(1, -165, 1, -48),
    BackgroundColor3 = Config.Background,
    BorderSizePixel = 0
}, Main)

local PageTitle = Create("TextLabel", {
    Position = UDim2.fromOffset(19, 13),
    Size = UDim2.new(1, -38, 0, 27),
    BackgroundTransparency = 1,
    Text = "FLING",
    TextColor3 = Config.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left
}, Content)

local Search = Create("TextBox", {
    Position = UDim2.fromOffset(18, 48),
    Size = UDim2.new(1, -36, 0, 35),
    BackgroundColor3 = Config.Card,
    Text = "",
    PlaceholderText = T("Search"),
    PlaceholderColor3 = Config.Muted,
    TextColor3 = Config.Text,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    ClearTextOnFocus = false
}, Content)

Round(Search, 8)
Stroke(Search, Config.Border)

local Page = Create("ScrollingFrame", {
    Name = "Page",
    Position = UDim2.fromOffset(18, 95),
    Size = UDim2.new(1, -36, 1, -112),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Config.Accent,
    ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
}, Content)

local PageLayout = Create("UIListLayout", {
    Padding = UDim.new(0, 10),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Page)

Create("UIPadding", {
    PaddingBottom = UDim.new(0, 12)
}, Page)

--========================================================
-- CARD CREATION
--========================================================

local function CreateCard(Key)
    local Card = Create("Frame", {
        Name = Key .. "Card",
        Size = UDim2.new(1, 0, 0, 59),
        BackgroundColor3 = Config.Card,
        BorderSizePixel = 0
    }, Page)

    Round(Card, 9)
    Stroke(Card, Config.Border)

    local Label = Create("TextLabel", {
        Position = UDim2.fromOffset(14, 0),
        Size = UDim2.new(1, -110, 1, 0),
        BackgroundTransparency = 1,
        Text = T(Key),
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Button = Create("TextButton", {
        Position = UDim2.new(1, -91, 0.5, -14),
        Size = UDim2.fromOffset(77, 28),
        BackgroundColor3 =
            State.Toggles[Key] and Config.Green or Config.Panel,
        Text =
            State.Toggles[Key] and T("Enabled") or T("Disabled"),
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 9,
        AutoButtonColor = false
    }, Card)

    Round(Button, 7)

    Button.Activated:Connect(function()
        State.Toggles[Key] = not State.Toggles[Key]

        Animate(Button, {
            BackgroundColor3 =
                State.Toggles[Key] and Config.Green or Config.Panel
        })

        Button.Text =
            State.Toggles[Key] and T("Enabled") or T("Disabled")
    end)

    Card.MouseEnter:Connect(function()
        Animate(Card, {BackgroundColor3 = Config.Hover})
    end)

    Card.MouseLeave:Connect(function()
        Animate(Card, {BackgroundColor3 = Config.Card})
    end)

    return Card
end

--========================================================
-- STRENGTH SLIDER
--========================================================

local function CreateStrength()
    local Card = Create("Frame", {
        Name = "StrengthCard",
        Size = UDim2.new(1, 0, 0, 83),
        BackgroundColor3 = Config.Card,
        BorderSizePixel = 0
    }, Page)

    Round(Card, 9)
    Stroke(Card, Config.Border)

    local Label = Create("TextLabel", {
        Position = UDim2.fromOffset(14, 8),
        Size = UDim2.new(1, -90, 0, 23),
        BackgroundTransparency = 1,
        Text = T("Strength"),
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Value = Create("TextLabel", {
        Position = UDim2.new(1, -70, 0, 8),
        Size = UDim2.fromOffset(55, 23),
        BackgroundTransparency = 1,
        Text = tostring(State.Strength),
        TextColor3 = Config.Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right
    }, Card)

    local Bar = Create("Frame", {
        Position = UDim2.fromOffset(14, 48),
        Size = UDim2.new(1, -28, 0, 9),
        BackgroundColor3 = Config.Panel,
        BorderSizePixel = 0
    }, Card)

    Round(Bar, 5)

    local Fill = Create("Frame", {
        Size = UDim2.new(State.Strength / 2000, 0, 1, 0),
        BackgroundColor3 = Config.Accent,
        BorderSizePixel = 0
    }, Bar)

    Round(Fill, 5)

    local Active = false

    local function SetStrength(X)
        local Width = math.max(1, Bar.AbsoluteSize.X)
        local Relative = math.clamp(
            (X - Bar.AbsolutePosition.X) / Width,
            0,
            1
        )

        State.Strength = math.floor(Relative * 2000)

        Value.Text = tostring(State.Strength)

        Animate(Fill, {
            Size = UDim2.new(Relative, 0, 1, 0)
        }, 0.07)
    end

    Bar.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1
            or Input.UserInputType == Enum.UserInputType.Touch then

            Active = true
            SetStrength(Input.Position.X)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if Active and (
            Input.UserInputType == Enum.UserInputType.MouseMovement
            or Input.UserInputType == Enum.UserInputType.Touch
        ) then
            SetStrength(Input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1
            or Input.UserInputType == Enum.UserInputType.Touch then
            Active = false
        end
    end)
end

--========================================================
-- LANGUAGE SELECTOR
--========================================================

local function CreateLanguageSelector()
    local Card = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 74),
        BackgroundColor3 = Config.Card,
        BorderSizePixel = 0
    }, Page)

    Round(Card, 9)
    Stroke(Card, Config.Border)

    local Label = Create("TextLabel", {
        Position = UDim2.fromOffset(14, 5),
        Size = UDim2.new(1, -28, 0, 24),
        BackgroundTransparency = 1,
        Text = T("SelectLanguage"),
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local function LanguageButton(Name, X, Code)
        local Button = Create("TextButton", {
            Position = UDim2.fromOffset(X, 36),
            Size = UDim2.fromOffset(105, 27),
            BackgroundColor3 =
                State.Language == Code and Config.Accent or Config.Panel,
            Text = Name,
            TextColor3 = Config.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 10,
            AutoButtonColor = false
        }, Card)

        Round(Button, 6)

        Button.Activated:Connect(function()
            State.Language = Code
            RefreshPage()
        end)
    end

    LanguageButton("English", 14, "EN")
    LanguageButton("Русский", 128, "RU")
end

--========================================================
-- RESET SETTINGS
--========================================================

local function CreateReset()
    local Card = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 59),
        BackgroundColor3 = Config.Card,
        BorderSizePixel = 0
    }, Page)

    Round(Card, 9)
    Stroke(Card, Config.Border)

    Create("TextLabel", {
        Position = UDim2.fromOffset(14, 0),
        Size = UDim2.new(1, -110, 1, 0),
        BackgroundTransparency = 1,
        Text = T("ResetSettings"),
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Button = Create("TextButton", {
        Position = UDim2.new(1, -91, 0.5, -14),
        Size = UDim2.fromOffset(77, 28),
        BackgroundColor3 = Config.Red,
        Text = "RESET",
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 10
    }, Card)

    Round(Button, 7)

    Button.Activated:Connect(function()
        State.Strength = 100

        for Key in pairs(State.Toggles) do
            State.Toggles[Key] = false
        end

        RefreshPage()
    end)
end

--========================================================
-- PAGE REFRESH
--========================================================

function RefreshPage()
    for _, Child in ipairs(Page:GetChildren()) do
        if Child:IsA("GuiObject")
            and Child ~= PageLayout then
            Child:Destroy()
        end
    end

    PageTitle.Text = T(State.CurrentTab)

    local Query = string.lower(State.Search)

    local function Matches(Key)
        return Query == ""
            or string.find(
                string.lower(T(Key)),
                Query,
                1,
                true
            ) ~= nil
    end

    if State.CurrentTab == "FLING" then
        if Matches("Strength") then
            CreateStrength()
        end
    end

    for _, Key in ipairs(Features[State.CurrentTab] or {}) do
        if Matches(Key) then
            if Key == "Language" then
                CreateLanguageSelector()
            elseif Key == "ResetSettings" then
                CreateReset()
            else
                CreateCard(Key)
            end
        end
    end

    Page.CanvasPosition = Vector2.new(0, 0)
end

--========================================================
-- SIDEBAR TABS
--========================================================

local TabNames = {
    "FLING",
    "ANTI",
    "FUN",
    "SETTINGS"
}

for Index, TabName in ipairs(TabNames) do
    local Tab = Create("TextButton", {
        Name = TabName .. "Tab",
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 =
            State.CurrentTab == TabName
            and Config.AccentDark
            or Config.Card,
        Text = T(TabName),
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        AutoButtonColor = false,
        LayoutOrder = Index
    }, TabList)

    Round(Tab, 8)
    Tabs[TabName] = Tab

    Tab.Activated:Connect(function()
        State.CurrentTab = TabName

        for Name, Button in pairs(Tabs) do
            Button.BackgroundColor3 =
                Name == TabName and Config.AccentDark or Config.Card
            Button.Text = T(Name)
        end

        RefreshPage()
    end)
end

--========================================================
-- SEARCH
--==================================================
