
--[[
    ARKON HUB V3
    VISUAL DEMO
    KEY SYSTEM + MAIN HUB
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local DemoKey = "AR-DUZ4-VA58-DURY"

local Theme = {
    Background = Color3.fromRGB(10, 13, 23),
    Panel = Color3.fromRGB(17, 24, 40),
    Button = Color3.fromRGB(26, 43, 70),
    Blue = Color3.fromRGB(45, 135, 255),
    White = Color3.fromRGB(240, 245, 255),
    Gray = Color3.fromRGB(145, 160, 185),
    Green = Color3.fromRGB(50, 220, 140)
}

local GUI = Instance.new("ScreenGui")
GUI.Name = "ARKON_HUB_V3_DEMO"
GUI.ResetOnSpawn = false
GUI.Parent = Player:WaitForChild("PlayerGui")

local function New(class, properties, parent)
    local object = Instance.new(class)

    for property, value in pairs(properties) do
        object[property] = value
    end

    object.Parent = parent
    return object
end

local function Corner(object, radius)
    New("UICorner", {
        CornerRadius = UDim.new(0, radius or 10)
    }, object)
end

local function Animate(object, properties)
    TweenService:Create(
        object,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
        properties
    ):Play()
end

local function MakeButton(parent, text, position, size)
    local button = New("TextButton", {
        Position = position,
        Size = size,
        BackgroundColor3 = Theme.Button,
        Text = text,
        TextColor3 = Theme.White,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    }, parent)

    Corner(button, 8)

    button.MouseEnter:Connect(function()
        Animate(button, {
            BackgroundColor3 = Theme.Blue
        })
    end)

    button.MouseLeave:Connect(function()
        Animate(button, {
            BackgroundColor3 = Theme.Button
        })
    end)

    return button
end

-- KEY SYSTEM

local KeyFrame = New("Frame", {
    Size = UDim2.fromOffset(330, 245),
    Position = UDim2.new(0.5, -165, 0.5, -122),
    BackgroundColor3 = Theme.Background,
    BorderSizePixel = 0
}, GUI)

Corner(KeyFrame, 14)

New("TextLabel", {
    Size = UDim2.new(1, 0, 0, 55),
    BackgroundTransparency = 1,
    Text = "ARKON HUB",
    TextColor3 = Theme.Blue,
    TextSize = 27,
    Font = Enum.Font.GothamBold
}, KeyFrame)

New("TextLabel", {
    Position = UDim2.fromOffset(0, 55),
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundTransparency = 1,
    Text = "KEY AUTHENTICATION",
    TextColor3 = Theme.Gray,
    TextSize = 11,
    Font = Enum.Font.GothamBold
}, KeyFrame)

local KeyInput = New("TextBox", {
    Position = UDim2.fromOffset(25, 95),
    Size = UDim2.new(1, -50, 0, 42),
    BackgroundColor3 = Theme.Panel,
    PlaceholderText = "Enter your key...",
    Text = "",
    TextColor3 = Theme.White,
    PlaceholderColor3 = Theme.Gray,
    TextSize = 14,
    Font = Enum.Font.Gotham
}, KeyFrame)

Corner(KeyInput, 8)

local Status = New("TextLabel", {
    Position = UDim2.fromOffset(15, 145),
    Size = UDim2.new(1, -30, 0, 25),
    BackgroundTransparency = 1,
    Text = "Waiting for key...",
    TextColor3 = Theme.Gray,
    TextSize = 12,
    Font = Enum.Font.Gotham
}, KeyFrame)

-- MAIN HUB

local function OpenMainHub()
    KeyFrame:Destroy()

    local Main = New("Frame", {
        Size = UDim2.fromOffset(370, 390),
        Position = UDim2.new(0.5, -185, 0.5, -195),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0
    }, GUI)

    Corner(Main, 14)

    local Header = New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 55),
        BackgroundColor3 = Theme.Panel,
        Text = "ARKON HUB V3",
        TextColor3 = Theme.Blue,
        TextSize = 22,
        Font = Enum.Font.GothamBold
    }, Main)

    Corner(Header, 12)

    -- Demo navigation

    local Sidebar = New("Frame", {
        Position = UDim2.fromOffset(10, 65),
        Size = UDim2.fromOffset(115, 310),
        BackgroundTransparency = 1
    }, Main)

    local Content = New("Frame", {
        Position = UDim2.fromOffset(135, 65),
        Size = UDim2.fromOffset(225, 310),
        BackgroundColor3 = Theme.Panel,
        BorderSizePixel = 0
    }, Main)

    Corner(Content, 10)

    local Tabs = {
        "FLING",
        "ANTI",
        "FUN",
        "BLOBMAN",
        "SETTINGS"
    }

    local function ShowTab(tab)
        Content:ClearAllChildren()
        Corner(Content, 10)

        New("TextLabel", {
            Position = UDim2.fromOffset(10, 10),
            Size = UDim2.new(1, -20, 0, 35),
            BackgroundTransparency = 1,
            Text = tab,
            TextColor3 = Theme.Blue,
            TextSize = 19,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left
        }, Content)

        local items = {}

        if tab == "FLING" then
            items = {
                "Super Strength",
                "Fling Settings",
                "Demo Strength: 100"
            }
        elseif tab == "ANTI" then
            items = {
                "Anti Grab",
                "Anti Ragdoll",
                "Anti Snowball",
                "Anti Explosion",
                "Anti Kick"
            }
        elseif tab == "FUN" then
            items = {
                "Wings",
                "Dynamic Wings",
                "Extra Wings",
                "Mech Suit"
            }
        elseif tab == "BLOBMAN" then
            items = {
                "Demo Target Selector",
                "No target selected"
            }
        else
            items = {
                "Dark Mode",
                "Notifications",
                "Language: English",
                "Reset Settings"
            }
        end

        for index, name in ipairs(items) do
            local toggle = MakeButton(
                Content,
                name .. "  [OFF]",
                UDim2.fromOffset(10, 55 + (index - 1) * 43),
                UDim2.new(1, -20, 0, 35)
            )

            local enabled = false

            toggle.MouseButton1Click:Connect(function()
                enabled = not enabled

                toggle.Text = name ..
                    (enabled and "  [ON]" or "  [OFF]")
            end)
        end
    end

    for index, tab in ipairs(Tabs) do
        local button = MakeButton(
            Sidebar,
            tab,
            UDim2.fromOffset(0, (index - 1) * 53),
            UDim2.new(1, 0, 0, 43)
        )

        button.MouseButton1Click:Connect(function()
            ShowTab(tab)
        end)
    end

    ShowTab("FLING")

    -- Mobile drag

    local dragging = false
    local dragStart
    local startPosition

    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPosition = Main.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.Touch
            or input.UserInputType == Enum.UserInputType.MouseMovement
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

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- KEY CHECK

local Check = MakeButton(
    KeyFrame,
    "CHECK KEY",
    UDim2.fromOffset(25, 185),
    UDim2.new(1, -50, 0, 42)
)

Check.BackgroundColor3 = Theme.Blue

Check.MouseButton1Click:Connect(function()
    if KeyInput.Text == DemoKey then
        Status.Text = "KEY VALID!"
        Status.TextColor3 = Theme.Green
        task.wait(0.4)
        OpenMainHub()
    else
        Status.Text = "Key is invalid"
        Status.TextColor3 = Color3.fromRGB(255, 80, 90)
    end
end)

print("ARKON HUB V3 DEMO loaded")
