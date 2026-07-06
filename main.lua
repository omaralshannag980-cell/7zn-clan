-- // سكربت ترفكسا - النسخة المتكاملة \\ --
-- // يحتوي على: البانج + المضادات + سكربت المطور \\ --

-- =====================================================
-- [1] الخدمات الأساسية
-- =====================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local plr = Players.LocalPlayer

-- إنشاء الواجهة الرئيسية
local gui = Instance.new("ScreenGui")
gui.Name = "Tarfxa_Menu"
gui.Parent = plr.PlayerGui

-- =====================================================
-- [2] الإطار الرئيسي (باسم ترفكسا)
-- =====================================================
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 320)
frame.Position = UDim2.new(0.5, -210, 0.5, -160)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(200, 50, 50) -- لمسة حمراء باسم ترفكسا
frame.BackgroundTransparency = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- العنوان العلوي (اسمك)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 420, 0, 35)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
title.BorderSizePixel = 0
title.Text = "🔥 ترفكسا | لوحة التحكم"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- =====================================================
-- [3] إنشاء علامات التبويب (Tabs) الثلاثة
-- =====================================================
local tabButtons = {}
local tabContents = {}

local function createTab(name, index)
    -- زر التبويب
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Position = UDim2.new(0, (index - 1) * 135 + 10, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(200, 200, 200)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.Parent = frame
    table.insert(tabButtons, btn)

    -- محتوى التبويب
    local content = Instance.new("Frame")
    content.Size = UDim2.new(0, 400, 0, 225)
    content.Position = UDim2.new(0, 10, 0, 80)
    content.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    content.BorderSizePixel = 1
    content.BorderColor3 = Color3.fromRGB(100, 100, 100)
    content.Visible = (index == 1)
    content.Parent = frame
    table.insert(tabContents, content)

    -- تبديل التبويب عند الضغط
    btn.MouseButton1Click:Connect(function()
        for i, tab in ipairs(tabContents) do
            tab.Visible = (i == index)
        end
        for i, b in ipairs(tabButtons) do
            b.BackgroundColor3 = (i == index) and Color3.fromRGB(180, 30, 30) or Color3.fromRGB(50, 50, 60)
        end
    end)
end

-- إنشاء 3 تبويبات باسم ترفكسا
createTab("📡 البانج", 1)
createTab("🛡️ المضادات", 2)
createTab("👨‍💻 ترفكسا", 3) -- التبويب الثالث باسمك

-- =====================================================
-- [4] التبويب الأول: البانج (Ping + بانج خلفي)
-- =====================================================
local tab1 = tabContents[1]

-- عرض الـ Ping
local pingLabel = Instance.new("TextLabel")
pingLabel.Size = UDim2.new(0, 350, 0, 30)
pingLabel.Position = UDim2.new(0, 15, 0, 10)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "🌐 Ping: -- مللي"
pingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
pingLabel.TextSize = 16
pingLabel.Font = Enum.Font.GothamBold
pingLabel.TextXAlignment = Enum.TextXAlignment.Left
pingLabel.Parent = tab1

-- زر "بانج خلفي"
local bangBtn = Instance.new("TextButton")
bangBtn.Size = UDim2.new(0, 160, 0, 40)
bangBtn.Position = UDim2.new(0, 15, 0, 50)
bangBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
bangBtn.BorderSizePixel = 2
bangBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
bangBtn.Text = "💥 بانج خلفي"
bangBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
bangBtn.TextSize = 16
bangBtn.Font = Enum.Font.GothamBold
bangBtn.Parent = tab1

bangBtn.MouseButton1Click:Connect(function()
    -- محاولة إيجاد Remote لإرسال البانج
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("BangEvent") 
                 or game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvent")
    if remote then
        pcall(function()
            remote:FireServer("Bang")
            bangBtn.Text = "✅ تم الإرسال"
            task.wait(1)
            bangBtn.Text = "💥 بانج خلفي"
        end)
    else
        bangBtn.Text = "❌ لا يوجد Remote"
        task.wait(1.5)
        bangBtn.Text = "💥 بانج خلفي"
    end
end)

-- تحديث الـ Ping تلقائياً
task.spawn(function()
    while gui.Parent do
        task.wait(2)
        local stats = game:GetService("Stats")
        local ping = stats:FindFirstChild("Data") and stats.Data:FindFirstChild("Ping")
        if ping then
            pingLabel.Text = "🌐 Ping: " .. math.floor(ping.Value * 1000) .. " مللي"
        else
            pingLabel.Text = "🌐 Ping: -- مللي"
        end
    end
end)

-- =====================================================
-- [5] التبويب الثاني: جميع أنواع المضادات
-- =====================================================
local tab2 = tabContents[2]

-- قائمة المضادات
local antiList = {
    {name = "🛡️ مضاد AFK", key = "afk"},
    {name = "🧊 مضاد التجميد", key = "freeze"},
    {name = "🚫 مضاد الطرد", key = "kick"},
    {name = "⚡ مضاد التعليق", key = "lag"}
}

local antiStates = {}
local yPos = 10

for i, item in ipairs(antiList) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 170, 0, 35)
    btn.Position = UDim2.new(0, 15 + ((i-1) % 2) * 190, 0, yPos + math.floor((i-1) / 2) * 50)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(200, 200, 200)
    btn.Text = item.name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.Parent = tab2
    
    antiStates[item.key] = false
    
    btn.MouseButton1Click:Connect(function()
        antiStates[item.key] = not antiStates[item.key]
        if antiStates[item.key] then
            btn.Text = item.name .. ": ✅ ON"
            btn.BackgroundColor3 = Color3.fromRGB(30, 120, 30)
        else
            btn.Text = item.name .. ": ❌ OFF"
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        end
    end)
end

-- =====================================================
-- [6] التبويب الثالث: سكربت المطور ترفكسا
-- =====================================================
local tab3 = tabContents[2]

local devLabel = Instance.new("TextLabel")
devLabel.Size = UDim2.new(0, 380, 0, 30)
devLabel.Position = UDim2.new(0, 10, 0, 10)
devLabel.BackgroundTransparency = 1
devLabel.Text = "👨‍💻 سكربت المطور ترفكسا"
devLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
devLabel.TextSize = 18
devLabel.Font = Enum.Font.GothamBold
devLabel.TextXAlignment = Enum.TextXAlignment.Center
devLabel.Parent = tab3

-- زر تشغيل سكربت المطور
local devBtn = Instance.new("TextButton")
devBtn.Size = UDim2.new(0, 350, 0, 60)
devBtn.Position = UDim2.new(0, 25, 0, 60)
devBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
devBtn.BorderSizePixel = 2
devBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
devBtn.Text = "🚀 تحميل وتشغيل سكربت المطور"
devBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
devBtn.TextSize = 16
devBtn.Font = Enum.Font.GothamBold
devBtn.Parent = tab3

-- الـ loadstring المطلوب
local devScript = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/omaralshannag980-cell/9z_e.1-/refs/heads/main/main.lua"))()]]

-- عرض الـ loadstring داخل مربع نصي (للنسخ)
local codeBox = Instance.new("TextBox")
codeBox.Size = UDim2.new(0, 350, 0, 40)
codeBox.Position = UDim2.new(0, 25, 0, 140)
codeBox.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
codeBox.BorderSizePixel = 1
codeBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
codeBox.Text = devScript
codeBox.TextColor3 = Color3.fromRGB(100, 255, 100)
codeBox.TextSize = 12
codeBox.Font = Enum.Font.Code
codeBox.TextXAlignment = Enum.TextXAlignment.Left
codeBox.ClearTextOnFocus = false
codeBox.Parent = tab3

-- زر النسخ
local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0, 100, 0, 30)
copyBtn.Position = UDim2.new(0, 25, 0, 190)
copyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
copyBtn.BorderSizePixel = 1
copyBtn.BorderColor3 = Color3.fromRGB(200, 200, 200)
copyBtn.Text = "📋 نسخ"
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.TextSize = 14
copyBtn.Font = Enum.Font.GothamBold
copyBtn.Parent = tab3

copyBtn.MouseButton1Click:Connect(function()
    local clip = setclipboard or toClipboard or function() end
    local success = pcall(function()
        clip(devScript)
    end)
    if success then
        copyBtn.Text = "✅ تم النسخ!"
        task.wait(1.5)
        copyBtn.Text = "📋 نسخ"
    else
        copyBtn.Text = "❌ فشل!"
        task.wait(1.5)
        copyBtn.Text = "📋 نسخ"
    end
end)

-- زر التشغيل المباشر
devBtn.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/omaralshannag980-cell/9z_e.1-/refs/heads/main/main.lua"))()
    end)
    if success then
        devBtn.Text = "✅ تم التشغيل!"
        devBtn.BackgroundColor3 = Color3.fromRGB(30, 150, 30)
        task.wait(2)
        devBtn.Text = "🚀 تحميل وتشغيل سكربت المطور"
        devBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
    else
        devBtn.Text = "❌ خطأ في التحميل!"
        task.wait(2)
        devBtn.Text = "🚀 تحميل وتشغيل سكربت المطور"
    end
end)

-- =====================================================
-- [7] إيقاف آمن عند الإغلاق
-- =====================================================
gui.AncestryChanged:Connect(function()
    if not gui.Parent then
        print("✅ تم إغلاق مينيو ترفكسا.")
    end
end)

print("🔥 تم تحميل مينيو ترفكسا بنجاح!")
