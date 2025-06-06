--[[ 
  Seed Spawner - Auto Inventory UI
  Execute using:
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Carters-Development/Spawner/main/spawner.lua"))()
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- UI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SeedSpawnUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 140)
frame.Position = UDim2.new(0.5, -150, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Text = "🌱 Seed Spawner"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(200, 255, 200)
title.TextScaled = true

local input = Instance.new("TextBox", frame)
input.PlaceholderText = "Enter Seed Name"
input.Size = UDim2.new(1, -20, 0, 35)
input.Position = UDim2.new(0, 10, 0, 40)
input.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
input.TextColor3 = Color3.new(1, 1, 1)
input.TextScaled = true

local button = Instance.new("TextButton", frame)
button.Text = "Spawn Seed"
button.Size = UDim2.new(1, -20, 0, 35)
button.Position = UDim2.new(0, 10, 0, 85)
button.BackgroundColor3 = Color3.fromRGB(80, 180, 100)
button.TextScaled = true
button.TextColor3 = Color3.new(1, 1, 1)

-- Spawning Logic
button.MouseButton1Click:Connect(function()
	local name = input.Text
	if not name or name == "" then return end

	local folder = ReplicatedStorage:FindFirstChild("Seeds") or ReplicatedStorage
	local model = folder:FindFirstChild(name)

	if model and player:FindFirstChild("Backpack") then
		local clone = model:Clone()
		clone.Parent = player.Backpack
		StarterGui:SetCore("SendNotification", {
			Title = "✅ Spawned",
			Text = name.." added to inventory!",
			Duration = 3
		})
	else
		StarterGui:SetCore("SendNotification", {
			Title = "❌ Not Found",
			Text = "Seed '"..name.."' not found!",
			Duration = 3
		})
	end
end)
