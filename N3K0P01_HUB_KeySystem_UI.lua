-- N3K0P01 HUB - Key System UI (Standalone)
-- Catatan:
-- 1) Ini adalah UI mandiri; belum digabungkan ke source script utama.
-- 2) Endpoint diasumsikan menerima POST JSON: {"key":"KEY_DARI_PENGGUNA"}.
--    Sesuaikan field/body jika API website menggunakan format berbeda.
-- 3) Untuk keamanan, validasi key harus dilakukan oleh server, bukan hanya di client.

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local VERIFY_URL = "https://neko-gamma-one.vercel.app/api/key/verify"

-- Hapus UI versi sebelumnya jika script dijalankan ulang.
local oldGui = playerGui:FindFirstChild("N3K0P01KeySystem")
if oldGui then
    oldGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "N3K0P01KeySystem"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

-- Ukuran berbasis piksel, lalu hanya diskalakan seperlunya agar muat di layar.
-- Ini mengurangi pengaruh DPI; ukuran tetap mengikuti ruang layar yang tersedia.
local scale = Instance.new("UIScale")
scale.Parent = gui

local function updateScale()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local viewport = camera.ViewportSize
    local baseW, baseH = 430, 320
    local fit = math.min(viewport.X / baseW, viewport.Y / baseH, 1)
    scale.Scale = math.max(0.72, fit)
end

updateScale()
if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
end
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(updateScale)

local function make(className, props, parent)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local main = make("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(430, 320),
    BackgroundColor3 = Color3.fromRGB(15, 25, 41),
    BorderSizePixel = 0,
    Active = true,
}, gui)
make("UICorner", {CornerRadius = UDim.new(0, 14)}, main)
make("UIStroke", {Color = Color3.fromRGB(65, 151, 205), Thickness = 1.5, Transparency = 0.15}, main)

local top = make("Frame", {
    Name = "TopBar",
    Size = UDim2.new(1, 0, 0, 72),
    BackgroundColor3 = Color3.fromRGB(22, 39, 61),
    BorderSizePixel = 0,
}, main)
make("UICorner", {CornerRadius = UDim.new(0, 14)}, top)
make("Frame", {
    Name = "CoverBottomCorners",
    Position = UDim2.new(0, 0, 1, -14),
    Size = UDim2.new(1, 0, 0, 14),
    BackgroundColor3 = top.BackgroundColor3,
    BorderSizePixel = 0,
}, top)

make("TextLabel", {
    Name = "Brand",
    Position = UDim2.fromOffset(20, 12),
    Size = UDim2.new(1, -70, 0, 27),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "N3K0P01 HUB",
    TextColor3 = Color3.fromRGB(235, 247, 255),
    TextSize = 21,
    TextXAlignment = Enum.TextXAlignment.Left,
}, top)

make("TextLabel", {
    Name = "Subtitle",
    Position = UDim2.fromOffset(21, 41),
    Size = UDim2.new(1, -42, 0, 17),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamMedium,
    Text = "KEY AUTHENTICATION SYSTEM",
    TextColor3 = Color3.fromRGB(117, 198, 239),
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
}, top)

local close = make("TextButton", {
    Name = "Close",
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -12, 0, 12),
    Size = UDim2.fromOffset(30, 30),
    BackgroundColor3 = Color3.fromRGB(43, 62, 84),
    BorderSizePixel = 0,
    Font = Enum.Font.GothamBold,
    Text = "×",
    TextColor3 = Color3.fromRGB(225, 239, 250),
    TextSize = 22,
    AutoButtonColor = true,
}, top)
make("UICorner", {CornerRadius = UDim.new(0, 8)}, close)

make("TextLabel", {
    Name = "Welcome",
    Position = UDim2.fromOffset(22, 88),
    Size = UDim2.new(1, -44, 0, 26),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "Masukkan Key Kamu",
    TextColor3 = Color3.fromRGB(239, 247, 255),
    TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left,
}, main)

make("TextLabel", {
    Name = "Description",
    Position = UDim2.fromOffset(22, 116),
    Size = UDim2.new(1, -44, 0, 34),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    Text = "Verifikasi key melalui server N3K0P01 HUB untuk melanjutkan.",
    TextColor3 = Color3.fromRGB(160, 180, 201),
    TextSize = 11,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
}, main)

local input = make("TextBox", {
    Name = "KeyInput",
    Position = UDim2.fromOffset(22, 160),
    Size = UDim2.new(1, -44, 0, 42),
    BackgroundColor3 = Color3.fromRGB(24, 39, 58),
    BorderSizePixel = 0,
    ClearTextOnFocus = false,
    Font = Enum.Font.Gotham,
    PlaceholderText = "Tempel key kamu di sini...",
    PlaceholderColor3 = Color3.fromRGB(126, 148, 170),
    Text = "",
    TextColor3 = Color3.fromRGB(240, 248, 255),
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
}, main)
make("UICorner", {CornerRadius = UDim.new(0, 9)}, input)
make("UIPadding", {
    PaddingLeft = UDim.new(0, 12),
    PaddingRight = UDim.new(0, 12),
}, input)
make("UIStroke", {Color = Color3.fromRGB(57, 85, 115), Thickness = 1}, input)

local verify = make("TextButton", {
    Name = "VerifyButton",
    Position = UDim2.fromOffset(22, 214),
    Size = UDim2.new(1, -44, 0, 40),
    BackgroundColor3 = Color3.fromRGB(76, 185, 235),
    BorderSizePixel = 0,
    Font = Enum.Font.GothamBold,
    Text = "VERIFY KEY",
    TextColor3 = Color3.fromRGB(8, 25, 39),
    TextSize = 13,
    AutoButtonColor = true,
}, main)
make("UICorner", {CornerRadius = UDim.new(0, 9)}, verify)

local status = make("TextLabel", {
    Name = "Status",
    Position = UDim2.fromOffset(22, 260),
    Size = UDim2.new(1, -44, 0, 20),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamMedium,
    Text = "Status: menunggu key",
    TextColor3 = Color3.fromRGB(153, 177, 198),
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
}, main)

make("TextLabel", {
    Name = "Footer",
    Position = UDim2.fromOffset(22, 291),
    Size = UDim2.new(1, -44, 0, 16),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    Text = "N3K0P01 HUB  •  KEY SYSTEM",
    TextColor3 = Color3.fromRGB(103, 129, 153),
    TextSize = 9,
    TextXAlignment = Enum.TextXAlignment.Center,
}, main)

-- Drag UI dengan mouse atau sentuhan.
local dragging = false
local dragStart, startPosition
local dragInput

top.InputBegan:Connect(function(inputObject)
    if inputObject.UserInputType == Enum.UserInputType.MouseButton1
        or inputObject.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = inputObject.Position
        startPosition = main.Position
        inputObject.Changed:Connect(function()
            if inputObject.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

top.InputChanged:Connect(function(inputObject)
    if inputObject.UserInputType == Enum.UserInputType.MouseMovement
        or inputObject.UserInputType == Enum.UserInputType.Touch then
        dragInput = inputObject
    end
end)

UserInputService.InputChanged:Connect(function(inputObject)
    if dragging and (inputObject == dragInput
        or inputObject.UserInputType == Enum.UserInputType.Touch) then
        local delta = inputObject.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local busy = false
local function setStatus(message, color)
    status.Text = "Status: " .. message
    status.TextColor3 = color
end

local function responseSaysValid(data)
    if type(data) ~= "table" then return false end
    -- Mendukung beberapa nama field respons umum; sesuaikan dengan API asli.
    if data.valid == true or data.success == true or data.authorized == true then
        return true
    end
    if type(data.status) == "string" then
        local s = string.lower(data.status)
        if s == "valid" or s == "success" or s == "authorized" then
            return true
        end
    end
    return false
end

verify.MouseButton1Click:Connect(function()
    if busy then return end

    local key = string.gsub(input.Text or "", "^%s*(.-)%s*$", "%1")
    if key == "" then
        setStatus("masukkan key terlebih dahulu", Color3.fromRGB(255, 190, 105))
        return
    end

    if not HttpService.HttpEnabled then
        setStatus("permintaan HTTP belum diizinkan", Color3.fromRGB(255, 135, 135))
        return
    end

    busy = true
    verify.Text = "MEMERIKSA..."
    verify.AutoButtonColor = false
    setStatus("menghubungi server...", Color3.fromRGB(132, 207, 244))

    local ok, result = pcall(function()
        return HttpService:RequestAsync({
            Url = VERIFY_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["Accept"] = "application/json",
            },
            Body = HttpService:JSONEncode({
                key = key,
            }),
        })
    end)

    if not ok then
        setStatus("gagal menghubungi API; periksa koneksi/format", Color3.fromRGB(255, 135, 135))
    else
        local decoded
        local decodeOk, decodedValue = pcall(function()
            return HttpService:JSONDecode(result.Body or "")
        end)
        if decodeOk then decoded = decodedValue end

        if result.Success and responseSaysValid(decoded) then
            setStatus("key valid! server mengizinkan akses", Color3.fromRGB(119, 232, 165))
            verify.Text = "KEY VERIFIED"
            verify.BackgroundColor3 = Color3.fromRGB(75, 190, 130)
            -- UI standalone ini tidak menjalankan fitur script utama.
            -- Integrasikan pemanggilan loader/fitur setelah validasi server sukses.
        elseif result.StatusCode == 405 then
            setStatus("metode API ditolak; cek metode yang diwajibkan", Color3.fromRGB(255, 190, 105))
        elseif result.StatusCode == 400 or result.StatusCode == 422 then
            setStatus("format permintaan API tidak cocok", Color3.fromRGB(255, 190, 105))
        elseif result.Success then
            local message = type(decoded) == "table" and (decoded.message or decoded.error) or nil
            if type(message) == "string" and #message > 0 then
                setStatus(string.sub(message, 1, 80), Color3.fromRGB(255, 190, 105))
            else
                setStatus("key ditolak atau format respons belum cocok", Color3.fromRGB(255, 135, 135))
            end
        else
            setStatus("server merespons HTTP " .. tostring(result.StatusCode), Color3.fromRGB(255, 135, 135))
        end
    end

    busy = false
    if verify.Parent then
        if verify.Text ~= "KEY VERIFIED" then
            verify.Text = "VERIFY KEY"
        end
        verify.AutoButtonColor = true
    end
end)

-- Fokus input saat UI dibuat.
task.defer(function()
    if input.Parent then
        input:CaptureFocus()
    end
end)
