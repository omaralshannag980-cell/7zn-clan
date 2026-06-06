-- ط§ظ„ط³ظ„ط§ظ… ط¹ظ„ظٹظƒظ… ظ„ط§ طھظ†ط³ظ‰ ط³ظƒط±ط¨طھظƒ

-- 1. طھط­ظ…ظٹظ„ ظ…ظƒطھط¨ط© RedzLib V4
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/techwearhubofc/Redz/main/Source.lua"))()

-- 2. ط¥ظ†ط´ط§ط، ط§ظ„ظ†ط§ظپط°ط© ط§ظ„ط±ط¦ظٹط³ظٹط© ط¨ط§ظ„ظˆط§ط¬ظ‡ط© ط§ظ„ط¬ط¯ظٹط¯ط© ط§ظ„ظ…ط·ظ„ظˆط¨ط© (by: 7zn)
local Window = redzlib:MakeWindow({
  Title = "DEMOz HUB [ Beta ] : Brookhaven ًںڈ،RP",
  SubTitle = "by : 7zn",
  LoadText = "Demoz Hub Troll version",
  Flags = "Demoz Hub | Example.lua"
})

-- 3. ط¥ط¶ط§ظپط© ط²ط± ط§ظ„طھطµط؛ظٹط± ظ„ظ„ظˆط§ط¬ظ‡ط©
Window:AddMinimizeButton({
  Image = "rbxassetid://130688450838044",
  UICorner = {true, CornerRadius = UDim.new(0.5, 0)},
  UIStroke = {false, {}}
})

-- طھظ†ط¨ظٹظ‡ طھط±ط­ظٹط¨ظٹ ط¹ظ†ط¯ ط§ظ„طھط´ط؛ظٹظ„
redzlib:Notification("DEMOz HUB", "طھظ… طھط´ط؛ظٹظ„ ط§ظ„ط³ظƒط±ط¨طھ ط¨ظ†ط¬ط§ط­ ط¨ط§ظ„ظˆط§ط¬ظ‡ط© ط§ظ„ط¬ط¯ظٹط¯ط©!\nby: 7zn", "success", 5)

---------------------------------------------------------------------
-- [ ط§ظ„طھط±ظƒظٹط² ط¹ظ„ظ‰ ط¥ظ†ط´ط§ط، ط§ظ„طھط¨ظˆظٹط¨ط§طھ ظˆط§ظ„ظ€ Tabs ط¨ط§ظ„طµظٹط؛ط© ط§ظ„ظ…طھظˆط§ظپظ‚ط© ]
---------------------------------------------------------------------
local SongsTab = Window:MakeTab({"Songs", "music"})
local AntiTab = Window:MakeTab({"Anti", "shield"})
local CreditsTab = Window:MakeTab({"Credits", "user"})
---------------------------------------------------------------------
-- [1] ظ†ط¸ط§ظ… ط§ظ„طµظˆطھظٹط§طھ ظˆط§ظ„ط£ط؛ط§ظ†ظٹ ط§ظ„ظ…ط­ط³ظ† (ط¯ط§ط®ظ„ SongsTab)
---------------------------------------------------------------------
local LocalPlayer = game:GetService("Players").LocalPlayer

local function playForEveryone(audioId)
    local cleanId = tostring(audioId):match("%d+")
    if not cleanId then
        redzlib:Notification("طھظ†ط¨ظٹظ‡", "ط§ظ„ظ€ ID ط§ظ„ظ…ط¯ط®ظ„ ط؛ظٹط± طµط§ظ„ط­!", "error", 3)
        return
    end

    -- ظ…ط­ط§ظˆظ„ط© ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط£ط¯ط§ط© ط§ظ„طµظˆطھ ظپظٹ ط§ظ„ط­ظ‚ظٹط¨ط© ط£ظˆ ط§ظ„ط´ط®طµظٹط©
    local radio = LocalPlayer.Backpack:FindFirstChild("Radio") or LocalPlayer.Character:FindFirstChild("Radio") 
               or LocalPlayer.Backpack:FindFirstChild("Boombox") or LocalPlayer.Character:FindFirstChild("Boombox") or LocalPlayer.Backpack:FindFirstChild("Music")
    
    if radio then
        -- ط§ظ„ط¨ط­ط« ط¹ظ† ط§ظ„ط±ظٹظ…ظˆطھ ط§ظ„ظ…ط³ط¤ظˆظ„ ط¹ظ† ط§ظ„ط¨ط« ظ„ظ„ط¬ظ…ظٹط¹
        local remote = radio:FindFirstChild("Remote") or radio:FindFirstChild("Server") or radio:FindFirstChildOfClass("RemoteEvent")
        if remote and remote:IsA("RemoteEvent") then
            remote:FireServer(cleanId)
            redzlib:Notification("DEMOz HUB", "طھظ… طھط´ط؛ظٹظ„ ط§ظ„طµظˆطھ ط¹ط¨ط± ط§ظ„ط±ط§ط¯ظٹظˆ ظ„ظƒظٹ ظٹط³ظ…ط¹ظ‡ ط§ظ„ط¬ظ…ظٹط¹!", "success", 3)
        else
            -- ط§ظ„ط¨ط­ط« ط¹ظ† ط±ظٹظ…ظˆطھ Brookhaven ط§ظ„ط´ظ‡ظٹط± ظ„ظ„ظ…ظˆط³ظٹظ‚ظ‰
            local bkrMusic = game:GetService("ReplicatedStorage"):FindFirstChild("MusicRemote") or game:GetService("ReplicatedStorage"):FindFirstChild("SoundEvent")
            if bkrMusic and bkrMusic:IsA("RemoteEvent") then
                bkrMusic:FireServer(cleanId)
                redzlib:Notification("DEMOz HUB", "طھظ… طھط´ط؛ظٹظ„ ط§ظ„طµظˆطھ ظ„ظ„ط¬ظ…ظٹط¹ ط¹ط¨ط± ظ†ط¸ط§ظ… ط§ظ„ط®ط±ظٹط·ط©!", "success", 3)
            else
                redzlib:Notification("طھظ†ط¨ظٹظ‡", "طھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط§ظ„ط£ط¯ط§ط© ظˆظ„ظƒظ† ظ„ظ… ظٹطھظ… ط§ظ„طھط¹ط±ظپ ط¹ظ„ظ‰ ظ†ط¸ط§ظ… ط§ظ„ط¨ط« ط§ظ„ط¹ط§ظ….", "warning", 3)
            end
        end
    else
        -- طھط´ط؛ظٹظ„ ظ…ط­ظ„ظٹ ظƒط®ظٹط§ط± ط§ط­طھظٹط§ط·ظٹ ط¥ط°ط§ ظ„ظ… ظٹظ…طھظ„ظƒ ط§ظ„ظ„ط§ط¹ط¨ ط±ط§ط¯ظٹظˆ
        local localSound = game:GetService("Workspace"):FindFirstChild("TaxGGLocalSound")
        if not localSound then
            localSound = Instance.new("Sound", game:GetService("Workspace"))
            localSound.Name = "TaxGGLocalSound"
        end
        localSound.SoundId = "rbxassetid://" .. cleanId
        localSound.Volume = 2
        localSound:Play()
        redzlib:Notification("DEMOz HUB", "طھظ†ط¨ظٹظ‡: طھظ… ط§ظ„طھط´ط؛ظٹظ„ ظ…ط­ظ„ظٹط§ظ‹ (ط£ظ†طھ ظپظ‚ط· ظ…ظ† ظٹط³ظ…ط¹) ظ„ط¹ط¯ظ… طھظˆظپط± ط±ط§ط¯ظٹظˆ ط¨ظٹط¯ظƒ.", "warning", 4)
    end
end

SongsTab:AddSection({"ط§ظ„طھط­ظƒظ… ط¨ط§ظ„طھط´ط؛ظٹظ„ (by 7zn)"})

local customTrackID = ""
SongsTab:AddTextBox({"ط¶ط¹ ID ظ…ط®طµطµ ظ‡ظ†ط§", "", function(value)
    customTrackID = value
end})

SongsTab:AddButton({"طھط´ط؛ظٹظ„ ط§ظ„ظ€ ID ط§ظ„ظٹط¯ظˆظٹ ًںŒگ", function()
    if customTrackID ~= "" then
        playForEveryone(customTrackID)
    else
        redzlib:Notification("طھظ†ط¨ظٹظ‡", "ط§ظ„ط±ط¬ط§ط، ظƒطھط§ط¨ط© ID ط£ظˆظ„ط§ظ‹", "error", 3)
    end
end})

SongsTab:AddSection({"ظ‚ط§ط¦ظ…ط© ط§ظ„ط£ظƒظˆط§ط¯ ط§ظ„ط®ط§طµط© ط¨ظƒ (طھط¨ط§ظ† ظ„ظ„ظ†ط§ط³)"})

local userTracks = {
    "95877137552489", "125861618879629", "134693931986753", "107273226047360", 
    "124123680327164", "73721014572224", "87920916682123", "126581313655066", 
    "12412368037164", "79193631928944", "85822106162452", "7984027399", 
    "129963257934687", "93297302504653", "98313375960954", "3230475415", 
    "71701207559451", "106330590409106", "71373562243752", "127666185347295", 
    "9108676586"
}

for index, id in ipairs(userTracks) do
    SongsTab:AddButton({"ًںژµ طھط´ط؛ظٹظ„ ط§ظ„ظƒظˆط¯ ط±ظ‚ظ… [" .. tostring(index) .. "]", function()
        playForEveryone(id)
    end})
end

---------------------------------------------------------------------
-- [2] ظ‚ط³ظ… ط§ظ„ظ…ط¶ط§ط¯ط§طھ ظˆط§ظ„ظ€ Anti (ط¯ط§ط®ظ„ AntiTab)
---------------------------------------------------------------------
AntiTab:AddSection({"ط­ظ…ط§ظٹط© ط§ظ„ظ„ط§ط¹ط¨ (Anti-AFK)"})

local antiAFKEnabled = false
AntiTab:AddToggle({"طھظپط¹ظٹظ„ ظ…ط¶ط§ط¯ ط§ظ„ط·ط±ط¯ ط§ظ„ط®ط§ظ…ظ„", false, function(state)
    antiAFKEnabled = state
    if antiAFKEnabled then
        redzlib:Notification("DEMOz HUB", "ظ…ط¶ط§ط¯ ط§ظ„ط·ط±ط¯ ظٹط¹ظ…ظ„ ط§ظ„ط¢ظ† ط¨ظ†ط¬ط§ط­!", "success", 3)
    end
end})

local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if antiAFKEnabled then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

AntiTab:AddSection({"طھط®ظپظٹظپ ط§ظ„ظ„ط§ظ‚ ظˆط²ظٹط§ط¯ط© ط§ظ„ظپط±ظٹظ…ط§طھ (Anti-Lag)"})

AntiTab:AddButton({"طھظ†ط¸ظٹظپ ط§ظ„ط®ط±ظٹط·ط© (ط¥ط²ط§ظ„ط© ط§ظ„طھط£ط«ظٹط±ط§طھ ط§ظ„ظ…ط³ط¨ط¨ط© ظ„ظ„ظ„ط§ظ‚)", function()
    local cleared = 0
    local targets = {game:GetService("Workspace"), game:GetService("Lighting")}
    for _, service in pairs(targets) do
        for _, obj in pairs(service:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = false
                cleared = cleared + 1
            elseif obj:IsA("PostEffect") then
                obj.Enabled = false
                cleared = cleared + 1
            end
        end
    end
    redzlib:Notification("DEMOz HUB", "طھظ… طھظ†ط¸ظٹظپ " .. tostring(cleared) .. " طھط£ط«ظٹط± ظ„ط§ظ‚ ط¨ظ†ط¬ط§ط­!", "success", 4)
end})

AntiTab:AddButton({"ظ†ظ…ط· ط§ظ„ط¨ط·ط§ط·ط³ (ط£ط¹ظ„ظ‰ ظپط±ظٹظ…ط§طھ ظ…ظ…ظƒظ†ط© ظ„ظ„ط¬ظ…ظٹط¹)", function()
    for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("MeshPart") then
            v.TextureID = ""
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
    redzlib:Notification("DEMOz HUB", "طھظ… طھظپط¹ظٹظ„ ظ†ظ…ط· ط§ظ„ظپط±ظٹظ…ط§طھ ط§ظ„ط¹ط§ظ„ظٹط© ظˆط§ظ„ظ…ط¸ظ‡ط± ط§ظ„ظ…ط¨ط³ط·!", "success", 4)
end})

---------------------------------------------------------------------
-- [3] طھط¨ظˆظٹط¨ ط§ظ„ط­ظ‚ظˆظ‚ ظˆط§ظ„ظ…ط·ظˆط± (ط¯ط§ط®ظ„ CreditsTab)
---------------------------------------------------------------------
CreditsTab:AddSection({"ظ…ط¹ظ„ظˆظ…ط§طھ ط§ظ„ط³ظƒط±ط¨طھ"})

CreditsTab:AddButton({"ط§ط³ظ… ط§ظ„ط³ظƒط±ط¨طھ: DEMOz HUB", function() end})
CreditsTab:AddButton({"ط§ظ„ظ…ط·ظˆط± ط§ظ„ط±ط¦ظٹط³ظٹ: 7zn", function() end})

CreditsTab:AddSection({"ط§ظ„طھظˆط§طµظ„ ظˆط§ظ„ط¯ط¹ظ…"})

CreditsTab:AddButton({"ط­ط³ط§ط¨ ط§ظ„طھظٹظƒ طھظˆظƒ: 9z_e.1", function() 
    setclipboard("9z_e.1")
    redzlib:Notification("DEMOz HUB", "طھظ… ظ†ط³ط® ط­ط³ط§ط¨ ط§ظ„طھظٹظƒ طھظˆظƒ 9z_e.1 ط¥ظ„ظ‰ ط§ظ„ط­ط§ظپط¸ط©!", "success", 3)
end})

---------------------------------------------------------------------
-- [4] ط­ظ„ ظ…ط´ظƒظ„ط© ط§ظ„ط§ط®طھظپط§ط،: ظپطھط­ ط§ظ„طھط¨ظˆظٹط¨ ط§ظ„ط£ظˆظ„ طھظ„ظ‚ط§ط¦ظٹط§ظ‹ ط¹ظ†ط¯ ط§ظ„طھط´ط؛ظٹظ„
---------------------------------------------------------------------
Window:SelectTab(SongsTab)
