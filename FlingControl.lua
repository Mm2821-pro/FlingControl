
--========================================================
-- FLING CONTROL V2.2
-- BLACK EDITION | MOBILE FIX
-- GUI DEMONSTRATION FOR OWN ROBLOX PROJECT
--========================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--========================================================
-- CLEANUP
--========================================================

local Old = PlayerGui:FindFirstChild("FlingControlV22")
if Old then
    Old:Destroy()
end

--========================================================
-- CONFIGURATION
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
        Enabled = "ON",
        Disabled = "OFF",
        SelectLanguage = "SELECT LANGUAGE"
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
        Enabled = "ВКЛ",
        Disabled = "ВЫКЛ",
        SelectLanguage = "ВЫБЕРИ ЯЗЫК"
    }
}

local function T(Key)
    return Texts[State.Language][Key] or Key
end

--========================================================
-- FEATURE LIST
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

for _, List in pairs(Features) do
    for _, Key in ipairs(List) do
        State.Toggles[Key] = false
    end
end

--========================================================
-- HELPERS
--========================================================

local function Create(Class, Properties, Parent)
    local Object = Instance.new(Class)

    for Key, Value in pairs(Properties or {}) do
        Object[Key] = Value
    end

    Object.Parent = Parent
    return Object
end

local function Round(Object, Radius)
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, Radius or 8)
    Corner.Parent = Object
end

local function AddStroke(Object, Color)
    local Line = Instance.new("UIStroke")
    Line.Color = Color or Config.Border
    Line.Thickness = 1
    Line.Parent = Object
end

local function Animate(Object, Properties)
    TweenService:Create(
        Object,
        TweenInfo.new(
            0.15,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out
        ),
        Properties
    ):Play()
end

--========================================================
-- SCREEN GUI
--========================================================

local Screen = Create("ScreenGui", {
    Name = "FlingControlV22",
    ResetOnSpawn = false,
    IgnoreGuiInset = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

--========================================================
-- RESPONSIVE SIZE
--========================================================

local Camera = workspace.CurrentCamera
local Viewport = Camera and Camera.ViewportSize or Vector2.new(800, 600)

local WindowWidth = math.clamp(Viewport.X - 24, 280, 420)
local WindowHeight = math.clamp(Viewport.Y - 70, 280, 440)

--========================================================
-- MAIN WINDOW
--========================================================

local Main = Create("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(WindowWidth, WindowHeight),
    Position = UDim2.new(0.5, -WindowWidth / 2, 0.5, -WindowHeight / 2),
    BackgroundColor3 = Config.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, Screen)

Round(Main, 12)
AddStroke(Main, Config.Border)

--========================================================
-- TOP BAR
--========================================================

local Top = Create("Frame", {
    Name = "Top",
    Size = UDim2.new(1, 0, 0, 42),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0,
    Active = true
}, Main)

local Logo = Create("TextLabel", {
    Position = UDim2.fromOffset(12, 0),
    Size = UDim2.new(1, -105, 1, 0),
    BackgroundTransparency = 1,
    Text = "FLING CONTROL",
    TextColor3 = Config.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left
}, Top)

local Version = Create("TextLabel", {
    Position = UDim2.new(1, -108, 0, 0),
    Size = UDim2.fromOffset(32, 42),
    BackgroundTransparency = 1,
    Text = "2.2",
    TextColor3 = Config.Accent,
    Font = Enum.Font.GothamBold,
    TextSize = 10
}, Top)

local Minimize = Create("TextButton", {
    Position = UDim2.new(1, -69, 0, 7),
    Size = UDim2.fromOffset(27, 27),
    BackgroundColor3 = Config.Card,
    Text = "−",
    TextColor3 = Config.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 17,
    AutoButtonColor = false
}, Top)

Round(Minimize, 7)

local Close = Create("TextButton", {
    Position = UDim2.new(1, -36, 0, 7),
    Size = UDim2.fromOffset(27, 27),
    BackgroundColor3 = Config.Red,
    Text = "×",
    TextColor3 = Config.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 17,
    AutoButtonColor = false
}, Top)

Round(Close, 7)

--========================================================
-- BODY
--========================================================

local Body = Create("Frame", {
    Position = UDim2.fromOffset(0, 42),
    Size = UDim2.new(1, 0, 1, -42),
    BackgroundTransparency = 1
}, Main)

--========================================================
-- SIDEBAR
--========================================================

local SidebarWidth = math.clamp(
    math.floor(WindowWidth * 0.30),
    82,
    120
)

local Sidebar = Create("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, SidebarWidth, 1, 0),
    BackgroundColor3 = Config.Sidebar,
    BorderSizePixel = 0
}, Body)

local TabList = Create("ScrollingFrame", {
    Position = UDim2.fromOffset(7, 10),
    Size = UDim2.new(1, -14, 1, -20),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollBarThickness = 2
}, Sidebar)

local TabLayout = Create("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder
}, TabList)

--========================================================
-- CONTENT
--========================================================

local Content = Create("Frame", {
    Position = UDim2.new(0, SidebarWidth, 0, 0),
    Size = UDim2.new(1, -SidebarWidth, 1, 0),
    BackgroundColor3 = Config.Background,
    BorderSizePixel = 0
}, Body)

local PageTitle = Create("TextLabel", {
    Position = UDim2.fromOffset(12, 9),
    Size = UDim2.new(1, -24, 0, 24),
    BackgroundTransparency = 1,
    Text = "FLING",
    TextColor3 = Config.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
}, Content)

local Search = Create("TextBox", {
    Position = UDim2.fromOffset(10, 39),
    Size = UDim2.new(1, -20, 0, 31),
    BackgroundColor3 = Config.Card,
    Text = "",
    PlaceholderText = T("Search"),
    PlaceholderColor3 = Config.Muted,
    TextColor3 = Config.Text,
    Font = Enum.Font.Gotham,
    TextSize = 10,
    ClearTextOnFocus = false
}, Content)

Round(Search, 7)
AddStroke(Search, Config.Border)

local Page = Create("ScrollingFrame", {
    Name = "Page",
    Position = UDim2.fromOffset(10, 80),
    Size = UDim2.new(1, -20, 1, -91),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = Config.Accent,
    ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
}, Content)

local PageLayout = Create("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Page)

Create("UIPadding", {
    PaddingBottom = UDim.new(0, 10)
}, Page)

--========================================================
-- CARD
--========================================================

local function CreateCard(Key)
    local Card = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 49),
        BackgroundColor3 = Config.Card,
        BorderSizePixel = 0
    }, Page)

    Round(Card, 8)
    AddStroke(Card, Config.Border)

    Create("TextLabel", {
        Position = UDim2.fromOffset(9, 0),
        Size = UDim2.new(1, -75, 1, 0),
        BackgroundTransparency = 1,
        Text = T(Key),
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Button = Create("TextButton", {
        Position = UDim2.new(1, -61, 0.5, -12),
        Size = UDim2.fromOffset(52, 24),
        BackgroundColor3 =
            State.Toggles[Key] and Config.Green or Config.Panel,
        Text =
            State.Toggles[Key] and T("Enabled") or T("Disabled"),
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 8,
        AutoButtonColor = false
    }, Card)

    Round(Button, 6)

    Button.Activated:Connect(function()
        State.Toggles[Key] = not State.Toggles[Key]

        Button.Text =
            State.Toggles[Key] and T("Enabled") or T("Disabled")

        Animate(Button, {
            BackgroundColor3 =
                State.Toggles[Key] and Config.Green or Config.Panel
        })
    end)
end

--========================================================
-- STRENGTH SLIDER
--========================================================

local function CreateStrength()
    local Card = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 72),
        BackgroundColor3 = Config.Card,
        BorderSizePixel = 0
    }, Page)

    Round(Card, 8)
    AddStroke(Card, Config.Border)

    Create("TextLabel", {
        Position = UDim2.fromOffset(10, 5),
        Size = UDim2.new(1, -65, 0, 22),
        BackgroundTransparency = 1,
        Text = T("Strength"),
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Value = Create("TextLabel", {
        Position = UDim2.new(1, -52, 0, 5),
        Size = UDim2.fromOffset(42, 22),
        BackgroundTransparency = 1,
        Text = tostring(State.Strength),
        TextColor3 = Config.Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 10
    }, Card)

    local Bar = Create("Frame", {
        Position = UDim2.fromOffset(10, 43),
        Size = UDim2.new(1, -20, 0, 8),
        BackgroundColor3 = Config.Panel,
        BorderSizePixel = 0
    }, Card)

    Round(Bar, 4)

    local Fill = Create("Frame", {
        Size = UDim2.new(State.Strength / 2000, 0, 1, 0),
        BackgroundColor3 = Config.Accent,
        BorderSizePixel = 0
    }, Bar)

    Round(Fill, 4)

    local Active = false

    local function Update(X)
        local Width = math.max(1, Bar.AbsoluteSize.X)
        local Percent = math.clamp(
            (X - Bar.AbsolutePosition.X) / Width,
            0,
            1
        )

        State.Strength = math.floor(Percent * 2000)
        Value.Text = tostring(State.Strength)

        Fill.Size = UDim2.new(Percent, 0, 1, 0)
    end

    Bar.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1
            or Input.UserInputType == Enum.UserInputType.Touch then

            Active = true
            Update(Input.Position.X)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if Active and (
            Input.UserInputType == Enum.UserInputType.MouseMovement
            or Input.UserInputType == Enum.UserInputType.Touch
        ) then
            Update(Input.Position.X)
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
        Size = UDim2.new(1, 0, 0, 65),
        BackgroundColor3 = Config.Card,
        BorderSizePixel = 0
    }, Page)

    Round(Card, 8)
    AddStroke(Card, Config.Border)

    Create("TextLabel", {
        Position = UDim2.fromOffset(9, 3),
        Size = UDim2.new(1, -18, 0, 22),
        BackgroundTransparency = 1,
        Text = T("SelectLanguage"),
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local function AddLanguage(Name, X, Code)
        local Button = Create("TextButton", {
            Position = UDim2.fromOffset(X, 31),
            Size = UDim2.fromOffset(83, 25),
            BackgroundColor3 =
                State.Language == Code and Config.Accent or Config.Panel,
            Text = Name,
            TextColor3 = Config.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 9,
            AutoButtonColor = false
        }, Card)

        Round(Button, 6)

        Button.Activated:Connect(function()
            State.Language = Code
            RefreshPage()
        end)
    end

    AddLanguage("English", 9, "EN")
    AddLanguage("Русский", 100, "RU")
end

--========================================================
-- RESET
--========================================================

local function CreateReset()
    local Card = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 49),
        BackgroundColor3 = Config.Card,
        BorderSizePixel = 0
    }, Page)

    Round(Card, 8)
    AddStroke(Card, Config.Border)

    Create("TextLabel", {
        Position = UDim2.fromOffset(9, 0),
        Size = UDim2.new(1, -75, 1, 0),
        BackgroundTransparency = 1,
        Text = T("ResetSettings"),
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Button = Create("TextButton", {
        Position = UDim2.new(1, -61, 0.5, -12),
        Size = UDim2.fromOffset(52, 24),
        BackgroundColor3 = Config.Red,
        Text = "RESET",
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 8
    }, Card)

    Round(Button, 6)

    Button.Activated:Connect(function()
        State.Strength = 100

        for Key in pairs(State.Toggles) do
            State.Toggles[Key] = false
        end

        RefreshPage()
    end)
end

--========================================================
-- REFRESH PAGE
--========================================================

function RefreshPage()
    for _, Child in ipairs(Page:GetChildren()) do
        if Child:IsA("GuiObject")
            and Child ~= PageLayout then
            Child:Destroy()
        end
    end

    PageTitle.Text = T(State.CurrentTab)
    Search.PlaceholderText = T("Search")

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

    if State.CurrentTab == "FLING" and Matches("Strength") then
        CreateStrength()
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
-- TABS
--========================================================

local TabNames = {
    "FLING",
    "ANTI",
    "FUN",
    "SETTINGS"
}

local Tabs = {}

for Index, Name in ipairs(TabNames) do
    local Button = Create("TextButton", {
        Name = Name .. "Tab",
        Size = UDim2.new(1, 0, 0, 37),
        BackgroundColor3 =
            State.CurrentTab == Name and Config.AccentDark or Config.Card,
        Text = T(Name),
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 9,
        AutoButtonColor = false,
        LayoutOrder = Index
    }, TabList)

    Round(Button, 7)
    Tabs[Name] = Button

    Button.Activated:Connect(function()
        State.CurrentTab = Name

        for TabName, TabButton in pairs(Tabs) do
            TabButton.BackgroundColor3 =
                TabName == Name and Config.AccentDark or Config.Card

            TabButton.Text = T(TabName)
        end

        RefreshPage()
    end)
end

--========================================================
-- SEARCH
--========================================================

Search:GetPropertyChangedSignal("Text"):Connect(function()
    State.Search = Search.Text
    RefreshPage()
end)

--=============================
