
-- ARKON HUB V5 | BLACK & BLUE
-- Visual demo interface only.
-- Does not fling, kick, grab or target real players.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local DEMO_KEY = "AR-DUZ4-VA58-DURY"

local OLD = PlayerGui:FindFirstChild("ARKON_HUB_V5")
if OLD then OLD:Destroy() end

local C = {
    BG = Color3.fromRGB(5, 5, 7),
    PANEL = Color3.fromRGB(12, 12, 15),
    BUTTON = Color3.fromRGB(18, 18, 22),
    BLUE = Color3.fromRGB(0, 145, 255),
    WHITE = Color3.fromRGB(240, 240, 245),
    GRAY = Color3.fromRGB(140, 140, 150),
    GREEN = Color3.fromRGB(60, 210, 130),
    RED = Color3.fromRGB(230, 75, 75)
}

local function New(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function Corner(obj, radius)
    New("UICorner", {
        CornerRadius = UDim.new(0, radius or 7)
    }, obj)
end

local function Outline(obj, color, thickness)
    return New("UIStroke", {
        Color = color or C.BLUE,
        Thickness = thickness or 1
    }, obj)
end

local function MakeLabel(parent, text, size, pos, dimensions)
    return New("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = C.WHITE,
        TextSize = size or 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Position = pos,
        Size = dimensions
    }, parent)
end

local Gui = New("ScreenGui", {
    Name = "ARKON_HUB_V5",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

local Main
local Body
local Header
local Minimize
local Close
local OpenHub

local function MakeWindow(width, height)
    Main = New("Frame", {
        Name = "Main",
        BackgroundColor3 = C.BG,
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(width, height),
        Position = UDim2.new(0.5, -width/2, 0.5, -height/2)
    }, Gui)
    Corner(Main, 9)
    Outline(Main, C.BLUE, 1.5)

    Header = New("Frame", {
        BackgroundColor3 = C.PANEL,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 43)
    }, Main)
    Corner(Header, 8)

    MakeLabel(Header, "ARKON HUB  |  V5", 16,
        UDim2.fromOffset(13, 0),
        UDim2.new(1, -100, 1, 0)).Font = Enum.Font.GothamBold

    Minimize = New("TextButton", {
        Text = "—",
        TextSize = 22,
        Font = Enum.Font.GothamBold,
        TextColor3 = C.BLUE,
        BackgroundColor3 = C.BUTTON,
        Size = UDim2.fromOffset(34, 29),
        Position = UDim2.new(1, -78, 0, 7)
    }, Header)
    Corner(Minimize, 5)

    Close = New("TextButton", {
        Text = "×",
        TextSize = 22,
        Font = Enum.Font.GothamBold,
        TextColor3 = C.WHITE,
        BackgroundColor3 = C.BUTTON,
        Size = UDim2.fromOffset(34, 29),
        Position = UDim2.new(1, -39, 0, 7)
    }, Header)
    Corner(Close, 5)

    -- Touch and mouse dragging
    local dragging = false
    local dragStart
    local startPosition
    local dragInput

    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPosition = Main.Position
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input == dragInput then
            dragging = false
            dragInput = nil
        end
    end)

    Close.MouseButton1Click:Connect(function()
        Gui:Destroy()
    end)
end

-- KEY SYSTEM
MakeWindow(370, 245)

local KeyPanel = New("Frame", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(18, 55),
    Size = UDim2.new(1, -36, 1, -65)
}, Main)

MakeLabel(KeyPanel, "KEY SYSTEM", 19,
    UDim2.fromOffset(0, 5),
    UDim2.new(1, 0, 0, 30)).Font = Enum.Font.GothamBold

local Description = MakeLabel(KeyPanel,
    "Enter your access key to continue.",
    12, UDim2.fromOffset(0, 40),
    UDim2.new(1, 0, 0, 25))
Description.TextColor3 = C.GRAY

local KeyInput = New("TextBox", {
    PlaceholderText = "AR-XXXX-XXXX-XXXX",
    Text = "",
    TextSize = 14,
    Font = Enum.Font.Gotham,
    TextColor3 = C.WHITE,
    PlaceholderColor3 = C.GRAY,
    BackgroundColor3 = C.BUTTON,
    ClearTextOnFocus = false,
    Position = UDim2.fromOffset(0, 78),
    Size = UDim2.new(1, 0, 0, 39)
}, KeyPanel)
Corner(KeyInput, 6)
Outline(KeyInput, C.BLUE, 1)

local KeyStatus = MakeLabel(KeyPanel, "Status: Waiting for key",
    12, UDim2.fromOffset(0, 124),
    UDim2.new(1, 0, 0, 25))
KeyStatus.TextColor3 = C.GRAY

local CheckKey = New("TextButton", {
    Text = "CHECK KEY",
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    TextColor3 = C.WHITE,
    BackgroundColor3 = C.BUTTON,
    Position = UDim2.fromOffset(0, 157),
    Size = UDim2.new(1, 0, 0, 36)
}, KeyPanel)
Corner(CheckKey, 6)
Outline(CheckKey, C.BLUE, 1)

-- MAIN HUB
OpenHub = function()
    Main:Destroy()
    MakeWindow(520, 430)

    Body = New("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 49),
        Size = UDim2.new(1, 0, 1, -55)
    }, Main)

    local Sidebar = New("Frame", {
        BackgroundColor3 = C.PANEL,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(8, 0),
        Size = UDim2.new(0, 135, 1, -8)
    }, Body)
    Corner(Sidebar, 7)

    local Content = New("Frame", {
        BackgroundColor3 = C.PANEL,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(151, 0),
        Size = UDim2.new(1, -159, 1, -8)
    }, Body)
    Corner(Content, 7)
    Outline(Content, Color3.fromRGB(40, 40, 45), 1)

    local PageTitle = MakeLabel(Content, "FLING", 17,
        UDim2.fromOffset(14, 9),
        UDim2.new(1, -25, 0, 30))
    PageTitle.Font = Enum.Font.GothamBold
    PageTitle.TextColor3 = C.BLUE

    local Page = New("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(12, 47),
        Size = UDim2.new(1, -24, 1, -55)
    }, Content)

    local function Info(text, y)
        local label = MakeLabel(Page, text, 12,
            UDim2.fromOffset(2, y),
            UDim2.new(1, -4, 0, 28))
        label.TextColor3 = C.GRAY
        return label
    end

    local function Button(text, y, callback)
        local b = New("TextButton", {
            Text = text,
            TextSize = 13,
            Font = Enum.Font.Gotham,
            TextColor3 = C.WHITE,
            BackgroundColor3 = C.BUTTON,
            BorderSizePixel = 0,
            Position = UDim2.fromOffset(0, y),
            Size = UDim2.new(1, 0, 0, 36),
            AutoButtonColor = false
        }, Page)
        Corner(b, 6)
        Outline(b, Color3.fromRGB(40, 40, 45), 1)

        b.MouseEnter:Connect(function()
            TweenService:Create(b, TweenInfo.new(0.12), {
                BackgroundColor3 = Color3.fromRGB(27, 27, 32)
            }):Play()
        end)

        b.MouseLeave:Connect(function()
            TweenService:Create(b, TweenInfo.new(0.12), {
                BackgroundColor3 = C.BUTTON
            }):Play()
        end)

        b.MouseButton1Click:Connect(callback)
        return b
    end

    local function Toggle(text, y)
        local enabled = false
        local b
        b = Button(text .. "  [OFF]", y, function()
            enabled = not enabled
            b.Text = text .. (enabled and "  [ON]" or "  [OFF]")
        end)
    end

    local function ClearPage()
        for _, child in ipairs(Page:GetChildren()) do
            child:Destroy()
        end
    end

    local function ShowTab(tab)
        ClearPage()
        PageTitle.Text = tab

        if tab == "FLING" then
            Info("Visual demonstration settings", 0)
            Toggle("Fling Demo", 36)
            Toggle("Super Strength Demo", 78)
            Toggle("Strength Indicator", 120)

        elseif tab == "ANTI" then
            Info("Local interface demonstration", 0)
            Toggle("Anti Grab Demo", 36)
            Toggle("Anti Ragdoll Demo", 78)
            Toggle("Anti Snowball Demo", 120)
            Toggle("Anti Explosion Demo", 162)
            Toggle("Anti Kick Demo", 204)

        elseif tab == "FUN" then
            Info("Cosmetic demo options", 0)
            Toggle("Wings", 36)
            Toggle("Dynamic Wings", 78)
            Toggle("Extra Wings", 120)
            Toggle("Mech Suit", 162)

        elseif tab == "BLOBMAN" then
            Info("Test character name:", 0)

            local NameInput = New("TextBox", {
                PlaceholderText = "Enter test dummy name...",
                Text = "",
                TextSize = 13,
                Font = Enum.Font.Gotham,
                TextColor3 = C.WHITE,
                PlaceholderColor3 = C.GRAY,
                BackgroundColor3 = C.BUTTON,
                ClearTextOnFocus = false,
                Position = UDim2.fromOffset(0, 32),
                Size = UDim2.new(1, 0, 0, 37)
            }, Page)
            Corner(NameInput, 6)
            Outline(NameInput, C.BLUE, 1)

            local Status = Info("Status: No test character selected", 76)

            Button("SELECT TEST DUMMY", 108, function()
                if NameInput.Text:gsub("%s", "") == "" then
                    Status.Text = "Enter a test dummy name first"
                else
                    Status.Text = "Demo selected: " .. NameInput.Text
                end
            end)

            Button("DEMO GRAB", 150, function()
                Status.Text = "Demo grab activated"
            end)

            Button("DEMO RELEASE", 192, function()
                Status.Text = "Demo released"
            end)

            Button("DEMO KICK", 234, function()
                Status.Text = "Visual kick demo only"
            end)

        elseif tab == "KICK" then
            Info("Visual-only kick interface demo", 0)
            local Status = Info("Status: IDLE", 38)

            Button("ENABLE DEMO", 76, function()
                Status.Text = "Status: ACTIVE (DEMO)"
            end)

            Button("STOP DEMO", 118, function()
                Status.Text = "Status: STOPPED"
            end)

        elseif tab == "SETTINGS" then
            Info("ARKON HUB V5", 0)
            Info("Theme: Black / Blue outline", 32)
            Info("Mode: Visual Demo", 64)

            Button("RESET WINDOW POSITION", 104, function()
                Main.Position = UDim2.new(0.5, -260, 0.5, -215)
            end)
        end
    end

    local tabs = {"FLING", "ANTI", "FUN", "BLOBMAN", "KICK", "SETTINGS"}

    for i, tab in ipairs(tabs) do
        local b = New("TextButton", {
            Text = tab,
            TextSize = 12,
            Font = Enum.Font.GothamBold,
            TextColor3 = C.WHITE,
            BackgroundColor3 = C.BUTTON,
            BorderSizePixel = 0,
            Position = UDim2.fromOffset(7, 9 + (i - 1) * 43),
            Size = UDim2.new(1, -14, 0, 35)
        }, Sidebar)
        Corner(b, 5)
        Outline(b, Color3.fromRGB(40, 40, 45), 1)

        b.MouseButton1Click:Connect(function()
            ShowTab(tab)
        end)
    end

    ShowTab("FLING")

    -- MINIMIZE THE WHOLE BODY, NOT JUST ITS BACKGROUND
    local minimized = false
    local fullSize = Main.Size

    Minimize.MouseButton1Click:Connect(function()
        minimized = not minimized
        Body.Visible = not minimized
        Main.Size = minimized
            and UDim2.fromOffset(520, 43)
            or fullSize
        Minimize.Text = minimized and "+" or "—"
    end)

    print("ARKON HUB V5 loaded!")
end

CheckKey.MouseButton1Click:Connect(function()
    if KeyInput.Text == DEMO_KEY then
        KeyStatus.Text = "Key accepted! Opening hub..."
        KeyStatus.TextColor3 = C.GREEN

        task.wait(0.4)
        OpenHub()
    else
        KeyStatus.Text = "Key is invalid!"
        KeyStatus.TextColor3 = C.RED
    end
end)

print("ARKON HUB V5 Key System loaded!")
