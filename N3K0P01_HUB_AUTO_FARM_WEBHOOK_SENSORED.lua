-- Recovered source by https://discord.gg/HwhJdTRFR
local v5567 = (function()
    local v294 = rawget(_G, "pcall")
    if not v294 then
        v294 = pcall
    end
    local v504 = rawget(_G, "type")
    if not v504 then
        v504 = type
    end
    local v333 = rawget(_G, "tostring")
    if not v333 then
        v333 = tostring
    end
    local v590 = function(v84)
        local v123 = 5381
        for v116 = 1, #v84 do
            v123 = (v123 * 33 + string.byte(v84, v116)) % 2147483647
        end
        return v123
    end
    local v525 = v590("N3K0P01_HUB_VD_2024_PROTECTED_XYZ")
    local v519 = {}
    local v498 = {tostring, "tostring"}
    local v514 = {type, "type"}
    local v462 = {pcall, "pcall"}
    local v454 = {pairs, "pairs"}
    local v515 = {ipairs, "ipairs"}
    local v576 = {rawget, "rawget"}
    local v564 = {rawset, "rawset"}
    v519[1] = v498
    v519[2] = v514
    v519[3] = v462
    v519[4] = v454
    v519[5] = v515
    v519[6] = v576
    v519[7] = v564
    local v336 = v519
    local v437 = function(v129)
        warn("[N3K0P01 HUB-AT] PROTEKSI AKTIF: " .. v333(v129))
        v294(function()
            if getgenv then
                getgenv().N3K0P01_HUB_LOADED = nil
            end
            return
        end)
        error("[N3K0P01 HUB] Akses tidak sah terdeteksi. Script dihentikan.", 0)
        return
    end
    if v590("N3K0P01_HUB_VD_2024_PROTECTED_XYZ") ~= v525 then
        v437("Integrity mismatch")
    end
    local v512 = debug
    if v512 then
        v512 = debug.getinfo
    end
    if v512 then
        for v476, v468 in ipairs(v336) do
            local v589, v579 = v294(debug.getinfo, v468[1], "S")
            local v583 = v589
            if v583 then
                v583 = v579
            end
            if v583 then
                v583 = v579.what ~= "C"
            end
            if v583 then
                v437("Hook detected on: " .. v468[2])
            end
        end
    end
    local v511 = {
        "hookfunction",
        "hookmetamethod",
        "replaceclosure",
        "getupvalue",
        "setupvalue",
        "getconstants",
        "setconstant",
        "getprotos",
    }
    local v451 = v511
    for v550, v479 in ipairs(v451) do
        if rawget(_G, v479) ~= nil then
            v437("Executor function found: " .. v479)
        end
    end
    local v587 = debug
    if v587 then
        v587 = debug.traceback
    end
    if v587 then
        local v474, v566 = v294(debug.traceback, "", 1)
        local v465 = not v474
        if not v465 then
            v465 = v504(v566) ~= "string"
        end
        if v465 then
            v437("debug.traceback tampering detected")
        end
    end
    task.spawn(function()
        while true do
            task.wait(60)
            local v250 = debug
            if v250 then
                v250 = debug.getinfo
            end
            if v250 then
                for v258, v248 in ipairs(v336) do
                    local v260, v270 = v294(debug.getinfo, v248[1], "S")
                    local v251 = v260
                    if v251 then
                        v251 = v270
                    end
                    if v251 then
                        v251 = v270.what ~= "C"
                    end
                    if v251 then
                        v437("Runtime hook detected on: " .. v248[2])
                    end
                end
            end
            local v268, v269, v241 = ipairs(v451)
            local v263, v267 = v268(v269, v241)
            local v246 = v263
            if v246 ~= nil then
                repeat
                    if rawget(_G, v267) ~= nil then
                        v437("Runtime executor function found: " .. v267)
                    end
                    local v254
                    v254, v267 = v268(v269, v246)
                    v246 = v254
                until v246 == nil
            end
        end
    end)
    return true
end)()
local v5520 = getgenv
if v5520 then
    v5520 = getgenv().N3K0P01_HUB_LOADED
end
if v5520 then
    warn("[N3K0P01 HUB] Script sudah berjalan! Mencegah eksekusi ganda.")
    return
end
if getgenv then
    getgenv().N3K0P01_HUB_LOADED = true
end
local v5525 = game
if not v5525:IsLoaded() then
    local v5398 = game.Loaded
    v5398:Wait()
end
local v5551 = game
local v5392 = v5551:GetService("Players")
local v5417 = game
local v4928 = v5417:GetService("TeleportService")
local v5643 = game
local v5063 = v5643:GetService("HttpService")
local v5412 = game
local v5004 = v5412:GetService("TweenService")
local v5341 = game
local v5044 = v5341:GetService("UserInputService")
local v5381 = game
local v5565 = v5381:GetService("RunService")
local v5503 = game
local v4934 = v5503:GetService("ReplicatedStorage")
local v4938 = workspace
if not v4938 then
    local v5356 = game
    v4938 = v5356:GetService("Workspace")
end
local v5433 = game
local v5330 = v5433:GetService("VirtualUser")
local v5051 = v5392.LocalPlayer
while not v5051 do
    v5051 = v5392.LocalPlayer
    task.wait(0.1)
end
local v5500 = game
local v5240 = v5500.PlaceId
local v4945 = v5500.JobId
local v5333 = function(v593)
    local v610 = task
    if v610 then
        v610 = task.wait
    end
    if v610 then
        v610 = task.wait(v593)
    end
    if not v610 then
        v610 = wait(v593)
    end
    return v610
end
local v4987 = function(v614)
    local v628 = task
    if v628 then
        v628 = task.spawn
    end
    if v628 then
        v628 = task.spawn(v614)
    end
    if not v628 then
        v628 = spawn(v614)
    end
    return v628
end
local v5261 = {}
local v4951 = syn
if v4951 then
    v4951 = syn.request
end
if not v4951 then
    v4951 = http
    if v4951 then
        v4951 = http.request
    end
end
if not v4951 then
    v4951 = fluxus
    if v4951 then
        v4951 = fluxus.request
    end
end
if not v4951 then
    v4951 = krnl
    if v4951 then
        v4951 = krnl.request
    end
end
if not v4951 then
    v4951 = request
end
if not v4951 then
    v4951 = http_request
end
local v5038 = function()
    if identifyexecutor then
        return (identifyexecutor())
    end
    if getexecutorname then
        return (getexecutorname())
    end
    return "Unknown Executor"
end
local v5531 = getgenv
if v5531 then
    v5531 = getgenv().N3K0P01_HUB_URL
end
if not v5531 then
    v5531 = "https://raw.githubusercontent.com/systemyour2/ajaxx/refs/heads/main/autofarm-premium.lua"
end
local v5056 = string.format('loadstring(game:HttpGet("%s"))()', v5531)
local v5235 = false
local v5072 = function(v653)
    if v5235 then
        return true
    end
    local v671 = v653
    if not v671 then
        v671 = v5056
    end
    local v681 = getgenv
    if v681 then
        v681 = getgenv().queue_on_teleport
    end
    if not v681 then
        v681 = queue_on_teleport
    end
    if not v681 then
        v681 = syn
        if v681 then
            v681 = syn.queue_on_teleport
        end
    end
    if not v681 then
        v681 = fluxus
        if v681 then
            v681 = fluxus.queue_on_teleport
        end
    end
    if not v681 then
        v681 = queueonteleport
    end
    local v698 = v681
    if v698 then
        v698 = type(v681) == "function"
    end
    if v698 then
        local v696 = pcall(function()
            v681(v671)
            return
        end)
        if v696 then
            v5235 = true
        end
        return v696
    end
    return false
end
local v5462 = {}
local v5652 = true
v5462.AutoFarm = v5652
v5462.AutoHopAfterEscape = v5652
v5462.DisableKillerChance = v5652
v5462.HopIfKiller = v5652
v5462.InstantFinish = v5652
v5462.GateTweenSpeed = 100
v5462.MinPlayers = 2
v5462.MaxPlayers = 4
v5462.EnableWebhook = true
v5462.WebhookURL = "https://discord.com/api/webhooks/1561797768362856464/BaQG3DZU84pGPN5AoI1C2FtD13PA7xxAjQaBdpjrcdCUBPd5Ld0YPveCvXVC24oZF3vy"

-- Simpan URL webhook secara lokal agar tetap ada setelah script dijalankan ulang.
local N3K0P01_WEBHOOK_CONFIG = "N3K0P01_HUB_Webhook.json"
local function N3K0P01_SaveWebhookURL(url)
    if type(writefile) ~= "function" then return false end
    local ok = pcall(function()
        writefile(N3K0P01_WEBHOOK_CONFIG, v5063:JSONEncode({WebhookURL = url}))
    end)
    return ok
end
local function N3K0P01_LoadWebhookURL()
    if type(isfile) ~= "function" or type(readfile) ~= "function" then return end
    local exists = false
    pcall(function() exists = isfile(N3K0P01_WEBHOOK_CONFIG) end)
    if not exists then return end
    local ok, data = pcall(function()
        return v5063:JSONDecode(readfile(N3K0P01_WEBHOOK_CONFIG))
    end)
    if ok and type(data) == "table" and type(data.WebhookURL) == "string"
        and data.WebhookURL:find("discord.com/api/webhooks", 1, true) then
        v5462.WebhookURL = data.WebhookURL
    end
end
N3K0P01_LoadWebhookURL()

local v5598 = true
v5462.AntiAFK = v5598
v5462.NoClip = v5598
v5462.AutoExecuteOnHop = v5598
local v4991 = v5462
local v5075 = v5598
local v5249 = false
local v5107
local v5199 = "Unknown"
local v4966 = true
local v5263 = false
local v5364 = function()
    local v788 = isfile
    if v788 then
        v788 = isfile("VD_AutoFarm_Attributes.json")
    end
    if v788 then
        local v778, v769 = pcall(function()
            local v730 = readfile("VD_AutoFarm_Attributes.json")
            local v731 = v5063
            return (v731:JSONDecode(v730))
        end)
        local v774 = v778
        if v774 then
            v774 = type(v769) == "table"
        end
        if v774 then
            v774 = v769.UserId == v5051.UserId
        end
        if v774 then
            return v769
        end
    end
    local v777 = {UserId = v5051.UserId}
    local v773 = 0
    v777.Level = v773
    v777.SIN = v773
    v777.EXP = v773
    v777.Screws = v773
    v777.Gears = v773
    v777.KillerChance = v773
    v777.UpdatedAt = os.time()
    return v777
end
local v5321 = function(v790)
    if writefile then
        pcall(function()
            local v820 = v790
            v820.UserId = v5051.UserId
            v820.UpdatedAt = os.time()
            local v824 = v5063
            writefile("VD_AutoFarm_Attributes.json", (v824:JSONEncode(v790)))
            return
        end)
    end
    return
end
local v5324 = v5364()
local v5218 = function()
    local v931 = {}
    local v920 = os.time()
    local v922 = isfile
    if v922 then
        v922 = isfile("ServerHop.txt")
    end
    if v922 then
        local v921, v923 = pcall(function()
            return (readfile("ServerHop.txt"))
        end)
        local v939 = v921
        if v939 then
            v939 = v923
        end
        if v939 then
            for v929 in string.gmatch(v923, "[^\r\n]+") do
                local v934, v917 = string.match(v929, "^([^|]+)|(%d+)$")
                local v936 = v934
                if v936 then
                    v936 = v917
                end
                if v936 then
                    local v928 = tonumber(v917)
                    if not v928 then
                        v928 = 0
                    end
                    if v920 - v928 < 600 then
                        v931[v934] = v928
                    end
                end
            end
        end
    end
    return v931
end
local v5077 = function(v945)
    if not writefile then
        return
    end
    local v1030 = v5218()
    v1030[v945] = os.time()
    local v995 = {}
    for v1047, v1032 in pairs(v1030) do
        table.insert(v995, v1047 .. "|" .. tostring(v1032))
    end
    pcall(function()
        writefile("ServerHop.txt", (table.concat(v995, "\n")))
        return
    end)
    return
end
v4987(function()
    pcall(function()
        if getconnections then
            for v1101, v1088 in ipairs((getconnections(v5051.Idled))) do
                if v1088.Disable then
                    local v1091 = v1088
                    v1091:Disable()
                else
                    if v1088.Disconnect then
                        local v1105 = v1088
                        v1105:Disconnect()
                    end
                end
            end
        end
        return
    end)
    local v1293 = function()
        pcall(function()
            local v1164 = v5330
            v1164:CaptureController()
            local v1172 = 0
            local v1166 = Vector2.new(v1172, v1172)
            local v1170 = v5330
            v1170:Button2Down(v1166, v4938.CurrentCamera.CFrame)
            task.wait(0.1)
            local v1155 = 0
            local v1153 = Vector2.new(v1155, v1155)
            local v1154 = v5330
            v1154:Button2Up(v1153, v4938.CurrentCamera.CFrame)
            return
        end)
        return
    end
    local v1306 = v5051.Idled
    table.insert(v5261, (v1306:Connect(v1293)))
    task.spawn(function()
        while v5075 do
            task.wait(300)
            local v1266 = v4991.AntiAFK
            if v1266 then
                v1266 = v5075
            end
            if v1266 then
                pcall(function()
                    local v1226 = v5330
                    v1226:CaptureController()
                    local v1244 = 0
                    local v1229 = Vector2.new(v1244, v1244)
                    local v1232 = v5330
                    v1232:Button2Down(v1229, v4938.CurrentCamera.CFrame)
                    task.wait(0.1)
                    local v1247 = 0
                    local v1253 = Vector2.new(v1247, v1247)
                    local v1233 = v5330
                    v1233:Button2Up(v1253, v4938.CurrentCamera.CFrame)
                    return
                end)
            end
        end
        return
    end)
    return
end)
local v5047 = function(v1307)
    if not v1307 then
        return
    end
    local v1361 = v1307
    for v1356, v1351 in ipairs((v1361:GetDescendants())) do
        local v1358 = v1351
        local v1368 = v1358:IsA("BasePart")
        if v1368 then
            v1368 = v1351.CanCollide
        end
        if v1368 then
            pcall(function()
                v1351.CanCollide = false
                return
            end)
        end
    end
    return
end
local v5404 = function()
    local v1383 = v4966
    if v1383 then
        v1383 = v5051.Character
    end
    if v1383 then
        v1383 = v5075
    end
    if v1383 then
        v5047(v5051.Character)
    end
    return
end
local v5385 = v5565.Stepped
table.insert(v5261, (v5385:Connect(v5404)))
local v5349 = function(v1385)
    task.wait(0.5)
    local v1398 = v4966
    if v1398 then
        v1398 = v5075
    end
    if v1398 then
        v5047(v1385)
    end
    return
end
local v5372 = v5051.CharacterAdded
table.insert(v5261, (v5372:Connect(v5349)))
local v4998
local v5452, v5642 = pcall(function()
    local v1425 = game
    return (loadstring((v1425:HttpGet("https://raw.githubusercontent.com/systemyour2/ajaxx/refs/heads/main/uigan.lua")))())
end)
local v5630 = v5452
if v5630 then
    v5630 = type(v5642) == "table"
end
if v5630 then
    v4998 = v5642
    v4998.UnloadEnabled = true
else
    warn("[N3K0P01 HUB] ModernV2 UI load warning: " .. tostring(v5642))
end
local v5197 = function(v1428, v1429, v1430)
    pcall(function()
        local v1482 = v4998
        if v1482 then
            v1482 = v4998.Notifier
        end
        if v1482 then
            v1482 = v4998.Notifier.new
        end
        if v1482 then
            local v1487 = v4998.Notifier.new
            local v1499 = {}
            local v1477 = v1428
            if not v1477 then
                v1477 = "N3K0P01 HUB"
            end
            v1499.Title = v1477
            local v1480 = v1429
            if not v1480 then
                v1480 = ""
            end
            v1499.Content = v1480
            local v1481 = v1430
            if not v1481 then
                v1481 = 3
            end
            v1499.Duration = v1481
            v1499.Icon = "lucide:bell"
            v1487(v1499)
        else
            local v1498 = game
            if v1498:GetService("StarterGui") then
                local v1502 = game
                local v1488 = v1502:GetService("StarterGui")
                local v1476 = {}
                local v1500 = v1428
                if not v1500 then
                    v1500 = "N3K0P01 HUB"
                end
                v1476.Title = v1500
                local v1492 = v1429
                if not v1492 then
                    v1492 = ""
                end
                v1476.Text = v1492
                local v1495 = v1430
                if not v1495 then
                    v1495 = 3
                end
                v1476.Duration = v1495
                local v1491 = v1488
                v1491:SetCore("SendNotification", v1476)
            end
        end
        return
    end)
    return
end
local v5205
local v5255
local v5259
local v5396 = v4998
if v5396 then
    v5396 = v4998.CreateWindow
end
if v5396 then
    local v5440, v5660 = pcall(function()
        local v1553 = {}
        local v1547 = "N3K0P01 HUB"
        v1553.Name = v1547
        v1553.Title = v1547
        v1553.Content = "Violence District"
        v1553.Logo = "rbxassetid://82977550246652"
        v1553.Color = Color3.fromRGB(168, 85, 247)
        v1553.ConfigFolder = "N3K0P01_HUB_Configs"
        v1553.Search = false
        local v1548 = true
        v1553.ShowUser = v1548
        v1553.TextGradient = v1548
        v1553.NotifyOnCallbackError = false
        local v1550 = v4998
        return (v1550:CreateWindow(v1553))
    end)
    local v5530 = v5440
    if v5530 then
        v5530 = v5660
    end
    if v5530 then
        v5259 = v5660
    end
end
local v5135
pcall(function()
    local v2131 = gethui
    if not v2131 then
        v2131 = function()
            local v1593 = game
            return (v1593:GetService("CoreGui"))
        end
    end
    local v2100
    pcall(function()
        v2100 = v2131()
        return
    end)
    if not v2100 then
        pcall(function()
            local v1611 = game
            v2100 = v1611:GetService("CoreGui")
            return
        end)
    end
    if not v2100 then
        local v2316 = v5051
        v2100 = v2316:WaitForChild("PlayerGui")
    end
    local v2208 = v2100
    for v2269, v2315 in ipairs((v2208:GetChildren())) do
        if v2315.Name == "N3K0P01_HUB_FloatingToggle" then
            local v2298 = v2315
            v2298:Destroy()
        end
    end
    v5135 = Instance.new("ScreenGui")
    local v2274 = v5135
    v2274.Name = "N3K0P01_HUB_FloatingToggle"
    v2274.ResetOnSpawn = false
    v2274.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    v2274.DisplayOrder = 999999
    v2274.Parent = v2100
    local v2115 = Instance.new("ImageButton")
    v2115.Name = "CircleButton"
    local v2214 = 0.5
    v2115.AnchorPoint = Vector2.new(v2214, v2214)
    v2115.Size = UDim2.new(0, 50, 0, 50)
    local v2296 = 0
    v2115.Position = UDim2.new(v2296, 55, 0.45, v2296)
    local v2301 = 18
    v2115.BackgroundColor3 = Color3.fromRGB(v2301, v2301, 26)
    v2115.BackgroundTransparency = 0.1
    v2115.BorderSizePixel = 0
    v2115.AutoButtonColor = false
    v2115.ZIndex = 100
    v2115.Parent = v5135
    local v2282 = Instance.new("UICorner")
    v2282.CornerRadius = UDim.new(1, 0)
    v2282.Parent = v2115
    local v2260 = Instance.new("UIStroke")
    v2260.Color = Color3.fromRGB(168, 85, 247)
    v2260.Thickness = 2
    v2260.Transparency = 0
    v2260.Parent = v2115
    local v2193 = Instance.new("ImageLabel")
    v2193.Name = "LogoIcon"
    local v2325 = 0.5
    v2193.AnchorPoint = Vector2.new(v2325, v2325)
    v2193.Position = UDim2.new(0.5, 0, 0.5, 0)
    v2193.Size = UDim2.new(0.68, 0, 0.68, 0)
    v2193.BackgroundTransparency = 1
    v2193.Image = "rbxassetid://76222344614410"
    v2193.ScaleType = Enum.ScaleType.Fit
    v2193.ZIndex = 101
    v2193.Parent = v2115
    local v2085 = false
    local v2129
    local v2094
    local v2098 = 0
    local v2207 = v2115.InputBegan
    v2207:Connect(function(v1613)
        local v1641 = v1613.UserInputType == Enum.UserInputType.MouseButton1
        if not v1641 then
            v1641 = v1613.UserInputType == Enum.UserInputType.Touch
        end
        if v1641 then
            v2085 = true
            v2098 = 0
            v2129 = v1613.Position
            v2094 = v2115.Position
        end
        return
    end)
    local v2252 = v5044.InputChanged
    local v2230 = function(v1654)
        local v1777 = v2085
        if v1777 then
            v1777 = v1654.UserInputType == Enum.UserInputType.MouseMovement
            if not v1777 then
                v1777 = v1654.UserInputType == Enum.UserInputType.Touch
            end
        end
        if v1777 then
            local v1755 = v1654.Position - v2129
            v2098 = v1755.Magnitude
            if v2098 > 7 then
                local v1761 = v4938.CurrentCamera
                local v1768 = v1761
                if v1768 then
                    v1768 = v1761.ViewportSize
                end
                if not v1768 then
                    v1768 = Vector2.new(1280, 720)
                end
                v2115.Position = UDim2.new(0, math.clamp(v2094.X.Offset + v1755.X, 25, v1768.X - 25), 0, (math.clamp(v2094.Y.Offset + v1755.Y, 25, v1768.Y - 25)))
            end
        end
        return
    end
    local v2276 = v2252
    v2276:Connect(v2230)
    local v2177 = function()
        pcall(function()
            local v1894 = v2115
            local v1918 = Enum
            local v1909 = TweenInfo.new(0.08, v1918.EasingStyle.Quad, v1918.EasingDirection.Out)
            local v1886 = {}
            v1886.Size = UDim2.new(0, 42, 0, 42)
            local v1888 = v5004
            local v1899 = v1888:Create(v1894, v1909, v1886)
            local v1900 = Enum
            local v1906 = TweenInfo.new(0.14, v1900.EasingStyle.Back, v1900.EasingDirection.Out)
            local v1876 = {}
            v1876.Size = UDim2.new(0, 50, 0, 50)
            local v1911 = v5004
            local v1853 = v1911:Create(v1894, v1906, v1876)
            local v1908 = v1899
            v1908:Play()
            local v1885 = function()
                local v1809 = v1853
                v1809:Play()
                return
            end
            local v1887 = v1899.Completed
            v1887:Connect(v1885)
            return
        end)
        local v1991 = v5259
        if v1991 then
            v1991 = v5259.ToggleInterface
        end
        if v1991 then
            local v1980 = v5259
            v1980:ToggleInterface()
        else
            local v1981 = v4998
            if v1981 then
                v1981 = v4998.FireKeybind
            end
            if v1981 then
                local v1975 = v4998
                v1975:FireKeybind()
            else
                local v1960 = v5259
                if v1960 then
                    v1960 = v5259.Signal
                end
                if v1960 then
                    local v1976 = v5259
                    local v1989 = v1976.Signal
                    local v1974 = v1976.Signal
                    local v1972 = not v1974:GetValue()
                    local v1973 = v1989
                    v1973:SetValue(v1972)
                else
                    local v1962 = v4998
                    if v1962 then
                        v1962 = v4998.ScreenGui
                    end
                    if v1962 then
                        local v1969 = v4998
                        v1969.ScreenGui.Enabled = not v1969.ScreenGui.Enabled
                    end
                end
            end
        end
        return
    end
    local v2277 = function(v1992)
        local v2022 = v1992.UserInputType == Enum.UserInputType.MouseButton1
        if not v2022 then
            v2022 = v1992.UserInputType == Enum.UserInputType.Touch
        end
        if v2022 then
            if v2085 then
                v2085 = false
                if v2098 <= 7 then
                    v2177()
                end
            end
        end
        return
    end
    local v2205 = v5044.InputEnded
    v2205:Connect(v2277)
    return
end)
local v5365 = v5259
if v5365 then
    v5365 = v5259.AddTab
end
if v5365 then
    local v5517 = {Name = "Auto Farm", Icon = "crosshairs", Type = "Double"}
    local v5543 = v5259
    local v5492 = v5543:AddTab(v5517)
    local v5603 = {Name = "Core Auto Farm", Position = "left"}
    local v5350 = v5492
    local v5477 = v5350:AddSection(v5603)
    local v5512 = {
        Name = "Auto Farm",
        Default = v4991.AutoFarm,
        Callback = function(v2327)
            v4991.AutoFarm = v2327
            if not v2327 then
                v5249 = false
                v5107 = nil
            end
            return
        end,
    }
    local v5649 = v5477
    v5649:AddToggle(v5512)
    local v5506 = {
        Name = "Auto Hop After Escape",
        Default = v4991.AutoHopAfterEscape,
        Callback = function(v2340)
            v4991.AutoHopAfterEscape = v2340
            return
        end,
    }
    local v5595 = v5477
    v5595:AddToggle(v5506)
    local v5593 = {
        Name = "Disable Killer Chance",
        Default = v4991.DisableKillerChance,
        Callback = function(v2347)
            v4991.DisableKillerChance = v2347
            return
        end,
    }
    local v5562 = v5477
    v5562:AddToggle(v5593)
    local v5556 = {
        Name = "Hop If Killer",
        Default = v4991.HopIfKiller,
        Callback = function(v2354)
            v4991.HopIfKiller = v2354
            return
        end,
    }
    local v5399 = v5477
    v5399:AddToggle(v5556)
    local v5442 = {
        Name = "Instant Finish Teleport",
        Default = v4991.InstantFinish,
        Callback = function(v2361)
            v4991.InstantFinish = v2361
            return
        end,
    }
    local v5407 = v5477
    v5407:AddToggle(v5442)
    local v5557 = {
        Name = "Tween Speed",
        Default = v4991.GateTweenSpeed,
        Min = 20,
        Max = 300,
        Rounding = 0,
        Callback = function(v2368)
            v4991.GateTweenSpeed = v2368
            return
        end,
    }
    local v5424 = v5477
    v5424:AddSlider(v5557)
    local v5577 = {Name = "Protections & Exploits", Position = "right"}
    local v5406 = v5492
    local v5544 = v5406:AddSection(v5577)
    local v5610 = {
        Name = "Anti-AFK System",
        Default = v4991.AntiAFK,
        Callback = function(v2375)
            v4991.AntiAFK = v2375
            return
        end,
    }
    local v5379 = v5544
    v5379:AddToggle(v5610)
    local v5510 = {
        Name = "Ghost NoClip",
        Default = v4991.NoClip,
        Callback = function(v2382)
            v4991.NoClip = v2382
            v4966 = v2382
            return
        end,
    }
    local v5469 = v5544
    v5469:AddToggle(v5510)
    local v5566 = v5544
    v5566:AddLabel("Status: Active (Violence District)")
    local v5583 = v5544
    v5583:AddLabel("Mode: Survivor Fast Escape")
    local v5536 = {
        Name = "Server Hop",
        Icon = "sliders-horizontal",
        Type = "Double",
    }
    local v5600 = v5259
    local v5475 = v5600:AddTab(v5536)
    local v5656 = {Name = "Target Player Range (1-3)", Position = "left"}
    local v5650 = v5475
    local v5355 = v5650:AddSection(v5656)
    local v5507 = {
        Name = "Min Players",
        Default = v4991.MinPlayers,
        Min = 1,
        Max = 4,
        Rounding = 0,
        Callback = function(v2389)
            v4991.MinPlayers = v2389
            return
        end,
    }
    local v5614 = v5355
    v5614:AddSlider(v5507)
    local v5502 = {
        Name = "Max Players",
        Default = v4991.MaxPlayers,
        Min = 1,
        Max = 8,
        Rounding = 0,
        Callback = function(v2396)
            v4991.MaxPlayers = v2396
            return
        end,
    }
    local v5430 = v5355
    v5430:AddSlider(v5502)
    local v5648 = {
        Name = "Auto Execute On Hop",
        Default = v4991.AutoExecuteOnHop,
        Callback = function(v2403)
            v4991.AutoExecuteOnHop = v2403
            return
        end,
    }
    local v5581 = v5355
    v5581:AddToggle(v5648)
    local v5454 = {Name = "Hop Controls", Position = "right"}
    local v5439 = v5475
    local v5383 = v5439:AddSection(v5454)
    local v5387 = {
        Name = "Server Hop Now",
        Callback = function()
            if v5205 then
                v5205()
            end
            return
        end,
    }
    local v5443 = v5383
    v5443:AddButton(v5387)
    local v5629 = {
        Name = "Rejoin This Server",
        Callback = function()
            local v2439 = v4928
            v2439:TeleportToPlaceInstance(v5240, v4945, v5051)
            return
        end,
    }
    local v5516 = v5383
    v5516:AddButton(v5629)
    local v5494 = {
        Name = "Reset Blacklist Hop",
        Callback = function()
            pcall(function()
                if delfile then
                    delfile("ServerHop.txt")
                end
                return
            end)
            v5197("N3K0P01 HUB", "Blacklist ServerHop.txt di-reset!", 3)
            return
        end,
    }
    local v5484 = v5383
    v5484:AddButton(v5494)
    local v5621 = {Name = "Settings", Icon = "bell", Type = "Double"}
    local v5369 = v5259
    local v5485 = v5369:AddTab(v5621)
    local v5561 = {Name = "Discord Webhook", Position = "left"}
    local v5612 = v5485
    local v5444 = v5612:AddSection(v5561)
    local v5421 = {
        Name = "Enable Webhook Log",
        Default = v4991.EnableWebhook,
        Callback = function(v2470)
            v4991.EnableWebhook = v2470
            return
        end,
    }
    local v5463 = v5444
    v5463:AddToggle(v5421)
    local v5427 = {
        Name = "Webhook URL",
        Default = v4991.WebhookURL,
        Placeholder = "https://discord.com/api/webhooks/...",
        Callback = function(v2477)
            v4991.WebhookURL = v2477
            N3K0P01_SaveWebhookURL(v2477)
            return
        end,
    }
    local v5528 = v5444
    v5528:AddTextInput(v5427)
    local v5374 = {
        Name = "Send Test Webhook",
        Callback = function()
            if v5255 then
                v5255("🔔 Test Connection - N3K0P01 HUB", true)
            end
            v5197("N3K0P01 HUB Webhook", "Test webhook dikirim!", 3)
            return
        end,
    }
    local v5420 = v5444
    v5420:AddButton(v5374)
    local v5616 = {Name = "Controls & Unload", Position = "right"}
    local v5456 = v5485
    local v5446 = v5456:AddSection(v5616)
    local v5638 = {
        Name = "Unload N3K0P01 HUB Script",
        Callback = function()
            v5075 = false
            local v2610 = false
            v4991.AutoFarm = v2610
            v4966 = v2610
            if getgenv then
                getgenv().N3K0P01_HUB_LOADED = nil
            end
            for v2597, v2554 in ipairs(v5261) do
                pcall(function()
                    local v2522 = v2554
                    v2522:Disconnect()
                    return
                end)
            end
            pcall(function()
                if v5135 then
                    local v2533 = v5135
                    v2533:Destroy()
                end
                return
            end)
            local v2584 = v4998
            if v2584 then
                v2584 = v4998.Unload
            end
            if v2584 then
                pcall(function()
                    local v2546 = v4998
                    v2546:Unload()
                    return
                end)
            end
            v5197("N3K0P01 HUB", "Script berhasil di-unload.", 3)
            return
        end,
    }
    local v5388 = v5446
    v5388:AddButton(v5638)
end
local function maskWebhookName(value)
    local name = tostring(value or "")
    if #name <= 3 then
        return string.rep("*", math.max(3, #name))
    end
    return string.sub(name, 1, 3) .. "******"
end

local v5256 = function(v2611, v2612)
    local v3028 = not v2612
    if v3028 then
        v3028 = not v4991.EnableWebhook
    end
    if v3028 then
        return
    end
    local v3027 = not v4991.WebhookURL
    if not v3027 then
        v3027 = v4991.WebhookURL == ""
    end
    if not v3027 then
        v3027 = not string.find(v4991.WebhookURL, "discord.com/api/webhooks")
    end
    if v3027 then
        if v2612 then
            v5197("N3K0P01 HUB", "Webhook URL tidak valid!", 3)
        end
        return
    end
    v4987(function()
        pcall(function()
            if not v4951 then
                return
            end
            local v2928 = v5051
            local v2837 = v2928:GetAttributes()
            if not v2837 then
                v2837 = {}
            end
            local v2898 = tonumber(v2837.Level)
            if not v2898 then
                v2898 = v5324.Level
            end
            if not v2898 then
                v2898 = 0
            end
            local v2940 = tonumber(v2837.EXP)
            if not v2940 then
                v2940 = v5324.EXP
            end
            if not v2940 then
                v2940 = 0
            end
            local v2874 = tonumber(v2837.Screws)
            if not v2874 then
                v2874 = v5324.Screws
            end
            if not v2874 then
                v2874 = 0
            end
            local v2879 = tonumber(v2837.Gears)
            if not v2879 then
                v2879 = v5324.Gears
            end
            if not v2879 then
                v2879 = 0
            end
            local v2862 = tonumber(v2837.SIN)
            if not v2862 then
                v2862 = v5324.SIN
            end
            if not v2862 then
                v2862 = 0
            end
            local v2902 = v5324.EXP
            if not v2902 then
                v2902 = v2940
            end
            local v2954 = v5324.Screws
            if not v2954 then
                v2954 = v2874
            end
            local v2849 = v5324.Gears
            if not v2849 then
                v2849 = v2879
            end
            local v2941 = {}
            local v2931 = {}
            local v2909 = {}
            local v2912 = v2611
            if not v2912 then
                v2912 = "🏆 Ronde Berhasil Selesai!"
            end
            v2909.title = v2912
            local v2868 = v2612
            if v2868 then
                v2868 = 3718648
            end
            if not v2868 then
                v2868 = 11032055
            end
            v2909.color = v2868
            local v2866 = {}
            local v2847 = {name = "Pemain"}
            local v2895 = v5051
            v2847.value = maskWebhookName(v2895.DisplayName) .. " (@" .. maskWebhookName(v2895.Name) .. ")"
            v2847.inline = true
            local v2976 = {name = "Level"}
            v2976.value = tostring(v2898)
            v2976.inline = true
            local v2975 = {name = "Role"}
            local v2947 = v5199
            if not v2947 then
                v2947 = "Survivor"
            end
            v2975.value = v2947
            v2975.inline = true
            local v2967 = {name = "💀 SIN"}
            v2967.value = tostring(v2862)
            v2967.inline = true
            local v2878 = {name = "🧪 EXP"}
            v2878.value = string.format("%d (**%+d**)", v2940, v2940 - v2902)
            v2878.inline = true
            local v2946 = {name = "🔩 Screws"}
            v2946.value = string.format("%d (**%+d**)", v2874, v2874 - v2954)
            v2946.inline = true
            local v2932 = {name = "⚙️ Gears"}
            v2932.value = string.format("%d (**%+d**)", v2879, v2879 - v2849)
            v2932.inline = true
            local v2911 = {name = "🆔 Server ID"}
            local v2865 = v4945 ~= ""
            if v2865 then
                v2865 = v4945
            end
            if not v2865 then
                v2865 = "Singleplayer"
            end
            v2911.value = "```\n" .. tostring(v2865) .. "\n```"
            v2911.inline = false
            v2866[1] = v2847
            v2866[2] = v2976
            v2866[3] = v2975
            v2866[4] = v2967
            v2866[5] = v2878
            v2866[6] = v2946
            v2866[7] = v2932
            v2866[8] = v2911
            v2909.fields = v2866
            local v2937 = {
                text = "N3K0P01 HUB · Violence District Auto-Farm (" .. v5038() .. ")",
            }
            v2909.footer = v2937
            v2909.timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
            v2931[1] = v2909
            v2941.embeds = v2931
            local v2951 = v5324
            v2951.Level = v2898
            v2951.EXP = v2940
            v2951.Screws = v2874
            v2951.Gears = v2879
            v2951.SIN = v2862
            v5321(v5324)
            local v2850 = {Url = v4991.WebhookURL, Method = "POST"}
            local v2904 = {["Content-Type"] = "application/json"}
            v2850.Headers = v2904
            local v2903 = v5063
            v2850.Body = v2903:JSONEncode(v2941)
            v4951(v2850)
            return
        end)
        return
    end)
    return
end
local v5206 = function()
    if v5263 then
        return
    end
    v5263 = true
    v5197("N3K0P01 HUB", "📡 Mencari server 1-3 player...", 3)
    if v4991.AutoExecuteOnHop then
        v5072(v5056)
    end
    local v3404 = v5218()
    local v3359 = ""
    local v3407 = 0
    local v3335 = v4991.MinPlayers
    if not v3335 then
        v3335 = 1
    end
    local v3338 = v4991.MaxPlayers
    if not v3338 then
        v3338 = 3
    end
    local v3294
    local v3373
    local v3424
    while (v3407 < 8) do
        v3407 = v3407 + 1
        local v3426 = string.format
        local v3420 = tostring(v5240)
        local v3369 = v5063
        local v3205 = v3426("https://games.roblox.com/v1/games/%s/servers/Public?limit=100&sortOrder=Asc&excludeFullGames=true&cursor=%s", v3420, (v3369:UrlEncode(v3359)))
        local v3405, v3263 = pcall(function()
            local v3072 = game
            return (v3072:HttpGet(v3205))
        end)
        local v3365 = v3405
        if v3365 then
            v3365 = v3263
        end
        if v3365 then
            v3365 = #v3263 > 0
        end
        if v3365 then
            local v3227
            pcall(function()
                local v3133 = v5063
                v3227 = v3133:JSONDecode(v3263)
                return
            end)
            local v3411 = v3227
            if v3411 then
                v3411 = v3227.data
            end
            if v3411 then
                for v3349, v3275 in ipairs(v3227.data) do
                    local v3345 = v3275.id ~= v4945
                    if v3345 then
                        v3345 = not v3404[v3275.id]
                    end
                    if v3345 then
                        local v3415 = v3275.playing
                        if not v3415 then
                            v3415 = 0
                        end
                        local v3360 = v3275.maxPlayers
                        if not v3360 then
                            v3360 = 10
                        end
                        if v3415 < v3360 then
                            local v3353 = v3415 >= v3335
                            if v3353 then
                                v3353 = v3415 <= v3338
                            end
                            if v3353 then
                                v5077(v3275.id)
                                v5197("N3K0P01 HUB", string.format("📡 Teleport ke server: %d player", v3415), 3)
                                if not not pcall(function()
                                    local v3159 = v4928
                                    v3159:TeleportToPlaceInstance(v5240, v3275.id, v5051)
                                    return
                                end) then
                                    v5333(5)
                                    return
                                end
                                v5077(v3275.id)
                            else
                                local v3377 = not v3294
                                if v3377 then
                                    v3377 = v3415 < v3360 - 1
                                end
                                if v3377 then
                                    v3294 = v3275
                                end
                            end
                        end
                    end
                end
                local v3379 = v3227.nextPageCursor
                if v3379 then
                    v3379 = v3227.nextPageCursor ~= ""
                end
                if not v3379 then
                    if v3294 then
                        v3424 = v3294.playing
                        if not v3424 then
                            v3424 = 0
                        end
                        v5197("N3K0P01 HUB", string.format("📡 Teleport ke server cadangan: %d player", v3424), 3)
                        v5077(v3294.id)
                        v3373 = pcall(function()
                            local v3117 = v4928
                            v3117:TeleportToPlaceInstance(v5240, v3294.id, v5051)
                            return
                        end)
                        if v3373 then
                            v5333(5)
                            return
                        end
                    end
                    v5197("N3K0P01 HUB", "⚠️ Server target penuh, mencoba server acak...", 3)
                    pcall(function()
                        local v3088 = v4928
                        v3088:Teleport(v5240, v5051)
                        return
                    end)
                    v5333(4)
                    v5263 = false
                    return
                end
                v3359 = v3227.nextPageCursor
            end
        end
        v5333(1)
    end
    if v3294 then
        v3424 = v3294.playing
        if not v3424 then
            v3424 = 0
        end
        v5197("N3K0P01 HUB", string.format("📡 Teleport ke server cadangan: %d player", v3424), 3)
        v5077(v3294.id)
        v3373 = pcall(function()
            local v3117 = v4928
            v3117:TeleportToPlaceInstance(v5240, v3294.id, v5051)
            return
        end)
        if v3373 then
            v5333(5)
            return
        end
    end
    v5197("N3K0P01 HUB", "⚠️ Server target penuh, mencoba server acak...", 3)
    pcall(function()
        local v3088 = v4928
        v3088:Teleport(v5240, v5051)
        return
    end)
    v5333(4)
    v5263 = false
    return
end
local v5402 = function(v3444, v3445, v3446)
    if v3444 == v5051 then
        local v3479 = false
        v5263 = v3479
        v5235 = v3479
        v5197("N3K0P01 HUB", "Teleport gagal: " .. tostring(v3446), 3)
        if v4945 ~= "" then
            v5077(v4945)
        end
        v5333(2)
        v5206()
    end
    return
end
local v5340 = v4928.TeleportInitFailed
v5340:Connect(v5402)
local v5281 = function()
    local v3719
    pcall(function()
        local v3659 = v4938
        local v3685 = v3659:FindFirstChild("Map")
        if not v3685 then
            return nil
        end
        local v3627 = v3685
        for v3712, v3683 in ipairs((v3627:GetDescendants())) do
            local v3672 = v3683
            local v3711 = v3672:IsA("BasePart")
            if not v3711 then
                local v3664 = v3683
                v3711 = v3664:IsA("Model")
            end
            if v3711 then
                local v3700 = tostring(v3683.Name)
                local v3705 = v3700:lower()
                local v3666 = v3705
                local v3697 = v3666:find("finish")
                if not v3697 then
                    v3697 = v3705 == "finishline"
                end
                if not v3697 then
                    v3697 = v3705 == "fininshline"
                end
                if v3697 then
                    local v3644 = v3683
                    if v3644:IsA("BasePart") then
                        v3719 = v3683.Position
                        return
                    end
                    local v3638 = v3683
                    local v3637 = v3638:IsA("Model")
                    if v3637 then
                        v3637 = v3683.PrimaryPart
                    end
                    if v3637 then
                        v3719 = v3683.PrimaryPart.Position
                        return
                    end
                end
            end
        end
        local v3680 = v3685
        local v3632 = v3680:FindFirstChild("Rooftop")
        if not v3632 then
            local v3630 = v3685
            v3632 = v3630:FindFirstChild("RooftopHitbox")
        end
        if v3632 then
            v3719 = Vector3.new(1546.12, 152.21, -796.72)
            return
        end
        local v3693 = v3685
        if v3693:FindFirstChild("churchbell") then
            v3719 = Vector3.new(760.98, -20.14, -78.48)
            return
        end
        local v3646 = v3685
        if v3646:FindFirstChild("HooksMeat") then
            v3719 = Vector3.new(-947.9, 152.12, -7579.52)
            return
        end
        local v3626 = v3685
        local v3687 = v3626:FindFirstChild("FinishLine")
        if not v3687 then
            local v3657 = v3685
            v3687 = v3657:FindFirstChild("Finishline")
        end
        local v3653 = v3687
        if v3653 then
            local v3706 = v3687
            v3653 = v3706:IsA("BasePart")
        end
        if v3653 then
            v3719 = v3687.Position
            return
        end
        v3719 = Vector3.new(3098.16, 454.04, -4918.74)
        return
    end)
    return v3719
end
local v4964 = function()
    local v3852 = "Survivor"
    pcall(function()
        if v5051.Team then
            local v3821 = tostring(v5051.Team.Name)
            local v3805 = v3821:lower()
            local v3846 = v3805
            if v3846:find("killer") then
                v3852 = "Killer"
                return
            end
            local v3793 = v3805
            if v3793:find("survivor") then
                v3852 = "Survivor"
                return
            end
            local v3822 = v3805
            if v3822:find("spectator") then
                v3852 = "Spectator"
                return
            end
        end
        local v3844 = v5051.Character
        if v3844 then
            local v3808 = v3844
            local v3830 = v3808:FindFirstChild("Team")
            if not v3830 then
                local v3800 = v3844
                v3830 = v3800:FindFirstChild("Role")
            end
            if v3830 then
                local v3819 = v3830.Value
                if not v3819 then
                    v3819 = v3830.Name
                end
                local v3795 = tostring(v3819)
                local v3807 = v3795:lower()
                local v3828 = v3807
                if v3828:find("killer") then
                    v3852 = "Killer"
                    return
                end
                local v3841 = v3807
                if v3841:find("survivor") then
                    v3852 = "Survivor"
                    return
                end
                local v3810 = v3807
                if v3810:find("spectator") then
                    v3852 = "Spectator"
                    return
                end
            end
        end
        return
    end)
    return v3852
end
local v5029 = function()
    local v4074 = game
    local v4113 = v4074:GetService("ReplicatedStorage")
    local v4171 = {
        "Status",
        "State",
        "GameState",
        "RoundStatus",
        "GameStatus",
        "Timer",
        "RoundTime",
        "Intermission",
        "Round",
        "Match",
        "GameValues",
    }
    for v4051, v4108 in ipairs(v4171) do
        local v4144 = v4113
        local v4119 = v4144:FindFirstChild(v4108, true)
        local v4120 = v4119
        if v4120 then
            local v4182 = v4119
            v4120 = v4182:IsA("StringValue")
            if not v4120 then
                local v4077 = v4119
                v4120 = v4077:IsA("IntValue")
            end
            if not v4120 then
                local v4138 = v4119
                v4120 = v4138:IsA("NumberValue")
            end
        end
        if v4120 then
            local v4094 = tostring(v4119.Value)
            local v4109 = v4094:lower()
            local v4086 = v4109
            local v4050 = v4086:find("intermission")
            if not v4050 then
                local v4063 = v4109
                v4050 = v4063:find("waiting")
            end
            if not v4050 then
                local v4041 = v4109
                v4050 = v4041:find("starting")
            end
            if not v4050 then
                local v4047 = v4109
                v4050 = v4047:find("lobby")
            end
            if not v4050 then
                local v4148 = v4109
                v4050 = v4148:find("prepare")
            end
            if v4050 then
                return true, (tostring(v4119.Value))
            end
        end
    end
    local v4085 = v5051
    local v4130 = v4085:FindFirstChild("PlayerGui")
    if v4130 then
        local v4116 = v4130
        for v4038, v4181 in ipairs((v4116:GetDescendants())) do
            local v4163 = v4181
            local v4123 = v4163:IsA("TextLabel")
            if v4123 then
                v4123 = v4181.Visible
            end
            if v4123 then
                local v4118 = v4181.Text
                if not v4118 then
                    v4118 = ""
                end
                local v4179 = tostring(v4118)
                local v4064 = v4179:lower()
                local v4165 = v4064
                local v4068 = v4165:find("intermission")
                if not v4068 then
                    local v4140 = v4064
                    v4068 = v4140:find("starting in")
                end
                if not v4068 then
                    local v4124 = v4064
                    v4068 = v4124:find("starts in")
                end
                if not v4068 then
                    local v4062 = v4064
                    v4068 = v4062:find("game start")
                end
                if not v4068 then
                    local v4049 = v4064
                    v4068 = v4049:find("round start")
                end
                if not v4068 then
                    local v4048 = v4064
                    v4068 = v4048:find("waiting for")
                end
                if v4068 then
                    return true, v4181.Text
                end
            end
        end
    end
    local v4168 = v4938
    local v4145 = v4168:FindFirstChild("Lobby")
    if not v4145 then
        local v4134 = v4938
        v4145 = v4134:FindFirstChild("SpawnLocation")
    end
    local v4081 = v5051.Character
    local v4054 = v4081
    if v4054 then
        local v4106 = v4081
        v4054 = v4106:FindFirstChild("HumanoidRootPart")
    end
    local v4104 = v4145
    if v4104 then
        v4104 = v4054
    end
    if v4104 then
        local v4080 = v4145
        local v4069 = v4080:IsA("BasePart")
        if v4069 then
            v4069 = v4145.Position
        end
        if not v4069 then
            local v4161 = v4145
            v4069 = v4161:FindFirstChildWhichIsA("BasePart")
            if v4069 then
                local v4127 = v4145
                v4069 = v4127:FindFirstChildWhichIsA("BasePart").Position
            end
        end
        local v4045 = v4069
        if v4045 then
            v4045 = (v4054.Position - v4069).Magnitude < 130
        end
        if v4045 then
            return true, "Masih di Lobby"
        end
    end
    return false, "In Match"
end
v4987(function()
    while v5075 do
        if v4991.DisableKillerChance then
            pcall(function()
                local v4232 = v4934
                local v4237 = v4232:FindFirstChild("Remotes")
                if not v4237 then
                    v4237 = v4934
                end
                local v4231 = v4237
                local v4226 = v4231:FindFirstChild("SetKillerChance")
                if not v4226 then
                    local v4224 = v4237
                    v4226 = v4224:FindFirstChild("KillerChance")
                end
                local v4219 = v4226
                if v4219 then
                    local v4228 = v4226
                    v4219 = v4228:IsA("RemoteEvent")
                end
                if v4219 then
                    local v4234 = v4226
                    v4234:FireServer(0)
                end
                return
            end)
        end
        v5333(10)
    end
    return
end)
pcall(function()
    local v4363 = v4934
    local v4366 = v4363:WaitForChild("Remotes", 5)
    if v4366 then
        local v4371 = v4366
        local v4369 = v4371:WaitForChild("StatusUpdateEvent", 5)
        local v4374 = v4369
        if v4374 then
            local v4354 = v4369
            v4374 = v4354:IsA("RemoteEvent")
        end
        if v4374 then
            local v4357 = v4369.OnClientEvent
            table.insert(v5261, (v4357:Connect(function(v4262)
                local v4279 = v4262 == "IntermissionStarting"
                if not v4279 then
                    v4279 = v4262 == "WaitingForPlayers"
                end
                if not v4279 then
                    v4279 = v4262 == "Intermission"
                end
                if v4279 then
                    v5249 = false
                    v5107 = nil
                end
                return
            end)))
        end
        local v4382 = v4366
        local v4348 = v4382:WaitForChild("TimeUpdateEvent", 5)
        local v4381 = v4348
        if v4381 then
            local v4358 = v4348
            v4381 = v4358:IsA("RemoteEvent")
        end
        if v4381 then
            local v4365 = v4348.OnClientEvent
            table.insert(v5261, (v4365:Connect(function(v4281)
                local v4292 = v4281 == "Round"
                if not v4292 then
                    v4292 = v4281 == "Starting"
                end
                if v4292 then
                    v5249 = false
                end
                return
            end)))
        end
    end
    return
end)
v4987(function()
    while v5075 do
        if v4991.AutoFarm then
            local v4860, v4882 = v5029()
            if v4860 then
                v5197("N3K0P01 HUB", "⏳ Menunggu match (" .. tostring(v4882) .. ")...", 3)
                while true do
                    local v4850 = v4860
                    if v4850 then
                        v4850 = v4991.AutoFarm
                    end
                    if v4850 then
                        v4850 = v5075
                    end
                    if not v4850 then
                        break
                    end
                    v5333(1)
                    local v4848, v4822 = v5029()
                    v4860 = v4848
                end
                local v4794 = not v4991.AutoFarm
                if not v4794 then
                    v4794 = not v5075
                end
                if v4794 then
                    break
                end
                v5197("N3K0P01 HUB", "🎮 Match dimulai! Mempersiapkan teleportasi...", 3)
                v5333(4)
            end
            local v4862 = v5051.Character
            local v4639 = v4862
            if v4639 then
                local v4795 = v4862
                v4639 = v4795:FindFirstChild("HumanoidRootPart")
            end
            if v4639 then
                local v4811 = v4964()
                v5199 = v4811
                local v4904 = v4811 == "Killer"
                if v4904 then
                    v4904 = v4991.HopIfKiller
                end
                if v4904 then
                    v5197("N3K0P01 HUB", "⚠️ Terpilih sebagai Killer! Melakukan Server Hop...", 3)
                    v5333(1.5)
                    v5206()
                else
                    local v4809 = v4811 == "Survivor"
                    if v4809 then
                        v4809 = not v5249
                    end
                    if v4809 then
                        v5249 = true
                        local v4614 = v5281()
                        if v4614 then
                            v5197("N3K0P01 HUB", "📍 Finish line ditemukan! Delay 6s aman...", 3)
                            v5333(6)
                            local v4835 = v4991.AutoFarm
                            if v4835 then
                                v4835 = v4964() == "Survivor"
                            end
                            if v4835 then
                                v4835 = v4639
                            end
                            if v4835 then
                                v4835 = v4639.Parent
                            end
                            if v4835 then
                                v4835 = v5075
                            end
                            if v4835 then
                                v5197("N3K0P01 HUB", "🚀 Teleportasi ke garis finish!", 2)
                                if v4991.InstantFinish then
                                    v4639.CFrame = CFrame.new(v4614 + Vector3.new(0, 4, 0))
                                else
                                    local v4815 = math
                                    local v4776 = TweenInfo.new(v4815.clamp((v4639.Position - v4614).Magnitude / v4815.max(v4991.GateTweenSpeed, 50), 0.5, 4), Enum.EasingStyle.Linear)
                                    local v4762 = {}
                                    v4762.CFrame = CFrame.new(v4614 + Vector3.new(0, 4, 0))
                                    local v4781 = v5004
                                    local v4773 = v4781:Create(v4639, v4776, v4762)
                                    local v4910 = v4773
                                    v4910:Play()
                                    local v4767 = v4773.Completed
                                    v4767:Wait()
                                end
                                pcall(function()
                                    local v4529 = v4938
                                    local v4501 = v4529:FindFirstChild("Map")
                                    if v4501 then
                                        local v4504 = v4501
                                        for v4514, v4527 in ipairs((v4504:GetDescendants())) do
                                            local v4492 = v4527
                                            if v4492:IsA("BasePart") then
                                                local v4495 = tostring(v4527.Name)
                                                local v4494 = v4495:lower()
                                                local v4499 = v4494
                                                local v4511 = v4499:find("finish")
                                                if not v4511 then
                                                    local v4513 = v4494
                                                    v4511 = v4513:find("escape")
                                                end
                                                if not v4511 then
                                                    local v4491 = v4494
                                                    v4511 = v4491:find("line")
                                                end
                                                if not v4511 then
                                                    v4511 = v4494 == "hitbox"
                                                end
                                                if v4511 then
                                                    if (v4527.Position - v4614).Magnitude < 35 then
                                                        local v4493 = firetouchinterest
                                                        if not v4493 then
                                                            v4493 = getgenv
                                                            if v4493 then
                                                                v4493 = getgenv().firetouchinterest
                                                            end
                                                        end
                                                        if v4493 then
                                                            v4493(v4639, v4527, 0)
                                                            task.wait(0.05)
                                                            v4493(v4639, v4527, 1)
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    return
                                end)
                                v5107 = v4614
                                v5197("N3K0P01 HUB", "✅ Berhasil escape ronde ini!", 3)
                                v5256("🏆 Escape Berhasil (N3K0P01 HUB)", false)
                                if v4991.AutoHopAfterEscape then
                                    v5197("N3K0P01 HUB", "🌐 Auto Hop Server dalam 2.5 detik...", 3)
                                    v5333(2.5)
                                    v5206()
                                else
                                    v4987(function()
                                        local v4573 = os.clock()
                                        while true do
                                            local v4571 = os.clock() - v4573 < 25
                                            if v4571 then
                                                v4571 = v5075
                                            end
                                            if not v4571 then
                                                return
                                            end
                                            v5333(1)
                                            if v4964() == "Spectator" then
                                                v5197("N3K0P01 HUB", "👁️ Match selesai (Spectator)", 3)
                                                return
                                            end
                                        end
                                    end)
                                end
                            end
                        else
                            v5249 = false
                            v5197("N3K0P01 HUB", "⚠️ Mencari lokasi finish...", 2)
                        end
                    end
                end
            end
        end
        v5333(1)
    end
    return
end)
print("✅ N3K0P01 HUB Auto Farm Loaded (Anti-Tamper + Anti-Duplicate Protected)")
v5197("N3K0P01 HUB", "🛡️ Script aktif! Anti-Tamper Shield ON", 4)
