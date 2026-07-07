--[[
    واجهة VR7 TEAM - The Mercy Script (النسخة المطورة)
    تم الإضافة: تبويب الاستهداف، تبويب السكربتات، تبويب المضادات
--]]

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "7ZN_GUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- === دالة مساعدة لإنشاء العناصر ===
local function new(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        pcall(function() obj[k] = v end)
    end
    return obj
end

local function makeCorner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = radius or UDim.new(0, 8)
    c.Parent = obj
end

-- === الإطار الرئيسي (قابل للسحب) ===
local mainFrame = new("Frame", {
    Size = UDim2.new(0, 600, 0, 480),
    Position = UDim2.new(0.5, -300, 0.5, -240),
    BackgroundColor3 = Color3.fromRGB(20, 20, 26),
    BorderSizePixel = 0,
    Parent = gui,
    Active = true,
    Draggable = true,
})
makeCorner(mainFrame, UDim.new(0, 12))

-- === شريط العنوان ===
local titleBar = new("Frame", {
    Size = UDim2.new(1, 0, 0, 45),
    BackgroundColor3 = Color3.fromRGB(30, 30, 38),
    Parent = mainFrame,
})
makeCorner(titleBar, UDim.new(0, 12))

local titleText = new("TextLabel", {
    Text = "7ZN TEAM: The Mercy Script",
    Size = UDim2.new(1, -20, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(0, 180, 255),
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    Parent = titleBar,
})

local targetBadge = new("TextLabel", {
    Text = "@target...",
    Size = UDim2.new(0, 80, 1, 0),
    Position = UDim2.new(1, -90, 0, 0),
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Right,
    Font = Enum.Font.Gotham,
    Parent = titleBar,
})

-- === شريط التبويبات (Tabs) ===
local tabBar = new("Frame", {
    Size = UDim2.new(1, -20, 0, 35),
    Position = UDim2.new(0, 10, 0, 55),
    BackgroundTransparency = 1,
    Parent = mainFrame,
})

local tabNames = {"Home", "Game", "Character", "Target", "Anims", "Misc", "News", "Scripts", "Antis"}
local tabs = {}
local currentTab = nil

-- حاوية المحتوى الرئيسي
local contentHolder = new("Frame", {
    Size = UDim2.new(1, -20, 1, -115),
    Position = UDim2.new(0, 10, 0, 95),
    BackgroundTransparency = 1,
    Parent = mainFrame,
})

-- دالة إنشاء تبويب
local function createTab(name)
    local btn = new("TextButton", {
        Text = name,
        Size = UDim2.new(0, 55, 1, 0),
        BackgroundColor3 = Color3.fromRGB(30, 30, 38),
        TextColor3 = Color3.fromRGB(180, 180, 180),
        TextSize = 12,
        Font = Enum.Font.GothamSemibold,
        BorderSizePixel = 0,
        Parent = tabBar,
    })
    makeCorner(btn, UDim.new(0, 6))

    local page = new("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = false,
        Parent = contentHolder,
    })

    btn.MouseButton1Click:Connect(function()
        if currentTab then currentTab.Visible = false end
        page.Visible = true
        currentTab = page
        for _, child in pairs(tabBar:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
                child.TextColor3 = Color3.fromRGB(180, 180, 180)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    tabs[name] = page
    return page
end

-- إنشاء كل التبويبات
local homeTab = createTab("Home")
local gameTab = createTab("Game")
local charTab = createTab("Character")
local targetTab = createTab("Target")
local animsTab = createTab("Anims")
local miscTab = createTab("Misc")
local newsTab = createTab("News")
local scriptsTab = createTab("Scripts")
local antisTab = createTab("Antis")

-- تفعيل التبويب الأول افتراضياً
tabs["Home"].Visible = true
currentTab = tabs["Home"]
for _, child in pairs(tabBar:GetChildren()) do
    if child:IsA("TextButton") and child.Text == "Home" then
        child.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
        child.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

-- === ===== تبويب HOME (القائمة الرئيسية) ===== ===
-- قسم معلومات المستخدم
local infoFrame = new("Frame", {
    Size = UDim2.new(1, 0, 0, 80),
    BackgroundColor3 = Color3.fromRGB(25, 25, 32),
    Parent = tabs["Home"],
})
makeCorner(infoFrame, UDim.new(0, 8))

local userLabel = new("TextLabel", {
    Text = "UserID: " .. player.UserId,
    Size = UDim2.new(0.5, -10, 0.5, 0),
    Position = UDim2.new(0, 10, 0, 5),
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.Gotham,
    Parent = infoFrame,
})

local displayLabel = new("TextLabel", {
    Text = "Display: " .. (player.DisplayName or "None"),
    Size = UDim2.new(0.5, -10, 0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 5),
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.Gotham,
    Parent = infoFrame,
})

local joinedLabel = new("TextLabel", {
    Text = "Joined: " .. os.date("%Y-%m-%d", player.AccountAge),
    Size = UDim2.new(1, -10, 0.5, 0),
    Position = UDim2.new(0, 10, 0, 35),
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.Gotham,
    Parent = infoFrame,
})

-- === أزرار الإجراءات (فلق، مشاهدة، بانق عكسي، إلخ) ===
local actionsFrame = new("Frame", {
    Size = UDim2.new(1, 0, 1, -95),
    Position = UDim2.new(0, 0, 0, 90),
    BackgroundTransparency = 1,
    Parent = tabs["Home"],
})

local actionNames = {"فلق", "مشاهدة", "بانق عكسي", "بانق", "سوها عليه", "يمص", "ضرب مؤخرة", "تمص"}
local buttonWidth = 110
local buttonHeight = 40
local spacing = 10
local columns = 3

for i, name in ipairs(actionNames) do
    local row = math.floor((i-1) / columns)
    local col = (i-1) % columns
    local x = col * (buttonWidth + spacing)
    local y = row * (buttonHeight + spacing)

    local btn = new("TextButton", {
        Text = name,
        Size = UDim2.new(0, buttonWidth, 0, buttonHeight),
        Position = UDim2.new(0, x, 0, y),
        BackgroundColor3 = Color3.fromRGB(35, 35, 44),
        TextColor3 = Color3.fromRGB(220, 220, 220),
        TextSize = 14,
        Font = Enum.Font.GothamSemibold,
        BorderSizePixel = 0,
        Parent = actionsFrame,
    })
    makeCorner(btn, UDim.new(0, 6))

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 44)
    end)

    btn.MouseButton1Click:Connect(function()
        print("تم تنفيذ الأمر: " .. name)
    end)
end

-- === ===== تبويب TARGET (الاستهداف) ===== ===
local targetMainFrame = new("Frame", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Parent = tabs["Target"],
})

-- حقل البحث
local searchBox = new("TextBox", {
    Size = UDim2.new(1, -20, 0, 35),
    Position = UDim2.new(0, 10, 0, 10),
    PlaceholderText = "ابحث عن لاعب...",
    Text = "",
    BackgroundColor3 = Color3.fromRGB(30, 30, 38),
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16,
    Font = Enum.Font.Gotham,
    ClearTextOnFocus = false,
    Parent = targetMainFrame,
})
makeCorner(searchBox, UDim.new(0, 8))

-- قائمة اللاعبين
local playerListFrame = new("ScrollingFrame", {
    Size = UDim2.new(1, -20, 1, -70),
    Position = UDim2.new(0, 10, 0, 55),
    BackgroundColor3 = Color3.fromRGB(25, 25, 32),
    BorderSizePixel = 0,
    Parent = targetMainFrame,
})
makeCorner(playerListFrame, UDim.new(0, 8))
playerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

local playerButtons = {}
local function updatePlayerList(searchText)
    for _, btn in pairs(playerButtons) do
        btn:Destroy()
    end
    playerButtons = {}
    local players = game:GetService("Players"):GetPlayers()
    local yPos = 5
    for _, p in pairs(players) do
        if p ~= player and string.find(string.lower(p.Name), string.lower(searchText or "")) then
            local btn = new("TextButton", {
                Text = p.Name,
                Size = UDim2.new(1, -10, 0, 30),
                Position = UDim2.new(0, 5, 0, yPos),
                BackgroundColor3 = Color3.fromRGB(35, 35, 44),
                TextColor3 = Color3.fromRGB(220, 220, 220),
                TextSize = 14,
                Font = Enum.Font.Gotham,
                BorderSizePixel = 0,
                Parent = playerListFrame,
            })
            makeCorner(btn, UDim.new(0, 6))
            btn.MouseButton1Click:Connect(function()
                print("تم استهداف: " .. p.Name)
                -- هنا ضع كود الاستهداف
            end)
            table.insert(playerButtons, btn)
            yPos = yPos + 35
        end
    end
    playerListFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updatePlayerList(searchBox.Text)
end)
updatePlayerList("")

-- === ===== تبويب SCRIPTS (السكربتات) ===== ===
local scriptsFrame = new("Frame", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Parent = tabs["Scripts"],
})

local scriptButton = new("TextButton", {
    Text = "سكربت المطور ترفكسا",
    Size = UDim2.new(1, -20, 0, 50),
    Position = UDim2.new(0, 10, 0, 10),
    BackgroundColor3 = Color3.fromRGB(35, 35, 44),
    TextColor3 = Color3.fromRGB(220, 220, 220),
    TextSize = 16,
    Font = Enum.Font.GothamSemibold,
    BorderSizePixel = 0,
    Parent = scriptsFrame,
})
makeCorner(scriptButton, UDim.new(0, 8))
scriptButton.MouseButton1Click:Connect(function()
    print("جاري تحميل سكربت المطور ترفكسا...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/omaralshannag980-cell/9z_e.1-/refs/heads/main/main.lua"))()
end)

-- === ===== تبويب ANTIS (المضادات) ===== ===
local antisFrame = new("Frame", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Parent = tabs["Antis"],
})

local antis = {
    {name = "Anti Ban", default = false},
    {name = "Anti Kick", default = false},
    {name = "Anti Freeze", default = false},
    {name = "Anti TP", default = false},
    {name = "Anti Exploit", default = false},
    {name = "Anti Crash", default = false},
}

local function createAntiToggle(parent, data, index)
    local frame = new("Frame", {
        Size = UDim2.new(1, -20, 0, 40),
        Position = UDim2.new(0, 10, 0, 10 + (index-1) * 45),
        BackgroundColor3 = Color3.fromRGB(30, 30, 38),
        Parent = parent,
    })
    makeCorner(frame, UDim.new(0, 8))

    local label = new("TextLabel", {
        Text = data.name,
        Size = UDim2.new(0.7, -10, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(220, 220, 220),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.Gotham,
        Parent = frame,
    })

    local toggleBtn = new("TextButton", {
        Text = data.default and "ON" or "OFF",
        Size = UDim2.new(0, 60, 0, 30),
        Position = UDim2.new(1, -70, 0, 5),
        BackgroundColor3 = data.default and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(180, 0, 0),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        Parent = frame,
    })
    makeCorner(toggleBtn, UDim.new(0, 6))

    local isOn = data.default
    toggleBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        toggleBtn.Text = isOn and "ON" or "OFF"
        toggleBtn.BackgroundColor3 = isOn and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(180, 0, 0)
        print(data.name .. " تم " .. (isOn and "تفعيل" or "تعطيل"))
    end)
end

for i, anti in ipairs(antis) do
    createAntiToggle(antisFrame, anti, i)
end

-- === تبويبات أخرى (Game, Character, Anims, Misc, News) ===
local function fillTab(tab, tabName)
    local label = new("TextLabel", {
        Text = "تبويب " .. tabName .. " - أضف محتواك هنا",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(150, 150, 150),
        TextSize = 18,
        Font = Enum.Font.Gotham,
        Parent = tab,
    })
end
fillTab(tabs["Game"], "Game")
fillTab(tabs["Character"], "Character")
fillTab(tabs["Anims"], "Anims")
fillTab(tabs["Misc"], "Misc")
fillTab(tabs["News"], "News")

-- === زر إغلاق الواجهة ===
local closeBtn = new("TextButton", {
    Text = "✕",
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(1, -40, 0, 7),
    BackgroundColor3 = Color3.fromRGB(60, 20, 20),
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    BorderSizePixel = 0,
    Parent = titleBar,
})
makeCorner(closeBtn, UDim.new(0, 6))
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
