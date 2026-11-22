
--[[
    ARKON HUB V2.4 - BLITZ EDITION
    Demonstration interface only.
    No player kicking, teleporting, or gameplay manipulation.
    Place this LocalScript in your own Roblox experience.
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local OldGui = PlayerGui:FindFirstChild("ARKON_HUB_V24")
if OldGui then
    OldGui:Destroy()
end

--==================================================
-- CONFIGURATION
--==================================================

local Theme = {
    Background = Color3.fromRGB(12, 15, 22),
    Sidebar = Color3.fromRGB(17, 21, 30),
    Panel = Color3.fromRGB(21, 26, 37),
    Card = Color3.fromRGB(27, 33, 46),
    CardHover = Color3.fromRGB(35, 43, 59),
    Accent = Color3.fromRGB(54, 133, 255),
    AccentDark = Color3.fromRGB(31, 83, 165),
    Text = Color3.fromRGB(239, 243, 250),
    Muted = Color3.fromRGB(145, 157, 178),
    Border = Color3.fromRGB(45, 54, 71),
    Green = Color3.fromRGB(64, 190, 125),
    Red = Color3.fromRGB(225, 75, 85),
    Gold = Color3.fromRGB(235, 180, 65)
}

local State = {
    Tab = "FLING",
    Language = "EN",
    Strength = 1000,
    Minimized = false,
    Premium = false,
    Target = "",
    Toggles = {},
    Notifications = true,
    DarkMode = true,
    Scale = 1
}

local TabNames = {
    "FLING",
    "ANTI",
    "FUN",
    "BLOBMAN",
    "SETTINGS"
}

local Translations = {
    RU = {
        FLING = "БРОСОК",
        ANTI = "ЗАЩИТА",
        FUN = "РАЗВЛЕЧЕНИЯ",
        BLOBMAN = "БЛОБМЕН",
        SETTINGS = "НАСТРОЙКИ",
        Search = "Поиск функций...",
        Description = "Демонстрационные настройки",
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
        InterfaceScale = "Масштаб интерфейса",
        Reset = "Сброс настроек",
        Target = "ЦЕЛЕВОЙ ИГРОК",
        TargetPlaceholder = "Введите имя игрока...",
        SelectPlayer = "ВЫБРАТЬ ИГРОКА",
        Kick = "Кик",
        Bring = "Привести",
        PremiumRequired = "ТРЕБУЕТСЯ PREMIUM",
        DemoOnly = "Демонстрационная функция",
        NoPlayers = "Нет других игроков на сервере",
        Free = "БЕСПЛАТНО",
        Premium = "PREMIUM",
        Open = "ОТКРЫТЬ",
        ResetDone = "Настройки сброшены",
        SelectTarget = "Сначала выберите игрока",
        DemoMessage = "Это демонстрационная кнопка"
    },

    EN = {
        FLING = "FLING",
        ANTI = "ANTI",
        FUN = "FUN",
        BLOBMAN = "BLOBMAN",
        SETTINGS = "SETTINGS",
        Search = "Search features...",
        Description = "Demonstration controls and settings",
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
        Reset = "Reset Settings",
        Target = "TARGET PLAYER",
        TargetPlaceholder = "Enter player name...",
        SelectPlayer = "SELECT PLAYER",
        Kick = "Kick",
        Bring = "Bring",
        PremiumRequired = "PREMIUM REQUIRED",
        DemoOnly = "Demonstration feature",
        NoPlayers = "No other players in this server",
        Free = "FREE",
        Premium = "PREMIUM",
        Open = "OPEN",
        ResetDone = "Settings have been reset",
        SelectTarget = "Select a player first",
        DemoMessage = "This is a demonstration button"
    }
}

local function T(key)
    return Translations[State.Language][key] or key
end

--==================================================
-- UI HELPERS
--==================================================

local function Create(className, properties, parent)
    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        object[property] = value
    end

    object.Parent = parent
    return object
end

local function Corner(parent, radius)
    Create("UICorner", {
        CornerRadius = UDim.new(0, radius or 9)
    }, parent)
end

local function Outline(parent, color, transparency)
    Create("UIStroke", {
        Color = color or Theme.Border,
        Transparency = transparency or 0,
        Thickness = 1
    }, parent)
end

local function Label(parent, text, size, color, font)
    return Create("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        TextSize = size or 13,
        TextColor3 = color or Theme.Text,
        Font = font or Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    }, parent)
end

local function Button(parent, text, color, size)
    return Create("TextButton", {
        Text = text,
        TextSize = 12,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        BackgroundColor3 = color or Theme.Card,
        BorderSizePixel = 0,
        Size = size or UDim2.fromOffset(100, 34),
        AutoButtonColor = true
    }, parent)
end

--==================================================
-- SCREEN GUI
--==================================================

local Screen = Create("ScreenGui", {
    Name = "ARKON_HUB_V24",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

local Main = Create("Frame", {
    Name = "MainWindow",
    BackgroundColor3 = Theme.Background,
    BorderSizePixel = 0,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(720, 450),
    ClipsDescendants = true
}, Screen)

Corner(Main, 13)
Outline(Main, Theme.Border)

local UIScale = Create("UIScale", {
    Scale = 1
}, Main)

--==================================================
-- TOP BAR
--==================================================

local Top = Create("Frame", {
    Name = "TopBar",
    BackgroundColor3 = Theme.Sidebar,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 48)
}, Main)

local Logo = Label(Top, "A", 25, Theme.Accent, Enum.Font.GothamBlack)
Logo.Position = UDim2.fromOffset(16, 0)
Logo.Size = UDim2.fromOffset(30, 48)

local Title = Label(Top, "ARKON", 17, Theme.Text, Enum.Font.GothamBlack)
Title.Position = UDim2.fromOffset(51, 0)
Title.Size = UDim2.fromOffset(90, 48)

local HubText = Label(Top, "HUB", 13, Theme.Accent, Enum.Font.GothamBold)
HubText.Position = UDim2.fromOffset(112, 1)
HubText.Size = UDim2.fromOffset(45, 48)

local Version = Label(
    Top,
    "V2.4  •  BLITZ EDITION",
    10,
    Theme.Muted
)
Version.Position = UDim2.fromOffset(175, 0)
Version.Size = UDim2.fromOffset(180, 48)

local Minimize = Button(
    Top,
    "−",
    Theme.Card,
    UDim2.fromOffset(38, 34)
)
Minimize.TextSize = 23
Minimize.Position = UDim2.new(1, -91, 0, 7)
Corner(Minimize, 8)

local Close = Button(
    Top,
    "×",
    Theme.Card,
    UDim2.fromOffset(38, 34)
)
Close.TextSize = 23
Close.Position = UDim2.new(1, -47, 0, 7)
Corner(Close, 8)

--==================================================
-- MAIN BODY
--==================================================

local Body = Create("Frame", {
    Name = "Body",
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(0, 48),
    Size = UDim2.new(1, 0, 1, -48)
}, Main)

local Sidebar = Create("Frame", {
    Name = "Sidebar",
    BackgroundColor3 = Theme.Sidebar,
    BorderSizePixel = 0,
    Size = UDim2.new(0, 145, 1, 0)
}, Body)

local MenuLabel = Label(
    Sidebar,
    "NAVIGATION",
    10,
    Theme.Muted,
    Enum.Font.GothamBold
)
MenuLabel.Position = UDim2.fromOffset(15, 14)
MenuLabel.Size = UDim2.new(1, -25, 0, 24)

local TabHolder = Create("Frame", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(9, 47),
    Size = UDim2.new(1, -18, 1, -55)
}, Sidebar)

Create("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
}, TabHolder)

local Content = Create("Frame", {
    Name = "Content",
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(145, 0),
    Size = UDim2.new(1, -145, 1, 0)
}, Body)

local Search = Create("TextBox", {
    Name = "SearchBox",
    PlaceholderText = T("Search"),
    Text = "",
    ClearTextOnFocus = false,
    TextColor3 = Theme.Text,
    PlaceholderColor3 = Theme.Muted,
    TextSize = 13,
    Font = Enum.Font.Gotham,
    BackgroundColor3 = Theme.Card,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(17, 13),
    Size = UDim2.new(1, -34, 0, 37)
}, Content)

Corner(Search, 8)
Outline(Search)

local PageTitle = Label(
    Content,
    "FLING",
    19,
    Theme.Text,
    Enum.Font.GothamBold
)
PageTitle.Position = UDim2.fromOffset(19, 58)
PageTitle.Size = UDim2.new(1, -35, 0, 28)

local Subtitle = Label(
    Content,
    T("Description"),
    11,
    Theme.Muted
)
Subtitle.Position = UDim2.fromOffset(20, 86)
Subtitle.Size = UDim2.new(1, -35, 0, 20)

local Scroll = Create("ScrollingFrame", {
    Name = "PageContent",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(17, 115),
    Size = UDim2.new(1, -34, 1, -125),
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = Theme.Accent
}, Content)

local PageLayout = Create("UIListLayout", {
    Padding = UDim.new(0, 9),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Scroll)

local PagePadding = Create("UIPadding", {
    PaddingBottom = UDim.new(0, 8)
}, Scroll)

--==================================================
-- NOTIFICATION
--==================================================

local Notification = Create("TextLabel", {
    Name = "Notification",
    Text = "",
    TextSize = 12,
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    BackgroundColor3 = Theme.Panel,
    BorderSizePixel = 0,
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, -55),
    Size = UDim2.fromOffset(290, 40),
    Visible = false,
    ZIndex = 20
}, Screen)

Corner(Notification, 9)
Outline(Notification, Theme.Accent)

local notificationToken = 0

local function Notify(message)
    if not State.Notifications then
        return
    end

    notificationToken += 1
    local token = notificationToken

    Notification.Text = message
    Notification.Visible = true

    TweenService:Create(
        Notification,
        TweenInfo.new(0.2),
        {Position = UDim2.new(0.5, 0, 0, 15)}
    ):Play()

    task.delay(2, function()
        if token ~= notificationToken then
            return
        end

        local tween = TweenService:Create(
            Notification,
            TweenInfo.new(0.2),
            {Position = UDim2.new(0.5, 0, 0, -55)}
        )

        tween:Play()
        tween.Completed:Wait()

        if token == notificationToken then
            Notification.Visible = false
        end
    end)
end

--==================================================
-- CARD HELPERS
--==================================================

local function ClearPage()
    for _, child in ipairs(Scroll:GetChildren()) do
        if child:IsA("GuiObject")
            and child ~= PageLayout
            and child ~= PagePadding then
            child:Destroy()
        end
    end
end

local function CreateCard(name, description, height)
    local Card = Create("Frame", {
        Name = name,
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, height or 64)
    }, Scroll)

    Corner(Card, 9)
    Outline(Card)

    local NameLabel = Label(
        Card,
        name,
        13,
        Theme.Text,
        Enum.Font.GothamBold
    )

    NameLabel.Position = UDim2.fromOffset(14, 7)
    NameLabel.Size = UDim2.new(1, -125, 0, 23)

    local Description = Label(
        Card,
        description or T("DemoOnly"),
        10,
        Theme.Muted
    )

    Description.Position = UDim2.fromOffset(14, 31)
    Description.Size = UDim2.new(1, -125, 0, 20)

    return Card
end

--==================================================
-- TOGGLE CARDS
--==================================================

local function CreateToggle(name, description, key)
    local Card = CreateCard(name, description)

    local Toggle = Button(
        Card,
        "",
        Theme.Border,
        UDim2.fromOffset(45, 24)
    )

    Toggle.Position = UDim2.new(1, -60, 0.5, -12)
    Toggle.AutoButtonColor = false
    Corner(Toggle, 20)

    local Dot = Create("Frame", {
        BackgroundColor3 = Theme.Text,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(3, 3),
        Size = UDim2.fromOffset(18, 18)
    }, Toggle)

    Corner(Dot, 20)

    local function Update()
        local enabled = State.Toggles[key] == true

        TweenService:Create(
            Toggle,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 =
                    enabled and Theme.Accent or Theme.Border
            }
        ):Play()

        TweenService:Create(
            Dot,
            TweenInfo.new(0.15),
            {
                Position = UDim2.fromOffset(
                    enabled and 24 or 3,
                    3
                )
            }
        ):Play()
    end

    Toggle.Activated:Connect(function()
        State.Toggles[key] = not State.Toggles[key]
        Update()
    end)

    Update()
end

--==================================================
-- STRENGTH DEMO SLIDER
--==================================================

local function CreateStrength()
    local Card = CreateCard(
        T("Strength"),
        "Visual demo slider • Maximum 2000",
        92
    )

    local Value = Label(
        Card,
        tostring(State.Strength),
        12,
        Theme.Accent,
        Enum.Font.GothamBold
    )

    Value.TextXAlignment = Enum.TextXAlignment.Right
    Value.Position = UDim2.new(1, -75, 0, 8)
    Value.Size = UDim2.fromOffset(60, 20)

    local Track = Create("Frame", {
        BackgroundColor3 = Theme.Border,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(14, 62),
        Size = UDim2.new(1, -28, 0, 7)
    }, Card)

    Corner(Track, 8)

    local Fill = Create("Frame", {
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new(State.Strength / 2000, 0, 1, 0)
    }, Track)

    Corner(Fill, 8)

    local draggingSlider = false

    local function UpdateValue(x)
        local width = math.max(1, Track.AbsoluteSize.X)
        local ratio = math.clamp(
            (x - Track.AbsolutePosition.X) / width,
            0,
            1
        )

        State.Strength = math.floor(ratio * 2000)
        Value.Text = tostring(State.Strength)
        Fill.Size = UDim2.new(ratio, 0, 1, 0)
    end

    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            draggingSlider = true
            UpdateValue(input.Position.X)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if draggingSlider then
            if input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch then

                UpdateValue(input.Position.X)
            end
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            draggingSlider = false
        end
    end)
end

--==================================================
-- LANGUAGE CARD
--==================================================

local RefreshPage

local function CreateLanguageCard()
    local Card = CreateCard(
        T("Language"),
        "English / Русский"
    )

    local Switch = Button(
        Card,
        State.Language,
        Theme.AccentDark,
        UDim2.fromOffset(55, 27)
    )

    Switch.Position = UDim2.new(1, -68, 0.5, -13)
    Corner(Switch, 7)

    Switch.Activated:Connect(function()
        State.Language = State.Language == "EN" and "RU" or "EN"
        Switch.Text = State.Language

        Search.PlaceholderText = T("Search")
        RefreshPage()
    end)
end

--==================================================
-- PLAYER TARGET CARD
--==================================================

local function CreateTargetCard()
    local Card = CreateCard(
        T("Target"),
        "Choose a player from this server",
        112
    )

    local TargetBox = Create("TextBox", {
        Name = "TargetInput",
        Text = State.Target,
        PlaceholderText = T("TargetPlaceholder"),
        ClearTextOnFocus = false,
        TextColor3 = Theme.Text,
        PlaceholderColor3 = Theme.Muted,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(13, 39),
        Size = UDim2.new(1, -26, 0, 29)
    }, Card)

    Corner(TargetBox, 7)
    Outline(TargetBox)

    TargetBox:GetPropertyChangedSignal("Text"):Connect(function()
        State.Target = TargetBox.Text
    end)

    local PlayerList = Create("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(13, 75),
        Size = UDim2.new(1, -26, 0, 27)
    }, Card)

    local PlayerLayout = Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, PlayerList)

    local function RefreshPlayers()
        for _, child in ipairs(PlayerList:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end

        local count = 0

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and count < 4 then
                count += 1

                local PlayerButton = Button(
                    PlayerList,
                    player.Name,
                    Theme.AccentDark,
                    UDim2.fromOffset(105, 26)
                )

                PlayerButton.TextSize = 9
                Corner(PlayerButton, 6)

                PlayerButton.Activated:Connect(function()
                    State.Target = player.Name
                    TargetBox.Text = player.Name
                end)
            end
        end

        if count == 0 then
            local Empty = Label(
                PlayerList,
                T("NoPlayers"),
                9,
                Theme.Muted
            )
            Empty.Size = UDim2.new(1, 0, 1, 0)
        end
    end

    RefreshPlayers()

    Players.PlayerAdded:Connect(RefreshPlayers)
    Players.PlayerRemoving:Connect(RefreshPlayers)
end

--==================================================
-- PREMIUM LOCK CARD
--==================================================

local function CreatePremiumCard()
    local Card = CreateCa
