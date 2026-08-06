--[[
   سكربت تعليمي: واجهة فخمة لإحصائيات السيرفر
   يعمل في Roblox Studio فقط (غير مخصص للاستغلال)
   الوصف: زر جانبي يفتح/يغلق لوحة إحصائيات
   الكاتب: مساعد تعليمي
]]

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

-- ============ إعدادات التصميم ============
local MAIN_COLOR = Color3.fromRGB(20, 20, 20)      -- أسود غامق
local ACCENT_COLOR = Color3.fromRGB(150, 15, 15)  -- أحمر غامق
local TEXT_COLOR = Color3.fromRGB(240, 240, 240)  -- أبيض فاتح
local FONT = Enum.Font.GothamBold

-- ============ إنشاء الشاشة ============
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- ============ زر الفتح/الإغلاق (الزر الجانبي) ============
local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(1, -60, 0.5, -25) -- على يمين الشاشة
ToggleButton.BackgroundColor3 = MAIN_COLOR
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "⟩" -- سهم صغير، ممكن تغيره لـ "TF" أو أيقونة
ToggleButton.TextColor3 = ACCENT_COLOR
ToggleButton.TextSize = 28
ToggleButton.Font = FONT
ToggleButton.ZIndex = 10

-- إطار دائري أنيق
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 25)
Corner.Parent = ToggleButton

-- شفافية بسيطة عند التحويم (اختياري)
ToggleButton.MouseEnter:Connect(function()
	ToggleButton.BackgroundColor3 = ACCENT_COLOR
	ToggleButton.TextColor3 = MAIN_COLOR
end)
ToggleButton.MouseLeave:Connect(function()
	ToggleButton.BackgroundColor3 = MAIN_COLOR
	ToggleButton.TextColor3 = ACCENT_COLOR
end)

-- ============ اللوحة الرئيسية ============
local MainPanel = Instance.new("Frame")
MainPanel.Parent = ScreenGui
MainPanel.Size = UDim2.new(0, 280, 0, 220)
MainPanel.Position = UDim2.new(1, -300, 0.5, -110) -- تبدأ مخفية خارج الشاشة
MainPanel.BackgroundColor3 = MAIN_COLOR
MainPanel.BorderSizePixel = 0
MainPanel.ZIndex = 5
MainPanel.Visible = false -- تظهر فقط عند الضغط

local PanelCorner = Instance.new("UICorner")
PanelCorner.CornerRadius = UDim.new(0, 12)
PanelCorner.Parent = MainPanel

-- شريط جانبي أحمر على اليسار (تفصيلة تصميمية)
local SideBar = Instance.new("Frame")
SideBar.Parent = MainPanel
SideBar.Size = UDim2.new(0, 4, 1, 0)
SideBar.BackgroundColor3 = ACCENT_COLOR
SideBar.BorderSizePixel = 0

-- ============ عنوان اللوحة ============
local Title = Instance.new("TextLabel")
Title.Parent = MainPanel
Title.Size = UDim2.new(1, -30, 0, 40)
Title.Position = UDim2.new(0, 25, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "سكربت ترفكسا"
Title.TextColor3 = TEXT_COLOR
Title.Font = FONT
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Left

-- خط تحت العنوان
local Divider = Instance.new("Frame")
Divider.Parent = MainPanel
Divider.Size = UDim2.new(1, -40, 0, 1)
Divider.Position = UDim2.new(0, 20, 0, 48)
Divider.BackgroundColor3 = ACCENT_COLOR
Divider.BorderSizePixel = 0

-- ============ وظائف جلب البيانات ============
local function GetServerTime()
	-- وقت انضمام اللاعب (نستخدم وقت بدء السكربت كتقريب)
	-- في الوضع التعليمي نأخذ الفرق بين tick() ووقت دخولنا
	-- لكن Roblox لا يعطي JoinTime مباشرة، لذا نخزنه عند بدء السكربت
	if not _G.JoinTick then
		_G.JoinTick = tick()
	end
	local seconds = math.floor(tick() - _G.JoinTick)
	local hours = math.floor(seconds / 3600)
	local mins = math.floor((seconds % 3600) / 60)
	local secs = seconds % 60
	return string.format("%02d:%02d:%02d", hours, mins, secs)
end

local function GetFPS()
	return math.floor(1 / RunService.RenderStepped:Wait())
end

local function GetPing()
	local ping = Stats:FindFirstChild("PerformanceStats") and Stats.PerformanceStats.Ping
	if ping then
		return math.floor(ping) .. " ms"
	else
		-- طريقة بديلة: DataPing
		local dping = Stats.Network.ServerStatsItem.DataPing
		return dping and math.floor(dping) .. " ms" or "N/A"
	end
end

local function GetPlayerCount()
	return #game.Players:GetPlayers()
end

-- ============ عناصر النص داخل اللوحة ============
local function CreateStatLabel(name, yPos)
	local label = Instance.new("TextLabel")
	label.Parent = MainPanel
	label.Size = UDim2.new(1, -40, 0, 25)
	label.Position = UDim2.new(0, 25, 0, yPos)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Color3.fromRGB(180, 180, 180)
	label.Font = Enum.Font.GothamSemibold
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	return label
end

local function CreateStatValue(yPos)
	local val = Instance.new("TextLabel")
	val.Parent = MainPanel
	val.Size = UDim2.new(1, -50, 0, 30)
	val.Position = UDim2.new(0, 25, 0, yPos + 18)
	val.BackgroundTransparency = 1
	val.Text = "--"
	val.TextColor3 = TEXT_COLOR
	val.Font = FONT
	val.TextSize = 18
	val.TextXAlignment = Enum.TextXAlignment.Left
	return val
end

local ServerTimeLabel = CreateStatLabel("وقت السيرفر", 60)
local ServerTimeValue = CreateStatValue(60)

local FPSLabel = CreateStatLabel("FPS", 115)
local FPSValue = CreateStatValue(115)

local PingLabel = CreateStatLabel("البينج", 165)
local PingValue = CreateStatValue(165)

local PlayersLabel = CreateStatLabel("عدد اللاعبين", 215)
local PlayersValue = CreateStatValue(215)

-- ============ تحديث البيانات ============
local function UpdateStats()
	ServerTimeValue.Text = GetServerTime()
	FPSValue.Text = tostring(GetFPS())
	PingValue.Text = GetPing()
	PlayersValue.Text = tostring(GetPlayerCount())
end

-- تحديث كل 1 ثانية
spawn(function()
	while true do
		UpdateStats()
		wait(1)
	end
end)

-- ============ منطق الفتح والإغلاق ============
local panelOpen = false
ToggleButton.MouseButton1Click:Connect(function()
	panelOpen = not panelOpen
	MainPanel.Visible = panelOpen
	if panelOpen then
		-- حركة سلايدر بسيطة
		MainPanel:TweenPosition(
			UDim2.new(1, -300, 0.5, -110),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quad,
			0.3,
			true
		)
		ToggleButton.Text = "⟨" -- سهم عكسي
	else
		MainPanel:TweenPosition(
			UDim2.new(1, 0, 0.5, -110),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quad,
			0.3,
			true
		)
		ToggleButton.Text = "⟩"
	end
end)
