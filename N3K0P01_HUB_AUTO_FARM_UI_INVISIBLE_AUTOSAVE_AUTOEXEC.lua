-- N3K0P01 HUB — AUTO FARM FEATURE ONLY
-- Extracted from N3K0P01_HUB_WITH_AUTO_FARM_WEBHOOK.lua
--
-- NOTE:
-- This is the Auto Farm feature block only, not a fully standalone script.
-- It expects the original UI/runtime helpers to already exist:
--   Window/MiscTab, MakeSection, LocalPlayer, VD_Notify,
--   and the game-specific objects/functions referenced in the block.
-- Paste this block into the original script after MiscTab is created.
-- Webhook URL was cleared; enter a NEW webhook URL in the UI.
--
-- ===== STANDALONE UI + REQUIRED RUNTIME =====
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local function AF_CreateUI()
    local parent
    pcall(function() parent = (gethui and gethui()) or game:GetService("CoreGui") end)
    if not parent then parent = LocalPlayer:WaitForChild("PlayerGui") end
    pcall(function() local old = parent:FindFirstChild("N3K0P01_AutoFarmUI"); if old then old:Destroy() end end)

    local gui = Instance.new("ScreenGui")
    gui.Name = "N3K0P01_AutoFarmUI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 99999
    gui.Parent = parent

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0, 300, 0, 350)
    main.Position = UDim2.new(0.5, -150, 0.5, -175)
    main.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
    main.BorderSizePixel = 0
    main.Parent = gui
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Color3.fromRGB(60, 190, 230)
    stroke.Thickness = 1.5

    local top = Instance.new("Frame")
    top.Size = UDim2.new(1, 0, 0, 42)
    top.BackgroundColor3 = Color3.fromRGB(22, 32, 46)
    top.BorderSizePixel = 0
    top.Parent = main
    Instance.new("UICorner", top).CornerRadius = UDim.new(0, 12)
    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 13, 0, 0)
    title.Size = UDim2.new(1, -88, 1, 0)
    title.Font = Enum.Font.GothamBold
    title.Text = "N3K0P01 HUB  |  AUTO FARM"
    title.TextColor3 = Color3.fromRGB(235, 245, 255)
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = top
    local minimize = Instance.new("TextButton")
    minimize.Size = UDim2.new(0, 30, 0, 28)
    minimize.Position = UDim2.new(1, -70, 0, 7)
    minimize.BackgroundColor3 = Color3.fromRGB(35, 55, 72)
    minimize.Text = "—"
    minimize.TextColor3 = Color3.new(1,1,1)
    minimize.Font = Enum.Font.GothamBold
    minimize.TextSize = 16
    minimize.Parent = top
    Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 7)
    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 30, 0, 28)
    close.Position = UDim2.new(1, -35, 0, 7)
    close.BackgroundColor3 = Color3.fromRGB(100, 42, 50)
    close.Text = "×"
    close.TextColor3 = Color3.new(1,1,1)
    close.Font = Enum.Font.GothamBold
    close.TextSize = 18
    close.Parent = top
    Instance.new("UICorner", close).CornerRadius = UDim.new(0, 7)

    local status = Instance.new("TextLabel")
    status.BackgroundTransparency = 1
    status.Position = UDim2.new(0, 12, 0, 46)
    status.Size = UDim2.new(1, -24, 0, 23)
    status.Font = Enum.Font.Gotham
    status.Text = "Status: Ready — aktifkan fitur sesuai kebutuhan"
    status.TextColor3 = Color3.fromRGB(140, 220, 240)
    status.TextSize = 10
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.TextWrapped = true
    status.Parent = main

    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = "Options"
    scroll.Position = UDim2.new(0, 10, 0, 72)
    scroll.Size = UDim2.new(1, -20, 1, -82)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = main
    local list = Instance.new("UIListLayout", scroll)
    list.Padding = UDim.new(0, 7)
    list.SortOrder = Enum.SortOrder.LayoutOrder

    -- Drag panel using mouse/touch input.
    local UserInputService = game:GetService("UserInputService")
    local dragging, dragStart, startPos
    top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = main.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    local collapsed = false
    minimize.MouseButton1Click:Connect(function()
        collapsed = not collapsed
        scroll.Visible = not collapsed
        status.Visible = not collapsed
        main.Size = collapsed and UDim2.new(0,300,0,42) or UDim2.new(0,300,0,350)
        minimize.Text = collapsed and "+" or "—"
    end)
    close.MouseButton1Click:Connect(function() gui:Destroy() end)

    local function addLabel(text, height, color)
        local l = Instance.new("TextLabel")
        l.BackgroundTransparency = 1
        l.Size = UDim2.new(1, -4, 0, height or 34)
        l.Font = Enum.Font.Gotham
        l.Text = text or ""
        l.TextColor3 = color or Color3.fromRGB(205, 220, 235)
        l.TextSize = 11
        l.TextWrapped = true
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.Parent = scroll
        return l
    end
    local function addRow(titleText, content)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, -4, 0, content and 58 or 42)
        row.BackgroundColor3 = Color3.fromRGB(25, 34, 48)
        row.BorderSizePixel = 0
        row.Parent = scroll
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Position = UDim2.new(0, 10, 0, 3)
        label.Size = UDim2.new(1, -100, 0, content and 25 or 36)
        label.Font = Enum.Font.GothamSemibold
        label.Text = titleText or "Option"
        label.TextColor3 = Color3.fromRGB(235, 242, 250)
        label.TextSize = 11
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextWrapped = true
        label.Parent = row
        if content then
            local desc = Instance.new("TextLabel")
            desc.BackgroundTransparency = 1
            desc.Position = UDim2.new(0, 10, 0, 28)
            desc.Size = UDim2.new(1, -20, 0, 25)
            desc.Font = Enum.Font.Gotham
            desc.Text = content
            desc.TextColor3 = Color3.fromRGB(145, 165, 185)
            desc.TextSize = 9
            desc.TextWrapped = true
            desc.TextXAlignment = Enum.TextXAlignment.Left
            desc.Parent = row
        end
        return row
    end
    local section = {}
    function section:AddParagraph(opt) addLabel((opt.Title or "Info") .. "\n" .. (opt.Content or ""), 46, Color3.fromRGB(145,220,240)) end
    function section:AddToggle(opt)
        local row = addRow(opt.Title, opt.Content)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 68, 0, 26)
        btn.Position = UDim2.new(1, -78, 0, opt.Content and 7 or 8)
        btn.BackgroundColor3 = opt.Default and Color3.fromRGB(25,130,115) or Color3.fromRGB(65,75,90)
        btn.Text = opt.Default and "ON" or "OFF"
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 10
        btn.Parent = row
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
        local value = opt.Default == true
        btn.MouseButton1Click:Connect(function()
            value = not value
            btn.Text = value and "ON" or "OFF"
            btn.BackgroundColor3 = value and Color3.fromRGB(25,130,115) or Color3.fromRGB(65,75,90)
            pcall(function() opt.Callback(value) end)
        end)
    end
    function section:AddInput(opt)
        addLabel(opt.Title .. (opt.Content and (" — " .. opt.Content) or ""), 30)
        local box = Instance.new("TextBox")
        box.Size = UDim2.new(1, -4, 0, 36)
        box.BackgroundColor3 = Color3.fromRGB(25,34,48)
        box.BorderSizePixel = 0
        box.ClearTextOnFocus = false
        box.PlaceholderText = opt.Placeholder or "Masukkan teks..."
        box.Text = opt.Default or ""
        box.TextColor3 = Color3.fromRGB(235,245,255)
        box.PlaceholderColor3 = Color3.fromRGB(130,150,170)
        box.Font = Enum.Font.Gotham
        box.TextSize = 11
        box.Parent = scroll
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
        box.FocusLost:Connect(function(enterPressed) pcall(function() opt.Callback(box.Text) end) end)
    end
    function section:AddButton(opt)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -4, 0, 36)
        btn.BackgroundColor3 = Color3.fromRGB(30,105,135)
        btn.BorderSizePixel = 0
        btn.Text = opt.Title or "Button"
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.Parent = scroll
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        btn.MouseButton1Click:Connect(function() pcall(opt.Callback) end)
    end
    return gui, main, status, section
end

local AF_Gui, AF_Main, AF_Status, AF_Section = AF_CreateUI()
local function VD_Notify(title, message, duration)
    if AF_Status and AF_Status.Parent then AF_Status.Text = tostring(title or "Auto Farm") .. ": " .. tostring(message or "") end
    print("[N3K0P01 HUB] " .. tostring(title or "Auto Farm") .. " — " .. tostring(message or ""))
end
local MiscTab = {}
local function MakeSection(_tab, _name) return AF_Section end
-- ===== END STANDALONE UI + REQUIRED RUNTIME =====

-- ===== AUTO FARM + DISCORD WEBHOOK (ported; no source library/UI) =====
            do
                local TeleportService = game:GetService("TeleportService")
                local AF_DEFAULT_WEBHOOK = "https://discord.com/api/webhooks/1561797768362856464/BaQG3DZU84pGPN5AoI1C2FtD13PA7xxAjQaBdpjrcdCUBPd5Ld0YPveCvXVC24oZF3vy"
                local AF_WEBHOOK_FILE = "N3K0P01_HUB_Webhook.json"
                local AF_State = {
                    RoundDetect = true,
                    HopIfAlone = true,
                    AutoEscape = true,
                    SendWebhook = true,
                    WebhookURL = AF_DEFAULT_WEBHOOK,
                    AutoExecute = true,
                    ScriptURL = "",
                    AntiAFK = true,
                    Hopping = false,
                    Busy = false,
                    KillerHopTriggered = false,
                    LoopRunning = false,
                    Baseline = { Screws = 0, EXP = 0, Level = 0, Gears = 0 },
                }
                local function AF_SaveWebhook()
                    if type(writefile) ~= "function" then return false end
                    local ok = pcall(function()
                        writefile(AF_WEBHOOK_FILE, HttpService:JSONEncode({WebhookURL = AF_State.WebhookURL, ScriptURL = AF_State.ScriptURL}))
                    end)
                    return ok
                end
                local function AF_LoadWebhook()
                    if type(isfile) ~= "function" or type(readfile) ~= "function" then return end
                    local exists = false
                    pcall(function() exists = isfile(AF_WEBHOOK_FILE) end)
                    if not exists then return end
                    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(AF_WEBHOOK_FILE)) end)
                    if ok and type(data) == "table" then
                        if type(data.WebhookURL) == "string" and data.WebhookURL:find("discord.com/api/webhooks", 1, true) then
                            AF_State.WebhookURL = data.WebhookURL
                        end
                        if type(data.ScriptURL) == "string" and data.ScriptURL:match("^https?://") then
                            AF_State.ScriptURL = data.ScriptURL
                        end
                    end
                end
                AF_LoadWebhook()
                pcall(function()
                    if getgenv and getgenv().N3K0P01_HUB_URL then AF_State.ScriptURL = tostring(getgenv().N3K0P01_HUB_URL) end
                end)

                local AF_Request = nil
                pcall(function() if syn and type(syn.request) == "function" then AF_Request = syn.request end end)
                pcall(function() if not AF_Request and http and type(http.request) == "function" then AF_Request = http.request end end)
                pcall(function() if not AF_Request and type(http_request) == "function" then AF_Request = http_request end end)
                pcall(function() if not AF_Request and fluxus and type(fluxus.request) == "function" then AF_Request = fluxus.request end end)
                pcall(function() if not AF_Request and type(request) == "function" then AF_Request = request end end)

                local function AF_Notify(title, message, duration)
                    pcall(function() VD_Notify(title or "Auto Farm", message or "", duration or 2) end)
                end

                -- ===== Invisible feature extracted from the source; no floating-button code =====
                local AF_Invis = {
                    Enabled = false,
                    Loading = false,
                    Ready = false,
                    API = nil,
                    LastToggle = -math.huge,
                    Retries = 3,
                    RetryDelay = 2,
                    QueueState = nil,
                }
                local AF_INVIS_URL = "https://leekguy.vercel.app/roblox/menghub/crack_obf_invisible_93978595733734.lua"

                local function AF_InvisValidateAPI(api)
                    return type(api) == "table"
                        and type(api.enable) == "function"
                        and type(api.disable) == "function"
                end

                local function AF_InvisCleanup()
                    pcall(function()
                        local chair = Workspace:FindFirstChild("invischair")
                        if chair then chair:Destroy() end
                        local char = LocalPlayer.Character
                        if char then
                            for _, part in ipairs(char:GetDescendants()) do
                                if (part:IsA("BasePart") or part:IsA("Decal"))
                                    and part.Name ~= "Hurtbox"
                                    and part.Name ~= "HumanoidRootPart"
                                    and part.Name ~= "HRP_Clone" then
                                    part.Transparency = 0
                                    if part:IsA("BasePart") then
                                        part.LocalTransparencyModifier = 0
                                    end
                                end
                            end
                        end
                    end)
                end

                local function AF_InvisFindAPI()
                    local api
                    pcall(function()
                        if _G.MengHub and _G.MengHub.Invisible then
                            api = _G.MengHub.Invisible
                        end
                    end)
                    if not api then
                        pcall(function()
                            if type(getgenv) == "function" then
                                local env = getgenv()
                                if env and env.MengHub then api = env.MengHub.Invisible end
                            end
                        end)
                    end
                    if AF_InvisValidateAPI(api) then
                        AF_Invis.API = api
                        AF_Invis.Ready = true
                        return true
                    end
                    return false
                end

                local function AF_InvisLoadAPI()
                    if AF_InvisFindAPI() then return true end
                    if AF_Invis.Loading then return false end
                    AF_Invis.Loading = true
                    AF_Invis.Ready = false
                    for attempt = 1, AF_Invis.Retries do
                        local ok, err = pcall(function()
                            assert(type(loadstring) == "function", "loadstring tidak didukung")
                            local source = game:HttpGet(AF_INVIS_URL)
                            assert(type(source) == "string" and #source > 0, "source invisible kosong")
                            loadstring(source)()
                        end)
                        task.wait(0.5)
                        if AF_InvisFindAPI() then
                            AF_Invis.Loading = false
                            print("[N3K0P01 HUB] Invisible API berhasil dimuat")
                            return true
                        end
                        warn("[N3K0P01 HUB] Invisible API gagal, percobaan " .. tostring(attempt) .. ": " .. tostring(err))
                        if attempt < AF_Invis.Retries then task.wait(AF_Invis.RetryDelay) end
                    end
                    AF_Invis.Loading = false
                    AF_Invis.Ready = false
                    return false
                end

                local function AF_InvisSetState(state, quiet)
                    state = state == true
                    if not AF_Invis.API then
                        AF_Invis.QueueState = state
                        if AF_Invis.Loading then
                            if not quiet then AF_Notify("Invisible", "Sedang memuat API...", 2) end
                            return
                        end
                        task.spawn(function()
                            local loaded = AF_InvisLoadAPI()
                            if loaded then
                                local queued = AF_Invis.QueueState
                                AF_Invis.QueueState = nil
                                if queued ~= nil then AF_InvisSetState(queued, quiet) end
                            else
                                AF_Notify("Invisible", "Gagal memuat API invisible. Cek koneksi atau dukungan executor.", 4)
                            end
                        end)
                        if not quiet then AF_Notify("Invisible", "Memuat fitur invisible...", 2) end
                        return
                    end

                    local now = os.clock()
                    if now - AF_Invis.LastToggle < 0.25 then return end
                    if AF_Invis.Enabled == state then
                        if not state then AF_InvisCleanup() end
                        return
                    end
                    AF_Invis.LastToggle = now
                    AF_Invis.Enabled = state
                    local ok, err = pcall(function()
                        if state then AF_Invis.API.enable() else AF_Invis.API.disable() end
                    end)
                    if not state then AF_InvisCleanup() end
                    if not ok then
                        AF_Invis.Enabled = false
                        AF_InvisCleanup()
                        warn("[N3K0P01 HUB] Invisible toggle error: " .. tostring(err))
                        AF_Notify("Invisible", "Gagal mengubah status invisible.", 3)
                    elseif not quiet then
                        AF_Notify("Invisible", state and "Invisible AKTIF" or "Invisible NONAKTIF", 2)
                    else
                        VD_Notify("Invisible", state and "Auto ON" or "OFF", 2)
                    end
                end

                LocalPlayer.CharacterAdded:Connect(function()
                    task.wait(1.2)
                    if AF_Invis.Enabled and AF_Invis.API then
                        pcall(function() AF_Invis.API.enable() end)
                    end
                end)
                -- ===== End Invisible feature =====

                -- Anti-AFK: respond to Roblox idle event and periodically refresh activity.
                local VirtualUser = game:GetService("VirtualUser")
                pcall(function()
                    LocalPlayer.Idled:Connect(function()
                        if not AF_State.AntiAFK then return end
                        pcall(function()
                            VirtualUser:CaptureController()
                            VirtualUser:ClickButton2(Vector2.new(0, 0))
                        end)
                    end)
                end)
                task.spawn(function()
                    while task.wait(300) do
                        if AF_State.AntiAFK then
                            pcall(function()
                                VirtualUser:CaptureController()
                                VirtualUser:ClickButton2(Vector2.new(0, 0))
                            end)
                        end
                    end
                end)

                local function AF_QueueAutoExecute()
                    if not AF_State.AutoExecute then return end
                    local url = tostring(AF_State.ScriptURL or "")
                    if url == "" then
                        pcall(function()
                            if getgenv and getgenv().N3K0P01_HUB_URL then
                                url = tostring(getgenv().N3K0P01_HUB_URL)
                            end
                        end)
                    end
                    if url == "" or not url:match("^https?://") then
                        AF_Notify("Auto Execute", "Isi Script Raw URL dulu agar bisa execute ulang setelah hop.", 4)
                        return
                    end
                    local queuedCode = "loadstring(game:HttpGet(" .. string.format("%q", url) .. "))()"
                    local queueFn
                    pcall(function() if getgenv and getgenv().queue_on_teleport then queueFn = getgenv().queue_on_teleport end end)
                    if not queueFn then pcall(function() queueFn = queue_on_teleport end) end
                    if not queueFn then pcall(function() if syn and syn.queue_on_teleport then queueFn = syn.queue_on_teleport end end) end
                    if not queueFn then pcall(function() if fluxus and fluxus.queue_on_teleport then queueFn = fluxus.queue_on_teleport end end) end
                    if type(queueFn) == "function" then
                        local ok = pcall(function() queueFn(queuedCode) end)
                        if not ok then AF_Notify("Auto Execute", "Executor menolak queue_on_teleport.", 3) end
                    else
                        AF_Notify("Auto Execute", "Executor tidak mendukung queue_on_teleport.", 3)
                    end
                end

                local function AF_UpdateBaseline()
                    AF_State.Baseline.Screws = tonumber(LocalPlayer:GetAttribute("Screws")) or AF_State.Baseline.Screws or 0
                    AF_State.Baseline.EXP = tonumber(LocalPlayer:GetAttribute("EXP")) or AF_State.Baseline.EXP or 0
                    AF_State.Baseline.Level = tonumber(LocalPlayer:GetAttribute("Level")) or AF_State.Baseline.Level or 0
                    AF_State.Baseline.Gears = tonumber(LocalPlayer:GetAttribute("Gears")) or AF_State.Baseline.Gears or 0
                end
                AF_UpdateBaseline()

                local function AF_PostJson(payload, targetUrl)
                    if not AF_Request then
                        return false, "HTTP request tidak didukung executor ini."
                    end
                    targetUrl = tostring(targetUrl or AF_State.WebhookURL or "")
                    if targetUrl == "" then return false, "URL webhook kosong." end
                    local body = HttpService:JSONEncode(payload)
                    local ok, result = pcall(function()
                        return AF_Request({
                            Url = targetUrl,
                            Method = "POST",
                            Headers = {
                                ["Content-Type"] = "application/json",
                                ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
                            },
                            Body = body,
                        })
                    end)
                    if not ok then return false, tostring(result) end
                    if type(result) == "table" and result.Success == false then
                        return false, tostring(result.StatusCode or "HTTP") .. " - " .. tostring(result.Body or "Request gagal")
                    end
                    return true, result
                end

                local function AF_SendAwardWebhook()
                    if not AF_State.SendWebhook then return end
                    if tostring(AF_State.WebhookURL or "") == "" then return end
                    local screwsNow = tonumber(LocalPlayer:GetAttribute("Screws")) or 0
                    local gearsNow = tonumber(LocalPlayer:GetAttribute("Gears")) or 0
                    local levelNow = tonumber(LocalPlayer:GetAttribute("Level")) or 0
                    local screwsEarned = screwsNow - (tonumber(AF_State.Baseline.Screws) or 0)
                    local gearsEarned = gearsNow - (tonumber(AF_State.Baseline.Gears) or 0)
                    if screwsEarned < 0 then screwsEarned = screwsNow end
                    if gearsEarned < 0 then gearsEarned = gearsNow end

                    local playerName = tostring(LocalPlayer.Name or "Player")
                    local maskedName = (#playerName > 3) and (string.sub(playerName, 1, math.max(1, #playerName - 10)) .. "***") or "***"
                    local embed = {
                        title = "Statistik Auto Farm",
                        color = 3329330,
                        fields = {
                            { name = "🔩 Screws Earned", value = "```" .. tostring(screwsEarned) .. "```", inline = true },
                            { name = "⚙️ Gears Earned", value = "```" .. tostring(gearsEarned) .. "```", inline = true },
                            { name = "📈 Level Status", value = "```Level " .. tostring(AF_State.Baseline.Level or 0) .. " ➔ Level " .. tostring(levelNow) .. "```", inline = false },
                        },
                        footer = { text = "Player: " .. maskedName },
                        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
                    }
                    local ok, result = AF_PostJson({ embeds = { embed } })
                    if not ok then
                        warn("[N3K0P01 Auto Farm] Webhook error: " .. tostring(result))
                    else
                        print("[N3K0P01 Auto Farm] Webhook statistik berhasil dikirim.")
                    end
                end

                local function AF_FindFinishLine()
                    for _, descendant in ipairs(Workspace:GetDescendants()) do
                        local lower = string.lower(descendant.Name or "")
                        local isFinish = lower:find("fininshline", 1, true) ~= nil
                            or lower:find("finishline", 1, true) ~= nil
                            or lower:find("finish_line", 1, true) ~= nil
                        if isFinish then
                            if descendant:IsA("BasePart") then return descendant end
                            if descendant:IsA("Model") then
                                local part = descendant.PrimaryPart or descendant:FindFirstChildWhichIsA("BasePart", true)
                                if part then return part end
                            end
                        end
                    end
                    return nil
                end

                local function AF_HopServer()
                    if AF_State.Hopping then return end
                    AF_State.Hopping = true
                    if not AF_Request then
                        AF_State.Hopping = false
                        AF_Notify("Auto Farm", "HTTP request tidak tersedia untuk Server Hop.", 3)
                        return
                    end

                    task.spawn(function()
                        local cursor = ""
                        local foundServer = false
                        local pagesChecked = 0
                        while cursor ~= nil and not foundServer and pagesChecked < 12 do
                            pagesChecked = pagesChecked + 1
                            local endpoint = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId)
                                .. "/servers/Public?sortOrder=Asc&limit=100"
                                .. (cursor ~= "" and "&cursor=" .. HttpService:UrlEncode(cursor) or "")
                            local ok, response = pcall(function()
                                return AF_Request({ Url = endpoint, Method = "GET" })
                            end)
                            if ok and type(response) == "table" and response.Success ~= false and type(response.Body) == "string" then
                                local decodedOK, decoded = pcall(function() return HttpService:JSONDecode(response.Body) end)
                                if decodedOK and type(decoded) == "table" and type(decoded.data) == "table" then
                                    for _, server in ipairs(decoded.data) do
                                        local playing = tonumber(server.playing)
                                        local maxPlayers = tonumber(server.maxPlayers)
                                        local available = playing ~= nil and maxPlayers ~= nil and playing < maxPlayers
                                        if available and server.id ~= game.JobId then
                                            AF_QueueAutoExecute()
                                            local teleportOK = pcall(function()
                                                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                                            end)
                                            if teleportOK then
                                                foundServer = true
                                                break
                                            end
                                        end
                                    end
                                    cursor = decoded.nextPageCursor
                                else
                                    cursor = nil
                                end
                            else
                                cursor = nil
                            end
                        end

                        if foundServer then
                            task.delay(15, function() AF_State.Hopping = false end)
                        else
                            AF_State.Hopping = false
                            AF_Notify("Auto Farm", "Server publik lain tidak ditemukan atau request gagal.", 3)
                        end
                    end)
                end

                local function AF_UpdateEscape()
                    if not AF_State.AutoEscape or AF_State.Busy or AF_State.Hopping then return end
                    local teamName = LocalPlayer.Team and string.lower(LocalPlayer.Team.Name or "") or ""
                    if not teamName:find("survivor", 1, true) then return end
                    local character = LocalPlayer.Character
                    local root = character and character:FindFirstChild("HumanoidRootPart")
                    if not root then return end
                    local finishPart = AF_FindFinishLine()
                    if not finishPart then return end

                    AF_State.Busy = true
                    local moved = pcall(function()
                        root.CFrame = finishPart.CFrame * CFrame.new(0, 3, 0)
                    end)
                    if moved then
                        task.delay(2, AF_SendAwardWebhook)
                        task.delay(5, function()
                            if not AF_State.Hopping then
                                AF_Notify("Auto Farm", "Melakukan Server Hop...", 2)
                                AF_HopServer()
                            end
                        end)
                        task.delay(6, function() AF_State.Busy = false end)
                    else
                        AF_State.Busy = false
                    end
                end

                local function AF_HandleKiller()
                    if not AF_State.AutoEscape or AF_State.KillerHopTriggered or AF_State.Hopping or AF_State.Busy then return end
                    local teamName = LocalPlayer.Team and string.lower(LocalPlayer.Team.Name or "") or ""
                    if not teamName:find("killer", 1, true) then return end
                    AF_State.KillerHopTriggered = true
                    AF_State.Busy = true
                    AF_Notify("Auto Farm", "Tim KILLER terdeteksi. Melakukan Server Hop...", 3)
                    task.delay(1.5, AF_HopServer)
                    task.delay(3, function() AF_State.Busy = false end)
                    task.delay(30, function() AF_State.KillerHopTriggered = false end)
                end

                local function AF_StartMonitor()
                    if AF_State.LoopRunning then return end
                    AF_State.LoopRunning = true
                    task.spawn(function()
                        while AF_State.RoundDetect or AF_State.HopIfAlone or AF_State.AutoEscape do
                            if AF_State.AutoEscape then
                                local teamName = LocalPlayer.Team and string.lower(LocalPlayer.Team.Name or "") or ""
                                if teamName:find("survivor", 1, true) then
                                    pcall(AF_UpdateEscape)
                                elseif teamName:find("killer", 1, true) then
                                    pcall(AF_HandleKiller)
                                end
                            end
                            if AF_State.HopIfAlone and not AF_State.Hopping and not AF_State.Busy then
                                local count = #Players:GetPlayers()
                                if count <= 1 then AF_HopServer() end
                            end
                            task.wait(0.35)
                        end
                        AF_State.LoopRunning = false
                    end)
                end

                local function AF_SetFlag(key, value)
                    AF_State[key] = value == true
                    if AF_State[key] then AF_StartMonitor() end
                end

                -- Bind only the game's existing events; no library from the source file is loaded.
                pcall(function()
                    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                    local timeEvent = remotes and remotes:FindFirstChild("TimeUpdateEvent")
                    if timeEvent and timeEvent:IsA("RemoteEvent") then
                        timeEvent.OnClientEvent:Connect(function(argument)
                            if not AF_State.RoundDetect or argument ~= "Round" then return end
                            local teamName = LocalPlayer.Team and string.lower(LocalPlayer.Team.Name or "") or ""
                            if teamName:find("spectator", 1, true) and not AF_State.Hopping and not AF_State.Busy then
                                AF_HopServer()
                            end
                        end)
                    end

                    local gameFolder = remotes and remotes:FindFirstChild("Game")
                    local startEvent = gameFolder and gameFolder:FindFirstChild("Start")
                    local resetEvent = gameFolder and gameFolder:FindFirstChild("ResetEndscreenvals")
                    local loadedEvent = gameFolder and gameFolder:FindFirstChild("Loadedevent")
                    if startEvent and startEvent:IsA("BindableEvent") then startEvent.Event:Connect(AF_UpdateBaseline) end
                    if resetEvent and resetEvent:IsA("BindableEvent") then resetEvent.Event:Connect(AF_UpdateBaseline) end
                    if loadedEvent and loadedEvent:IsA("RemoteEvent") then loadedEvent.OnClientEvent:Connect(AF_UpdateBaseline) end
                end)

                local autoFarmSection = MakeSection(MiscTab, "Auto Farm")
                autoFarmSection:AddToggle({ Title = "Invisible (Auto ON)", Content = "Mengaktifkan fitur invisible saat script dijalankan. Kontrol melalui toggle UI utama.", Default = true, Callback = function(v)
                    AF_InvisSetState(v, false)
                end })
                autoFarmSection:AddParagraph({
                    Title = "Violence District Auto Farm",
                    Content = "Auto Escape, deteksi ronde/server, dan laporan statistik ke Discord.",
                })
                autoFarmSection:AddToggle({ Title = "Round Detect", Content = "Server Hop saat ronde terdeteksi ketika role Spectator.", Default = true, ConfigId = "AF_RoundDetect", Callback = function(v)
                    AF_SetFlag("RoundDetect", v)
                    if v then AF_Notify("Auto Farm", "Round Detect ON", 2) end
                end })
                autoFarmSection:AddToggle({ Title = "Detect Player (Hop if Alone)", Content = "Pindah server jika hanya ada kamu di server.", Default = true, ConfigId = "AF_HopIfAlone", Callback = function(v)
                    AF_SetFlag("HopIfAlone", v)
                    if v then AF_Notify("Auto Farm", "Hop if Alone ON", 2) end
                end })
                autoFarmSection:AddToggle({ Title = "Auto Escape (Survivor)", Content = "Teleport ke finish line, kirim statistik jika webhook diaktifkan, lalu Server Hop.", Default = true, ConfigId = "AF_AutoEscape", Callback = function(v)
                    AF_State.KillerHopTriggered = false
                    AF_SetFlag("AutoEscape", v)
                    AF_Notify("Auto Farm", v and "Auto Escape ON" or "Auto Escape OFF", 2)
                end })
                autoFarmSection:AddInput({ Title = "Discord Webhook URL", Content = "URL sudah terpasang dan akan disimpan lokal.", Default = AF_State.WebhookURL, Placeholder = "Discord Webhook URL", Save = false, Callback = function(v)
                    local candidate = tostring(v or ""):gsub("%s+", "")
                    if candidate:find("discord.com/api/webhooks", 1, true) then
                        AF_State.WebhookURL = candidate
                        local saved = AF_SaveWebhook()
                        AF_Notify("Webhook", saved and "URL tersimpan di perangkat." or "URL aktif, tetapi penyimpanan lokal tidak didukung.", 3)
                    else
                        AF_Notify("Webhook", "URL webhook tidak valid; URL sebelumnya tetap dipakai.", 3)
                    end
                end })
                autoFarmSection:AddToggle({ Title = "Award Status Webhook", Content = "Kirim statistik Screws, Gears, dan Level setelah Auto Escape.", Default = true, ConfigId = "AF_SendWebhook", Callback = function(v)
                    AF_State.SendWebhook = v == true
                    AF_Notify("Auto Farm Webhook", v and "Aktif" or "Nonaktif", 2)
                end })
                autoFarmSection:AddToggle({ Title = "Auto Execute On Hop", Content = "ON. Perlu Script Raw URL agar script dapat dijalankan ulang setelah pindah server.", Default = true, Callback = function(v)
                    AF_State.AutoExecute = v == true
                    AF_Notify("Auto Execute", v and "Aktif" or "Nonaktif", 2)
                end })
                autoFarmSection:AddInput({ Title = "Script Raw URL", Content = "URL raw file Lua milik lu; bukan URL webhook.", Default = AF_State.ScriptURL, Placeholder = "https://raw.githubusercontent.com/.../script.lua", Save = false, Callback = function(v)
                    AF_State.ScriptURL = tostring(v or ""):gsub("%s+", "")
                    pcall(function() if getgenv then getgenv().N3K0P01_HUB_URL = AF_State.ScriptURL end end)
                    AF_SaveWebhook()
                    AF_Notify("Auto Execute", AF_State.ScriptURL ~= "" and "Raw URL disimpan." or "Raw URL dikosongkan.", 2)
                end })
                autoFarmSection:AddToggle({ Title = "Anti AFK", Content = "Mencoba mencegah status idle selama script aktif.", Default = true, Callback = function(v)
                    AF_State.AntiAFK = v == true
                    AF_Notify("Anti AFK", v and "Aktif" or "Nonaktif", 2)
                end })
                autoFarmSection:AddButton({ Title = "Test Webhook", Callback = function()
                    local targetUrl = tostring(AF_State.WebhookURL or "")
                    if targetUrl == "" then AF_Notify("Webhook Error", "URL webhook kosong!", 3); return end
                    AF_Notify("Webhook Test", "Mengirim test ke Discord...", 2)
                    task.spawn(function()
                        local ok, result = AF_PostJson({ content = "✅ Test Webhook N3K0P01 HUB Auto Farm berhasil! Toggle webhook berfungsi." }, targetUrl)
                        if ok then AF_Notify("Webhook Success", "Test webhook berhasil dikirim!", 3)
                        else AF_Notify("Webhook Error", tostring(result), 4) end
                    end)
                end })

                -- Save the preconfigured webhook when supported; all requested features start ON.
                AF_SaveWebhook()
                AF_StartMonitor()
                AF_Notify("N3K0P01 HUB", "Auto Farm, Webhook, Auto Execute, Anti AFK, dan Invisible disiapkan ON.", 4)

                -- Start loading/enabling the invisible API automatically at script execution.
                task.spawn(function()
                    AF_InvisSetState(true, true)
                end)
            end
            -- ===== END AUTO FARM + WEBHOOK =====
