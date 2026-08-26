local v1 = game:GetService("Players")
local v2 = workspace:WaitForChild("PartsPlayer")
local v3 = {}

for _, v4 in ipairs(v2:GetDescendants()) do
	if v4:IsA("BasePart") then
		table.insert(v3, v4)
	end
end

for v5, v6 in ipairs(v3) do
	v6.Name = "Player" .. v5
	v6:SetAttribute("UserIdPlayer", 0)

	v6.Touched:Connect(function(hit)
		local v7 = hit.Parent
		local v8 = v1:GetPlayerFromCharacter(v7)

		if not v8 then
			return
		end

		local v9 = v6:GetAttribute("UserIdPlayer")

		if v9 == 0 then
			v6:SetAttribute("UserIdPlayer", v8.UserId)
		end
	end)
end

v1.PlayerRemoving:Connect(function(v8)
	for v10, v11 in ipairs(v3) do
		if v11:GetAttribute("UserIdPlayer") == v8.UserId then
			v11:SetAttribute("UserIdPlayer", 0)
		end
	end
end)

