
--==================================================
-- FLING CONTROL V2.1
-- GLOBAL UPDATE | BLACK EDITION
-- GUI ONLY | ENGLISH + RUSSIAN
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIGURATION
--==================================================

local Config = {
    Background = Color3.fromRGB(10, 10, 12),
    Panel = Color3.fromRGB(18, 18, 22),
    Card = Color3.fromRGB(27, 27, 33),
    CardHover = Color3.fromRGB(36, 36, 44),
    Accent = Color3.fromRGB(55, 125, 210),
    AccentDark = Color3.fromRGB(35, 85, 150),
    Text = Color3.fromRGB(245, 245, 250),
    Muted = Color3.fromRGB(145, 145, 155),
    Green = Color3.fromRGB(45, 165, 105),
    Red = Color3.fromRGB(190, 65, 65)
}

local State = {
    Language = "EN",
    CurrentTab = "FLING",
    Minimized = false,
    Strength = 100,
    Toggles = {},
    Search = ""
}

--==================================================
-- TRANSLATIONS
--==================================================

local Languages = {
    EN = {
        FLING = "FLING",
        ANTI = "ANTI",
        FUN = "FUN",
        SETTINGS = "SETTINGS",
        Search = "Search functions...",
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
        Enabled = "Enabled",
        Disabled = "Disabled",
        Maximum = "Maximum: 2000",
        SelectLanguage = "Select Language",
        Demo = "Demonstration setting",
        Version = "GLOBAL UPDATE"
    },

    RU = {
        FLING = "ФЛИНГ",
        ANTI = "АНТИ",
        FUN = "РАЗВЛЕЧЕНИЯ",
        SETTINGS = "НАСТРОЙКИ",
        Search = "Поиск функций...",
        Strength = "Сила",
        SuperStrength = "Супер сила",
        FlingSettings = "Настройки флинга",
        AntiGrab = "Анти захват",
        AntiRagdoll = "Анти рэгдолл",
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
        Enabled = "Включено",
        Disabled = "Выключено",
        Maximum = "Максимум: 2000",
        SelectLanguage = "Выбрать язык",
        Demo = "Демонстрационная настройка",
        Version = "ГЛОБАЛЬНОЕ ОБНОВЛЕНИЕ"
    }
}

local function T(key)
    return Languages[State.Language][key] or key
end

--==================================================
-- CLEANUP
--==================================================

local Old = PlayerGui:FindFirstChild("FlingControlV21")
if Old then
    Old:Destroy()
end

--==================================================
-- UI HELPERS
--==================================================

local function Create(class, props, parent)
    local object = Instance.new(class)

    for property, value in pairs(props) do
        object[property] = value
    end

    object.Parent = parent
    return object
end

local function Round(object, radius)
    Create("UICorner", {
        CornerRadius = UDim.new(0, radius or 8)
    }, object)
end

local function Outline(object, color)
    Create("UIStroke", {
        Color = color or Color3.fromRGB(48, 48, 58),
        Thickness = 1,
        Transparency = 0.15
    }, object)
end

local function Tween(object, properties, duration)
    local animation = TweenService:Create(
        object,
        TweenInfo.new(
            duration or 0.2,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out
        ),
        properties
    )
    animation:Play()
    return animation
end

--==================================================
-- SCREEN
--==================================================

local Screen = Create("ScreenGui", {
    Name = "FlingControlV21",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Create("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(680, 460),
    Position = UDim2.new(0.5, -340, 0.5, -230),
    BackgroundColor3 = Config.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, Screen)

Round(Main, 12)
Outline(Main, Color3.fromRGB(55, 55, 70))

--==================================================
-- TOP BAR
--==================================================

local Top = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 50),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0
}, Main)

local TopTitle = Create("TextLabel", {
    Position = UDim2.fromOffset(16, 3),
    Size = UDim2.new(1, -130, 0, 27),
    BackgroundTransparency = 1,
    Text = "FLING CONTROL",
    TextColor3 = Config.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left
}, Top)

local VersionLabel = Create("TextLabel", {
    Position = UDim2.fromOffset(17, 27),
    Size = UDim2.new(1, -130, 0, 16),
    BackgroundTransparency = 1,
    Text = "V2.1 | GLOBAL UPDATE",
    TextColor3 = Config.Accent,
    Font = Enum.Font.GothamMedium,
    TextSize = 9,
    TextXAlignment = Enum.TextXAlignment.Left
}, Top)

local Minimize = Create("TextButton", {
    Position = UDim2.new(1, -78, 0, 10),
    Size = UDim2.fromOffset(29, 29),
    Text = "—",
    BackgroundColor3 = Config.Card,
    TextColor3 = Config.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    AutoButtonColor = false
}, Top)

Round(Minimize, 7)

local Close = Create("TextButton", {
    Position = UDim2.new(1, -41, 0, 10),
    Size = UDim2.fromOffset(29, 29),
    Text = "×",
    BackgroundColor3 = Color3.fromRGB(65, 30, 34),
    TextColor3 = Color3.fromRGB(255, 120, 120),
    Font = Enum.Font.GothamBold,
    TextSize = 19,
    AutoButtonColor = false
}, Top)

Round(Close, 7)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Create("Frame", {
    Position = UDim2.fromOffset(10, 60),
    Size = UDim2.new(0, 165, 1, -70),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0
}, Main)

Round(Sidebar, 9)

local Search = Create("TextBox", {
    Position = UDim2.fromOffset(9, 10),
    Size = UDim2.new(1, -18, 0, 36),
    BackgroundColor3 = Config.Card,
    Text = "",
    PlaceholderText = T("Search"),
    PlaceholderColor3 = Config.Muted,
    TextColor3 = Config.Text,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    ClearTextOnFocus = false
}, Sidebar)

Round(Search, 7)

local TabList = Create("Frame", {
    Position = UDim2.fromOffset(9, 56),
    Size = UDim2.new(1, -18, 1, -65),
    BackgroundTransparency = 1
}, Sidebar)

Create("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
}, TabList)

--==================================================
-- CONTENT PANEL
--==================================================

local Content = Create("Frame", {
    Position = UDim2.fromOffset(185, 60),
    Size = UDim2.new(1, -195, 1, -70),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, Main)

Round(Content, 9)

local PageTitle = Create("TextLabel", {
    Position = UDim2.fromOffset(15, 8),
    Size = UDim2.new(1, -30, 0, 35),
    BackgroundTransparency = 1,
    Text = "FLING",
    TextColor3 = Config.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left
}, Content)

local Page = Create("ScrollingFrame", {
    Position = UDim2.fromOffset(10, 47),
    Size = UDim2.new(1, -20, 1, -57),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = Config.Accent,
    ScrollBarImageTransparency = 0.1,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ScrollingEnabled = true,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
    VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
}, Content)

local PageLayout = Create("UIListLayout", {
    Padding = UDim.new(0, 9),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Page)

Create("UIPadding", {
    PaddingBottom = UDim.new(0, 15),
    PaddingTop = UDim.new(0, 3),
    PaddingLeft = UDim.new(0, 2),
    PaddingRight = UDim.new(0, 5)
}, Page)

--==================================================
-- FUNCTION LIST
--==================================================

local Functions = {
    FLING = {
        "Strength",
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

local Tabs = {}
local RefreshPage

--==================================================
-- CARD CREATION
--==================================================

local function CreateCard(name, key)
    local Card = Create("Frame", {
        Size = UDim2.new(1, -4, 0, 66),
        BackgroundColor3 = Config.Card,
        BorderSizePixel = 0
    }, Page)

    Round(Card, 8)
    Outline(Card)

    local Label = Create("TextLabel", {
        Position = UDim2.fromOffset(13, 6),
        Size = UDim2.new(1, -110, 0, 27),
        BackgroundTransparency = 1,
        Text = T(key),
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Description = Create("TextLabel", {
        Position = UDim2.fromOffset(13, 32),
        Size = UDim2.new(1, -110, 0, 20),
        BackgroundTransparency = 1,
        Text = T("Demo"),
        TextColor3 = Config.Muted,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Button = Create("TextButton", {
        Position = UDim2.new(1, -79, 0.5, -13),
        Size = UDim2.fromOffset(65, 27),
        BackgroundColor3 = Color3.fromRGB(52, 52, 60),
        Text = State.Toggles[name] and "ON" or "OFF",
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        AutoButtonColor = false
    }, Card)

    Round(Button, 7)

    Button.BackgroundColor3 =
        State.Toggles[name] and Config.Green
        or Color3.fromRGB(52, 52, 60)

    Button.Activated:Connect(function()
        State.Toggles[name] = not State.Toggles[name]

        Button.Text = State.Toggles[name] and "ON" or "OFF"

        Tween(Button, {
            BackgroundColor3 =
                State.Toggles[name] and Config.Green
                or Color3.fromRGB(52, 52, 60)
        })
    end)

    Card.MouseEnter:Connect(function()
        Tween(Card, {
            BackgroundColor3 = Config.CardHover
        })
    end)

    Card.MouseLeave:Connect(function()
        Tween(Card, {
            BackgroundColor3 = Config.Card
        })
    end)

    return Card
end

--==================================================
-- STRENGTH SLIDER
--==================================================

local function CreateStrength()
    local Card = Create("Frame", {
        Size = UDim2.new(1, -4, 0, 105),
        BackgroundColor3 = Config.Card,
        BorderSizePixel = 0
    }, Page)

    Round(Card, 8)
    Outline(Card)

    Create("TextLabel", {
        Position = UDim2.fromOffset(13, 7),
        Size = UDim2.new(0.7, 0, 0, 25),
        BackgroundTransparency = 1,
        Text = T("Strength"),
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Value = Create("TextLabel", {
        Position = UDim2.new(1, -100, 0, 7),
        Size = UDim2.fromOffset(85, 25),
        BackgroundTransparency = 1,
        Text = tostring(State.Strength),
        TextColor3 = Config.Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Right
    }, Card)

    local MaxLabel = Create("TextLabel", {
        Position = UDim2.fromOffset(13, 33),
        Size = UDim2.new(1, -26, 0, 16),
        BackgroundTransparency = 1,
        Text = T("Maximum"),
        TextColor3 = Config.Muted,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Bar = Create("Frame", {
        Position = UDim2.fromOffset(13, 68),
        Size = UDim2.new(1, -26, 0, 10),
        BackgroundColor3 = Color3.fromRGB(50, 50, 58),
        BorderSizePixel = 0
    }, Card)

    Round(Bar, 6)

    local Fill = Create("Frame", {
        Size = UDim2.new(State.Strength / 2000, 0, 1, 0),
        BackgroundColor3 = Config.Accent,
        BorderSizePixel = 0
    }, Bar)

    Round(Fill, 6)

    local Knob = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(State.Strength / 2000, 0, 0.5, 0),
        Size = UDim2.fromOffset(17, 17),
        BackgroundColor3 = Config.Text,
        BorderSizePixel = 0
    }, Bar)

    Round(Knob, 20)
    Outline(Knob, Config.Accent)

    local dragging = false

    local function SetValue(positionX)
        local percent = math.clamp(
            (positionX - Bar.AbsolutePosition.X) /
            Bar.AbsoluteSize.X,
            0,
            1
        )

        State.Strength = math.clamp(
            math.floor(percent * 2000 + 0.5),
            0,
            2000
        )

        Value.Text = tostring(State.Strength)

        Tween(Fill, {
            Size = UDim2.new(percent, 0, 1, 0)
        }, 0.08)

        Tween(Knob, {
            Position = UDim2.new(percent, 0, 0.5, 0)
        }, 0.08)
    end

    Bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            SetValue(input.Position.X)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            SetValue(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

--==================================================
-- LANGUAGE SELECTOR
--==================================================

local function CreateLanguageSelector()
    local Card = Create("Frame", {
        Size = UDim2.new(1, -4, 0, 105),
        BackgroundColor3 = Config.Card,
        BorderSizePixel = 0
    }, Page)

    Round(Card, 8)
    Outline(Card)

    Create("TextLabel", {
        Position = UDim2.fromOffset(13, 8),
        Size = UDim2.new(1, -26, 0, 25),
        BackgroundTransparency = 1,
        Text = T("SelectLanguage"),
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local English = Create("TextButton", {
        Position = UDim2.fromOffset(13, 45),
        Size = UDim2.new(0.5, -19, 0, 36),
        BackgroundColor3 =
            State.Language == "EN" and Config.Accent or Config.Element,
        Text = "English",
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        AutoButtonColor = false
    }, Card)

    Round(English, 7)

    local Russian = Create("TextButton", {
        Position = UDim2.new(0.5, 6, 0, 45),
        Size = UDim2.new(0.5, -19, 0, 36),
        BackgroundColor3 =
            State.Language == "RU" and Config.Accent or Config.Element,
        Text = "Русский",
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        AutoButtonColor = false
    }, Card)

    Round(Russian, 7)

    English.Activated:Connect(function()
        State.Language = "EN"
        RefreshPage()
    end)

    Russian.Activated:Connect(function()
        State.Language = "RU"
        RefreshPage()
    end)
end

--==================================================
-- RESET SETTINGS
--==================================================

local function ResetSettings()
    State.Strength = 100

    for key in pairs(State.Toggles) do
        State.Toggles[key] = false
    end

    RefreshPage()
end

--==================================================
-- PAGE REFRESH
--==================================================

RefreshPage = function()
    PageTitle.Text = T(State.CurrentTab)
    Search.PlaceholderText = T("Search")

    for _, child in ipairs(Page:GetChildren()) do
        if child:IsA("GuiObject")
            and child ~= PageLayout then
            child:Destroy()
        end
    end

    if State.CurrentTab == "FLING" then
        CreateStrength()
    end

    for _, key in ipairs(Functions[State.CurrentTab]) do
        local translated = T(key)

        local matches =
            State.Search == ""
            or translated:lower():find(State.Search:lower(), 1, true)
            or key:lower():find(State.Search:lower(), 1, true)

        if matches then
            if key == "Language" then
                CreateLanguageSelector()

            elseif key == "ResetSettings" then
                local Card = Create("Frame", {
                    Size = UDim2.new(1, -4, 0, 66),
                    BackgroundColor3 = Config.Card,
                    BorderSizePixel = 0
                }, Page)

                Round(Card, 8)

                Create("TextLabel", {
                    Position = UDim2.fromOffset(13, 5),
                    Size = UDim2.new(1, -100, 1, -10),
                    BackgroundTransparency = 1,
                    Text = translated,
                    TextColor3 = Config.Text,
                    Font = Enum.Font.GothamSemibold,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                }, Card)

                local Reset = Create("TextButton", {
                    Position = UDim2.new(1, -85, 0.5, -14),
                    Size = UDim2.fromOffset(72, 28),
                    BackgroundColor3 = Config.Red,
                    Text = "RESET",
                    TextColor3 = Config.Text,
                    Font = Enum.Font.GothamBold,
                    TextSize = 10
                }, Card)

                Round(Reset, 7)

                Reset.Activated:Connec
