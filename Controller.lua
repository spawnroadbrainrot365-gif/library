local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("TweenService")

local v4 = v1.LocalPlayer
local v5 = v4.PlayerGui:WaitForChild("ReadyButton"):WaitForChild("Ready")
local v6 = v2:WaitForChild("Re/ReadyServic/Ready")

local v7
local v8 = false

v5.Visible = false
v5.BackgroundTransparency = 1

local function v9()
	if v7 then
		v7:Cancel()
	end

	v5.Visible = true
	v8 = true

	v7 = v3:Create(
		v5,
		TweenInfo.new(0.5),
		{BackgroundTransparency = 0}
	)

	v7:Play()
end

local function v10()
	if not v5.Visible then
		return
	end

	if v7 then
		v7:Cancel()
	end

	v8 = false

	v7 = v3:Create(
		v5,
		TweenInfo.new(0.5),
		{BackgroundTransparency = 1}
	)

	v7:Play()

	v7.Completed:Connect(function()
		if not v8 then
			v5.Visible = false
		end
	end)
end

v6.OnClientEvent:Connect(function(v11)
	if v11 then
		if not v5.Visible then
			v9()
		end
	else
		v10()
	end
end)
