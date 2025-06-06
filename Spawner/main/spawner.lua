local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- Collect seeds dynamically: all children of ReplicatedStorage that have a Name and are of class Tool or Model
local function getAvailableSeeds()
	local seeds = {}
	for _, child in pairs(ReplicatedStorage:GetChildren()) do
		-- Adjust this if seeds have a different class
		if child:IsA("Tool") or child:IsA("Model") then
			table.insert(seeds, child.Name)
		end
	end
	return seeds
end

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

-- Spawn logic
button.MouseButton1Click:Connect(function()
	local name = input.Text
	if not name or name == "" then return end

	-- Get all available seeds dynamically
	local seeds = getAvailableSeeds()

	-- Check if the input name is among available seeds (case sensitive)
	local foundSeed = nil
	for _, seedName in ipairs(seeds) do
		if seedName == name then
			foundSeed = seedName
			break
		end
	end

	if foundSeed then
		local seedInstance = ReplicatedStorage:FindFirstChild(foundSeed)
		if seedInstance and player:FindFirstChild("Backpack") then
			local clone = seedInstance:Clone()
			clone.Parent = player.Backpack
			StarterGui:SetCore("SendNotification", {
				Title = "✅ Spawned",
				Text = foundSeed .. " added to inventory!",
				Duration = 3
			})
		else
			StarterGui:SetCore("SendNotification", {
				Title = "❌ Error",
				Text = "Could not clone the seed.",
				Duration = 3
			})
		end
	else
		StarterGui:SetCore("SendNotification", {
			Title = "❌ Not Found",
			Text = "Seed '" .. name .. "' not found! Available seeds: " .. table.concat(seeds, ", "),
			Duration = 6
		})
	end
end)
