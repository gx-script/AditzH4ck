local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local Localization = {
    ["ID"] = {combat = "TEMBAK", movement = "GERAK", visuals = "GRAFIS", settings = "PENGATURAN"},
    ["EN"] = {combat = "COMBAT", movement = "MOVE", visuals = "VISUAL", settings = "SETTINGS"},
    ["ES"] = {combat = "COMBATE", movement = "MOVER", visuals = "VISUAL", settings = "OPCIONES"},
    ["FR"] = {combat = "COMBAT", movement = "MOUV.", visuals = "VISUEL", settings = "REGLAGES"},
    ["FIL"] = {combat = "LABANAN", movement = "KILOS", visuals = "BISWAL", settings = "SETTING"}
}
local currentLang = "ID"

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AditDosHub_Custom"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local ThemeColor = Color3.fromRGB(140, 20, 252)
local BGColor = Color3.fromRGB(15, 11, 25)
local PanelColor = Color3.fromRGB(25, 20, 40)

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 320)
MainFrame.Position = UDim2.new(0.5, -250, 0.4, -160)
MainFrame.BackgroundColor3 = BGColor
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = ThemeColor
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

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
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = PanelColor
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "ADITZ MODS | FPS CUSTOM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

local MiniBtn = Instance.new("TextButton")
MiniBtn.Size = UDim2.new(0, 30, 0, 30)
MiniBtn.Position = UDim2.new(1, -75, 0, 5)
MiniBtn.Text = "−"
MiniBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
MiniBtn.Font = Enum.Font.GothamBold
MiniBtn.TextSize = 16
MiniBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MiniBtn.Parent = TopBar
Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(0, 5)

local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(1, 0, 0, 25)
Watermark.Position = UDim2.new(0, 0, 1, -25)
Watermark.BackgroundColor3 = PanelColor
Watermark.Text = "⚡ Powered by Yt @adityabrr ⚡"
Watermark.TextColor3 = ThemeColor
Watermark.Font = Enum.Font.GothamBold
Watermark.TextSize = 12
Watermark.Parent = MainFrame

local MiniIcon = Instance.new("TextButton")
MiniIcon.Size = UDim2.new(0, 50, 0, 50)
MiniIcon.Position = UDim2.new(0.05, 0, 0.1, 0)
MiniIcon.BackgroundColor3 = BGColor
MiniIcon.Text = "🔮"
MiniIcon.TextSize = 24
MiniIcon.Visible = false
MiniIcon.Parent = ScreenGui
Instance.new("UICorner", MiniIcon).CornerRadius = UDim.new(0, 25)
local MiniStroke = Instance.new("UIStroke", MiniIcon)
MiniStroke.Color = ThemeColor
MiniStroke.Thickness = 2

MiniBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 500, 0, 0)}).Completed:Connect(function()
        MainFrame.Visible = false
        MiniIcon.Visible = true
        MiniIcon.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(MiniIcon, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 50, 0, 50)}):Play()
    end):Play()
end)

MiniIcon.MouseButton1Click:Connect(function()
    MiniIcon.Visible = false
    MainFrame.Visible = true
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 500, 0, 320)}):Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 120, 1, -65)
TabContainer.Position = UDim2.new(0, 10, 0, 45)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -150, 1, -65)
ContentContainer.Position = UDim2.new(0, 140, 0, 45)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

local Tabs = {"COMBAT", "MOVEMENT", "VISUAL", "SETTINGS"}
local Pages = {}

for i, tabName in ipairs(Tabs) do
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    Page.ScrollBarThickness = 2
    Page.Visible = (string.match(tostring(i), "1") and true or false)
    Page.Parent = ContentContainer
    Pages[tabName] = Page
    
    local UIList = Instance.new("UIListLayout")
    UIList.Padding = UDim.new(0, 8)
    UIList.Parent = Page

    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 35)
    TabBtn.Position = UDim2.new(0, 0, 0, (i-1)*40)
    TabBtn.BackgroundColor3 = (string.match(tostring(i), "1") and ThemeColor or PanelColor)
    TabBtn.Text = tabName
    TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextSize = 12
    TabBtn.Parent = TabContainer
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, btn in pairs(TabContainer:GetChildren()) do if btn:IsA("TextButton") then btn.BackgroundColor3 = PanelColor end end
        Page.Visible = true
        TweenService:Create(TabBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = ThemeColor}):Play()
    end)
end

local function CreateToggle(parent, text, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 40)
    Frame.BackgroundColor3 = PanelColor
    Frame.Parent = parent
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Frame

    local Switch = Instance.new("TextButton")
    Switch.Size = UDim2.new(0, 45, 0, 22)
    Switch.Position = UDim2.new(1, -55, 0, 9)
    Switch.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
    Switch.Text = ""
    Switch.Parent = Frame
    local SwCorner = Instance.new("UICorner", Switch)
    SwCorner.CornerRadius = UDim.new(1, 0)

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 16, 0, 16)
    Dot.Position = UDim2.new(0, 3, 0, 3)
    Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Dot.Parent = Switch
    Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

    local enabled = false
    Switch.MouseButton1Click:Connect(function()
        enabled = not enabled
        local targetPos = enabled and UDim2.new(1, -19, 0, 3) or UDim2.new(0, 3, 0, 3)
        local targetColor = enabled and ThemeColor or Color3.fromRGB(50, 45, 65)
        
        TweenService:Create(Dot, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = targetPos}):Play()
        TweenService:Create(Switch, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = targetColor}):Play()
        callback(enabled)
    end)
end

local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 35)
    Btn.BackgroundColor3 = PanelColor
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamMedium
    Btn.TextSize = 13
    Btn.Parent = parent
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    Btn.MouseButton1Click:Connect(function()
        local oldSize = Btn.Size
        Btn:TweenSize(UDim2.new(1, -15, 0, 32), "Out", "Quad", 0.1, true, function()
            Btn:TweenSize(oldSize, "Out", "Quad", 0.1)
        end)
        callback()
    end)
end

local SilentAim = false
CreateToggle(Pages["COMBAT"], "Silent Aim", function(val) SilentAim = val end)
CreateToggle(Pages["COMBAT"], "Body Headshot", function(val) _G.BodyHeadshot = val end)

local AutoFire = false
CreateToggle(Pages["COMBAT"], "Auto Fire", function(val) 
    AutoFire = val 
    spawn(function()
        while AutoFire do
            task.wait(0.1)
            if Mouse.Target and Mouse.Target.Parent:FindFirstChild("Humanoid") then
                if not string.match(Mouse.Target.Parent.Name, LocalPlayer.Name) then mouse1click() end
            end
        end
    end)
end)

CreateToggle(Pages["COMBAT"], "Auto Head", function(val) _G.AutoHead = val end)
CreateButton(Pages["COMBAT"], "Auto Clear Map Objects", function()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Debris") or string.match(obj.Name, "Corpse") then obj:Destroy() end
    end
end)
CreateButton(Pages["COMBAT"], "Teleport Mark", function()
    for _, p in pairs(Players:GetPlayers()) do
        if not string.match(p.Name, LocalPlayer.Name) and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
            break
        end
    end
end)

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if SilentAim and (string.match(method, "FindPartOnRayWithIgnoreList") or string.match(method, "Raycast")) then
        local target = nil
        local maxDist = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if not string.match(p.Name, LocalPlayer.Name) and p.Character and p.Character:FindFirstChild("Head") then
                local pos, onScreen = Camera:WorldToScreenPoint(p.Character.Head.Position)
                if onScreen then
                    local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                    if dist < maxDist then maxDist = dist; target = p end
                end
            end
        end
        if target then
            local pName = _G.BodyHeadshot and "HumanoidRootPart" or "Head"
            args[1] = Ray.new(Camera.CFrame.Position, (target.Character[pName].Position - Camera.CFrame.Position).Unit * 1000)
        end
    end
    return old(self, unpack(args))
end)
setreadonly(mt, true)

local SpeedActive = false
CreateToggle(Pages["MOVEMENT"], "Speed Max", function(val)
    SpeedActive = val
    spawn(function()
        while SpeedActive do
            task.wait(0.1)
            pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 150 end)
        end
        pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end)
    end)
end)

local JumpActive = false
CreateToggle(Pages["MOVEMENT"], "Jump Max", function(val)
    JumpActive = val
    spawn(function()
        while JumpActive do
            task.wait(0.1)
            pcall(function() LocalPlayer.Character.Humanoid.JumpPower = 250 end)
        end
        pcall(function() LocalPlayer.Character.Humanoid.JumpPower = 50 end)
    end)
end)

local EspActive = false
CreateToggle(Pages["VISUAL"], "Esp Line Box", function(val)
    EspActive = val
    for _, p in pairs(Players:GetPlayers()) do
        if not string.match(p.Name, LocalPlayer.Name) and p.Character then
            if EspActive then
                local hl = Instance.new("Highlight")
                hl.Name = "AditHighlight"
                hl.FillColor = ThemeColor
                hl.Parent = p.Character
            else
                if p.Character:FindFirstChild("AditHighlight") then p.Character.AditHighlight:Destroy() end
            end
        end
    end
end)

CreateToggle(Pages["VISUAL"], "Hologram", function(val)
    _G.Hologram = val
    for _, p in pairs(Players:GetPlayers()) do
        if not string.match(p.Name, LocalPlayer.Name) and p.Character then
            for _, part in pairs(p.Character:GetChildren()) do
                if part:IsA("BasePart") then part.Material = (val and Enum.Material.ForceField or Enum.Material.Plastic) end
            end
        end
    end
end)

CreateButton(Pages["VISUAL"], "Minecraft Graphic", function()
    game:GetService("Lighting").GlobalShadows = false
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Texture") or obj:IsA("Decal") then obj:Destroy() end
    end
end)

CreateButton(Pages["SETTINGS"], "Ubah Warna Acak", function()
    local r = math.random(100, 255)
    local g = math.random(50, 150)
    local b = math.random(180, 255)
    ThemeColor = Color3.fromRGB(r, g, b)
    UIStroke.Color = ThemeColor
    MiniStroke.Color = ThemeColor
    Watermark.TextColor3 = ThemeColor
end)

CreateButton(Pages["SETTINGS"], "Ganti Bahasa", function()
    local langs = {"ID", "EN", "ES", "FR", "FIL"}
    local curIdx = table.find(langs, currentLang) or 1
    local nextIdx = curIdx + 1
    if nextIdx > #langs then nextIdx = 1 end
    currentLang = langs[nextIdx]
    Title.Text = "ADITZ MODS " .. currentLang
end)
