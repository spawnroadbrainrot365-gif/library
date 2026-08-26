local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = workspace:WaitForChild("PartsPlayer")

local v4 = v2:WaitForChild("Re/ReadyServic/Ready")
local v5 = {}

for _, v6 in ipairs(v3:GetDescendants()) do
	if v6:IsA("BasePart") then
		table.insert(v5, v6)
	end
end

for v7, v8 in ipairs(v5) do
	v8.Name = "Player" .. v7
	v8:SetAttribute("UserIdPlayer", 0)

	v8.Touched:Connect(function(v9)
		local v10 = v9.Parent
		local v11 = v1:GetPlayerFromCharacter(v10)

		if not v11 then
			return
		end

		if v8:GetAttribute("UserIdPlayer") == 0 then
			v8:SetAttribute("UserIdPlayer", v11.UserId)
		end
	end)
end

local function v12(v13)
	local v14 = v13.Character
	local v15 = v14 and v14:FindFirstChild("HumanoidRootPart")

	if not v15 then
		v4:FireClient(v13, false)
		return
	end

	local v16 = false

	for _, v17 in ipairs(v5) do
		if v17:GetAttribute("UserIdPlayer") == v13.UserId then
			local v18 = v17.CFrame:PointToObjectSpace(v15.Position)
			local v19 = v17.Size / 2

			if math.abs(v18.X) <= v19.X
				and math.abs(v18.Z) <= v19.Z
				and v18.Y >= -v19.Y
				and v18.Y <= v19.Y + 7 then
				v16 = true
				break
			end
		end
	end

	v4:FireClient(v13, v16)
end

task.spawn(function()
	while task.wait(0.1) do
		for _, v20 in ipairs(v1:GetPlayers()) do
			v12(v20)
		end
	end
end)

v1.PlayerRemoving:Connect(function(v21)
	for _, v22 in ipairs(v5) do
		if v22:GetAttribute("UserIdPlayer") == v21.UserId then
			v22:SetAttribute("UserIdPlayer", 0)
		end
	end
end)
