local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AditzMods_V5_Final"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local ThemeColor = Color3.fromRGB(150, 30, 255)
local BGColor = Color3.fromRGB(11, 8, 20)
local PanelColor = Color3.fromRGB(22, 16, 38)
local ActiveColor = Color3.fromRGB(180, 70, 255)

local OriginalMaterials = {}

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 540, 0, 360)
MainFrame.Position = UDim2.new(0.5, -270, 0.4, -180)
MainFrame.BackgroundColor3 = BGColor
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.BackgroundTransparency = 0.05
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = ThemeColor
UIStroke.Thickness = 2.5
UIStroke.Parent = MainFrame

spawn(function()
    while task.wait(0.05) do
        local hue = (tick() % 5) / 5
        UIStroke.Color = Color3.fromHSV(hue, 0.8, 1)
    end
end)

local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = PanelColor
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 14)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Position = UDim2.new(0, 18, 0, 0)
Title.Text = "Yt @Adityabrr"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

local MonitorLabel = Instance.new("TextLabel")
MonitorLabel.Size = UDim2.new(0.35, 0, 1, 0)
MonitorLabel.Position = UDim2.new(0.65, -95, 0, 0)
MonitorLabel.Text = "FPS: -- | PING: --"
MonitorLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
MonitorLabel.Font = Enum.Font.Code
MonitorLabel.TextSize = 12
MonitorLabel.TextXAlignment = Enum.TextXAlignment.Right
MonitorLabel.BackgroundTransparency = 1
MonitorLabel.Parent = TopBar

local fpsCount = 0
RunService.RenderStepped:Connect(function(delta)
    fpsCount = math.floor(1 / delta)
    local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    MonitorLabel.Text = "FPS: " .. tostring(fpsCount) .. " | PING: " .. tostring(ping) .. "ms"
end)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -45, 0, 6.5)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 22, 22)
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

local MiniBtn = Instance.new("TextButton")
MiniBtn.Size = UDim2.new(0, 32, 0, 32)
MiniBtn.Position = UDim2.new(1, -85, 0, 6.5)
MiniBtn.Text = "-"
MiniBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
MiniBtn.Font = Enum.Font.GothamBold
MiniBtn.TextSize = 15
MiniBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
MiniBtn.Parent = TopBar
Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(0, 8)

local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(1, 0, 0, 28)
Watermark.Position = UDim2.new(0, 0, 1, -28)
Watermark.BackgroundColor3 = PanelColor
Watermark.Text = "Yt @Adityabrr"
Watermark.TextColor3 = Color3.fromRGB(200, 150, 255)
Watermark.Font = Enum.Font.GothamBold
Watermark.TextSize = 11
Watermark.Parent = MainFrame

local MiniIcon = Instance.new("TextButton")
MiniIcon.Size = UDim2.new(0, 55, 0, 55)
MiniIcon.Position = UDim2.new(0, 25, 0, 25)
MiniIcon.BackgroundColor3 = BGColor
MiniIcon.Text = "[+]"
MiniIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniIcon.Font = Enum.Font.GothamBold
MiniIcon.TextSize = 16
MiniIcon.Visible = false
MiniIcon.Parent = ScreenGui
Instance.new("UICorner", MiniIcon).CornerRadius = UDim.new(0, 28)
local MiniStroke = Instance.new("UIStroke", MiniIcon)
MiniStroke.Color = ThemeColor
MiniStroke.Thickness = 2.5

MiniBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; MiniIcon.Visible = true end)
MiniIcon.MouseButton1Click:Connect(function() MiniIcon.Visible = false; MainFrame.Visible = true end)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 130, 1, -85)
TabContainer.Position = UDim2.new(0, 12, 0, 55)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -165, 1, -85)
ContentContainer.Position = UDim2.new(0, 153, 0, 55)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

local Pages = {}
local TabButtons = {}

local function CreatePage(name, order)
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.CanvasSize = UDim2.new(0, 0, 2.0, 0)
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = ThemeColor
    Page.Visible = false
    Page.Parent = ContentContainer
    Pages[name] = Page
    
    local UIList = Instance.new("UIListLayout")
    UIList.Padding = UDim.new(0, 8)
    UIList.Parent = Page

    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 38)
    TabBtn.Position = UDim2.new(0, 0, 0, order * 44)
    TabBtn.BackgroundColor3 = PanelColor
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextSize = 12
    TabBtn.Parent = TabContainer
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)
    TabButtons[name] = TabBtn

    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(TabButtons) do b.BackgroundColor3 = PanelColor end
        Page.Visible = true
        TabBtn.BackgroundColor3 = ThemeColor
    end)
end

CreatePage("MAIN", 0)
CreatePage("COMBAT", 1)
CreatePage("MOVEMENT", 2)
CreatePage("VISUAL & MISC", 3)

Pages["MAIN"].Visible = true
TabButtons["MAIN"].BackgroundColor3 = ThemeColor

local function CreateToggle(parent, text, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 44)
    Frame.BackgroundColor3 = PanelColor
    Frame.Parent = parent
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(240, 240, 240)
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Frame

    local Switch = Instance.new("TextButton")
    Switch.Size = UDim2.new(0, 48, 0, 24)
    Switch.Position = UDim2.new(1, -60, 0, 10)
    Switch.BackgroundColor3 = Color3.fromRGB(40, 35, 55)
    Switch.Text = ""
    Switch.Parent = Frame
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 18, 0, 18)
    Dot.Position = UDim2.new(0, 3, 0, 3)
    Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Dot.Parent = Switch
    Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

    local state = {value = false}
    Switch.MouseButton1Click:Connect(function()
        if state.value then
            state.value = false
            Dot.Position = UDim2.new(0, 3, 0, 3)
            Switch.BackgroundColor3 = Color3.fromRGB(40, 35, 55)
            callback(false)
        else
            state.value = true
            Dot.Position = UDim2.new(1, -21, 0, 3)
            Switch.BackgroundColor3 = ActiveColor
            callback(true)
        end
    end)
end

local Config = {
    Master = false,
    AutoHead = false,
    BodyHead = false,
    Silent = false,
    AutoFire = false,
    Speed = false,
    Jump = false,
    Noclip = false,
    Fly = false,
    Hologram = false,
    Minecraft = false,
    AntiBan = false
}

local function GetClosestTarget()
    local target = nil
    local maxDist = math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name ~= LocalPlayer.Name and p.Character then
            local part = p.Character:FindFirstChild("Head")
            if Config.BodyHead then part = p.Character:FindFirstChild("HumanoidRootPart") end
            if Config.AutoHead then part = p.Character:FindFirstChild("Head") end
            
            if part then
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - part.Position).Magnitude
                if distance < maxDist then
                    maxDist = distance
                    target = part
                end
            end
        end
    end
    return target
end

-- TAB 1: MAIN
CreateToggle(Pages["MAIN"], "Enable Function", function(val) Config.Master = val end)
CreateToggle(Pages["MAIN"], "Anti Ban", function(val)
    Config.AntiBan = val
    if val then
        local meta = getrawmetatable(game)
        if meta then
            setreadonly(meta, false)
            local old = meta.__index
            meta.__index = newcclosure(function(t, k)
                if tostring(k) == "Crash" or tostring(k) == "Kick" then return function() return nil end end
                return old(t, k)
            end)
            setreadonly(meta, true)
        end
    end
end)

-- TAB 2: COMBAT
CreateToggle(Pages["COMBAT"], "Silent Aim (Raycast Redirect)", function(val) Config.Silent = val end)
CreateToggle(Pages["COMBAT"], "Auto Headshot", function(val) Config.AutoHead = val end)
CreateToggle(Pages["COMBAT"], "Body Headshot", function(val) Config.BodyHead = val end)
CreateToggle(Pages["COMBAT"], "Auto Fire", function(val)
    Config.AutoFire = val
    spawn(function()
        while Config.AutoFire do
            task.wait(0.07)
            if Config.Master then
                local target = GetClosestTarget()
                if target then
                    VirtualUser:Button1Down(Vector2.new(0,0))
                    task.wait(0.02)
                    VirtualUser:Button1Up(Vector2.new(0,0))
                end
            end
        end
    end)
end)

-- SILENT AIM MECHANISM (Redirecting Index Mouse / Tool Hit)
local HookMeta = getrawmetatable(game)
local OldIndex = HookMeta.__index
setreadonly(HookMeta, false)
HookMeta.__index = newcclosure(function(self, key)
    if Config.Master and Config.Silent and tostring(key) == "Hit" then
        local target = GetClosestTarget()
        if target then
            return target.CFrame
        end
    end
    return OldIndex(self, key)
end)
setreadonly(HookMeta, true)

-- TAB 3: MOVEMENT
CreateToggle(Pages["MOVEMENT"], "Speed Max", function(val)
    Config.Speed = val
    spawn(function()
        while Config.Speed do
            task.wait(0.05)
            if Config.Master and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 150
            end
        end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end)
end)

CreateToggle(Pages["MOVEMENT"], "Jump Max", function(val)
    Config.Jump = val
    spawn(function()
        while Config.Jump do
            task.wait(0.05)
            if Config.Master and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.JumpPower = 250
            end
        end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end)
end)

CreateToggle(Pages["MOVEMENT"], "Noclip", function(val)
    Config.Noclip = val
    spawn(function()
        while Config.Noclip do
            task.wait(0.05)
            if Config.Master and LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end
    end)
end)

CreateToggle(Pages["MOVEMENT"], "Fly", function(val)
    Config.Fly = val
    spawn(function()
        while Config.Fly do
            task.wait(0.01)
            if Config.Master and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                hrp.Velocity = Vector3.new(0, 0.5, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    hrp.Velocity = Vector3.new(0, 60, 0)
                elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    hrp.Velocity = Vector3.new(0, -60, 0)
                end
            end
        end
    end)
end)

-- TAB 4: VISUAL & MISC
CreateToggle(Pages["VISUAL & MISC"], "Hologram Target", function(val)
    Config.Hologram = val
    spawn(function()
        while Config.Hologram do
            task.wait(0.5)
            if Config.Master then
                for _, p in pairs(Players:GetPlayers()) do
                    if p.Name ~= LocalPlayer.Name and p.Character then
                        for _, part in pairs(p.Character:GetChildren()) do
                            if part:IsA("BasePart") and not part:FindFirstChild("HoloInlay") then
                                local bbo = Instance.new("BoxHandleAdornment")
                                bbo.Name = "HoloInlay"
                                bbo.Size = part.Size + Vector3.new(0.05, 0.05, 0.05)
                                bbo.AlwaysOnTop = true
                                bbo.ZIndex = 5
                                bbo.Color3 = Color3.fromRGB(0, 200, 255)
                                bbo.Transparency = 0.6
                                bbo.Adornee = part
                                bbo.Parent = part
                            end
                        end
                    end
                end
            end
        end
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                for _, part in pairs(p.Character:GetDescendants()) do
                    if part.Name == "HoloInlay" then part:Destroy() end
                end
            end
        end
    end)
end)

CreateToggle(Pages["VISUAL & MISC"], "Minecraft Graphic", function(val)
    Config.Minecraft = val
    if val then
        if Config.Master then
            game:GetService("Lighting").GlobalShadows = false
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Texture") or obj:IsA("Decal") then
                    OriginalMaterials[obj] = {Parent = obj.Parent, Name = obj.Name, Asset = obj.Texture}
                    obj.Parent = nil
                end
            end
        end
    else
        game:GetService("Lighting").GlobalShadows = true
        for obj, data in pairs(OriginalMaterials) do
            if obj then
                obj.Parent = data.Parent
            end
        end
        table.clear(OriginalMaterials)
    end
end)
