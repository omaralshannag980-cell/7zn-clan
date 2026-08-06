--[[
   واجهة إحصائيات فخمة – Roblox Studio
   مربعة بحواف دائرية، لون رمادي غامق، كتابة بيضاء
   تعرض: FPS، البينج، عدد اللاعبين
]]

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

-- ============ إنشاء الشاشة ============
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "StatsUI"

-- ============ الإطار الرئيسي (مربع) ============
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 220, 0, 220) -- مربع 220x220
MainFrame.Position = UDim2.new(0, 20, 0.5, -110) -- على اليسار في المنتصف (غيّر كما تريد)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- رمادي غامق
MainFrame.BorderSizePixel = 0

-- حواف دائرية
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 18)
Corner.Parent = MainFrame

-- ============ عناوين النص ============
local function CreateStatRow(yPosition, labelText)
	local label = Instance.new("TextLabel")
	label.Parent = MainFrame
	label.Size = UDim2.new(1, -20, 0, 30)
	label.Position = UDim2.new(0, 15, 0, yPosition)
	label.BackgroundTransparency = 1
	label.Text = labelText .. ":"
	label.TextColor3 = Color3.fromRGB(255, 255, 255) -- أبيض فاتح
	label.Font = Enum.Font.GothamSemibold
	label.TextSize = 18
	label.TextXAlignment = Enum.TextXAlignment.Left
	return label
end

local FPSLabel = CreateStatRow(20, "fps")
local PingLabel = CreateStatRow(75, "ping")
local PeopleLabel = CreateStatRow(130, "people")

-- ============ قيم الإحصائيات ============
local function CreateValueLabel(yPosition)
	local val = Instance.new("TextLabel")
	val.Parent = MainFrame
	val.Size = UDim2.new(1, -20, 0, 30)
	val.Position = UDim2.new(0, 15, 0, yPosition + 25)
	val.BackgroundTransparency = 1
	val.Text = "--"
	val.TextColor3 = Color3.fromRGB(255, 255, 255)
	val.Font = Enum.Font.GothamBold
	val.TextSize = 22
	val.TextXAlignment = Enum.TextXAlignment.Left
	return val
end

local FPSValue = CreateValueLabel(20)
local PingValue = CreateValueLabel(75)
local PeopleValue = CreateValueLabel(130)

-- ============ جلب البيانات ============
local function GetFPS()
	-- طريقة دقيقة لقياس الإطارات
	local dt = 0
	for i = 1, 5 do
		dt = dt + RunService.RenderStepped:Wait()
	end
	local fps = math.floor(5 / dt)
	return fps
end

local function GetPing()
	local ping = Stats:FindFirstChild("PerformanceStats") and Stats.PerformanceStats.Ping
	if ping then
		return math.floor(ping) .. " ms"
	else
		-- خيار احتياطي
		local dping = Stats.Network.ServerStatsItem.DataPing
		return dping and math.floor(dping) .. " ms" or "N/A"
	end
end

local function GetPlayerCount()
	return #game.Players:GetPlayers()
end

-- ============ تحديث متواصل ============
spawn(function()
	while true do
		FPSValue.Text = tostring(GetFPS())
		PingValue.Text = GetPing()
		PeopleValue.Text = tostring(GetPlayerCount())
		wait(0.5) -- يحدث كل نصف ثانية
	end
end)
