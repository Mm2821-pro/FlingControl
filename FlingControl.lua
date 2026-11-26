
-- ARKON HUB V4 | BLACK & BLUE DEMO
-- Visual-only interface. No actions against real players.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local OLD = PlayerGui:FindFirstChild("ARKON_HUB_V4")
if OLD then OLD:Destroy() end

local Theme = {
    Background = Color3.fromRGB(5, 5, 7),
    Panel = Color3.fromRGB(10, 10, 12),
    Button = Color3.fromRGB(15, 15, 18),
    Blue = Color3.fromRGB(0, 145, 255),
    White = Color3.fromRGB(240, 240, 245),
    Gray = Color3.fromRGB(135, 135, 145),
    Green = Color3.fromRGB(50, 210, 120)
}

local function New(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function Corner(parent, radius)
    New("UICorner", {
        CornerRadius = UDim.new(0, radius or 8)
    }, parent)
end

local function Stroke(parent, color, thickness)
    return New("UIStroke", {
        Color = color or Theme.Blue,
        Thickness = thickness or 1
    }, parent)
end

local function Label(parent, text, size, position, dimensions)
    return New("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Theme.White,
        TextSize = size or 14,
        Font = Enum.Font.Gotham,
        Position = position,
        Size = dimensions,
        TextXAlignment = Enum.TextXAlignment.Left
    }, parent)
end

local Gui = New("ScreenGui", {
    Name = "ARKON_HUB_V4",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

local Main = New("Frame", {
    Name = "Main",
    BackgroundColor3 = Theme.Background,
    BorderSizePixel = 0,
    Size = UDim2.fromOffset(520, 430),
    Position = UDim2.new(0.5, -260, 0.5, -215)
}, Gui)

Corner(Main, 10)
Stroke(Main, Theme.Blue, 1.5)

local Scale = New("UIScale", {
    Scale = 1
}, Main)

local function UpdateScale()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local viewport = camera.ViewportSize
    Scale.Scale = math.min(1, viewport.X / 540, viewport.Y / 460)
end

UpdateScale()
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(UpdateScale)
if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)
end

-- HEADER
local Header = New("Frame", {
    BackgroundColor3 = Theme.Panel,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 43)
}, Main)
Corner(Header, 9)

local Title = Label(Header, "ARKON HUB  |  V4", 16,
    UDim2.fromOffset(14, 0), UDim2.new(1, -110, 1, 0))
Title.Font = Enum.Font.GothamBold

local Minimize = New("TextButton", {
    Text = "—",
    TextSize = 22,
    Font = Enum.Font.GothamBold,
    TextColor3 = Theme.Blue,
    BackgroundColor3 = Theme.Button,
    Size = UDim2.fromOffset(34, 29),
    Position = UDim2.new(1, -78, 0, 7)
}, Header)
Corner(Minimize, 6)

local Close = New("TextButton", {
    Text = "×",
    TextSize = 22,
    Font = Enum.Font.GothamBold,
    TextColor3 = Theme.White,
    BackgroundColor3 = Theme.Button,
    Size = UDim2.fromOffset(34, 29),
    Position = UDim2.new(1, -39, 0, 7)
}, Header)
Corner(Close, 6)

-- DRAG
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

-- MINIMIZE / CLOSE
local minimized = false
local oldSize = Main.Size

Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    Main.Size = minimized and UDim2.fromOffset(520, 43) or oldSize
    Minimize.Text = minimized and "+" or "—"
end)

Close.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

-- BODY
local Body = New("Frame", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(0, 49),
    Size = UDim2.new(1, 0, 1, -55)
}, Main)

local Sidebar = New("Frame", {
    BackgroundColor3 = Theme.Panel,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(8, 0),
    Size = UDim2.new(0, 135, 1, -8)
}, Body)
Corner(Sidebar, 8)

local Content = New("Frame", {
    BackgroundColor3 = Theme.Panel,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(151, 0),
    Size = UDim2.new(1, -159, 1, -8)
}, Body)
Corner(Content, 8)
Stroke(Content, Color3.fromRGB(35, 35, 40), 1)

local PageTitle = Label(Content, "FLING", 17,
    UDim2.fromOffset(14, 10), UDim2.new(1, -28, 0, 30))
PageTitle.Font = Enum.Font.GothamBold
PageTitle.TextColor3 = Theme.Blue

local PageContent = New("Frame", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(12, 48),
    Size = UDim2.new(1, -24, 1, -58)
}, Content)

local function MakeButton(parent, text, callback, y)
    local button = New("TextButton", {
        Text = text,
        TextSize = 13,
        Font = Enum.Font.Gotham,
        TextColor3 = Theme.White,
        BackgroundColor3 = Theme.Button,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, y),
        Size = UDim2.new(1, 0, 0, 36),
        AutoButtonColor = false
    }, parent)

    Corner(button, 6)
    Stroke(button, Color3.fromRGB(35, 35, 42), 1)

    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.12), {
            BackgroundColor3 = Color3.fromRGB(24, 24, 29)
        }):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.12), {
            BackgroundColor3 = Theme.Button
        }):Play()
    end)

    button.MouseButton1Click:Connect(callback)
    return button
end

local function MakeToggle(parent, name, y)
    local enabled = false
    local button

    button = MakeButton(parent, name .. "  [OFF]", function()
        enabled = not enabled
        button.Text = name .. (enabled and "  [ON]" or "  [OFF]")
    end, y)

    return button
end

local function ClearPage()
    for _, child in ipairs(PageContent:GetChildren()) do
        child:Destroy()
    end
end

local function AddInfo(text, y)
    local label = Label(PageContent, text, 13,
        UDim2.fromOffset(2, y), UDim2.new(1, -4, 0, 30))
    label.TextColor3 = Theme.Gray
    return label
end

local function ShowTab(tab)
    ClearPage()
    PageTitle.Text = tab

    if tab == "FLING" then
        AddInfo("Visual demonstration settings", 0)
        MakeToggle(PageContent, "Fling Demo", 38)
        MakeToggle(PageContent, "Super Strength Demo", 82)
        MakeToggle(PageContent, "Show Strength Indicator", 126)

    elseif tab == "ANTI" then
        AddInfo("Local interface demonstration", 0)
        MakeToggle(PageContent, "Anti Grab Demo", 38)
        MakeToggle(PageContent, "Anti Ragdoll Demo", 82)
        MakeToggle(PageContent, "Anti Snowball Demo", 126)
        MakeToggle(PageContent, "Anti Explosion Demo", 170)
        MakeToggle(PageContent, "Anti Kick Demo", 214)

    elseif tab == "FUN" then
        AddInfo("Cosmetic demo options", 0)
        MakeToggle(PageContent, "Wings", 38)
        MakeToggle(PageContent, "Dynamic Wings", 82)
        MakeToggle(PageContent, "Extra Wings", 126)
        MakeToggle(PageContent, "Mech Suit", 170)

    elseif tab == "BLOBMAN" then
        AddInfo("Test character name:", 0)

        local NameInput = New("TextBox", {
            PlaceholderText = "Enter test dummy name...",
            Text = "",
            TextSize = 13,
            Font = Enum.Font.Gotham,
            TextColor3 = Theme.White,
            PlaceholderColor3 = Theme.Gray,
            BackgroundColor3 = Theme.Button,
            ClearTextOnFocus = false,
            Position = UDim2.fromOffset(0, 35),
            Size = UDim2.new(1, 0, 0, 38)
        }, PageContent)
        Corner(NameInput, 6)
        Stroke(NameInput, Theme.Blue, 1)

        local Status = AddInfo("Status: No test character selected", 82)

        MakeButton(PageContent, "SELECT TEST DUMMY", function()
            if NameInput.Text:gsub("%s", "") == "" then
                Status.Text = "Enter a test dummy name first"
                return
            end
            Status.Text = "Demo selected: " .. NameInput.Text
        end, 116)

        MakeButton(PageContent, "DEMO GRAB", function()
            Status.Text = "Demo grab activated"
        end, 160)

        MakeButton(PageContent, "DEMO RELEASE", function()
            Status.Text = "Demo released"
        end, 204)

        MakeButton(PageContent, "DEMO KICK", function()
            Status.Text = "Visual kick demonstration only"
        end, 248)

    elseif tab == "KICK" then
        AddInfo("Visual-only kick interface demo", 0)
        local Status = AddInfo("Status: IDLE", 40)

        MakeButton(PageContent, "ENABLE DEMO", function()
            Status.Text = "Status: ACTIVE (DEMO)"
        end, 78)

        MakeButton(PageContent, "STOP DEMO", function()
            Status.Text = "Status: STOPPED"
        end, 122)

    elseif tab == "SETTINGS" then
        AddInfo("ARKON HUB V4", 0)
        AddInfo("Theme: Black / Blue outline", 35)
        AddInfo("Mode: Visual Demo", 70)
        MakeButton(PageContent, "RESET WINDOW POSITION", function()
            Main.Position = UDim2.new(0.5, -260, 0.5, -215)
        end, 110)
    end
end

local tabs = {"FLING", "ANTI", "FUN", "BLOBMAN", "KICK", "SETTINGS"}

for i, tab in ipairs(tabs) do
    local button = MakeButton(Sidebar, tab, function()
        ShowTab(tab)
    end, 10 + (i - 1) * 43)

    button.Size = UDim2.new(1, -14, 0, 35)
    button.Position = UDim2.fromOffset(7, 10 + (i - 1) * 43)
end

ShowTab("FLING")

print("ARKON HUB V4 loaded successfully!")
