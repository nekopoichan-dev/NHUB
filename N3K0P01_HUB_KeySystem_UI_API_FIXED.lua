-- N3K0P01 HUB - Key System UI (Delta/executor-compatible request adapters)
-- Standalone UI only; this does not load or unlock any other script features.
-- API assumptions: POST JSON {"key":"..."} to VERIFY_URL.
-- A successful API response must include valid/success/authorized=true (or status="valid"/"success")
-- and ideally an expiry field: expiresAt, expires_at, expiry, expires, or expiration.
-- Local saved key is re-verified with the server on each run; expired/revoked keys are cleared.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local VERIFY_URL = "https://neko-gamma-one.vercel.app/api/key/verify"
local SAVE_FILE = "N3K0P01_HUB_saved_key.json"
local DEVICE_FILE = "N3K0P01_HUB_device_id.txt"

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function safeCall(fn, ...)
    local ok, result = pcall(fn, ...)
    if ok then return true, result end
    return false, result
end

local function decodeJson(raw)
    if type(raw) ~= "string" then return nil end
    local ok, data = pcall(function() return HttpService:JSONDecode(raw) end)
    if ok and type(data) == "table" then return data end
    return nil
end

local function getDeviceId()
    -- Prefer an executor-provided stable device ID if available.
    if type(gethwid) == "function" then
        local ok, value = pcall(gethwid)
        if ok and type(value) == "string" and #value >= 4 and #value <= 256 then
            return value
        end
    end

    -- Otherwise persist a generated ID locally so the same device identifier is
    -- reused on later executions. If file APIs are unavailable, use a stable
    -- account-scoped fallback (not a true hardware ID).
    if type(isfile) == "function" and type(readfile) == "function" then
        local existsOk, exists = pcall(isfile, DEVICE_FILE)
        if existsOk and exists then
            local readOk, value = pcall(readfile, DEVICE_FILE)
            if readOk and type(value) == "string" and #value >= 4 and #value <= 256 then
                return value
            end
        end
    end

    local generated = "N3K-" .. HttpService:GenerateGUID(false)
    if type(writefile) == "function" then
        pcall(writefile, DEVICE_FILE, generated)
        local verifyOk, saved = pcall(function() return readfile(DEVICE_FILE) end)
        if verifyOk and type(saved) == "string" and #saved >= 4 then
            return saved
        end
    end
    return "ROBLOX-USER-" .. tostring(player.UserId)
end

local DEVICE_ID = getDeviceId()

-- Executor request functions are tried first. HttpService is a fallback, but normally
-- is not available for client-side HTTP in a live game.
local function sendVerifyRequest(key)
    local body = HttpService:JSONEncode({ key = key, hwid = DEVICE_ID })
    local headers = {
        ["Content-Type"] = "application/json",
        ["Accept"] = "application/json",
    }

    local requestFunctions = {}
    if type(request) == "function" then table.insert(requestFunctions, request) end
    if type(http_request) == "function" then table.insert(requestFunctions, http_request) end
    if type(syn) == "table" and type(syn.request) == "function" then
        table.insert(requestFunctions, syn.request)
    end
    if type(fluxus) == "table" and type(fluxus.request) == "function" then
        table.insert(requestFunctions, fluxus.request)
    end

    for _, req in ipairs(requestFunctions) do
        if type(req) == "function" then
            local ok, result = pcall(req, {
                Url = VERIFY_URL,
                URL = VERIFY_URL,
                Method = "POST",
                Method = "POST",
                Headers = headers,
                Body = body,
            })
            if ok and type(result) == "table" then
                local statusCode = result.StatusCode or result.Status or result.status_code or result.status
                local responseBody = result.Body or result.body or result.ResponseBody
                if type(responseBody) == "string" then
                    return tonumber(statusCode) or 0, responseBody
                end
            end
        end
    end

    local ok, result = pcall(function()
        return HttpService:RequestAsync({
            Url = VERIFY_URL,
            Method = "POST",
            Headers = headers,
            Body = body,
        })
    end)
    if ok and type(result) == "table" then
        return tonumber(result.StatusCode) or 0, result.Body or ""
    end
    return 0, tostring(result or "HTTP request gagal")
end

local function isValidResponse(data)
    if type(data) ~= "table" then return false end
    if data.valid == true or data.success == true or data.authorized == true or data.isValid == true then
        return true
    end
    if type(data.status) == "string" then
        local s = string.lower(data.status)
        return s == "valid" or s == "success" or s == "authorized" or s == "active"
    end
    return false
end

local function getExpiry(data)
    if type(data) ~= "table" then return nil end
    local value = data.expiresAt or data.expires_at or data.expiry or data.expires or data.expiration
    if type(value) == "table" then
        value = value.timestamp or value.unix or value.date
    end
    if type(value) == "number" then
        -- Accept seconds or milliseconds.
        if value > 100000000000 then value = math.floor(value / 1000) end
        return value
    end
    if type(value) == "string" then
        local n = tonumber(value)
        if n then
            if n > 100000000000 then n = math.floor(n / 1000) end
            return n
        end
        -- ISO date parsing is not consistent in Luau; server should return Unix seconds.
    end
    return nil
end

local function saveKey(key, expiry)
    if type(writefile) ~= "function" then
        return false, "penyimpanan file tidak tersedia"
    end
    local ok, err = pcall(function()
        writefile(SAVE_FILE, HttpService:JSONEncode({
            key = key,
            hwid = DEVICE_ID,
            expiry = expiry,
            savedAt = os.time(),
        }))
    end)
    return ok, err
end

local function loadSavedKey()
    if type(isfile) ~= "function" or type(readfile) ~= "function" then return nil end
    local existsOk, exists = pcall(isfile, SAVE_FILE)
    if not existsOk or not exists then return nil end
    local readOk, raw = pcall(readfile, SAVE_FILE)
    if not readOk then return nil end
    local data = decodeJson(raw)
    if type(data) == "table" and type(data.key) == "string" and data.key ~= "" then
        return data.key, tonumber(data.expiry)
    end
    return nil
end

local function clearSavedKey()
    if type(delfile) == "function" then
        pcall(delfile, SAVE_FILE)
    elseif type(writefile) == "function" then
        pcall(writefile, SAVE_FILE, "{}")
    end
end

local oldGui = playerGui:FindFirstChild("N3K0P01KeySystem")
if oldGui then oldGui:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "N3K0P01KeySystem"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local scale = Instance.new("UIScale")
scale.Parent = gui

local function updateScale()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local viewport = camera.ViewportSize
    scale.Scale = math.max(0.65, math.min(viewport.X / 430, viewport.Y / 320, 1))
end
updateScale()
if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
end
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(updateScale)

local function make(className, props, parent)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local main = make("Frame", {
    Name = "Main", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(430, 320), BackgroundColor3 = Color3.fromRGB(15, 25, 41),
    BorderSizePixel = 0, Active = true,
}, gui)
make("UICorner", {CornerRadius = UDim.new(0, 14)}, main)
make("UIStroke", {Color = Color3.fromRGB(65, 151, 205), Thickness = 1.5, Transparency = 0.15}, main)

local top = make("Frame", {
    Name = "TopBar", Size = UDim2.new(1, 0, 0, 72),
    BackgroundColor3 = Color3.fromRGB(22, 39, 61), BorderSizePixel = 0,
}, main)
make("UICorner", {CornerRadius = UDim.new(0, 14)}, top)
make("Frame", {Position = UDim2.new(0, 0, 1, -14), Size = UDim2.new(1, 0, 0, 14),
    BackgroundColor3 = top.BackgroundColor3, BorderSizePixel = 0}, top)

make("TextLabel", {
    Position = UDim2.fromOffset(20, 12), Size = UDim2.new(1, -70, 0, 27),
    BackgroundTransparency = 1, Font = Enum.Font.GothamBold, Text = "N3K0P01 HUB",
    TextColor3 = Color3.fromRGB(235, 247, 255), TextSize = 21, TextXAlignment = Enum.TextXAlignment.Left,
}, top)
make("TextLabel", {
    Position = UDim2.fromOffset(21, 41), Size = UDim2.new(1, -42, 0, 17),
    BackgroundTransparency = 1, Font = Enum.Font.GothamMedium, Text = "KEY AUTHENTICATION SYSTEM",
    TextColor3 = Color3.fromRGB(117, 198, 239), TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left,
}, top)

local close = make("TextButton", {
    AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 12), Size = UDim2.fromOffset(30, 30),
    BackgroundColor3 = Color3.fromRGB(43, 62, 84), BorderSizePixel = 0, Font = Enum.Font.GothamBold,
    Text = "×", TextColor3 = Color3.fromRGB(225, 239, 250), TextSize = 22,
}, top)
make("UICorner", {CornerRadius = UDim.new(0, 8)}, close)

make("TextLabel", {
    Position = UDim2.fromOffset(22, 88), Size = UDim2.new(1, -44, 0, 26), BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold, Text = "Masukkan Key Kamu", TextColor3 = Color3.fromRGB(239, 247, 255),
    TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left,
}, main)
make("TextLabel", {
    Position = UDim2.fromOffset(22, 116), Size = UDim2.new(1, -44, 0, 34), BackgroundTransparency = 1,
    Font = Enum.Font.Gotham, Text = "Verifikasi key melalui server N3K0P01 HUB untuk melanjutkan.",
    TextColor3 = Color3.fromRGB(160, 180, 201), TextSize = 11, TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
}, main)

local input = make("TextBox", {
    Name = "KeyInput", Position = UDim2.fromOffset(22, 160), Size = UDim2.new(1, -44, 0, 42),
    BackgroundColor3 = Color3.fromRGB(24, 39, 58), BorderSizePixel = 0, ClearTextOnFocus = false,
    Font = Enum.Font.Gotham, PlaceholderText = "Tempel key kamu di sini...",
    PlaceholderColor3 = Color3.fromRGB(126, 148, 170), Text = "", TextColor3 = Color3.fromRGB(240, 248, 255),
    TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
}, main)
make("UICorner", {CornerRadius = UDim.new(0, 9)}, input)
make("UIPadding", {PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12)}, input)
make("UIStroke", {Color = Color3.fromRGB(57, 85, 115), Thickness = 1}, input)

local verify = make("TextButton", {
    Name = "VerifyButton", Position = UDim2.fromOffset(22, 214), Size = UDim2.new(1, -44, 0, 40),
    BackgroundColor3 = Color3.fromRGB(76, 185, 235), BorderSizePixel = 0, Font = Enum.Font.GothamBold,
    Text = "VERIFY KEY", TextColor3 = Color3.fromRGB(8, 25, 39), TextSize = 13,
}, main)
make("UICorner", {CornerRadius = UDim.new(0, 9)}, verify)

local status = make("TextLabel", {
    Name = "Status", Position = UDim2.fromOffset(22, 260), Size = UDim2.new(1, -44, 0, 20),
    BackgroundTransparency = 1, Font = Enum.Font.GothamMedium, Text = "Status: menunggu key",
    TextColor3 = Color3.fromRGB(153, 177, 198), TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
}, main)
make("TextLabel", {
    Position = UDim2.fromOffset(22, 291), Size = UDim2.new(1, -44, 0, 16), BackgroundTransparency = 1,
    Font = Enum.Font.Gotham, Text = "N3K0P01 HUB  •  KEY SYSTEM",
    TextColor3 = Color3.fromRGB(103, 129, 153), TextSize = 9, TextXAlignment = Enum.TextXAlignment.Center,
}, main)

-- Drag support for mouse and touch.
local dragging, dragStart, startPosition, dragInput = false, nil, nil, nil
top.InputBegan:Connect(function(io)
    if io.UserInputType == Enum.UserInputType.MouseButton1 or io.UserInputType == Enum.UserInputType.Touch then
        dragging, dragStart, startPosition = true, io.Position, main.Position
        io.Changed:Connect(function()
            if io.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
top.InputChanged:Connect(function(io)
    if io.UserInputType == Enum.UserInputType.MouseMovement or io.UserInputType == Enum.UserInputType.Touch then
        dragInput = io
    end
end)
UserInputService.InputChanged:Connect(function(io)
    if dragging and (io == dragInput or io.UserInputType == Enum.UserInputType.Touch) then
        local delta = io.Position - dragStart
        main.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
    end
end)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

local busy = false
local function setStatus(message, color)
    status.Text = "Status: " .. message
    status.TextColor3 = color
end

local function verifyKey(key, fromCache)
    local code, body = sendVerifyRequest(key)
    if code < 200 or code >= 300 then
        return false, "API HTTP " .. tostring(code) .. (code == 0 and ": " .. string.sub(tostring(body), 1, 65) or "")
    end
    local data = decodeJson(body)
    if not isValidResponse(data) then
        local msg = type(data) == "table" and (data.message or data.error) or nil
        return false, type(msg) == "string" and string.sub(msg, 1, 80) or "key ditolak / format respons tidak cocok"
    end
    local expiry = getExpiry(data)
    if expiry and expiry <= os.time() then
        clearSavedKey()
        return false, "key sudah expired"
    end
    if not fromCache then
        local saved, err = saveKey(key, expiry)
        if not saved then
            return true, expiry and ("valid; penyimpanan tidak tersedia") or "valid; expiry tidak dikirim API"
        end
    end
    return true, expiry and ("key valid sampai " .. os.date("!%Y-%m-%d %H:%M UTC", expiry)) or "key valid; API tidak mengirim expiry"
end

verify.MouseButton1Click:Connect(function()
    if busy then return end
    local key = string.gsub(input.Text or "", "^%s*(.-)%s*$", "%1")
    if key == "" then
        setStatus("masukkan key terlebih dahulu", Color3.fromRGB(255, 190, 105))
        return
    end
    busy = true
    verify.Text = "MEMERIKSA..."
    setStatus("menghubungi server...", Color3.fromRGB(132, 207, 244))
    local ok, valid, message = pcall(verifyKey, key, false)
    if ok and valid then
        setStatus(message, Color3.fromRGB(119, 232, 165))
        verify.Text = "KEY VERIFIED"
        verify.BackgroundColor3 = Color3.fromRGB(75, 190, 130)
    else
        setStatus(ok and message or "gagal: " .. string.sub(tostring(valid), 1, 70), Color3.fromRGB(255, 135, 135))
        verify.Text = "VERIFY KEY"
        verify.BackgroundColor3 = Color3.fromRGB(76, 185, 235)
    end
    busy = false
end)

-- Automatically re-verify a saved key. Local expiry is a convenience only;
-- server response remains authoritative for expiry/revocation.
task.spawn(function()
    local savedKey, savedExpiry = loadSavedKey()
    if not savedKey then return end
    input.Text = savedKey
    if savedExpiry and savedExpiry <= os.time() then
        clearSavedKey()
        input.Text = ""
        setStatus("key tersimpan sudah expired; masukkan key baru", Color3.fromRGB(255, 190, 105))
        return
    end
    busy = true
    verify.Text = "MEMERIKSA KEY TERSIMPAN..."
    setStatus("memeriksa key tersimpan...", Color3.fromRGB(132, 207, 244))
    local ok, valid, message = pcall(verifyKey, savedKey, true)
    if ok and valid then
        setStatus("key tersimpan: " .. message, Color3.fromRGB(119, 232, 165))
        verify.Text = "KEY VERIFIED"
        verify.BackgroundColor3 = Color3.fromRGB(75, 190, 130)
    else
        clearSavedKey()
        input.Text = ""
        setStatus("key tersimpan ditolak/expired; masukkan key lagi", Color3.fromRGB(255, 135, 135))
        verify.Text = "VERIFY KEY"
    end
    busy = false
end)
