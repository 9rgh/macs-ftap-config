local Lighting = game:GetService("Lighting")

-- Remove existing sky
local oldSky = Lighting:FindFirstChildOfClass("Sky")
if oldSky then
	oldSky:Destroy()
end

-- Create gray sky
local sky = Instance.new("Sky")
sky.Name = "GraySky"
sky.SkyboxBk = "rbxassetid://0"
sky.SkyboxDn = "rbxassetid://0"
sky.SkyboxFt = "rbxassetid://0"
sky.SkyboxLf = "rbxassetid://0"
sky.SkyboxRt = "rbxassetid://0"
sky.SkyboxUp = "rbxassetid://0"
sky.Parent = Lighting

-- Gray ambient atmosphere
local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
if atmosphere then
	atmosphere.Color = Color3.fromRGB(128, 128, 128)
	atmosphere.Decay = Color3.fromRGB(100, 100, 100)
	atmosphere.Glare = 0
	atmosphere.Haze = 0
end

Lighting.Ambient = Color3.fromRGB(128, 128, 128)
Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)