
-- ARKON HUB V3
-- KEY SYSTEM DEMO
-- Interface foundation

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ARKON_HUB"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Name = "KeyWindow"
Main.Size = UDim2.fromOffset(330, 250)
Main.Position = UDim2.new(0.5, -165, 0.5, -125)
Main.BackgroundColor3 = Color3.fromRGB(12, 15, 24)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 14)
Corner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 55)
Title.BackgroundTransparency = 1
Title.Text = "ARKON HUB"
Title.TextColor3 = Color3.fromRGB(65, 150, 255)
Title.TextSize = 25
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

local Input = Instance.new("TextBox")
Input.Size = UDim2.new(1, -30, 0, 42)
Input.Position = UDim2.fromOffset(15, 75)
Input.BackgroundColor3 = Color3.fromRGB(25, 31, 45)
Input.PlaceholderText = "Enter your key..."
Input.Text = ""
Input.TextColor3 = Color3.new(1, 1, 1)
Input.PlaceholderColor3 = Color3.fromRGB(130, 140, 160)
Input.TextSize = 14
Input.Font = Enum.Font.Gotham
Input.ClearTextOnFocus = false
Input.Parent = Main

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = Input

local Check = Instance.new("TextButton")
Check.Size = UDim2.new(1, -30, 0, 42)
Check.Position = UDim2.fromOffset(15, 132)
Check.BackgroundColor3 = Color3.fromRGB(35, 110, 220)
Check.Text = "CHECK KEY"
Check.TextColor3 = Color3.new(1, 1, 1)
Check.TextSize = 14
Check.Font = Enum.Font.GothamBold
Check.Parent = Main

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = Check

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -20, 0, 35)
Status.Position = UDim2.fromOffset(10, 185)
Status.BackgroundTransparency = 1
Status.Text = "Waiting for key..."
Status.TextColor3 = Color3.fromRGB(150, 160, 180)
Status.TextSize = 12
Status.Font = Enum.Font.Gotham
Status.Parent = Main

local function OpenMainHub()
    Main:Destroy()

    local Hub = Instance.new("Frame")
    Hub.Name = "MainHub"
    Hub.Size = UDim2.fromOffset(330, 300)
    Hub.Position = UDim2.new(0.5, -165, 0.5, -150)
    Hub.BackgroundColor3 = Color3.fromRGB(12, 15, 24)
    Hub.BorderSizePixel = 0
    Hub.Parent = ScreenGui

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 60)
    Label.BackgroundTransparency = 1
    Label.Text = "ARKON HUB — MAIN MENU"
    Label.TextColor3 = Color3.fromRGB(65, 150, 255)
    Label.TextSize = 19
    Label.Font = Enum.Font.GothamBold
    Label.Parent = Hub
end

Check.MouseButton1Click:Connect(function()
    Status.Text = "Demo mode: server verification not connected."
    Status.TextColor3 = Color3.fromRGB(255, 190, 70)
end)

ScreenGui.Parent = Player:WaitForChild("PlayerGui")
