-- ARKON HUB KEY SYSTEM V1.0
-- Demonstration key gate

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("ArkonKeySystem")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "ArkonKeySystem"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(310, 220)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(12, 17, 31)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 13)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(35, 105, 220)
stroke.Thickness = 1.5
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 43)
title.BackgroundTransparency = 1
title.Text = "ARKON HUB"
title.TextColor3 = Color3.fromRGB(100, 170, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 21
title.Parent = main

local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.fromOffset(0, 39)
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.BackgroundTransparency = 1
subtitle.Text = "KEY VERIFICATION"
subtitle.TextColor3 = Color3.fromRGB(145, 155, 180)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 10
subtitle.Parent = main

local input = Instance.new("TextBox")
input.Position = UDim2.fromOffset(20, 75)
input.Size = UDim2.new(1, -40, 0, 39)
input.BackgroundColor3 = Color3.fromRGB(25, 36, 59)
input.TextColor3 = Color3.new(1, 1, 1)
input.PlaceholderText = "Enter your key..."
input.PlaceholderColor3 = Color3.fromRGB(120, 135, 160)
input.Font = Enum.Font.Gotham
input.TextSize = 12
input.ClearTextOnFocus = false
input.Text = ""
input.BorderSizePixel = 0
input.Parent = main

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 7)
inputCorner.Parent = input

local status = Instance.new("TextLabel")
status.Position = UDim2.fromOffset(15, 119)
status.Size = UDim2.new(1, -30, 0, 20)
status.BackgroundTransparency = 1
status.Text = "Waiting for key..."
status.TextColor3 = Color3.fromRGB(150, 165, 190)
status.Font = Enum.Font.Gotham
status.TextSize = 10
status.Parent = main

local check = Instance.new("TextButton")
check.Position = UDim2.fromOffset(20, 151)
check.Size = UDim2.new(1, -40, 0, 34)
check.BackgroundColor3 = Color3.fromRGB(35, 105, 190)
check.Text = "CHECK KEY"
check.TextColor3 = Color3.new(1, 1, 1)
check.Font = Enum.Font.GothamBold
check.TextSize = 11
check.BorderSizePixel = 0
check.Parent = main

local checkCorner = Instance.new("UICorner")
checkCorner.CornerRadius = UDim.new(0, 7)
checkCorner.Parent = check

-- Demo key only; this is not secure authentication.
local DEMO_KEY = "AR-DUZ4-VA58-DURY"

local function launchDemoHub()
    gui:Destroy()

    local hub = Instance.new("ScreenGui")
    hub.Name = "ArkonHubDemo"
    hub.ResetOnSpawn = false
    hub.Parent = playerGui

    local panel = Instance.new("TextLabel")
    panel.Size = UDim2.fromOffset(260, 90)
    panel.Position = UDim2.fromScale(0.5, 0.5)
    panel.AnchorPoint = Vector2.new(0.5, 0.5)
    panel.BackgroundColor3 = Color3.fromRGB(12, 17, 31)
    panel.TextColor3 = Color3.fromRGB(100, 170, 255)
    panel.Text = "ARKON HUB\nDEMO UNLOCKED"
    panel.Font = Enum.Font.GothamBold
    panel.TextSize = 17
    panel.Parent = hub

    local panelCorner = Instance.new("UICorner")
    panelCorner.CornerRadius = UDim.new(0, 12)
    panelCorner.Parent = panel
end

check.Activated:Connect(function()
    if input.Text == DEMO_KEY then
        status.Text = "KEY VALID — ACCESS GRANTED"
        status.TextColor3 = Color3.fromRGB(50, 210, 145)
        task.wait(0.5)
        launchDemoHub()
    else
        status.Text = "KEY IS INVALID"
        status.TextColor3 = Color3.fromRGB(240, 75, 85)
    end
end)

print("ARKON HUB KEY SYSTEM loaded!")
