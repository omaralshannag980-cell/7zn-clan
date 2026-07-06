-- =====================================================
-- 7ZN TEAM | 9z_e.1  (بصمة المطور)
-- القائمة الجانبية + نظام استهداف + حساب المطور
-- =====================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VR7_GUI_9z_e_1"
screenGui.Parent = game:GetService("CoreGui")

-- =====================================================
-- الإطار الرئيسي (على اليسار)
-- =====================================================
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 680)
mainFrame.Position = UDim2.new(0, 10, 0.5, -340)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- العنوان + بصمة المطور
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "VR7 TEAM | 9z_e.1"
title.TextColor3 = Color3.fromRGB(255, 200, 50)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- =====================================================
-- 1. أزرار القائمة الرئيسية (مع إضافة زر "المطور")
-- =====================================================
local buttons = {"Home", "Game", "Character", "Target", "Anims", "Misc", "News", "Dev"}
local buttonY = 50
local buttonHeight = 32

for _, btnName in ipairs(buttons) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.85, 0, 0, buttonHeight)
    btn.Position = UDim2.new(0.075, 0, 0, buttonY)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    btn.BackgroundTransparency = 0.7
    btn.BorderSizePixel = 0
    btn.Text = btnName
    btn.TextColor3 = Color3.fromRGB(220, 220, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Name = btnName
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    end)
    
    btn.Parent = mainFrame
    buttonY = buttonY + buttonHeight + 6
end

-- =====================================================
-- 2. قسم الاستهداف (Target)
-- =====================================================
local targetFrame = Instance.new("Frame")
targetFrame.Size = UDim2.new(0.9, 0, 0, 160)
targetFrame.Position = UDim2.new(0.05, 0, 0, buttonY + 10) -- 50 + (8*38) + 10 = 364
targetFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
targetFrame.BackgroundTransparency = 0.3
targetFrame.BorderSizePixel = 0
targetFrame.Visible = false
targetFrame.Parent = mainFrame

local targetCorner = Instance.new("UICorner")
targetCorner.CornerRadius = UDim.new(0, 8)
targetCorner.Parent = targetFrame

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(0.9, 0, 0, 30)
searchBox.Position = UDim2.new(0.05, 0, 0, 10)
searchBox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
searchBox.BorderSizePixel = 0
searchBox.PlaceholderText = "أكتب أول 3 حروف من اسم اللاعب"
searchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 180)
searchBox.Text = ""
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.TextScaled = true
searchBox.Font = Enum.Font.Gotham
searchBox.Parent = targetFrame

local searchBtn = Instance.new("TextButton")
searchBtn.Size = UDim2.new(0.3, 0, 0, 28)
searchBtn.Position = UDim2.new(0.35, 0, 0, 48)
searchBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
searchBtn.BorderSizePixel = 0
searchBtn.Text = "بحث"
searchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBtn.TextScaled = true
searchBtn.Font = Enum.Font.GothamBold
searchBtn.Parent = targetFrame

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 6)
searchCorner.Parent = searchBtn

local resultList = Instance.new("ScrollingFrame")
resultList.Size = UDim2.new(0.9, 0, 0, 50)
resultList.Position = UDim2.new(0.05, 0, 0, 85)
resultList.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
resultList.BorderSizePixel = 0
resultList.ScrollBarThickness = 4
resultList.Visible = false
resultList.Parent = targetFrame

local selectedTarget = nil

local function applyAllAbilities(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    print("تم تفعيل جميع المزايا على: " .. targetPlayer.Name)
    -- هنا حط كود المزايا (فلق، بانق، يمص، إلخ) حق السكربت الأصلي
end

local function searchPlayers(query)
    query = query:lower()
    local matches = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Name:lower():sub(1, 3) == query then
            table.insert(matches, player)
        end
    end
    return matches
end

searchBtn.MouseButton1Click:Connect(function()
    local query = searchBox.Text
    if #query < 3 then print("أدخل 3 حروف على الأقل") return end
    local matches = searchPlayers(query)
    if #matches == 0 then
        print("مافي لاعبين بهذا الاسم")
        resultList.Visible = false
        return
    end
    resultList.Visible = true
    for _, child in ipairs(resultList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    local yPos = 0
    for _, player in ipairs(matches) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 25)
        btn.Position = UDim2.new(0, 5, 0, yPos)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        btn.BorderSizePixel = 0
        btn.Text = player.Name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextScaled = true
        btn.Font = Enum.Font.Gotham
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 4)
        btnCorner.Parent = btn
        btn.MouseButton1Click:Connect(function()
            selectedTarget = player
            resultList.Visible = false
            searchBox.Text = "✓ " .. player.Name
            applyAllAbilities(player)
        end)
        btn.Parent = resultList
        yPos = yPos + 28
    end
    resultList.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end)

local targetButton = mainFrame:FindFirstChild("Target")
if targetButton then
    targetButton.MouseButton1Click:Connect(function()
        targetFrame.Visible = not targetFrame.Visible
    end)
end

-- =====================================================
-- 3. زر Remote Spy
-- =====================================================
local remoteButton = Instance.new("TextButton")
remoteButton.Size = UDim2.new(0.85, 0, 0, 32)
remoteButton.Position = UDim2.new(0.075, 0, 0, buttonY + 180) -- 364 + 180 = 544
remoteButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
remoteButton.BorderSizePixel = 0
remoteButton.Text = "🌐 Remote Spy"
remoteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
remoteButton.TextScaled = true
remoteButton.Font = Enum.Font.GothamBold
remoteButton.Parent = mainFrame

local remoteCorner = Instance.new("UICorner")
remoteCorner.CornerRadius = UDim.new(0, 8)
remoteCorner.Parent = remoteButton

remoteButton.MouseButton1Click:Connect(function()
    print("تم تفعيل Remote Spy على جميع المابات")
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            obj.OnServerEvent:Connect(function(player, ...)
                print("Remote من:", player.Name, "البيانات:", ...)
            end)
        end
    end
end)

-- =====================================================
-- 4. قائمة "سكربتات" (تحميل VR7)
-- =====================================================
local scriptsLabel = Instance.new("TextLabel")
scriptsLabel.Size = UDim2.new(0.85, 0, 0, 25)
scriptsLabel.Position = UDim2.new(0.075, 0, 0, buttonY + 225) -- 364 + 225 = 589
scriptsLabel.BackgroundTransparency = 1
scriptsLabel.Text = "⏬ سكربتات"
scriptsLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
scriptsLabel.TextScaled = true
scriptsLabel.Font = Enum.Font.GothamBold
scriptsLabel.Parent = mainFrame

local loadVr7 = Instance.new("TextButton")
loadVr7.Size = UDim2.new(0.85, 0, 0, 32)
loadVr7.Position = UDim2.new(0.075, 0, 0, buttonY + 258) -- 364 + 258 = 622
loadVr7.BackgroundColor3 = Color3.fromRGB(30, 150, 80)
loadVr7.BorderSizePixel = 0
loadVr7.Text = "▶ تحميل VR7"
loadVr7.TextColor3 = Color3.fromRGB(255, 255, 255)
loadVr7.TextScaled = true
loadVr7.Font = Enum.Font.GothamBold
loadVr7.Parent = mainFrame

local loadCorner = Instance.new("UICorner")
loadCorner.CornerRadius = UDim.new(0, 8)
loadCorner.Parent = loadVr7

loadVr7.MouseButton1Click:Connect(function()
    print("جاري تحميل سكربت VR7 (بواسطة 9z_e.1)...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/omaralshannag980-cell/9z_e.1-/refs/heads/main/main.lua"))()
end)

-- =====================================================
-- 5. قائمة "حساب المطور" (نافذة منبثقة)
-- =====================================================
local devButton = mainFrame:FindFirstChild("Dev")
if devButton then
    devButton.MouseButton1Click:Connect(function()
        devPopup.Visible = not devPopup.Visible
    end)
end

-- إنشاء النافذة المنبثقة الخاصة بالمطور
local devPopup = Instance.new("Frame")
devPopup.Size = UDim2.new(0, 220, 0, 140)
devPopup.Position = UDim2.new(0.5, -110, 0.5, -70)
devPopup.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
devPopup.BackgroundTransparency = 0.1
devPopup.BorderSizePixel = 0
devPopup.Visible = false
devPopup.Parent = screenGui

local popupCorner = Instance.new("UICorner")
popupCorner.CornerRadius = UDim.new(0, 14)
popupCorner.Parent = devPopup

-- خلفية زجاجية (اختياري)
local glass = Instance.new("Frame")
glass.Size = UDim2.new(1, 0, 1, 0)
glass.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
glass.BackgroundTransparency = 0.5
glass.BorderSizePixel = 0
glass.Parent = devPopup

-- نص "by ترفكسا"
local byLabel = Instance.new("TextLabel")
byLabel.Size = UDim2.new(1, 0, 0, 40)
byLabel.Position = UDim2.new(0, 0, 0, 15)
byLabel.BackgroundTransparency = 1
byLabel.Text = "by ترفكسا"
byLabel.TextColor3 = Color3.fromRGB(200, 180, 255)
byLabel.TextScaled = true
byLabel.Font = Enum.Font.GothamBold
byLabel.Parent = devPopup

-- اسم المطور "9z_e.1"
local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, 0, 0, 60)
nameLabel.Position = UDim2.new(0, 0, 0, 55)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = "9z_e.1"
nameLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- اللون الذهبي
nameLabel.TextScaled = true
nameLabel.Font = Enum.Font.GothamBlack
nameLabel.Parent = devPopup

-- زر إغلاق النافذة
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = devPopup

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    devPopup.Visible = false
end)

-- =====================================================
-- (اختياري) تحريك القائمة بالماوس
-- =====================================================
local dragging = false
local dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
