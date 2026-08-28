local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer


local folderName = LocalPlayer.Name .. "SpawnedInToys"
local folder = workspace:WaitForChild(folderName, 10)

if not folder then
	warn("找不到資料夾：" .. folderName)
	return
end

local REFLECTANCE = 0.28
local COLOR_TIME = 0.7

local function applyBlack(obj)
	if not obj or not obj.Parent then return end

	for _, part in ipairs(obj:GetDescendants()) do
		if part:IsA("BasePart") then
			local old = part:FindFirstChild("FakeReflection")
			if old then old:Destroy() end

			TweenService:Create(
				part,
				TweenInfo.new(COLOR_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{
					Color = Color3.fromRGB(10, 10, 10),
					Reflectance = REFLECTANCE
				}
			):Play()

			local highlight = Instance.new("Highlight")
			highlight.Name = "FakeReflection"
			highlight.Adornee = part
			highlight.FillColor = Color3.fromRGB(255, 255, 255)
			highlight.FillTransparency = 0.93
			highlight.OutlineTransparency = 1
			highlight.DepthMode = Enum.HighlightDepthMode.Occluded
			highlight.Parent = part
		end
	end
end

folder.ChildAdded:Connect(function(obj)
	if obj.Name == "PalletLightBrown" then
		task.wait(0.25)
		if obj and obj.Parent then
			applyBlack(obj)
		end
	end
end)


for _, obj in ipairs(folder:GetChildren()) do
	if obj.Name == "PalletLightBrown" then
		task.spawn(function()
			task.wait(0.25)
			applyBlack(obj)
		end)
	end
end

for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") and obj.Material == Enum.Material.Grass then
        obj.Color = Color3.fromRGB(120, 120, 120)
    end
end


local Lighting = game:GetService("Lighting")


Lighting.GlobalShadows = false
Lighting.FogEnd = 100000


for _, obj in ipairs(Lighting:GetChildren()) do
    if obj:IsA("PostEffect") then
        obj.Enabled = false
    end
end


for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("ParticleEmitter")
        or obj:IsA("Trail")
        or obj:IsA("Beam") then
        obj.Enabled = false

    elseif obj:IsA("BasePart") then
        obj.CastShadow = false
    end
end

