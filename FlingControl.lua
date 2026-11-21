
-- BLACK MOBILE GUI
-- Compact minimize / restore example
-- For your own Roblox Studio project

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "BlackMobileMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local expandedSize = UDim2.new(0.88, 0, 0.78, 0)
local compactSize = UDim2.new(0, 230, 0, 48)

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = expandedSize
main.Position = UDim2.new(0.06, 0, 0.11, 0)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(35, 100, 220)
stroke.Thickness = 1
stroke.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
header.BorderSizePixel = 0
header.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "FLING CONTROL"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local function createHeaderButton(symbol, x)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 34, 0, 30)
    button.Position = UDim2.new(1, x, 0, 9)
    button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = symbol
    button.Font = Enum.Font.GothamBold
    button.TextSize = 17
    button.Parent = header

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = button

    return button
end

local minimize = createHeaderButton("−", -82)
local close = createHeaderButton("X", -42)

local body = Instance.new("Frame")
body.Name = "Body"
body.Position = UDim2.new(0, 8, 0, 56)
body.Size = UDim2.new(1, -16, 1, -64)
body.BackgroundColor3 = Color3.fromRGB(9, 9, 9)
body.BorderSizePixel = 0
body.Parent = main

local bodyCorner = Instance.new("UICorner")
bodyCorner.CornerRadius = UDim.new(0, 8)
bodyCorner.Parent = body

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 105, 1, -12)
sidebar.Position = UDim2.new(0, 6, 0, 6)
sidebar.BackgroundTransparency = 1
sidebar.Parent = body

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 7)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = sidebar

local tabs = {"FLING", "SETTINGS", "ANTI", "FUN"}

for index, name in ipairs(tabs) do
    local button = Instance.new("TextButton")
    button.Name = name
    button.LayoutOrder = index
    button.Size = UDim2.new(1, -4, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = name
    button.Font = Enum.Font.GothamBold
    button.TextSize = 12
    button.Parent = sidebar

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 7)
    c.Parent = button
end

local minimized = false

minimize.Activated:Connect(function()
    minimized = not minimized

    body.Visible = not minimized
    close.Visible = not minimized

    if minimized then
        main.Size = compactSize
        minimize.Text = "+"
        minimize.Position = UDim2.new(1, -42, 0, 9)
    else
        main.Size = expandedSize
        minimize.Text = "−"
        minimize.Position = UDim2.new(1, -82, 0, 9)
    end
end)

close.Activated:Connect(function()
    gui:Destroy()
end)
