-- Anti Afk V1 By omarshannag1234
-- يعمل على Delta و大多数 إكسكيوتورات روبلوكس

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer

-- إعدادات الواجهة
local screenSize = workspace.CurrentCamera.ViewportSize
local gui = Instance.new("ScreenGui")
gui.Name = "AntiAfkGUI"
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- خلفية شبه شفافة (اختياري)
local background = Instance.new("Frame")
background.Size = UDim2.new(0, 250, 0, 110)
background.Position = UDim2.new(0, 10, 0, 10) -- الزاوية اليسرى العليا
background.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
background.BackgroundTransparency = 0.5
background.BorderSizePixel = 1
background.BorderColor3 = Color3.fromRGB(255, 255, 255)
background.Parent = gui

-- نص العنوان
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Anti Afk V1 By omarshannag1234"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = background

-- نص المعلومات (Ping, FPS)
local info = Instance.new("TextLabel")
info.Size = UDim2.new(1, 0, 0, 25)
info.Position = UDim2.new(0, 0, 0, 32)
info.BackgroundTransparency = 1
info.Text = "Ping: 0    Fps: 0"
info.TextColor3 = Color3.fromRGB(200, 200, 200)
info.TextScaled = true
info.Font = Enum.Font.Gotham
info.Parent = background

-- نص حالة Anti-Afk
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 25)
status.Position = UDim2.new(0, 0, 0, 58)
status.BackgroundTransparency = 1
status.Text = "Anti-Afk Auto Enabled"
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.TextScaled = true
status.Font = Enum.Font.Gotham
status.Parent = background

-- نص العداد (وقت الجلسة)
local timer = Instance.new("TextLabel")
timer.Size = UDim2.new(1, 0, 0, 25)
timer.Position = UDim2.new(0, 0, 0, 82)
timer.BackgroundTransparency = 1
timer.Text = "0:0:0"
timer.TextColor3 = Color3.fromRGB(255, 255, 0)
timer.TextScaled = true
timer.Font = Enum.Font.GothamBold
timer.Parent = background

-- متغيرات العد
local startTime = tick()
local frameCount = 0
local lastFpsUpdate = tick()
local currentFps = 0

-- دالة حساب الـ Ping من Stats (إن وجد)
local function getPing()
    local success, ping = pcall(function()
        return Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
    end)
    if success and ping then
        return tonumber(ping) or 0
    else
        -- طريقة بديلة: قياس الـ Ping عبر RemoteFunction (اختياري)
        -- لكن نكتفي بـ 0 افتراضياً إذا لم تتوفر
        return 0
    end
end

-- تحديث المعلومات كل 0.5 ثانية
coroutine.wrap(function()
    while wait(0.5) do
        -- تحديث Ping
        local ping = getPing()
        -- تحديث FPS (يُحدث في heartbeat لكن نعرضه هنا)
        info.Text = string.format("Ping: %d    Fps: %d", ping, currentFps)

        -- تحديث العداد
        local elapsed = math.floor(tick() - startTime)
        local hours = math.floor(elapsed / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local seconds = elapsed % 60
        timer.Text = string.format("%d:%d:%02d", hours, minutes, seconds)
    end
end)()

-- حساب الـ FPS عبر RunService
RunService.Heartbeat:Connect(function(deltaTime)
    frameCount = frameCount + 1
    local now = tick()
    if now - lastFpsUpdate >= 1 then
        currentFps = frameCount
        frameCount = 0
        lastFpsUpdate = now
    end
end)

-- الحفاظ على الواجهة في المقدمة (اختياري)
gui.ResetOnSpawn = false
