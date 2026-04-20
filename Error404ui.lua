-- ╔══════════════════════════════════════════════════════════╗
-- ║              ERROR 404 UI LIBRARY  v1.0                  ║
-- ║         Stylizowana biblioteka GUI dla Roblox            ║
-- ╚══════════════════════════════════════════════════════════╝

local Error404UI = {}
Error404UI.__index = Error404UI

-- ══════════════════════════════════════════════════════════════
-- SERVICES
-- ══════════════════════════════════════════════════════════════
local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local CoreGui          = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse       = LocalPlayer:GetMouse()

-- ══════════════════════════════════════════════════════════════
-- HELPERS
-- ══════════════════════════════════════════════════════════════
local function Tween(obj, info, props)
    TweenService:Create(obj, info, props):Play()
end

local function TI(t, style, dir)
    return TweenInfo.new(t, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out)
end

local function Round(frame, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = frame
    return c
end

local function Stroke(frame, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1.5
    s.Transparency = transparency or 0
    s.Parent = frame
    return s
end

local function Gradient(frame, c0, c1, rotation)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, c0), ColorSequenceKeypoint.new(1, c1) })
    g.Rotation = rotation or 135
    g.Parent = frame
    return g
end

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- ══════════════════════════════════════════════════════════════
-- MOTYW
-- ══════════════════════════════════════════════════════════════
local DefaultTheme = {
    Background   = Color3.fromRGB(14, 14, 22),
    Surface      = Color3.fromRGB(22, 22, 34),
    SurfaceLight = Color3.fromRGB(30, 30, 46),
    SurfaceMid   = Color3.fromRGB(26, 26, 40),
    Accent       = Color3.fromRGB(100, 60, 255),
    AccentLight  = Color3.fromRGB(140, 90, 255),
    AccentDark   = Color3.fromRGB(60, 30, 180),
    Text         = Color3.fromRGB(235, 235, 255),
    TextDim      = Color3.fromRGB(140, 135, 170),
    TextMuted    = Color3.fromRGB(90, 85, 120),
    Border       = Color3.fromRGB(50, 40, 85),
    Danger       = Color3.fromRGB(220, 50, 90),
    Success      = Color3.fromRGB(60, 210, 130),
    Warning      = Color3.fromRGB(255, 175, 50),
    Toggle_On    = Color3.fromRGB(100, 60, 255),
    Toggle_Off   = Color3.fromRGB(50, 45, 75),
}

-- ══════════════════════════════════════════════════════════════
-- INTRO ANIMACJA
-- ══════════════════════════════════════════════════════════════
local function PlayIntro(parent, callback)
    local tIn  = TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local tOut = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    local center = UDim2.new(0.5, 0, 0.5, 0)

    local function makeText(text, color, glowColor)
        local container = Instance.new("Frame")
        container.Size = UDim2.new(0, 700, 0, 110)
        container.AnchorPoint = Vector2.new(0.5, 0.5)
        container.BackgroundTransparency = 1
        container.ZIndex = 200
        container.Parent = parent

        local shadow = Instance.new("TextLabel")
        shadow.Size = UDim2.new(1, 8, 1, 8)
        shadow.Position = UDim2.new(0, -4, 0, -4)
        shadow.BackgroundTransparency = 1
        shadow.Text = text
        shadow.Font = Enum.Font.GothamBold
        shadow.TextSize = 78
        shadow.TextColor3 = glowColor
        shadow.TextTransparency = 0.55
        shadow.ZIndex = 200
        shadow.Parent = container

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.Font = Enum.Font.GothamBold
        label.TextSize = 78
        label.TextColor3 = color
        label.ZIndex = 201
        label.Parent = container

        local stroke = Instance.new("UIStroke")
        stroke.Color = glowColor
        stroke.Thickness = 2
        stroke.Transparency = 0.2
        stroke.Parent = label

        return container, label
    end

    local function pulse(label, times)
        for _ = 1, times do
            Tween(label, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0.4})
            task.wait(0.25)
            Tween(label, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0})
            task.wait(0.25)
        end
    end

    -- ERROR
    local c1, l1 = makeText("ERROR", Color3.fromRGB(200, 100, 255), Color3.fromRGB(160, 0, 255))
    c1.Position = UDim2.new(-0.6, 0, 0.5, 0)
    Tween(c1, tIn, {Position = center})
    task.wait(0.65)
    task.spawn(pulse, l1, 4)
    task.wait(2)
    Tween(c1, tOut, {Position = UDim2.new(1.6, 0, 0.5, 0)})
    task.wait(0.5)
    c1:Destroy()

    task.wait(0.1)

    -- 404
    local c2, l2 = makeText("404", Color3.fromRGB(255, 60, 130), Color3.fromRGB(255, 0, 80))
    c2.Position = UDim2.new(1.6, 0, 0.5, 0)
    Tween(c2, tIn, {Position = center})
    task.wait(0.65)
    task.spawn(pulse, l2, 4)
    task.wait(2)
    Tween(c2, tOut, {Position = UDim2.new(-0.6, 0, 0.5, 0)})
    task.wait(0.5)
    c2:Destroy()

    task.wait(0.2)
    if callback then callback() end
end

-- ══════════════════════════════════════════════════════════════
-- GŁÓWNA FUNKCJA: tworzenie okna
-- ══════════════════════════════════════════════════════════════

--[[
    Error404UI.new(config)
    config = {
        Title      = "Moje Menu",
        Subtitle   = "v1.0",
        ToggleKey  = Enum.KeyCode.Insert,  -- tylko desktop
        ShowIntro  = true,
        Theme      = {},  -- opcjonalne nadpisanie motywu
        Size       = {Width=340, Height=540},
    }
]]
function Error404UI.new(config)
    config = config or {}

    local self = setmetatable({}, Error404UI)
    self.Theme       = {}
    self.Tabs        = {}
    self.ActiveTab   = nil
    self.IsOpen      = false
    self.Connections = {}

    -- Scalanie motywu
    for k, v in pairs(DefaultTheme) do
        self.Theme[k] = (config.Theme and config.Theme[k]) or v
    end

    local T        = self.Theme
    local W        = (config.Size and config.Size.Width)  or (isMobile and 310 or 340)
    local H        = (config.Size and config.Size.Height) or (isMobile and 520 or 540)
    local toggleKey = config.ToggleKey or Enum.KeyCode.Insert

    -- ── ScreenGui ──
    local ok, sg = pcall(function()
        local s = Instance.new("ScreenGui")
        s.Name = "Error404UI_" .. (config.Title or "Menu")
        s.ResetOnSpawn = false
        s.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        s.IgnoreGuiInset = true
        s.DisplayOrder = 999
        s.Parent = CoreGui
        return s
    end)
    if not ok then
        local s = Instance.new("ScreenGui")
        s.Name = "Error404UI_" .. (config.Title or "Menu")
        s.ResetOnSpawn = false
        s.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        s.IgnoreGuiInset = true
        s.Parent = LocalPlayer:WaitForChild("PlayerGui")
        sg = s
    end
    self.ScreenGui = sg

    -- ── Główna ramka ──
    local Menu = Instance.new("Frame")
    Menu.Name = "Menu"
    Menu.Size = UDim2.new(0, W, 0, H)
    Menu.AnchorPoint = Vector2.new(0, 0.5)
    Menu.BackgroundColor3 = T.Background
    Menu.BorderSizePixel = 0
    Menu.ClipsDescendants = true
    Menu.ZIndex = 10
    Menu.Visible = false
    Menu.Parent = sg
    Round(Menu, 14)
    local menuStroke = Stroke(Menu, T.Border, 1.5)
    self.Menu = Menu
    self._menuStroke = menuStroke

    -- Drop shadow (visual tylko)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0.5, 0, 0.5, 10)
    shadow.Size = UDim2.new(1, 40, 1, 40)
    shadow.ZIndex = 9
    shadow.Image = "rbxassetid://5028857084"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(24, 24, 276, 276)
    shadow.Parent = Menu

    -- ══════════════════════════════════════
    -- PASEK TYTUŁU
    -- ══════════════════════════════════════
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 52)
    TitleBar.BackgroundColor3 = T.Surface
    TitleBar.BorderSizePixel = 0
    TitleBar.ZIndex = 11
    TitleBar.Parent = Menu
    Round(TitleBar, 14)

    -- Fix narożniki dolne
    local tbFix = Instance.new("Frame")
    tbFix.Size = UDim2.new(1, 0, 0, 14)
    tbFix.Position = UDim2.new(0, 0, 1, -14)
    tbFix.BackgroundColor3 = T.Surface
    tbFix.BorderSizePixel = 0
    tbFix.ZIndex = 11
    tbFix.Parent = TitleBar

    -- Linia akcentu
    local accentLine = Instance.new("Frame")
    accentLine.Size = UDim2.new(1, 0, 0, 2)
    accentLine.Position = UDim2.new(0, 0, 1, -2)
    accentLine.BackgroundColor3 = T.Accent
    accentLine.BorderSizePixel = 0
    accentLine.ZIndex = 12
    accentLine.Parent = TitleBar

    local alGrad = Instance.new("UIGradient")
    alGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(0,0,0)),
        ColorSequenceKeypoint.new(0.15, Color3.new(1,1,1)),
        ColorSequenceKeypoint.new(0.85, Color3.new(1,1,1)),
        ColorSequenceKeypoint.new(1, Color3.new(0,0,0)),
    })
    alGrad.Parent = accentLine

    -- Logo
    local logoCircle = Instance.new("Frame")
    logoCircle.Size = UDim2.new(0, 30, 0, 30)
    logoCircle.Position = UDim2.new(0, 12, 0.5, -15)
    logoCircle.BackgroundColor3 = T.Accent
    logoCircle.BorderSizePixel = 0
    logoCircle.ZIndex = 12
    logoCircle.Parent = TitleBar
    Round(logoCircle, 999)
    Gradient(logoCircle, T.AccentLight, T.AccentDark, 135)

    local logoLbl = Instance.new("TextLabel")
    logoLbl.Size = UDim2.new(1, 0, 1, 0)
    logoLbl.BackgroundTransparency = 1
    logoLbl.Text = "⚡"
    logoLbl.TextSize = 15
    logoLbl.Font = Enum.Font.GothamBold
    logoLbl.TextColor3 = Color3.new(1,1,1)
    logoLbl.ZIndex = 13
    logoLbl.Parent = logoCircle

    -- Tytuł i podtytuł
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -110, 0, 20)
    titleLbl.Position = UDim2.new(0, 50, 0, 8)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = config.Title or "ERROR 404 UI"
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 15
    titleLbl.TextColor3 = T.Text
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 12
    titleLbl.Parent = TitleBar

    local subLbl = Instance.new("TextLabel")
    subLbl.Size = UDim2.new(1, -110, 0, 14)
    subLbl.Position = UDim2.new(0, 50, 0, 30)
    subLbl.BackgroundTransparency = 1
    subLbl.Text = config.Subtitle or "v1.0"
    subLbl.Font = Enum.Font.Gotham
    subLbl.TextSize = 11
    subLbl.TextColor3 = T.TextDim
    subLbl.TextXAlignment = Enum.TextXAlignment.Left
    subLbl.ZIndex = 12
    subLbl.Parent = TitleBar

    -- Przycisk zamknięcia
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 28, 0, 28)
    closeBtn.Position = UDim2.new(1, -40, 0.5, -14)
    closeBtn.BackgroundColor3 = T.SurfaceLight
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "✕"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 13
    closeBtn.TextColor3 = T.TextDim
    closeBtn.ZIndex = 13
    closeBtn.Parent = TitleBar
    Round(closeBtn, 7)

    closeBtn.MouseEnter:Connect(function()
        Tween(closeBtn, TI(0.2), {BackgroundColor3 = T.Danger, TextColor3 = Color3.new(1,1,1)})
    end)
    closeBtn.MouseLeave:Connect(function()
        Tween(closeBtn, TI(0.2), {BackgroundColor3 = T.SurfaceLight, TextColor3 = T.TextDim})
    end)

    -- ══════════════════════════════════════
    -- SIDEBAR
    -- ══════════════════════════════════════
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 44, 1, -52)
    Sidebar.Position = UDim2.new(0, 0, 0, 52)
    Sidebar.BackgroundColor3 = T.Surface
    Sidebar.BorderSizePixel = 0
    Sidebar.ZIndex = 11
    Sidebar.Parent = Menu

    local sbRight = Instance.new("Frame")
    sbRight.Size = UDim2.new(0, 1, 1, 0)
    sbRight.Position = UDim2.new(1, -1, 0, 0)
    sbRight.BackgroundColor3 = T.Border
    sbRight.BorderSizePixel = 0
    sbRight.ZIndex = 12
    sbRight.Parent = Sidebar

    local sideLayout = Instance.new("UIListLayout")
    sideLayout.Padding = UDim.new(0, 5)
    sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sideLayout.Parent = Sidebar

    local sidePad = Instance.new("UIPadding")
    sidePad.PaddingTop = UDim.new(0, 10)
    sidePad.Parent = Sidebar

    self._sidebar = Sidebar
    self._sideLayout = sideLayout

    -- ══════════════════════════════════════
    -- CONTENT AREA
    -- ══════════════════════════════════════
    local ContentHolder = Instance.new("Frame")
    ContentHolder.Name = "ContentHolder"
    ContentHolder.Size = UDim2.new(1, -44, 1, -62)
    ContentHolder.Position = UDim2.new(0, 44, 0, 62)
    ContentHolder.BackgroundTransparency = 1
    ContentHolder.BorderSizePixel = 0
    ContentHolder.ClipsDescendants = true
    ContentHolder.ZIndex = 11
    ContentHolder.Parent = Menu
    self._contentHolder = ContentHolder

    -- ══════════════════════════════════════
    -- DRAG
    -- ══════════════════════════════════════
    do
        local dragging, dragStart, startPos
        TitleBar.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = inp.Position
                startPos = Menu.Position
            end
        end)
        TitleBar.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
                local delta = inp.Position - dragStart
                Menu.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end)
    end

    -- ══════════════════════════════════════
    -- OPEN / CLOSE
    -- ══════════════════════════════════════
    local openPos   = isMobile and UDim2.new(0.5, -W/2, 0.5, 0) or UDim2.new(0, 15, 0.5, 0)
    local closedPos = UDim2.new(-0.5, 0, 0.5, 0)

    function self:Open()
        if self.IsOpen then return end
        self.IsOpen = true
        Menu.Visible = true
        Menu.Position = closedPos
        Menu.BackgroundTransparency = 1
        menuStroke.Transparency = 1
        Tween(Menu, TI(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = openPos,
            BackgroundTransparency = 0,
        })
        Tween(menuStroke, TI(0.4), {Transparency = 0})
    end

    function self:Close()
        if not self.IsOpen then return end
        self.IsOpen = false
        Tween(Menu, TI(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Position = closedPos,
            BackgroundTransparency = 1,
        })
        Tween(menuStroke, TI(0.3), {Transparency = 1})
        task.delay(0.4, function()
            if not self.IsOpen then Menu.Visible = false end
        end)
    end

    function self:Toggle()
        if self.IsOpen then self:Close() else self:Open() end
    end

    function self:Destroy()
        sg:Destroy()
    end

    -- Close button
    closeBtn.MouseButton1Click:Connect(function() self:Close() end)
    closeBtn.TouchTap:Connect(function() self:Close() end)

    -- ── Mobile toggle ──
    if isMobile then
        local mBtn = Instance.new("TextButton")
        mBtn.Name = "MobileToggle"
        mBtn.Size = UDim2.new(0, 56, 0, 56)
        mBtn.Position = UDim2.new(0, 12, 1, -76)
        mBtn.AnchorPoint = Vector2.new(0, 1)
        mBtn.BackgroundColor3 = T.Accent
        mBtn.BorderSizePixel = 0
        mBtn.Text = "⚡"
        mBtn.TextSize = 24
        mBtn.Font = Enum.Font.GothamBold
        mBtn.TextColor3 = Color3.new(1,1,1)
        mBtn.ZIndex = 20
        mBtn.Parent = sg
        Round(mBtn, 16)
        Gradient(mBtn, T.AccentLight, T.AccentDark, 135)
        local mbs = Stroke(mBtn, Color3.fromRGB(160, 100, 255), 2)
        task.spawn(function()
            while mBtn.Parent do
                Tween(mbs, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.7})
                task.wait(1.3)
                Tween(mbs, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0})
                task.wait(1.3)
            end
        end)
        mBtn.TouchTap:Connect(function() self:Toggle() end)
    else
        -- Desktop key
        local conn = UserInputService.InputBegan:Connect(function(inp, gpe)
            if gpe then return end
            if inp.KeyCode == toggleKey then self:Toggle() end
        end)
        table.insert(self.Connections, conn)

        -- Hint
        local hint = Instance.new("Frame")
        hint.Size = UDim2.new(0, 185, 0, 28)
        hint.Position = UDim2.new(0, 10, 1, -42)
        hint.AnchorPoint = Vector2.new(0, 1)
        hint.BackgroundColor3 = T.Surface
        hint.BackgroundTransparency = 0.1
        hint.BorderSizePixel = 0
        hint.ZIndex = 5
        hint.Parent = sg
        Round(hint, 8)
        local hs = Stroke(hint, T.Border, 1)

        local hintLbl = Instance.new("TextLabel")
        hintLbl.Size = UDim2.new(1, 0, 1, 0)
        hintLbl.BackgroundTransparency = 1
        hintLbl.Text = "[ " .. toggleKey.Name:upper() .. " ] Otwórz menu"
        hintLbl.Font = Enum.Font.Gotham
        hintLbl.TextSize = 12
        hintLbl.TextColor3 = T.TextDim
        hintLbl.ZIndex = 6
        hintLbl.Parent = hint

        task.delay(5, function()
            Tween(hint,    TweenInfo.new(1.2), {BackgroundTransparency = 1})
            Tween(hintLbl, TweenInfo.new(1.2), {TextTransparency = 1})
            Tween(hs,      TweenInfo.new(1.2), {Transparency = 1})
        end)
    end

    -- ══════════════════════════════════════
    -- INTRO + START
    -- ══════════════════════════════════════
    if config.ShowIntro ~= false then
        task.spawn(function()
            PlayIntro(sg, function()
                task.delay(0.2, function() self:Open() end)
            end)
        end)
    else
        task.delay(0.1, function() self:Open() end)
    end

    return self
end

-- ══════════════════════════════════════════════════════════════
-- DODAWANIE ZAKŁADKI
-- ══════════════════════════════════════════════════════════════

--[[
    Window:AddTab(config)
    config = {
        Title = "Home",
        Icon  = "🏠",
    }
    returns Tab object
]]
function Error404UI:AddTab(config)
    config = config or {}
    local T = self.Theme
    local tabIndex = #self.Tabs + 1

    -- Przycisk na sidebarze
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0, 32, 0, 32)
    tabBtn.BackgroundColor3 = tabIndex == 1 and T.Accent or Color3.new(0,0,0)
    tabBtn.BackgroundTransparency = tabIndex == 1 and 0 or 1
    tabBtn.BorderSizePixel = 0
    tabBtn.Text = config.Icon or "●"
    tabBtn.TextSize = 15
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextColor3 = tabIndex == 1 and Color3.new(1,1,1) or T.TextDim
    tabBtn.ZIndex = 12
    tabBtn.LayoutOrder = tabIndex
    tabBtn.Parent = self._sidebar
    Round(tabBtn, 8)

    -- Tooltip
    local tooltip = Instance.new("TextLabel")
    tooltip.Size = UDim2.new(0, 0, 0, 22)
    tooltip.Position = UDim2.new(1, 8, 0.5, -11)
    tooltip.BackgroundColor3 = T.SurfaceMid
    tooltip.BackgroundTransparency = 1
    tooltip.BorderSizePixel = 0
    tooltip.Text = "  " .. (config.Title or "Tab") .. "  "
    tooltip.Font = Enum.Font.Gotham
    tooltip.TextSize = 11
    tooltip.TextColor3 = T.Text
    tooltip.AutomaticSize = Enum.AutomaticSize.X
    tooltip.TextTransparency = 1
    tooltip.ZIndex = 50
    tooltip.Parent = tabBtn
    Round(tooltip, 6)

    tabBtn.MouseEnter:Connect(function()
        Tween(tooltip, TI(0.15), {TextTransparency = 0, BackgroundTransparency = 0.1})
        if tabBtn.BackgroundTransparency == 1 then
            Tween(tabBtn, TI(0.2), {BackgroundTransparency = 0.7, BackgroundColor3 = T.Accent})
        end
    end)
    tabBtn.MouseLeave:Connect(function()
        Tween(tooltip, TI(0.15), {TextTransparency = 1, BackgroundTransparency = 1})
        if tabBtn.BackgroundTransparency ~= 0 then
            Tween(tabBtn, TI(0.2), {BackgroundTransparency = 1})
        end
    end)

    -- Scroll frame (zawartość zakładki)
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Name = "Tab_" .. tabIndex
    ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 3
    ScrollFrame.ScrollBarImageColor3 = T.Accent
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollFrame.ZIndex = 11
    ScrollFrame.Visible = tabIndex == 1
    ScrollFrame.Parent = self._contentHolder

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = ScrollFrame

    local pad = Instance.new("UIPadding")
    pad.PaddingTop    = UDim.new(0, 10)
    pad.PaddingLeft   = UDim.new(0, 10)
    pad.PaddingRight  = UDim.new(0, 10)
    pad.PaddingBottom = UDim.new(0, 10)
    pad.Parent = ScrollFrame

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)

    local tabObject = {
        Index  = tabIndex,
        Frame  = ScrollFrame,
        Button = tabBtn,
        Layout = layout,
        _window = self,
    }
    setmetatable(tabObject, { __index = Error404UI })

    -- Przełączanie zakładek
    local allTabs = self.Tabs
    tabBtn.MouseButton1Click:Connect(function()
        for _, t in ipairs(allTabs) do
            t.Frame.Visible = false
            Tween(t.Button, TI(0.2), {BackgroundTransparency = 1, TextColor3 = T.TextDim})
        end
        tabObject.Frame.Visible = true
        Tween(tabBtn, TI(0.2), {BackgroundTransparency = 0, BackgroundColor3 = T.Accent, TextColor3 = Color3.new(1,1,1)})
        self.ActiveTab = tabObject
    end)
    tabBtn.TouchTap:Connect(function()
        for _, t in ipairs(allTabs) do
            t.Frame.Visible = false
            Tween(t.Button, TI(0.2), {BackgroundTransparency = 1, TextColor3 = T.TextDim})
        end
        tabObject.Frame.Visible = true
        Tween(tabBtn, TI(0.2), {BackgroundTransparency = 0, BackgroundColor3 = T.Accent, TextColor3 = Color3.new(1,1,1)})
        self.ActiveTab = tabObject
    end)

    table.insert(self.Tabs, tabObject)
    if tabIndex == 1 then self.ActiveTab = tabObject end

    return tabObject
end

-- ══════════════════════════════════════════════════════════════
-- SEKCJA (grupuje elementy z nagłówkiem)
-- ══════════════════════════════════════════════════════════════

--[[
    Tab:AddSection(title)
    returns Section object
]]
function Error404UI:AddSection(title)
    local T = self._window and self._window.Theme or self.Theme
    local parentFrame = self.Frame  -- ScrollingFrame zakładki

    -- Header sekcji
    local sectionHeader = Instance.new("TextLabel")
    sectionHeader.Size = UDim2.new(1, 0, 0, 22)
    sectionHeader.BackgroundTransparency = 1
    sectionHeader.Text = (title or "Sekcja"):upper()
    sectionHeader.Font = Enum.Font.GothamBold
    sectionHeader.TextSize = 10
    sectionHeader.TextColor3 = T.Accent
    sectionHeader.TextXAlignment = Enum.TextXAlignment.Left
    sectionHeader.ZIndex = 12
    sectionHeader.LayoutOrder = self.Layout.AbsoluteContentSize.Y + 1
    sectionHeader.Parent = parentFrame

    -- Linia
    local sectionLine = Instance.new("Frame")
    sectionLine.Size = UDim2.new(1, 0, 0, 1)
    sectionLine.BackgroundColor3 = T.Border
    sectionLine.BorderSizePixel = 0
    sectionLine.ZIndex = 12
    sectionLine.LayoutOrder = sectionHeader.LayoutOrder + 1
    sectionLine.Parent = parentFrame

    local sectionObject = {
        Frame   = parentFrame,
        Layout  = self.Layout,
        _window = self._window or self,
        _orderBase = sectionLine.LayoutOrder,
        _itemCount = 0,
    }
    setmetatable(sectionObject, { __index = Error404UI })

    function sectionObject:_nextOrder()
        self._orderBase = self._orderBase + 1
        return self._orderBase
    end

    return sectionObject
end

-- ══════════════════════════════════════════════════════════════
-- PRZYCISK
-- ══════════════════════════════════════════════════════════════

--[[
    Tab/Section:AddButton(config)
    config = {
        Title    = "Kliknij mnie",
        Callback = function() end,
        Color    = Color3  (opcjonalne)
    }
]]
function Error404UI:AddButton(config)
    config = config or {}
    local T = self._window and self._window.Theme or self.Theme
    local parentFrame = self.Frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = config.Color or T.SurfaceLight
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.ZIndex = 12
    btn.AutoButtonColor = false
    btn.LayoutOrder = self._orderBase and self:_nextOrder() or 99
    btn.Parent = parentFrame
    Round(btn, 8)
    Stroke(btn, T.Border, 1, 0.5)

    -- Gradient
    Gradient(btn,
        config.Color and config.Color:Lerp(Color3.new(1,1,1), 0.08) or T.SurfaceLight,
        config.Color and config.Color:Lerp(Color3.new(0,0,0), 0.12) or T.Surface,
        90)

    local btnLabel = Instance.new("TextLabel")
    btnLabel.Size = UDim2.new(1, -16, 1, 0)
    btnLabel.Position = UDim2.new(0, 12, 0, 0)
    btnLabel.BackgroundTransparency = 1
    btnLabel.Text = config.Title or "Button"
    btnLabel.Font = Enum.Font.GothamBold
    btnLabel.TextSize = 13
    btnLabel.TextColor3 = config.Color and Color3.new(1,1,1) or T.Text
    btnLabel.TextXAlignment = Enum.TextXAlignment.Left
    btnLabel.ZIndex = 13
    btnLabel.Parent = btn

    -- Strzałka
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 20, 1, 0)
    arrow.Position = UDim2.new(1, -26, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "›"
    arrow.TextSize = 18
    arrow.Font = Enum.Font.GothamBold
    arrow.TextColor3 = T.TextDim
    arrow.ZIndex = 13
    arrow.Parent = btn

    -- Hover / click
    btn.MouseEnter:Connect(function()
        Tween(btn, TI(0.2), {BackgroundColor3 = T.Accent})
        Tween(btnLabel, TI(0.2), {TextColor3 = Color3.new(1,1,1)})
        Tween(arrow, TI(0.2), {TextColor3 = Color3.new(1,1,1), Position = UDim2.new(1,-22,0,0)})
    end)
    btn.MouseLeave:Connect(function()
        Tween(btn, TI(0.2), {BackgroundColor3 = config.Color or T.SurfaceLight})
        Tween(btnLabel, TI(0.2), {TextColor3 = config.Color and Color3.new(1,1,1) or T.Text})
        Tween(arrow, TI(0.2), {TextColor3 = T.TextDim, Position = UDim2.new(1,-26,0,0)})
    end)
    btn.MouseButton1Down:Connect(function()
        Tween(btn, TI(0.1), {BackgroundColor3 = T.AccentDark})
    end)
    btn.MouseButton1Up:Connect(function()
        Tween(btn, TI(0.15), {BackgroundColor3 = T.Accent})
        if config.Callback then
            task.spawn(pcall, config.Callback)
        end
    end)
    btn.TouchTap:Connect(function()
        Tween(btn, TI(0.1), {BackgroundColor3 = T.AccentDark})
        task.wait(0.1)
        Tween(btn, TI(0.15), {BackgroundColor3 = T.Accent})
        if config.Callback then
            task.spawn(pcall, config.Callback)
        end
    end)

    return btn
end

-- ══════════════════════════════════════════════════════════════
-- TOGGLE
-- ══════════════════════════════════════════════════════════════

--[[
    Tab/Section:AddToggle(config)
    config = {
        Title    = "Opcja",
        Default  = false,
        Callback = function(value) end,
    }
    returns { Value, SetValue(bool) }
]]
function Error404UI:AddToggle(config)
    config = config or {}
    local T = self._window and self._window.Theme or self.Theme
    local parentFrame = self.Frame

    local state = config.Default or false

    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 38)
    row.BackgroundColor3 = T.SurfaceLight
    row.BorderSizePixel = 0
    row.ZIndex = 12
    row.LayoutOrder = self._orderBase and self:_nextOrder() or 99
    row.Parent = parentFrame
    Round(row, 8)
    Stroke(row, T.Border, 1, 0.5)

    local rowLabel = Instance.new("TextLabel")
    rowLabel.Size = UDim2.new(1, -60, 1, 0)
    rowLabel.Position = UDim2.new(0, 12, 0, 0)
    rowLabel.BackgroundTransparency = 1
    rowLabel.Text = config.Title or "Toggle"
    rowLabel.Font = Enum.Font.Gotham
    rowLabel.TextSize = 13
    rowLabel.TextColor3 = T.Text
    rowLabel.TextXAlignment = Enum.TextXAlignment.Left
    rowLabel.ZIndex = 13
    rowLabel.Parent = row

    -- Track
    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 36, 0, 20)
    track.Position = UDim2.new(1, -46, 0.5, -10)
    track.BackgroundColor3 = state and T.Toggle_On or T.Toggle_Off
    track.BorderSizePixel = 0
    track.ZIndex = 13
    track.Parent = row
    Round(track, 999)

    -- Knob
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
    knob.BackgroundColor3 = Color3.new(1,1,1)
    knob.BorderSizePixel = 0
    knob.ZIndex = 14
    knob.Parent = track
    Round(knob, 999)

    local toggleObj = { Value = state }

    local function setValue(v)
        state = v
        toggleObj.Value = v
        Tween(track, TI(0.25, Enum.EasingStyle.Back), {BackgroundColor3 = v and T.Toggle_On or T.Toggle_Off})
        Tween(knob, TI(0.25, Enum.EasingStyle.Back), {
            Position = v and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        })
        if config.Callback then task.spawn(pcall, config.Callback, v) end
    end

    toggleObj.SetValue = setValue

    local clickArea = Instance.new("TextButton")
    clickArea.Size = UDim2.new(1, 0, 1, 0)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    clickArea.ZIndex = 15
    clickArea.Parent = row
    clickArea.MouseButton1Click:Connect(function() setValue(not state) end)
    clickArea.TouchTap:Connect(function() setValue(not state) end)

    return toggleObj
end

-- ══════════════════════════════════════════════════════════════
-- SLIDER
-- ══════════════════════════════════════════════════════════════

--[[
    Tab/Section:AddSlider(config)
    config = {
        Title    = "Prędkość",
        Min      = 0,
        Max      = 100,
        Default  = 50,
        Suffix   = "",       -- np. "%", " studs/s"
        Callback = function(value) end,
    }
    returns { Value, SetValue(num) }
]]
function Error404UI:AddSlider(config)
    config = config or {}
    local T = self._window and self._window.Theme or self.Theme
    local parentFrame = self.Frame

    local Min     = config.Min     or 0
    local Max     = config.Max     or 100
    local current = math.clamp(config.Default or Min, Min, Max)
    local suffix  = config.Suffix or ""

    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 52)
    container.BackgroundColor3 = T.SurfaceLight
    container.BorderSizePixel = 0
    container.ZIndex = 12
    container.LayoutOrder = self._orderBase and self:_nextOrder() or 99
    container.Parent = parentFrame
    Round(container, 8)
    Stroke(container, T.Border, 1, 0.5)

    local topRow = Instance.new("Frame")
    topRow.Size = UDim2.new(1, 0, 0, 28)
    topRow.BackgroundTransparency = 1
    topRow.ZIndex = 13
    topRow.Parent = container

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(0.7, 0, 1, 0)
    titleLbl.Position = UDim2.new(0, 12, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = config.Title or "Slider"
    titleLbl.Font = Enum.Font.Gotham
    titleLbl.TextSize = 13
    titleLbl.TextColor3 = T.Text
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 13
    titleLbl.Parent = topRow

    local valueLbl = Instance.new("TextLabel")
    valueLbl.Size = UDim2.new(0.3, -12, 1, 0)
    valueLbl.Position = UDim2.new(0.7, 0, 0, 0)
    valueLbl.BackgroundTransparency = 1
    valueLbl.Text = tostring(current) .. suffix
    valueLbl.Font = Enum.Font.GothamBold
    valueLbl.TextSize = 12
    valueLbl.TextColor3 = T.Accent
    valueLbl.TextXAlignment = Enum.TextXAlignment.Right
    valueLbl.ZIndex = 13
    valueLbl.Parent = topRow

    -- Track
    local trackBg = Instance.new("Frame")
    trackBg.Size = UDim2.new(1, -24, 0, 6)
    trackBg.Position = UDim2.new(0, 12, 0, 36)
    trackBg.BackgroundColor3 = T.Border
    trackBg.BorderSizePixel = 0
    trackBg.ZIndex = 13
    trackBg.Parent = container
    Round(trackBg, 999)

    local trackFill = Instance.new("Frame")
    local fillPct = (current - Min) / (Max - Min)
    trackFill.Size = UDim2.new(fillPct, 0, 1, 0)
    trackFill.BackgroundColor3 = T.Accent
    trackFill.BorderSizePixel = 0
    trackFill.ZIndex = 14
    trackFill.Parent = trackBg
    Round(trackFill, 999)
    Gradient(trackFill, T.AccentLight, T.Accent, 90)

    -- Knob
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.Position = UDim2.new(fillPct, 0, 0.5, 0)
    knob.BackgroundColor3 = Color3.new(1,1,1)
    knob.BorderSizePixel = 0
    knob.ZIndex = 15
    knob.Parent = trackBg
    Round(knob, 999)
    Stroke(knob, T.Accent, 2)

    local sliderObj = { Value = current }

    local function setValue(v, animate)
        v = math.clamp(math.round(v), Min, Max)
        current = v
        sliderObj.Value = v
        local pct = (v - Min) / (Max - Min)
        valueLbl.Text = tostring(v) .. suffix
        if animate then
            Tween(trackFill, TI(0.1), {Size = UDim2.new(pct, 0, 1, 0)})
            Tween(knob, TI(0.1), {Position = UDim2.new(pct, 0, 0.5, 0)})
        else
            trackFill.Size = UDim2.new(pct, 0, 1, 0)
            knob.Position = UDim2.new(pct, 0, 0.5, 0)
        end
        if config.Callback then task.spawn(pcall, config.Callback, v) end
    end

    sliderObj.SetValue = setValue

    -- Interakcja
    local sliding = false
    local function slide(inputPos)
        local absPos  = trackBg.AbsolutePosition.X
        local absSize = trackBg.AbsoluteSize.X
        local pct = math.clamp((inputPos - absPos) / absSize, 0, 1)
        setValue(Min + (Max - Min) * pct)
    end

    trackBg.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            sliding = true
            slide(inp.Position.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if sliding and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            slide(inp.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            sliding = false
        end
    end)

    return sliderObj
end

-- ══════════════════════════════════════════════════════════════
-- TEXTBOX (input)
-- ══════════════════════════════════════════════════════════════

--[[
    Tab/Section:AddTextBox(config)
    config = {
        Title       = "Podaj wartość",
        Placeholder = "Wpisz...",
        Default     = "",
        Callback    = function(text) end,  -- wywoływane po Enter / utracie fokusa
    }
    returns { Value, SetValue(str) }
]]
function Error404UI:AddTextBox(config)
    config = config or {}
    local T = self._window and self._window.Theme or self.Theme
    local parentFrame = self.Frame

    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 52)
    container.BackgroundColor3 = T.SurfaceLight
    container.BorderSizePixel = 0
    container.ZIndex = 12
    container.LayoutOrder = self._orderBase and self:_nextOrder() or 99
    container.Parent = parentFrame
    Round(container, 8)
    Stroke(container, T.Border, 1, 0.5)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -12, 0, 22)
    titleLbl.Position = UDim2.new(0, 12, 0, 4)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = config.Title or "TextBox"
    titleLbl.Font = Enum.Font.Gotham
    titleLbl.TextSize = 12
    titleLbl.TextColor3 = T.TextDim
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 13
    titleLbl.Parent = container

    local inputFrame = Instance.new("Frame")
    inputFrame.Size = UDim2.new(1, -24, 0, 22)
    inputFrame.Position = UDim2.new(0, 12, 0, 26)
    inputFrame.BackgroundColor3 = T.Background
    inputFrame.BorderSizePixel = 0
    inputFrame.ZIndex = 13
    inputFrame.Parent = container
    Round(inputFrame, 5)
    local inputStroke = Stroke(inputFrame, T.Border, 1)

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -10, 1, 0)
    textBox.Position = UDim2.new(0, 8, 0, 0)
    textBox.BackgroundTransparency = 1
    textBox.Text = config.Default or ""
    textBox.PlaceholderText = config.Placeholder or "Wpisz..."
    textBox.PlaceholderColor3 = T.TextMuted
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 12
    textBox.TextColor3 = T.Text
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.ClearTextOnFocus = false
    textBox.ZIndex = 14
    textBox.Parent = inputFrame

    textBox.Focused:Connect(function()
        Tween(inputStroke, TI(0.2), {Color = T.Accent, Transparency = 0})
    end)
    textBox.FocusLost:Connect(function(enter)
        Tween(inputStroke, TI(0.2), {Color = T.Border, Transparency = 0})
        if config.Callback then task.spawn(pcall, config.Callback, textBox.Text) end
    end)

    local obj = { Value = textBox.Text }
    obj.SetValue = function(_, v)
        textBox.Text = v
        obj.Value = v
    end
    textBox:GetPropertyChangedSignal("Text"):Connect(function()
        obj.Value = textBox.Text
    end)

    return obj
end

-- ══════════════════════════════════════════════════════════════
-- DROPDOWN
-- ══════════════════════════════════════════════════════════════

--[[
    Tab/Section:AddDropdown(config)
    config = {
        Title    = "Wybierz tryb",
        Options  = {"Opcja 1", "Opcja 2", "Opcja 3"},
        Default  = "Opcja 1",
        Callback = function(selected) end,
    }
    returns { Value, SetValue(str), Refresh(options) }
]]
function Error404UI:AddDropdown(config)
    config = config or {}
    local T = self._window and self._window.Theme or self.Theme
    local parentFrame = self.Frame

    local options = config.Options or {}
    local selected = config.Default or (options[1] or "")
    local isOpen = false

    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 38)
    container.BackgroundColor3 = T.SurfaceLight
    container.BorderSizePixel = 0
    container.ClipsDescendants = false
    container.ZIndex = 12
    container.LayoutOrder = self._orderBase and self:_nextOrder() or 99
    container.Parent = parentFrame
    Round(container, 8)
    Stroke(container, T.Border, 1, 0.5)

    local header = Instance.new("TextButton")
    header.Size = UDim2.new(1, 0, 0, 38)
    header.BackgroundTransparency = 1
    header.BorderSizePixel = 0
    header.Text = ""
    header.ZIndex = 13
    header.Parent = container

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(0.6, 0, 1, 0)
    titleLbl.Position = UDim2.new(0, 12, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = config.Title or "Dropdown"
    titleLbl.Font = Enum.Font.Gotham
    titleLbl.TextSize = 13
    titleLbl.TextColor3 = T.TextDim
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 14
    titleLbl.Parent = header

    local valueLbl = Instance.new("TextLabel")
    valueLbl.Size = UDim2.new(0.38, 0, 1, 0)
    valueLbl.Position = UDim2.new(0.58, 0, 0, 0)
    valueLbl.BackgroundTransparency = 1
    valueLbl.Text = selected
    valueLbl.Font = Enum.Font.GothamBold
    valueLbl.TextSize = 12
    valueLbl.TextColor3 = T.Text
    valueLbl.TextXAlignment = Enum.TextXAlignment.Right
    valueLbl.ZIndex = 14
    valueLbl.Parent = header

    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 20, 1, 0)
    arrow.Position = UDim2.new(1, -22, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "▾"
    arrow.TextSize = 12
    arrow.Font = Enum.Font.GothamBold
    arrow.TextColor3 = T.TextDim
    arrow.ZIndex = 14
    arrow.Parent = header

    -- Lista opcji
    local dropList = Instance.new("Frame")
    dropList.Size = UDim2.new(1, 0, 0, 0)
    dropList.Position = UDim2.new(0, 0, 1, 4)
    dropList.BackgroundColor3 = T.SurfaceMid
    dropList.BorderSizePixel = 0
    dropList.ClipsDescendants = true
    dropList.ZIndex = 50
    dropList.Visible = false
    dropList.Parent = container
    Round(dropList, 8)
    Stroke(dropList, T.Border, 1)

    local dropLayout = Instance.new("UIListLayout")
    dropLayout.SortOrder = Enum.SortOrder.LayoutOrder
    dropLayout.Parent = dropList

    local dropObj = { Value = selected }

    local function buildOptions()
        for _, c in ipairs(dropList:GetChildren()) do
            if c:IsA("TextButton") then c:Destroy() end
        end
        for _, opt in ipairs(options) do
            local optBtn = Instance.new("TextButton")
            optBtn.Size = UDim2.new(1, 0, 0, 30)
            optBtn.BackgroundColor3 = opt == selected and T.Accent or Color3.new(0,0,0)
            optBtn.BackgroundTransparency = opt == selected and 0.3 or 1
            optBtn.BorderSizePixel = 0
            optBtn.Text = ""
            optBtn.ZIndex = 51
            optBtn.Parent = dropList

            local optLbl = Instance.new("TextLabel")
            optLbl.Size = UDim2.new(1, -20, 1, 0)
            optLbl.Position = UDim2.new(0, 10, 0, 0)
            optLbl.BackgroundTransparency = 1
            optLbl.Text = opt
            optLbl.Font = Enum.Font.Gotham
            optLbl.TextSize = 12
            optLbl.TextColor3 = opt == selected and T.Text or T.TextDim
            optLbl.TextXAlignment = Enum.TextXAlignment.Left
            optLbl.ZIndex = 52
            optLbl.Parent = optBtn

            optBtn.MouseEnter:Connect(function()
                if opt ~= selected then
                    Tween(optBtn, TI(0.15), {BackgroundTransparency = 0.7, BackgroundColor3 = T.Accent})
                    Tween(optLbl, TI(0.15), {TextColor3 = T.Text})
                end
            end)
            optBtn.MouseLeave:Connect(function()
                if opt ~= selected then
                    Tween(optBtn, TI(0.15), {BackgroundTransparency = 1})
                    Tween(optLbl, TI(0.15), {TextColor3 = T.TextDim})
                end
            end)

            local function selectOpt()
                selected = opt
                dropObj.Value = opt
                valueLbl.Text = opt
                if config.Callback then task.spawn(pcall, config.Callback, opt) end
                buildOptions()
                isOpen = false
                Tween(dropList, TI(0.2), {Size = UDim2.new(1, 0, 0, 0)})
                task.delay(0.2, function() dropList.Visible = false end)
                Tween(arrow, TI(0.2), {Rotation = 0})
            end
            optBtn.MouseButton1Click:Connect(selectOpt)
            optBtn.TouchTap:Connect(selectOpt)
        end
    end
    buildOptions()

    -- Toggle dropdown
    local function toggleDrop()
        isOpen = not isOpen
        if isOpen then
            dropList.Visible = true
            local totalH = #options * 30
            Tween(dropList, TI(0.25, Enum.EasingStyle.Back), {Size = UDim2.new(1, 0, 0, totalH)})
            Tween(arrow, TI(0.2), {Rotation = 180})
        else
            Tween(dropList, TI(0.2), {Size = UDim2.new(1, 0, 0, 0)})
            Tween(arrow, TI(0.2), {Rotation = 0})
            task.delay(0.2, function() dropList.Visible = false end)
        end
    end
    header.MouseButton1Click:Connect(toggleDrop)
    header.TouchTap:Connect(toggleDrop)

    dropObj.SetValue = function(_, v)
        selected = v
        dropObj.Value = v
        valueLbl.Text = v
        buildOptions()
    end
    dropObj.Refresh = function(_, newOptions)
        options = newOptions
        buildOptions()
    end

    return dropObj
end

-- ══════════════════════════════════════════════════════════════
-- LABEL (tekst informacyjny)
-- ══════════════════════════════════════════════════════════════

--[[
    Tab/Section:AddLabel(text)
]]
function Error404UI:AddLabel(text)
    local T = self._window and self._window.Theme or self.Theme
    local parentFrame = self.Frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 26)
    lbl.BackgroundTransparency = 1
    lbl.Text = text or ""
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextColor3 = T.TextDim
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true
    lbl.ZIndex = 12
    lbl.LayoutOrder = self._orderBase and self:_nextOrder() or 99
    lbl.Parent = parentFrame

    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 4)
    pad.Parent = lbl

    return lbl
end

-- ══════════════════════════════════════════════════════════════
-- SEPARATOR
-- ══════════════════════════════════════════════════════════════

function Error404UI:AddSeparator()
    local T = self._window and self._window.Theme or self.Theme
    local parentFrame = self.Frame

    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(1, 0, 0, 1)
    sep.BackgroundColor3 = T.Border
    sep.BorderSizePixel = 0
    sep.ZIndex = 12
    sep.LayoutOrder = self._orderBase and self:_nextOrder() or 99
    sep.Parent = parentFrame
    return sep
end

-- ══════════════════════════════════════════════════════════════
-- KEYBIND
-- ══════════════════════════════════════════════════════════════

--[[
    Tab/Section:AddKeybind(config)
    config = {
        Title    = "Sprint",
        Default  = Enum.KeyCode.LeftShift,
        Callback = function(keyCode) end,
    }
    returns { Value, SetValue(KeyCode) }
]]
function Error404UI:AddKeybind(config)
    config = config or {}
    local T = self._window and self._window.Theme or self.Theme
    local parentFrame = self.Frame

    local currentKey = config.Default or Enum.KeyCode.Unknown
    local listening = false

    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 38)
    row.BackgroundColor3 = T.SurfaceLight
    row.BorderSizePixel = 0
    row.ZIndex = 12
    row.LayoutOrder = self._orderBase and self:_nextOrder() or 99
    row.Parent = parentFrame
    Round(row, 8)
    Stroke(row, T.Border, 1, 0.5)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(0.6, 0, 1, 0)
    titleLbl.Position = UDim2.new(0, 12, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = config.Title or "Keybind"
    titleLbl.Font = Enum.Font.Gotham
    titleLbl.TextSize = 13
    titleLbl.TextColor3 = T.Text
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 13
    titleLbl.Parent = row

    local keyBtn = Instance.new("TextButton")
    keyBtn.Size = UDim2.new(0, 70, 0, 24)
    keyBtn.Position = UDim2.new(1, -80, 0.5, -12)
    keyBtn.BackgroundColor3 = T.Surface
    keyBtn.BorderSizePixel = 0
    keyBtn.Text = currentKey.Name
    keyBtn.Font = Enum.Font.GothamBold
    keyBtn.TextSize = 11
    keyBtn.TextColor3 = T.Accent
    keyBtn.ZIndex = 13
    keyBtn.Parent = row
    Round(keyBtn, 6)
    Stroke(keyBtn, T.Accent, 1, 0.3)

    local kbObj = { Value = currentKey }

    kbObj.SetValue = function(_, key)
        currentKey = key
        kbObj.Value = key
        keyBtn.Text = key.Name
        if config.Callback then task.spawn(pcall, config.Callback, key) end
    end

    keyBtn.MouseButton1Click:Connect(function()
        if listening then return end
        listening = true
        keyBtn.Text = "..."
        Tween(keyBtn, TI(0.2), {BackgroundColor3 = T.Accent, TextColor3 = Color3.new(1,1,1)})
    end)

    UserInputService.InputBegan:Connect(function(inp, gpe)
        if not listening then return end
        if inp.UserInputType == Enum.UserInputType.Keyboard then
            listening = false
            currentKey = inp.KeyCode
            kbObj.Value = inp.KeyCode
            keyBtn.Text = inp.KeyCode.Name
            Tween(keyBtn, TI(0.2), {BackgroundColor3 = T.Surface, TextColor3 = T.Accent})
            if config.Callback then task.spawn(pcall, config.Callback, inp.KeyCode) end
        end
    end)

    return kbObj
end

-- ══════════════════════════════════════════════════════════════
-- NOTIFICATION (powiadomienie)
-- ══════════════════════════════════════════════════════════════

--[[
    Error404UI.Notify(config)  (funkcja statyczna, nie wymaga okna)
    config = {
        Title    = "Sukces",
        Message  = "Operacja zakończona",
        Duration = 4,
        Type     = "success" | "error" | "warning" | "info",
    }
]]
function Error404UI.Notify(config)
    config = config or {}
    local T = DefaultTheme

    local typeColors = {
        success = T.Success,
        error   = T.Danger,
        warning = T.Warning,
        info    = T.Accent,
    }
    local typeIcons = {
        success = "✓",
        error   = "✕",
        warning = "⚠",
        info    = "ℹ",
    }
    local accentColor = typeColors[config.Type or "info"] or T.Accent
    local icon        = typeIcons[config.Type or "info"] or "ℹ"

    -- Znajdź lub stwórz kontener powiadomień
    local sg
    for _, gui in ipairs(CoreGui:GetChildren()) do
        if gui.Name == "Error404UI_Notifications" then sg = gui; break end
    end
    if not sg then
        local ok, s = pcall(function()
            local s2 = Instance.new("ScreenGui")
            s2.Name = "Error404UI_Notifications"
            s2.ResetOnSpawn = false
            s2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            s2.DisplayOrder = 1000
            s2.Parent = CoreGui
            return s2
        end)
        if ok then sg = s else
            sg = Instance.new("ScreenGui")
            sg.Name = "Error404UI_Notifications"
            sg.ResetOnSpawn = false
            sg.Parent = LocalPlayer:WaitForChild("PlayerGui")
        end
    end

    -- Holder
    local holder = sg:FindFirstChild("NotifHolder")
    if not holder then
        holder = Instance.new("Frame")
        holder.Name = "NotifHolder"
        holder.Size = UDim2.new(0, 280, 1, 0)
        holder.Position = UDim2.new(1, -295, 0, 0)
        holder.BackgroundTransparency = 1
        holder.BorderSizePixel = 0
        holder.ZIndex = 100
        holder.Parent = sg
        local hl = Instance.new("UIListLayout")
        hl.VerticalAlignment = Enum.VerticalAlignment.Bottom
        hl.Padding = UDim.new(0, 8)
        hl.SortOrder = Enum.SortOrder.LayoutOrder
        hl.Parent = holder
        local hp = Instance.new("UIPadding")
        hp.PaddingBottom = UDim.new(0, 16)
        hp.Parent = holder
    end

    -- Karta powiadomienia
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 72)
    card.BackgroundColor3 = T.Surface
    card.BorderSizePixel = 0
    card.ZIndex = 101
    card.BackgroundTransparency = 1
    card.Parent = holder
    Round(card, 10)
    Stroke(card, accentColor, 1, 0.3)

    local accentBar = Instance.new("Frame")
    accentBar.Size = UDim2.new(0, 3, 1, 0)
    accentBar.BackgroundColor3 = accentColor
    accentBar.BorderSizePixel = 0
    accentBar.ZIndex = 102
    accentBar.Parent = card
    Round(accentBar, 3)

    local iconLbl = Instance.new("TextLabel")
    iconLbl.Size = UDim2.new(0, 30, 0, 30)
    iconLbl.Position = UDim2.new(0, 12, 0.5, -15)
    iconLbl.BackgroundColor3 = accentColor
    iconLbl.BackgroundTransparency = 0.8
    iconLbl.Text = icon
    iconLbl.Font = Enum.Font.GothamBold
    iconLbl.TextSize = 14
    iconLbl.TextColor3 = accentColor
    iconLbl.ZIndex = 102
    iconLbl.Parent = card
    Round(iconLbl, 8)

    local notifTitle = Instance.new("TextLabel")
    notifTitle.Size = UDim2.new(1, -60, 0, 22)
    notifTitle.Position = UDim2.new(0, 52, 0, 10)
    notifTitle.BackgroundTransparency = 1
    notifTitle.Text = config.Title or "Powiadomienie"
    notifTitle.Font = Enum.Font.GothamBold
    notifTitle.TextSize = 13
    notifTitle.TextColor3 = T.Text
    notifTitle.TextXAlignment = Enum.TextXAlignment.Left
    notifTitle.ZIndex = 102
    notifTitle.Parent = card

    local notifMsg = Instance.new("TextLabel")
    notifMsg.Size = UDim2.new(1, -60, 0, 28)
    notifMsg.Position = UDim2.new(0, 52, 0, 34)
    notifMsg.BackgroundTransparency = 1
    notifMsg.Text = config.Message or ""
    notifMsg.Font = Enum.Font.Gotham
    notifMsg.TextSize = 11
    notifMsg.TextColor3 = T.TextDim
    notifMsg.TextXAlignment = Enum.TextXAlignment.Left
    notifMsg.TextWrapped = true
    notifMsg.ZIndex = 102
    notifMsg.Parent = card

    -- Pasek postępu
    local progressBg = Instance.new("Frame")
    progressBg.Size = UDim2.new(1, 0, 0, 2)
    progressBg.Position = UDim2.new(0, 0, 1, -2)
    progressBg.BackgroundColor3 = T.Border
    progressBg.BorderSizePixel = 0
    progressBg.ZIndex = 102
    progressBg.Parent = card

    local progressFill = Instance.new("Frame")
    progressFill.Size = UDim2.new(1, 0, 1, 0)
    progressFill.BackgroundColor3 = accentColor
    progressFill.BorderSizePixel = 0
    progressFill.ZIndex = 103
    progressFill.Parent = progressBg

    -- Animacja wejścia
    card.Position = UDim2.new(1, 20, 0, 0)
    Tween(card, TI(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Position = UDim2.new(0, 0, 0, 0)})

    local duration = config.Duration or 4
    Tween(progressFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)})

    task.delay(duration, function()
        Tween(card, TI(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            BackgroundTransparency = 1,
            Position = UDim2.new(1, 20, 0, 0),
        })
        task.delay(0.35, function() card:Destroy() end)
    end)
end

return Error404UI
