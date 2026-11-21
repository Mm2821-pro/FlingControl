
-- FLING CONTROL V1
-- Black Minimalist UI
-- For your own Roblox experience

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "FlingControl"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(300, 370)
main.Position = UDim2.new(0.5, -150, 0.5, -185)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius =
    UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 45)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.Text = "FLING CONTROL"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 19
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(35,35)
minimize.Position = UDim2.new(1,-42,0,5)
minimize.Text = "−"
minimize.TextSize = 24
minimize.BackgroundColor3 = Color3.fromRGB(40,40,40)
minimize.TextColor3 = Color3.new(1,1,1)
minimize.Parent = main

local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(10,55)
content.Size = UDim2.new(1,-20,1,-65)
content.BackgroundTransparency = 1
content.Parent = main

local minimized = false

minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    content.Visible = not minimized
    main.Size = minimized
        and UDim2.fromOffset(300,45)
        or UDim2.fromOffset(300,370)
    minimize.Text = minimized and "+" or "−"
end)

-- Window dragging
local dragging = false
local dragStart, startPosition

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local function makeButton(text, position, parent)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,0,0,38)
    button.Position = UDim2.fromOffset(0,position)
    button.BackgroundColor3 = Color3.fromRGB(35,35,35)
    button.TextColor3 = Color3.new(1,1,1)
    button.TextSize = 14
    button.Font = Enum.Font.Gotham
    button.Text = text
    button.Parent = parent
    Instance.new("UICorner",button).CornerRadius =
        UDim.new(0,7)
    return button
end

local tabs = {"FLING","ANTI","SETTINGS"}
local pages = {}

for i, name in ipairs(tabs) do
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(1/3,-4,0,32)
    tab.Position = UDim2.new((i-1)/3,4*(i-1),0,0)
    tab.BackgroundColor3 = Color3.fromRGB(35,35,35)
    tab.TextColor3 = Color3.new(1,1,1)
    tab.Text = name
    tab.TextSize = 12
    tab.Parent = content

    local page = Instance.new("Frame")
    page.Position = UDim2.fromOffset(0,42)
    page.Size = UDim2.new(1,0,1,-42)
    page.BackgroundTransparency = 1
    page.Visible = i == 1
    page.Parent = content
    pages[name] = page

    tab.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do
            p.Visible = false
        end
        page.Visible = true
    end)
end

-- FLING page: strength selector
local flingPage = pages.FLING
local strength = 100

local display = Instance.new("TextLabel")
display.Size = UDim2.new(1,0,0,40)
display.BackgroundTransparency = 1
display.TextColor3 = Color3.new(1,1,1)
display.TextSize = 18
display.Font = Enum.Font.GothamBold
display.Text = "Strength: 100"
display.Parent = flingPage

local minus = makeButton("-100",45,flingPage)
minus.Size = UDim2.new(0.48,0,0,38)

local plus = makeButton("+100",45,flingPage)
plus.Position = UDim2.new(0.52,0,0,45)
plus.Size = UDim2.new(0.48,0,0,38)

local entry = Instance.new("TextBox")
entry.Position = UDim2.fromOffset(0,95)
entry.Size = UDim2.new(1,0,0,38)
entry.BackgroundColor3 = Color3.fromRGB(35,35,35)
entry.TextColor3 = Color3.new(1,1,1)
entry.PlaceholderText = "100 - 10000"
entry.Text = "100"
entry.Parent = flingPage

local function updateStrength(v)
    strength = math.clamp(
        math.floor(v/100)*100,100,10000
    )
    display.Text = "Strength: "..strength
    entry.Text = tostring(strength)
end

minus.MouseButton1Click:Connect(function()
    updateStrength(strength-100)
end)

plus.MouseButton1Click:Connect(function()
    updateStrength(strength+100)
end)

entry.FocusLost:Connect(function()
    local n = tonumber(entry.Text)
    if n then
        updateStrength(math.clamp(n,100,10000))
    else
        updateStrength(strength)
    end
end)

-- ANTI page: demo switches
local antiPage = pages.ANTI
local antiNames = {
    "Anti Grab",
    "Anti Ragdoll",
    "Anti Snowball",
    "Anti Explosion",
    "Anti Paint"
}

local antiStates = {}

for i,name in ipairs(antiNames) do
    antiStates[name] = false
    local button = makeButton(name.." : OFF",(i-1)*45,antiPage)

    button.MouseButton1Click:Connect(function()
        antiStates[name] = not antiStates[name]
        button.Text = name..
            (antiStates[name] and " : ON" or " : OFF")
    end)
end

-- SETTINGS page
local settingsPage = pages.SETTINGS
makeButton("FLING CONTROL V1",0,settingsPage)
makeButton("Black Minimalist Theme",45,settingsPage)

print("FLING CONTROL V1 loaded")
