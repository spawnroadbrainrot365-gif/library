local v1 = game:GetService("Players")
local v2 = workspace:WaitForChild("PartsPlayer")
local v3 = v1.LocalPlayer
local v4 = v3.PlayerGui:WaitForChild("Ready"):WaitForChild("Ready")

v4.Visible = false
v4.BackgroundTransparency = 1

local v5
local v6

local function v7()
if v6 then
v6:Cancel()
end

v4.Visible = true  

v6 = game:GetService("TweenService"):Create(  
	v4,  
	TweenInfo.new(0.5),  
	{BackgroundTransparency = 0}  
)  

v6:Play()

end

local function v8()
if not v4.Visible then
return
end

if v6 then  
	v6:Cancel()  
end  

v6 = game:GetService("TweenService"):Create(  
	v4,  
	TweenInfo.new(0.5),  
	{BackgroundTransparency = 1}  
)  

v6:Play()  

v6.Completed:Connect(function()  
	if v4.BackgroundTransparency == 1 then  
		v4.Visible = false  
	end  
end)

end

for _, v9 in ipairs(v2:GetDescendants()) do
if v9:IsA("BasePart") then
v9.Touched:Connect(function(v10)
if v10.Parent ~= v3.Character then
return
end

if v9:GetAttribute("UserIdPlayer") ~= v3.UserId then  
			return  
		end  

		v5 = v9  

		if not v4.Visible then  
			v7()  
		end  
	end)  

	v9.TouchEnded:Connect(function(v10)  
		if v10.Parent ~= v3.Character then  
			return  
		end  

		if v5 ~= v9 then  
			return  
		end  

		v5 = nil  
		v8()  
	end)  
end

end
