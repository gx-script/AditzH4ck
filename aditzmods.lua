local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local currentLang = "ID"

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AditDosHub_Fixed"
ScreenGui.ResetOnSpawn = false

local function GetSafeParent()
    local success, core = pcall(function() return game:GetService("CoreGui") end)
    if success and core then return core end
    return LocalPlayer:WaitForChild("PlayerGui")
end
ScreenGui.Parent = GetSafeParent()

local ThemeColor = Color3.fromRGB(150, 30, 255)
local BGColor = Color3.fromRGB(11, 8, 20)
local PanelColor = Color3.fromRGB(22, 16, 38)
local ActiveColor = Color3.fromRGB(180, 70, 255)

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 340)
MainFrame.Position = UDim2.new(0.5, -260, 0.4, -170)
MainFrame.BackgroundColor3 = BGColor
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.BackgroundTransparency = 1
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = ThemeColor
UIStroke.Thickness = 2.5
UIStroke.Transparency = 1
UIStroke.Parent = MainFrame

spawn(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.05}):Play()
    TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0}):Play()
end)

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
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0, 18, 0, 0)
Title.Text = "* ADITDOS ENGINE | VIP V3"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

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
Watermark.Text = "* ACCESS GRANTED TO ADITYABRR *"
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
MiniIcon.BackgroundTransparency = 1
MiniIcon.Parent = ScreenGui
Instance.new("UICorner", MiniIcon).CornerRadius = UDim.new(0, 28)
local MiniStroke = Instance.new("UIStroke", MiniIcon)
MiniStroke.Color = ThemeColor
MiniStroke.Thickness = 2.5
MiniStroke.Transparency = 1

MiniBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
    TweenService:Create(UIStroke, TweenInfo.new(0.2), {Transparency = 1}):Play()
    task.wait(0.25)
    MainFrame.Visible = false
    MiniIcon.Visible = true
    TweenService:Create(MiniIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.1}):Play()
    TweenService:Create(MiniStroke, TweenInfo.new(0.3), {Transparency = 0}):Play()
end)

MiniIcon.MouseButton1Click:Connect(function()
    TweenService:Create(MiniIcon, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
    TweenService:Create(MiniStroke, TweenInfo.new(0.2), {Transparency = 1}):Play()
    task.wait(0.15)
    MiniIcon.Visible = false
    MainFrame.Visible = true
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 520, 0, 340), BackgroundTransparency = 0.05}):Play()
    TweenService:Create(UIStroke, TweenInfo.new(0.4), {Transparency = 0}):Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
    task.wait(0.2)
    ScreenGui:Destroy()
end)

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

local Tabs = {"COMBAT", "MOVEMENT", "VISUAL", "SETTINGS"}
local Pages = {}
local TabButtons = {}

for i, tabName in ipairs(Tabs) do
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.CanvasSize = UDim2.new(0, 0, 1.8, 0)
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = ThemeColor
    Page.Visible = false
    if string.match(tostring(i), "1") then Page.Visible = true end
    Page.Parent = ContentContainer
    Pages[tabName] = Page
    
    local UIList = Instance.new("UIListLayout")
    UIList.Padding = UDim.new(0, 9)
    UIList.Parent = Page

    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 38)
    TabBtn.Position = UDim2.new(0, 0, 0, (i-1)*44)
    TabBtn.BackgroundColor3 = PanelColor
    if string.match(tostring(i), "1") then TabBtn.BackgroundColor3 = ThemeColor end
    TabBtn.Text = tabName
    TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextSize = 12
    TabBtn.Parent = TabContainer
    TabButtons[tabName] = TabBtn
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)

    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, btn in pairs(TabButtons) do btn.BackgroundColor3 = PanelColor end
        Page.Visible = true
        TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = ThemeColor}):Play()
    end)
end

local function CreateToggle(parent, text, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -12, 0, 44)
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
            TweenService:Create(Dot, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 3, 0, 3)}):Play()
            TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 35, 55)}):Play()
            callback(false)
        else
            state.value = true
            TweenService:Create(Dot, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -21, 0, 3)}):Play()
            TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = ActiveColor}):Play()
            callback(true)
        end
    end)
end

local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -12, 0, 38)
    Btn.BackgroundColor3 = PanelColor
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.Parent = parent
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

    local Stroke = Instance.new("UIStroke", Btn)
    Stroke.Color = ThemeColor
    Stroke.Thickness = 1
    Stroke.Transparency = 0.6

    Btn.MouseButton1Click:Connect(function()
        local origColor = Btn.BackgroundColor3
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = ActiveColor}):Play()
        callback()
        task.wait(0.1)
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = origColor}):Play()
    end)
end

local SilentAimStatus = {Active = false}
local BodyHeadshotStatus = {Active = false}
local AutoHeadStatus = {Active = false}

CreateToggle(Pages["COMBAT"], "Silent Aim", function(val) SilentAimStatus.Active = val end)
CreateToggle(Pages["COMBAT"], "Body Headshot", function(val) BodyHeadshotStatus.Active = val end)
CreateToggle(Pages["COMBAT"], "Auto Head", function(val) AutoHeadStatus.Active = val end)

local AutoFireActive = {State = false}
CreateToggle(Pages["COMBAT"], "Auto Fire", function(val) 
    AutoFireActive.State = val 
    spawn(function()
        while AutoFireActive.State do
            task.wait(0.1)
            if Mouse.Target then
                local pName = Mouse.Target.Parent.Name
                if pName ~= LocalPlayer.Name then
                    if Mouse.Target.Parent:FindFirstChild("Humanoid") then
                        mouse1click()
                    end
                end
            end
        end
    end)
end)

CreateButton(Pages["COMBAT"], "Auto Clear Map Objects", function()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Debris") then obj:Destroy() end
        if string.match(obj.Name, "Corpse") then obj:Destroy() end
    end
end)

CreateButton(Pages["COMBAT"], "Teleport Mark", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name ~= LocalPlayer.Name then
            if p.Character then
                if p.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                    break
                end
            end
        end
    end
end)

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if SilentAimStatus.Active then
        if string.match(method, "Raycast") or string.match(method, "FindPartOnRay") then
            local target = nil
            local maxDist = math.huge
            for _, p in pairs(Players:GetPlayers()) do
                if p.Name ~= LocalPlayer.Name then
                    if p.Character then
                        if p.Character:FindFirstChild("Head") then
                            local pos, onScreen = Camera:WorldToScreenPoint(p.Character.Head.Position)
                            if onScreen then
                                local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                                if dist < maxDist then maxDist = dist; target = p end
                            end
                        end
                    end
                end
            end
            if target then
                local partName = "Head"
                if BodyHeadshotStatus.Active then partName = "HumanoidRootPart" end
                if AutoHeadStatus.Active then partName = "Head" end
                args[1] = Ray.new(Camera.CFrame.Position, (target.Character[partName].Position - Camera.CFrame.Position).Unit * 1000)
            end
        end
    end
    return old(self, unpack(args))
end)
setreadonly(mt, true)

local SpeedActive = {State = false}
CreateToggle(Pages["MOVEMENT"], "Speed Max", function(val)
    SpeedActive.State = val
    spawn(function()
        while SpeedActive.State do
            task.wait(0.05)
            pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 150 end)
        end
        pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end)
    end)
end)

local JumpActive = {State = false}
CreateToggle(Pages["MOVEMENT"], "Jump Max", function(val)
    JumpActive.State = val
    spawn(function()
        while JumpActive.State do
            task.wait(0.05)
            pcall(function() LocalPlayer.Character.Humanoid.JumpPower = 250 end)
        end
        pcall(function() LocalPlayer.Character.Humanoid.JumpPower = 50 end)
    end)
end)

local EspActive = {State = false}
CreateToggle(Pages["VISUAL"], "Esp Line Box", function(val)
    EspActive.State = val
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name ~= LocalPlayer.Name then
            if p.Character then
                if EspActive.State then
                    local hl = Instance.new("Highlight")
                    hl.Name = "AditHighlight"
                    hl.FillColor = ThemeColor
                    hl.Parent = p.Character
                else
                    if p.Character:FindFirstChild("AditHighlight") then p.Character.AditHighlight:Destroy() end
                end
            end
        end
    end
end)

local HologramActive = {State = false}
CreateToggle(Pages["VISUAL"], "Hologram", function(val)
    HologramActive.State = val
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name ~= LocalPlayer.Name then
            if p.Character then
                for _, part in pairs(p.Character:GetChildren()) do
                    if part:IsA("BasePart") then 
                        if HologramActive.State then
                            part.Material = Enum.Material.ForceField
                        else
                            part.Material = Enum.Material.Plastic
                        end
                    end
                end
            end
        end
    end
end)

CreateButton(Pages["VISUAL"], "Minecraft Graphic", function()
    game:GetService("Lighting").GlobalShadows = false
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Texture") then obj:Destroy() end
        if obj:IsA("Decal") then obj:Destroy() end
    end
end)

CreateButton(Pages["SETTINGS"], "Ubah Warna Acak", function()
    local r = math.random(120, 255)
    local g = math.random(60, 160)
    local b = math.random(190, 255)
    ThemeColor = Color3.fromRGB(r, g, b)
    ActiveColor = Color3.fromRGB(math.clamp(r+20, 0, 255), math.clamp(g+20, 0, 255), 255)
end)

CreateButton(Pages["SETTINGS"], "Ganti Bahasa", function()
    local nextLang = "ID"
    if currentLang == "ID" then nextLang = "EN"
    elseif currentLang == "EN" then nextLang = "ES"
    elseif currentLang == "ES" then nextLang = "FR"
    elseif currentLang == "FR" then nextLang = "FIL"
    elseif currentLang == "FIL" then nextLang = "ID"
    end
    currentLang = nextLang
    Title.Text = "* ADITDOS ENGINE " .. currentLang
end)
