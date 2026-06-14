local player = game.Players.LocalPlayer
local gui = script.Parent

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 500)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -50, 1, 0)
titleText.Position = UDim2.new(0, 25, 0, 0)
titleText.Text = "🔥 DEMOz HUB [Beta] : Brookhaven RP"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.BackgroundTransparency = 1
titleText.TextSize = 18
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 2)
closeBtn.Text = "✖"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    gui.Enabled = false
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.K then
        gui.Enabled = not gui.Enabled
    end
end)

local tabsFrame = Instance.new("Frame")
tabsFrame.Size = UDim2.new(0, 100, 1, -40)
tabsFrame.Position = UDim2.new(0, 0, 0, 40)
tabsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
tabsFrame.BorderSizePixel = 0
tabsFrame.Parent = mainFrame

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -105, 1, -45)
contentFrame.Position = UDim2.new(1, -345, 0, 45)
contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 8)
contentCorner.Parent = contentFrame

local currentTab = nil

local function switchToTab(tabName)
    for _, child in pairs(contentFrame:GetChildren()) do
        if child:IsA("ScrollingFrame") then
            child.Visible = false
        end
    end
    local targetContent = contentFrame:FindFirstChild(tabName .. "Content")
    if targetContent then
        targetContent.Visible = true
        currentTab = tabName
    end
end

local function createTabButton(name, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    btn.BorderSizePixel = 0
    btn.Parent = tabsFrame
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    btn.MouseButton1Click:Connect(function()
        switchToTab(name)
        for _, b in pairs(tabsFrame:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(80, 60, 120)
    end)
    return btn
end

createTabButton("Songs & IDs", 10)
createTabButton("Anti-AFK & Lag", 65)
createTabButton("Credits", 120)

local songsContent = Instance.new("ScrollingFrame")
songsContent.Name = "Songs & IDsContent"
songsContent.Size = UDim2.new(1, -10, 1, -10)
songsContent.Position = UDim2.new(0, 5, 0, 5)
songsContent.BackgroundTransparency = 1
songsContent.CanvasSize = UDim2.new(0, 0, 0, 800)
songsContent.ScrollBarThickness = 6
songsContent.Parent = contentFrame
songsContent.Visible = false

local yOffset = 5

local section1 = Instance.new("TextLabel")
section1.Size = UDim2.new(1, -10, 0, 30)
section1.Position = UDim2.new(0, 5, 0, yOffset)
section1.Text = "🎵 Music Control"
section1.TextColor3 = Color3.fromRGB(255, 200, 100)
section1.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
section1.TextSize = 16
section1.Font = Enum.Font.GothamBold
section1.Parent = songsContent

local secCorner = Instance.new("UICorner")
secCorner.CornerRadius = UDim.new(0, 4)
secCorner.Parent = section1
yOffset = yOffset + 40

local idBox = Instance.new("TextBox")
idBox.Size = UDim2.new(1, -10, 0, 35)
idBox.Position = UDim2.new(0, 5, 0, yOffset)
idBox.PlaceholderText = "Enter Audio ID..."
idBox.Text = ""
idBox.TextColor3 = Color3.fromRGB(255, 255, 255)
idBox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
idBox.ClearTextOnFocus = false
idBox.Parent = songsContent

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 6)
boxCorner.Parent = idBox
yOffset = yOffset + 45

local playBtn = Instance.new("TextButton")
playBtn.Size = UDim2.new(1, -10, 0, 40)
playBtn.Position = UDim2.new(0, 5, 0, yOffset)
playBtn.Text = "▶ Play Custom ID"
playBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
playBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 200)
playBtn.BorderSizePixel = 0
playBtn.Parent = songsContent

local playCorner = Instance.new("UICorner")
playCorner.CornerRadius = UDim.new(0, 6)
playCorner.Parent = playBtn
yOffset = yOffset + 50

local function playAudio(audioId)
    local cleanId = tostring(audioId):match("%d+")
    if not cleanId then return end
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. cleanId
    sound.Volume = 1
    sound.Parent = game:GetService("Workspace")
    sound:Play()
    task.wait(sound.TimeLength)
    sound:Destroy()
end

playBtn.MouseButton1Click:Connect(function()
    if idBox.Text ~= "" then
        playAudio(idBox.Text)
    end
end)

local section2 = Instance.new("TextLabel")
section2.Size = UDim2.new(1, -10, 0, 30)
section2.Position = UDim2.new(0, 5, 0, yOffset)
section2.Text = "📀 Track List"
section2.TextColor3 = Color3.fromRGB(255, 200, 100)
section2.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
section2.TextSize = 16
section2.Font = Enum.Font.GothamBold
section2.Parent = songsContent

local sec2Corner = Instance.new("UICorner")
sec2Corner.CornerRadius = UDim.new(0, 4)
sec2Corner.Parent = section2
yOffset = yOffset + 40

local tracks = {
    "95877137552489", "125861618879629", "134693931986753", "107273226047360",
    "124123680327164", "73721014572224", "87920916682123", "126581313655066",
    "79193631928944", "85822106162452", "7984027399", "129963257934687",
    "93297302504653", "98313375960954", "3230475415", "71701207559451",
    "106330590409106", "71373562243752", "127666185347295", "9108676586"
}

for i, id in ipairs(tracks) do
    local trackBtn = Instance.new("TextButton")
    trackBtn.Size = UDim2.new(1, -10, 0, 35)
    trackBtn.Position = UDim2.new(0, 5, 0, yOffset)
    trackBtn.Text = "Track " .. tostring(i)
    trackBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
    trackBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    trackBtn.BorderSizePixel = 0
    trackBtn.Parent = songsContent
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 6)
    trackCorner.Parent = trackBtn
    trackBtn.MouseButton1Click:Connect(function()
        playAudio(id)
    end)
    yOffset = yOffset + 42
end

songsContent.CanvasSize = UDim2.new(0, 0, 0, yOffset + 20)

local antiContent = Instance.new("ScrollingFrame")
antiContent.Name = "Anti-AFK & LagContent"
antiContent.Size = UDim2.new(1, -10, 1, -10)
antiContent.Position = UDim2.new(0, 5, 0, 5)
antiContent.BackgroundTransparency = 1
antiContent.CanvasSize = UDim2.new(0, 0, 0, 400)
antiContent.ScrollBarThickness = 6
antiContent.Parent = contentFrame
antiContent.Visible = false

local yOffset2 = 5

local antiSection = Instance.new("TextLabel")
antiSection.Size = UDim2.new(1, -10, 0, 30)
antiSection.Position = UDim2.new(0, 5, 0, yOffset2)
antiSection.Text = "🛡️ Anti-AFK"
antiSection.TextColor3 = Color3.fromRGB(255, 200, 100)
antiSection.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
antiSection.TextSize = 16
antiSection.Font = Enum.Font.GothamBold
antiSection.Parent = antiContent

local antiSecCorner = Instance.new("UICorner")
antiSecCorner.CornerRadius = UDim.new(0, 4)
antiSecCorner.Parent = antiSection
yOffset2 = yOffset2 + 40

local antiAFKEnabled = false
local antiAFKBtn = Instance.new("TextButton")
antiAFKBtn.Size = UDim2.new(1, -10, 0, 40)
antiAFKBtn.Position = UDim2.new(0, 5, 0, yOffset2)
antiAFKBtn.Text = "Enable Anti-AFK"
antiAFKBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
antiAFKBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 100)
antiAFKBtn.BorderSizePixel = 0
antiAFKBtn.Parent = antiContent

local antiBtnCorner = Instance.new("UICorner")
antiBtnCorner.CornerRadius = UDim.new(0, 6)
antiBtnCorner.Parent = antiAFKBtn
yOffset2 = yOffset2 + 50

local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if antiAFKEnabled then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

antiAFKBtn.MouseButton1Click:Connect(function()
    antiAFKEnabled = not antiAFKEnabled
    if antiAFKEnabled then
        antiAFKBtn.Text = "Disable Anti-AFK"
        antiAFKBtn.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
    else
        antiAFKBtn.Text = "Enable Anti-AFK"
        antiAFKBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 100)
    end
end)

local lagSection = Instance.new("TextLabel")
lagSection.Size = UDim2.new(1, -10, 0, 30)
lagSection.Position = UDim2.new(0, 5, 0, yOffset2)
lagSection.Text = "⚡ Anti-Lag"
lagSection.TextColor3 = Color3.fromRGB(255, 200, 100)
lagSection.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
lagSection.TextSize = 16
lagSection.Font = Enum.Font.GothamBold
lagSection.Parent = antiContent

local lagSecCorner = Instance.new("UICorner")
lagSecCorner.CornerRadius = UDim.new(0, 4)
lagSecCorner.Parent = lagSection
yOffset2 = yOffset2 + 40

local cleanBtn = Instance.new("TextButton")
cleanBtn.Size = UDim2.new(1, -10, 0, 40)
cleanBtn.Position = UDim2.new(0, 5, 0, yOffset2)
cleanBtn.Text = "Clean Effects"
cleanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
cleanBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
cleanBtn.BorderSizePixel = 0
cleanBtn.Parent = antiContent

local cleanCorner = Instance.new("UICorner")
cleanCorner.CornerRadius = UDim.new(0, 6)
cleanCorner.Parent = cleanBtn
yOffset2 = yOffset2 + 50

cleanBtn.MouseButton1Click:Connect(function()
    for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            obj.Enabled = false
        elseif obj:IsA("Decal") then
            obj:Destroy()
        end
    end
end)

local potatoBtn = Instance.new("TextButton")
potatoBtn.Size = UDim2.new(1, -10, 0, 40)
potatoBtn.Position = UDim2.new(0, 5, 0, yOffset2)
potatoBtn.Text = "Potato Mode"
potatoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
potatoBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 50)
potatoBtn.BorderSizePixel = 0
potatoBtn.Parent = antiContent

local potatoCorner = Instance.new("UICorner")
potatoCorner.CornerRadius = UDim.new(0, 6)
potatoCorner.Parent = potatoBtn
yOffset2 = yOffset2 + 50

potatoBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("MeshPart") then
            v.TextureID = ""
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
end)

antiContent.CanvasSize = UDim2.new(0, 0, 0, yOffset2 + 20)

local creditsContent = Instance.new("ScrollingFrame")
creditsContent.Name = "CreditsContent"
creditsContent.Size = UDim2.new(1, -10, 1, -10)
creditsContent.Position = UDim2.new(0, 5, 0, 5)
creditsContent.BackgroundTransparency = 1
creditsContent.CanvasSize = UDim2.new(0, 0, 0, 250)
creditsContent.ScrollBarThickness = 6
creditsContent.Parent = contentFrame
creditsContent.Visible = false

local yOffset3 = 5

local creditTitle = Instance.new("TextLabel")
creditTitle.Size = UDim2.new(1, -10, 0, 40)
creditTitle.Position = UDim2.new(0, 5, 0, yOffset3)
creditTitle.Text = "📜 Information"
creditTitle.TextColor3 = Color3.fromRGB(255, 200, 100)
creditTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
creditTitle.TextSize = 16
creditTitle.Font = Enum.Font.GothamBold
creditTitle.Parent = creditsContent

local creditCorner = Instance.new("UICorner")
creditCorner.CornerRadius = UDim.new(0, 4)
creditCorner.Parent = creditTitle
yOffset3 = yOffset3 + 50

local scriptLabel = Instance.new("TextLabel")
scriptLabel.Size = UDim2.new(1, -10, 0, 35)
scriptLabel.Position = UDim2.new(0, 5, 0, yOffset3)
scriptLabel.Text = "Script: DEMOz HUB"
scriptLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
scriptLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
scriptLabel.TextSize = 14
scriptLabel.Parent = creditsContent

local scriptCorner = Instance.new("UICorner")
scriptCorner.CornerRadius = UDim.new(0, 6)
scriptCorner.Parent = scriptLabel
yOffset3 = yOffset3 + 42

local devLabel = Instance.new("TextLabel")
devLabel.Size = UDim2.new(1, -10, 0, 35)
devLabel.Position = UDim2.new(0, 5, 0, yOffset3)
devLabel.Text = "Developer: 7zn"
devLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
devLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
devLabel.TextSize = 14
devLabel.Parent = creditsContent

local devCorner = Instance.new("UICorner")
devCorner.CornerRadius = UDim.new(0, 6)
devCorner.Parent = devLabel
yOffset3 = yOffset3 + 42

local tiktokBtn = Instance.new("TextButton")
tiktokBtn.Size = UDim2.new(1, -10, 0, 40)
tiktokBtn.Position = UDim2.new(0, 5, 0, yOffset3)
tiktokBtn.Text = "TikTok: 9z_e.1 (Click to Copy)"
tiktokBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tiktokBtn.BackgroundColor3 = Color3.fromRGB(80, 60, 120)
tiktokBtn.BorderSizePixel = 0
tiktokBtn.Parent = creditsContent

local tiktokCorner = Instance.new("UICorner")
tiktokCorner.CornerRadius = UDim.new(0, 6)
tiktokCorner.Parent = tiktokBtn

tiktokBtn.MouseButton1Click:Connect(function()
    setclipboard("9z_e.1")
end)

creditsContent.CanvasSize = UDim2.new(0, 0, 0, yOffset3 + 60)

switchToTab("Songs & IDs")
