local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = workspace:WaitForChild("PartsPlayer")

local v4 = v2:WaitForChild("Re/ReadyService/Ready")
local v5 = {}
local v6 = {}

for _, v7 in ipairs(v3:GetDescendants()) do
	if v7:IsA("BasePart") then
		table.insert(v5, v7)
	end
end

for v8, v9 in ipairs(v5) do
	v9.Name = "Player" .. v8
	v9:SetAttribute("UserIdPlayer", 0)

	v9.Touched:Connect(function(v10)
		local v11 = v10.Parent
		local v12 = v1:GetPlayerFromCharacter(v11)

		if not v12 then
			return
		end

		if v9:GetAttribute("UserIdPlayer") == 0 then
			v9:SetAttribute("UserIdPlayer", v12.UserId)
		end
	end)
end

local function v13(v14)
	local v15 = v14.Character
	local v16 = v15 and v15:FindFirstChild("HumanoidRootPart")
	local v17 = false

	if v16 then
		for _, v18 in ipairs(v5) do
			if v18:GetAttribute("UserIdPlayer") == v14.UserId then
				local v19 = v18.CFrame:PointToObjectSpace(v16.Position)
				local v20 = v18.Size / 2

				if math.abs(v19.X) <= v20.X
					and math.abs(v19.Z) <= v20.Z
					and v19.Y >= -v20.Y
					and v19.Y <= v20.Y + 7 then
					v17 = true
					break
				end
			end
		end
	end

	if v6[v14] ~= v17 then
		v6[v14] = v17
		v4:FireClient(v14, v17)
	end
end

task.spawn(function()
	while task.wait(0.1) do
		for _, v21 in ipairs(v1:GetPlayers()) do
			v13(v21)
		end
	end
end)

v1.PlayerRemoving:Connect(function(v22)
	v6[v22] = nil

	for _, v23 in ipairs(v5) do
		if v23:GetAttribute("UserIdPlayer") == v22.UserId then
			v23:SetAttribute("UserIdPlayer", 0)
		end
	end
end)
