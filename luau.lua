--!strict
-- AntiCheatV2Client
-- Purely cosmetic client listener for the server anti-cheat. Shows a brief
-- toast when the server sends a "warn"/"lagback" notify. Server enforcement does
-- not depend on this in any way -- a modified/removed client changes nothing
-- about detection, which is fully server-authoritative.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local remote = ReplicatedStorage:WaitForChild("AntiCheatV2Notify", 30)
if not remote or not remote:IsA("RemoteEvent") then return end

local function ensureGui(): ScreenGui
  local gui = playerGui:FindFirstChild("AntiCheatV2Toast")
  if gui and gui:IsA("ScreenGui") then return gui end
  gui = Instance.new("ScreenGui")
  gui.Name = "AntiCheatV2Toast"
  gui.ResetOnSpawn = false
  gui.IgnoreGuiInset = true
  gui.Parent = playerGui
  return gui
end

local function toast(kind: string, text: string)
  local gui = ensureGui()

  local frame = Instance.new("Frame")
  frame.Size = UDim2.new(0, 320, 0, 44)
  frame.Position = UDim2.new(0.5, -160, 0, -60)
  frame.BackgroundColor3 = kind == "lagback"
    and Color3.fromRGB(150, 40, 40)
    or Color3.fromRGB(45, 45, 55)
  frame.BorderSizePixel = 0
  frame.Parent = gui

  local corner = Instance.new("UICorner")
  corner.CornerRadius = UDim.new(0, 10)
  corner.Parent = frame

  local label = Instance.new("TextLabel")
  label.Size = UDim2.new(1, -20, 1, 0)
  label.Position = UDim2.new(0, 10, 0, 0)
  label.BackgroundTransparency = 1
  label.TextColor3 = Color3.fromRGB(255, 255, 255)
  label.TextScaled = false
  label.TextSize = 15
  label.Font = Enum.Font.GothamMedium
  label.Text = text
  label.TextXAlignment = Enum.TextXAlignment.Left
  label.Parent = frame

  local tin = TweenService:Create(frame,
    TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    { Position = UDim2.new(0.5, -160, 0, 24) })
  tin:Play()

  task.delay(3.5, function()
    local tout = TweenService:Create(frame,
      TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
      { Position = UDim2.new(0.5, -160, 0, -60) })
    tout:Play()
    tout.Completed:Wait()
    frame:Destroy()
  end)
end

remote.OnClientEvent:Connect(function(kind: string, text: string)
  pcall(toast, kind, text)
end)
