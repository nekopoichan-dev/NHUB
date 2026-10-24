--==============================================================
-- N3K0P01 HUB KEY SYSTEM — N3K0P01 STYLE UI
-- Monochrome Blue Glass + RGB Border
-- No hub load after authorization
--==============================================================

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local RunService       = game:GetService("RunService")
local HttpService      = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local CoreGui          = game:GetService("CoreGui")

local player = Players.LocalPlayer
if not player then return end

--==============================================================
-- CONFIG
--==============================================================
local GUI_NAME      = "N3K0P01_KeySystem_N3K0P01Style"
local VERIFY_URL    = "https://neko-gamma-one.vercel.app/api/key/verify"
local BACKGROUND    = "rbxassetid://92099537571062"
local LOGO          = "rbxassetid://79536536479823"
local SAVE_FOLDER   = "N3K0P01"
local SAVE_FILE     = SAVE_FOLDER .. "/web_key.txt"

--==============================================================
-- CLEAN OLD UI
--==============================================================
pcall(function()
    local old = CoreGui:FindFirstChild(GUI_NAME)
    if old then old:Destroy() end
end)
pcall(function()
    local old = player:WaitForChild("PlayerGui"):FindFirstChild(GUI_NAME)
    if old then old:Destroy() end
end)

local parent = CoreGui
local parentOK = pcall(function() assert(CoreGui ~= nil) end)
if not parentOK then parent = player:WaitForChild("PlayerGui") end

--==============================================================
-- HELPERS
--==============================================================
local function new(className, props, parentObject)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do
        pcall(function() obj[k] = v end)
    end
    obj.Parent = parentObject
    return obj
end

local function corner(parentObject, radius)
    return new("UICorner", { CornerRadius = UDim.new(0, radius or 10) }, parentObject)
end

local function stroke(parentObject, color, thickness, transparency)
    return new("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
    }, parentObject)
end

local function tween(object, duration, properties)
    return TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        properties
    )
end

local COLORS = {
    Background = Color3.fromRGB(7, 9, 16),
    Panel      = Color3.fromRGB(14, 17, 27),
    Panel2     = Color3.fromRGB(19, 23, 35),
    Panel3     = Color3.fromRGB(26, 31, 46),
    Text       = Color3.fromRGB(255, 255, 255),
    SubText    = Color3.fromRGB(220, 228, 240),
    Muted      = Color3.fromRGB(164, 177, 197),
    Stroke     = Color3.fromRGB(112, 146, 190),
    Blue       = Color3.fromRGB(72, 166, 255),
    Cyan       = Color3.fromRGB(71, 224, 255),
    Purple     = Color3.fromRGB(145, 93, 255),
    Green      = Color3.fromRGB(82, 231, 154),
    Red        = Color3.fromRGB(255, 76, 92),
}

local function addLogo(parentObject, position, size, z)
    local holder = new("Frame", {
        BackgroundColor3 = COLORS.Panel3,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Position = position,
        Size = UDim2.fromOffset(size, size),
        ClipsDescendants = true,
        ZIndex = z or 5,
    }, parentObject)
    corner(holder, 14)

    local logoCorner = math.max(9, math.floor(size * 0.29))
    local crop = math.max(16, math.floor(size * 0.38))
    local image = new("ImageLabel", {
        BackgroundTransparency = 1,
        Image = LOGO,
        ScaleType = Enum.ScaleType.Crop,
        Position = UDim2.fromOffset(-crop, -crop),
        Size = UDim2.new(1, crop * 2, 1, crop * 2),
        ZIndex = (z or 5) + 1,
    }, holder)
    corner(image, logoCorner)
    return holder
end

local function makeLabel(parentObject, text, size, position, dimensions, font, color, z)
    return new("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        Font = font or Enum.Font.Gotham,
        TextSize = size or 12,
        TextColor3 = color or COLORS.Text,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        Position = position,
        Size = dimensions,
        ZIndex = z or 5,
    }, parentObject)
end

--==============================================================
-- KEY UI
--==============================================================
local KeyGui = new("ScreenGui", {
    Name = GUI_NAME .. "_Key",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999999,
}, parent)

-- Full-screen background
local KeyStage = new("Frame", {
    Name = "FullScreenBackground",
    Size = UDim2.fromScale(1, 1),
    Position = UDim2.fromScale(0, 0),
    BackgroundColor3 = COLORS.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, KeyGui)

new("ImageLabel", {
    BackgroundColor3 = COLORS.Background,
    BackgroundTransparency = 0,
    BorderSizePixel = 0,
    Image = BACKGROUND,
    ImageTransparency = 0,
    ScaleType = Enum.ScaleType.Crop,
    Size = UDim2.fromScale(1, 1),
    ZIndex = 0,
}, KeyStage)

new("Frame", {
    BackgroundColor3 = Color3.fromRGB(5, 12, 25),
    BackgroundTransparency = 0.58,
    BorderSizePixel = 0,
    Size = UDim2.fromScale(1, 1),
    ZIndex = 1,
}, KeyStage)

-- Centered glass card
local KeyCard = new("Frame", {
    Name = "GlassKeyPanel",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(425, 405),
    BackgroundColor3 = Color3.fromRGB(17, 31, 52),
    BackgroundTransparency = 0.30,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 3,
}, KeyStage)
corner(KeyCard, 18)

new("Frame", {
    BackgroundColor3 = Color3.fromRGB(65, 145, 220),
    BackgroundTransparency = 0.88,
    BorderSizePixel = 0,
    Position = UDim2.fromScale(0, 0),
    Size = UDim2.fromScale(1, 0.48),
    ZIndex = 4,
}, KeyCard)
corner(KeyCard, 18)

local function makeRGBBorder(target, inset, radius, zBoost)
    inset = inset or 2
    radius = radius or 16
    zBoost = zBoost or 1

    local borderFrame = Instance.new("Frame")
    borderFrame.Name = "RGBBorderFrame"
    borderFrame.BackgroundTransparency = 1
    borderFrame.BorderSizePixel = 0
    borderFrame.Position = UDim2.fromOffset(inset, inset)
    borderFrame.Size = UDim2.new(1, -(inset * 2), 1, -(inset * 2))
    borderFrame.ClipsDescendants = true
    borderFrame.ZIndex = target.ZIndex + zBoost
    borderFrame.Parent = target
    corner(borderFrame, radius)

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Name = "RGBBorder"
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Thickness = 1.35
    uiStroke.Transparency = 0.06
    uiStroke.LineJoinMode = Enum.LineJoinMode.Round
    uiStroke.Color = Color3.fromRGB(80, 210, 255)
    uiStroke.Parent = borderFrame

    local gradient = Instance.new("UIGradient")
    gradient.Name = "RGBGradient"
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(55, 135, 255)),
        ColorSequenceKeypoint.new(0.20, Color3.fromRGB(70, 220, 255)),
        ColorSequenceKeypoint.new(0.40, Color3.fromRGB(245, 250, 255)),
        ColorSequenceKeypoint.new(0.58, Color3.fromRGB(145, 165, 185)),
        ColorSequenceKeypoint.new(0.76, Color3.fromRGB(60, 195, 255)),
        ColorSequenceKeypoint.new(0.90, Color3.fromRGB(120, 235, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(55, 135, 255)),
    })
    gradient.Parent = uiStroke

    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not target.Parent or not borderFrame.Parent then
            connection:Disconnect()
            return
        end
        gradient.Rotation = (os.clock() * 24) % 360
    end)
    return uiStroke
end

makeRGBBorder(KeyCard, 3, 15, 2)

local KeyContent = new("Frame", {
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 1),
    ZIndex = 5,
}, KeyCard)

addLogo(KeyContent, UDim2.fromOffset(20, 20), 52, 6)

makeLabel(
    KeyContent,
    "N3K0P01 HUB",
    21,
    UDim2.fromOffset(84, 21),
    UDim2.new(1, -130, 0, 30),
    Enum.Font.GothamBold,
    COLORS.Text,
    6
).TextXAlignment = Enum.TextXAlignment.Left

makeLabel(
    KeyContent,
    "SECURE ACCESS • LUAPROTECT",
    9,
    UDim2.fromOffset(85, 51),
    UDim2.new(1, -130, 0, 18),
    Enum.Font.GothamMedium,
    COLORS.SubText,
    6
).TextXAlignment = Enum.TextXAlignment.Left

-- Close button
local KeyClose = new("TextButton", {
    BackgroundColor3 = Color3.fromRGB(8, 14, 25),
    BackgroundTransparency = 0.16,
    BorderSizePixel = 0,
    Text = "×",
    TextColor3 = COLORS.Text,
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    Position = UDim2.new(1, -52, 0, 18),
    Size = UDim2.fromOffset(34, 34),
    AutoButtonColor = false,
    ZIndex = 8,
}, KeyContent)
corner(KeyClose, 9)

-- Key input
local KeyInputHolder = new("Frame", {
    BackgroundColor3 = Color3.fromRGB(4, 11, 23),
    BackgroundTransparency = 0.22,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(40, 108),
    Size = UDim2.new(1, -80, 0, 55),
    ZIndex = 6,
}, KeyContent)
corner(KeyInputHolder, 11)
stroke(KeyInputHolder, COLORS.Blue, 1, 0.25)

local KeyInput = new("TextBox", {
    BackgroundTransparency = 1,
    ClearTextOnFocus = false,
    PlaceholderText = "Enter your key here...",
    PlaceholderColor3 = Color3.fromRGB(185, 201, 224),
    Text = "",
    TextColor3 = COLORS.Text,
    TextSize = 14,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center,
    Position = UDim2.fromOffset(15, 2),
    Size = UDim2.new(1, -30, 1, -4),
    ZIndex = 7,
}, KeyInputHolder)

local KeyStatus = makeLabel(
    KeyContent,
    "Enter your key, then press VERIFY KEY.",
    10,
    UDim2.fromOffset(35, 170),
    UDim2.new(1, -70, 0, 28),
    Enum.Font.Gotham,
    COLORS.SubText,
    6
)

-- Verify button
local VerifyButton = new("TextButton", {
    BackgroundColor3 = Color3.fromRGB(44, 113, 190),
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "VERIFY KEY",
    TextColor3 = COLORS.Text,
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    Position = UDim2.fromOffset(55, 213),
    Size = UDim2.new(1, -110, 0, 48),
    ZIndex = 6,
}, KeyContent)
corner(VerifyButton, 10)
stroke(VerifyButton, COLORS.Cyan, 1, 0.30)

makeLabel(
    KeyContent,
    "LuaProtect protected access",
    9,
    UDim2.fromOffset(40, 330),
    UDim2.new(1, -80, 0, 20),
    Enum.Font.Gotham,
    COLORS.Muted,
    6
)

--==============================================================
-- KEY STORAGE / LUAPROTECT
--==============================================================
local function fileApiAvailable()
    return type(isfile) == "function"
       and type(readfile) == "function"
       and type(writefile) == "function"
end

local function loadSavedKey()
    if not fileApiAvailable() then return nil end
    local ok, value = pcall(function()
        if not isfile(SAVE_FILE) then return nil end
        local key = tostring(readfile(SAVE_FILE) or "")
        key = key:gsub("^%s+", ""):gsub("%s+$", "")
        if key == "" then return nil end
        return key
    end)
    return ok and value or nil
end

local function saveKey(key)
    if not fileApiAvailable() then return false end
    return pcall(function()
        if type(isfolder) == "function" and type(makefolder) == "function" then
            if not isfolder(SAVE_FOLDER) then makefolder(SAVE_FOLDER) end
        end
        writefile(SAVE_FILE, key)
    end)
end

local function clearSavedKey()
    if type(delfile) ~= "function" then return end
    pcall(function()
        if isfile(SAVE_FILE) then delfile(SAVE_FILE) end
    end)
end

local function setKeyStatus(text, good)
    KeyStatus.Text = text
    KeyStatus.TextColor3 = good and COLORS.Green or Color3.fromRGB(255, 185, 195)
end

local function verifyWebKey(key)
    -- Assumes the Vercel API accepts POST JSON: { "key": "..." }
    -- and returns JSON containing valid=true or authorized=true.
    local body
    local encodedOK, encoded = pcall(function()
        return HttpService:JSONEncode({ key = key })
    end)
    if not encodedOK then
        setKeyStatus("Could not prepare verification request.", false)
        return false
    end
    body = encoded

    local response
    local requestFn = nil
    pcall(function()
        if type(request) == "function" then
            requestFn = request
        elseif type(http_request) == "function" then
            requestFn = http_request
        elseif syn and type(syn.request) == "function" then
            requestFn = syn.request
        end
    end)

    local ok, result
    if requestFn then
        ok, result = pcall(function()
            return requestFn({
                Url = VERIFY_URL,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                    ["Accept"] = "application/json"
                },
                Body = body
            })
        end)
    else
        ok, result = pcall(function()
            return HttpService:RequestAsync({
                Url = VERIFY_URL,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                    ["Accept"] = "application/json"
                },
                Body = body
            })
        end)
    end

    if not ok or type(result) ~= "table" then
        setKeyStatus("Could not connect to key API.", false)
        warn("[N3K0P01] Key API request failed:", result)
        return false
    end

    local statusCode = tonumber(result.StatusCode or result.Status or 0) or 0
    local responseBody = result.Body or result.body or ""
    if statusCode < 200 or statusCode >= 300 then
        setKeyStatus("Key API returned HTTP " .. tostring(statusCode) .. ".", false)
        warn("[N3K0P01] Key API HTTP status:", statusCode, responseBody)
        return false
    end

    local decodedOK, data = pcall(function()
        return HttpService:JSONDecode(responseBody)
    end)
    if not decodedOK or type(data) ~= "table" then
        setKeyStatus("Key API response was not valid JSON.", false)
        warn("[N3K0P01] Unexpected key API response:", responseBody)
        return false
    end

    if data.valid == true or data.authorized == true then
        return true
    end

    setKeyStatus(tostring(data.message or data.error or "Key is invalid or expired."), false)
    return false
end

--==============================================================
-- VERIFY (no hub load)
--==============================================================
local verifying = false
local authorized = false

local function verifyKey(key, fromSaved)
    if verifying or authorized then return end
    verifying = true

    key = tostring(key or ""):gsub("^%s+", ""):gsub("%s+$", "")

    if key == "" then
        setKeyStatus("Please enter your key first.", false)
        verifying = false
        return
    end

    if fromSaved then
        KeyInput.Text = key
        setKeyStatus("Checking saved key...", true)
    else
        setKeyStatus("Checking key...", true)
    end

    setKeyStatus("Checking key with N3K0P01 web API...", true)
    if verifyWebKey(key) then
        saveKey(key)
        authorized = true
        setKeyStatus("Key accepted. Authorization complete.", true)

        --========================================================
        -- KEY VALID — tidak ada hub yang di-load
        --========================================================
        task.wait(1.4)

        local fadeTween = TweenService:Create(
            KeyCard,
            TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            {
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(390, 370),
            }
        )
        fadeTween:Play()

        for _, child in ipairs(KeyCard:GetDescendants()) do
            if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                tween(child, 0.4, { TextTransparency = 1, BackgroundTransparency = 1 }):Play()
            elseif child:IsA("Frame") or child:IsA("ImageLabel") then
                if child.BackgroundTransparency < 1 then
                    tween(child, 0.4, { BackgroundTransparency = 1 }):Play()
                end
                if child:IsA("ImageLabel") then
                    tween(child, 0.4, { ImageTransparency = 1 }):Play()
                end
            elseif child:IsA("UIStroke") then
                tween(child, 0.4, { Transparency = 1 }):Play()
            end
        end

        task.wait(0.7)
        pcall(function() KeyGui:Destroy() end)

        print("[N3K0P01] License verified ✓ (no hub loaded)")
    else
        if fromSaved then
            clearSavedKey()
            KeyInput.Text = ""
            setKeyStatus("Saved key is no longer valid.", false)
        else
            setKeyStatus("Key was not authorized yet.", false)
        end
    end

    verifying = false
end

VerifyButton.MouseEnter:Connect(function()
    tween(VerifyButton, 0.12, { BackgroundColor3 = Color3.fromRGB(55, 124, 205) }):Play()
end)

VerifyButton.MouseLeave:Connect(function()
    tween(VerifyButton, 0.12, { BackgroundColor3 = Color3.fromRGB(44, 113, 190) }):Play()
end)

VerifyButton.Activated:Connect(function()
    verifyKey(KeyInput.Text, false)
end)

KeyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        verifyKey(KeyInput.Text, false)
    end
end)

KeyClose.Activated:Connect(function()
    if KeyGui and KeyGui.Parent then KeyGui:Destroy() end
end)

-- Auto verify saved key
task.spawn(function()
    task.wait(0.6)
    local saved = loadSavedKey()
    if saved then
        KeyInput.Text = saved
        setKeyStatus("Saved key detected • Auto verifying...", true)
        task.wait(0.4)
        verifyKey(saved, true)
    end
end)

print("[N3K0P01] Web API Key System loaded — logo: 79536536479823")