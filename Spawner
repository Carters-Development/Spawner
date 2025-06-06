--// SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

--// UI SETUP
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "SeedSpawnerGui"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0

local TextBox = Instance.new("TextBox", Frame)
TextBox.PlaceholderText = "Enter Seed Name"
TextBox.Size = UDim2.new(1, -20, 0, 40)
TextBox.Position = UDim2.new(0, 10, 0, 10)
TextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.TextScaled = true
TextBox.ClearTextOnFocus = false

local Button = Instance.new("TextButton", Frame)
Button.Text = "Spawn Seed"
Button.Size = UDim2.new(1, -20, 0, 40)
Button.Position = UDim2.new(0, 10, 0, 60)
Button.BackgroundColor3 = Color3.fromRGB(60, 180, 75)
Button.TextScaled = true
Button.TextColor3 = Color3.new(1, 1, 1)

--// FUNCTION TO SPAWN SEED
local function spawnSeed(seedName)
    local seedsFolder = ReplicatedStorage:FindFirstChild("Seeds") or ReplicatedStorage
    local seedModel = seedsFolder:FindFirstChild(seedName)

    if seedModel and player:FindFirstChild("Backpack") then
        local clone = seedModel:Clone()
        clone.Parent = player.Backpack
        StarterGui:SetCore("SendNotification", {
            Title = "✅ Seed Added",
            Text = seedName.." has been added to your backpack!",
            Duration = 3
        })
    else
        StarterGui:SetCore("SendNotification", {
            Title = "❌ Error",
            Text = "Seed '"..seedName.."' not found!",
            Duration = 3
        })
    end
end

--// BUTTON ACTION
Button.MouseButton1Click:Connect(function()
    local input = TextBox.Text
    if input and input ~= "" then
        spawnSeed(input)
    end
end)
