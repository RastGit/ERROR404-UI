--[[
╔══════════════════════════════════════════════════════════════════╗
║                    ERROR 404 UI LIBRARY  v4.0                    ║
║       Executor-safe | PC + Mobile | Clean modern design          ║
╚══════════════════════════════════════════════════════════════════╝

   ⚡ Własne API inspirowane Rayfield
   ⚡ Executor-compatible (wszystkie popularne executory)
   ⚡ Responsive design (mobile + desktop)
   ⚡ Działający fly, noclip, ESP, speed
   ⚡ Intro animacja ERROR → 404
]]

local Library = {}

-- ══════════════════════════════════════════════════════════════
-- SERVICES & GLOBALS
-- ══════════════════════════════════════════════════════════════
local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local CoreGui          = game:GetService("CoreGui")

local LP     = Players.LocalPlayer
local Mouse  = LP:GetMouse()
local MOBILE = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- ══════════════════════════════════════════════════════════════
-- THEME (ERROR 404 colors)
-- ══════════════════════════════════════════════════════════════
local Theme = {
    -- Backgrounds
    BG1        = Color3.fromRGB(15, 15, 26),
    BG2        = Color3.fromRGB(22, 22, 42),
    BG3        = Color3.fromRGB(30, 30, 53),
    BG4        = Color3.fromRGB(37, 37, 64),
    
    -- Accent (purple)
    Accent     = Color3.fromRGB(139, 92, 246),
    AccentDark = Color3.fromRGB(124, 58, 237),
    AccentGlow = Color3.fromRGB(139, 92, 246),
    
    -- Text
    Text       = Color3.fromRGB(226, 232, 240),
    TextDim    = Color3.fromRGB(148, 163, 184),
    TextMuted  = Color3.fromRGB(100, 116, 139),
    
    -- Borders
    Border     = Color3.fromRGB(56, 50, 90),
    BorderLight= Color3.fromRGB(80, 72, 120),
    
    -- Status colors
    Green      = Color3.fromRGB(34, 197, 94),
    Red        = Color3.fromRGB(239, 68, 68),
    Orange     = Color3.fromRGB(249, 115, 22),
    Blue       = Color3.fromRGB(59, 130, 246),
}

-- ══════════════════════════════════════════════════════════════
-- UTILITIES
-- ══════════════════════════════════════════════════════════════
local function Create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        if k ~= "Parent" then
            obj[k] = v
        end
    end
    if props.Parent then
        obj.Parent = props.Parent
    end
    return obj
end

local function Tween(obj, time, props, style, dir)
    TweenService:Create(obj,
        TweenInfo.new(time, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out),
        props
    ):Play()
end

local function Corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
    return c
end

local function Stroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0
    s.Parent = parent
    return s
end

local function ListLayout(parent, padding)
    local l = Instance.new("UIListLayout")
    l.Padding = UDim.new(0, padding or 6)
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Parent = parent
    return l
end

local function Padding(parent, all)
    local p = Instance.new("UIPadding")
    p.PaddingTop    = UDim.new(0, all or 0)
    p.PaddingBottom = UDim.new(0, all or 0)
    p.PaddingLeft   = UDim.new(0, all or 0)
    p.PaddingRight  = UDim.new(0, all or 0)
    p.Parent = parent
    return p
end

local function MakeSG(name, order)
    local sg
    local ok = pcall(function()
        sg = Create("ScreenGui", {
            Name = name,
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            IgnoreGuiInset = true,
            DisplayOrder = order or 100,
            Parent = CoreGui,
        })
    end)
    if not ok or not sg then
        sg = Create("ScreenGui", {
            Name = name,
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            IgnoreGuiInset = true,
            Parent = LP:WaitForChild("PlayerGui"),
        })
    end
    return sg
end

-- ══════════════════════════════════════════════════════════════
-- INTRO ANIMATION
-- ══════════════════════════════════════════════════════════════
local function PlayIntro(callback)
    local sg = MakeSG("E404Intro", 10000)
    
    local function MakeWord(text, mainColor, glowColor)
        local frame = Create("Frame", {
            Size = UDim2.new(0, 780, 0, 130),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            ZIndex = 500,
            Parent = sg,
        })
        
        -- Glow
        Create("TextLabel", {
            Size = UDim2.new(1, 16, 1, 16),
            Position = UDim2.new(0, -8, 0, -8),
            BackgroundTransparency = 1,
            Text = text,
            Font = Enum.Font.GothamBold,
            TextSize = 88,
            TextColor3 = glowColor,
            TextTransparency = 0.65,
            ZIndex = 500,
            Parent = frame,
        })
        
        -- Main text
        local label = Create("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = text,
            Font = Enum.Font.GothamBold,
            TextSize = 88,
            TextColor3 = mainColor,
            TextTransparency = 0,
            ZIndex = 501,
            Parent = frame,
        })
        
        Stroke(label, glowColor, 3, 0.2)
        
        return frame, label
    end
    
    local function Pulse(label, times)
        for i = 1, times do
            Tween(label, 0.18, {TextTransparency = 0.5}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(0.18)
            Tween(label, 0.18, {TextTransparency = 0}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(0.18)
        end
    end
    
    local center = UDim2.new(0.5, 0, 0.5, 0)
    
    -- ERROR
    local c1, l1 = MakeWord("ERROR", Color3.fromRGB(189, 91, 252), Color3.fromRGB(145, 0, 252))
    c1.Position = UDim2.new(-0.7, 0, 0.5, 0)
    Tween(c1, 0.6, {Position = center}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    task.wait(0.65)
    task.spawn(Pulse, l1, 4)
    task.wait(2.0)
    Tween(c1, 0.45, {Position = UDim2.new(1.7, 0, 0.5, 0)}, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    task.wait(0.5)
    c1:Destroy()
    
    task.wait(0.1)
    
    -- 404
    local c2, l2 = MakeWord("404", Color3.fromRGB(252, 54, 122), Color3.fromRGB(252, 0, 72))
    c2.Position = UDim2.new(1.7, 0, 0.5, 0)
    Tween(c2, 0.6, {Position = center}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    task.wait(0.65)
    task.spawn(Pulse, l2, 4)
    task.wait(2.0)
    Tween(c2, 0.45, {Position = UDim2.new(-0.7, 0, 0.5, 0)}, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    task.wait(0.5)
    c2:Destroy()
    
    task.wait(0.2)
    sg:Destroy()
    
    if callback then callback() end
end

-- ══════════════════════════════════════════════════════════════
-- ICONS (SVG-like simple shapes)
-- ══════════════════════════════════════════════════════════════
local Icons = {
    Player = "👤",
    Eye    = "👁",
    Settings = "⚙️",
    Zap    = "⚡",
    Target = "🎯",
    Shield = "🛡️",
    Speed  = "🏃",
    Jump   = "⬆️",
}

-- ══════════════════════════════════════════════════════════════
-- WINDOW
-- ══════════════════════════════════════════════════════════════
--[[
    Library.CreateWindow({
        Name        = "Nazwa scriptu",
        Version     = "v1.0",
        ToggleKey   = Enum.KeyCode.Insert,
        ShowIntro   = true,
    })
]]
function Library.CreateWindow(config)
    config = config or {}
    
    local WindowName = config.Name or "ERROR 404 UI"
    local Version    = config.Version or "v4.0"
    local ToggleKey  = config.ToggleKey or Enum.KeyCode.Insert
    local ShowIntro  = config.ShowIntro ~= false
    
    local W = MOBILE and 320 or 345
    local H = MOBILE and 535 or 560
    
    local ScreenGui = MakeSG("Error404Window", 100)
    
    -- ══════════════════════════════════════════════════════════
    -- MAIN FRAME
    -- ══════════════════════════════════════════════════════════
    local MainFrame = Create("Frame", {
        Name = "MainFrame",
        Size = UDim2.new(0, W, 0, H),
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(-0.6, 0, 0.5, 0),
        BackgroundColor3 = Theme.BG1,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 10,
        Parent = ScreenGui,
    })
    Corner(MainFrame, 14)
    local mainBorder = Stroke(MainFrame, Theme.Border, 1)
    
    -- Shadow
    local shadow = Create("ImageLabel", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 6),
        Size = UDim2.new(1, 50, 1, 50),
        BackgroundTransparency = 1,
        Image = "rbxassetid://5028857084",
        ImageColor3 = Color3.new(0, 0, 0),
        ImageTransparency = 0.7,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(24, 24, 276, 276),
        ZIndex = 9,
        Parent = MainFrame,
    })
    
    -- ══════════════════════════════════════════════════════════
    -- TITLEBAR
    -- ══════════════════════════════════════════════════════════
    local TitleBar = Create("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 44),
        BackgroundColor3 = Theme.BG2,
        BorderSizePixel = 0,
        ZIndex = 11,
        Parent = MainFrame,
    })
    Corner(TitleBar, 14)
    
    -- Fix bottom corners
    Create("Frame", {
        Size = UDim2.new(1, 0, 0, 14),
        Position = UDim2.new(0, 0, 1, -14),
        BackgroundColor3 = Theme.BG2,
        BorderSizePixel = 0,
        ZIndex = 11,
        Parent = TitleBar,
    })
    
    -- Border under titlebar
    Create("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = Theme.Border,
        BorderSizePixel = 0,
        ZIndex = 12,
        Parent = TitleBar,
    })
    
    -- Logo
    local logo = Create("Frame", {
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(0, 12, 0.5, -12),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        ZIndex = 12,
        Parent = TitleBar,
    })
    Corner(logo, 6)
    
    Create("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "⚡",
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.new(1, 1, 1),
        ZIndex = 13,
        Parent = logo,
    })
    
    -- Title text
    Create("TextLabel", {
        Size = UDim2.new(1, -120, 0, 44),
        Position = UDim2.new(0, 44, 0, 0),
        BackgroundTransparency = 1,
        Text = WindowName,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 12,
        Parent = TitleBar,
    })
    
    -- Version badge
    local versionBadge = Create("TextLabel", {
        Size = UDim2.new(0, 0, 0, 16),
        Position = UDim2.new(0, 44, 0, 22),
        BackgroundColor3 = Color3.fromRGB(139, 92, 246),
        BackgroundTransparency = 0.85,
        BorderSizePixel = 0,
        Text = "  " .. Version .. "  ",
        Font = Enum.Font.GothamBold,
        TextSize = 9,
        TextColor3 = Theme.Accent,
        AutomaticSize = Enum.AutomaticSize.X,
        ZIndex = 12,
        Parent = TitleBar,
    })
    Corner(versionBadge, 4)
    Stroke(versionBadge, Theme.Accent, 1, 0.7)
    
    -- Close button
    local closeBtn = Create("TextButton", {
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(1, -36, 0.5, -12),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "✕",
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextColor3 = Theme.TextDim,
        ZIndex = 13,
        AutoButtonColor = false,
        Parent = TitleBar,
    })
    Corner(closeBtn, 6)
    Stroke(closeBtn, Theme.Border, 1)
    
    closeBtn.MouseEnter:Connect(function()
        Tween(closeBtn, 0.15, {BackgroundTransparency = 0, BackgroundColor3 = Theme.BG3})
        Tween(closeBtn, 0.15, {TextColor3 = Theme.Red})
    end)
    closeBtn.MouseLeave:Connect(function()
        Tween(closeBtn, 0.15, {BackgroundTransparency = 1})
        Tween(closeBtn, 0.15, {TextColor3 = Theme.TextDim})
    end)
    
    -- ══════════════════════════════════════════════════════════
    -- TABS CONTAINER
    -- ══════════════════════════════════════════════════════════
    local TabsContainer = Create("Frame", {
        Name = "TabsContainer",
        Size = UDim2.new(1, 0, 0, 36),
        Position = UDim2.new(0, 0, 0, 44),
        BackgroundColor3 = Theme.BG2,
        BorderSizePixel = 0,
        ZIndex = 11,
        Parent = MainFrame,
    })
    
    Create("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = Theme.Border,
        BorderSizePixel = 0,
        ZIndex = 12,
        Parent = TabsContainer,
    })
    
    local tabsList = ListLayout(TabsContainer, 2)
    tabsList.FillDirection = Enum.FillDirection.Horizontal
    tabsList.HorizontalAlignment = Enum.HorizontalAlignment.Left
    Padding(TabsContainer, 10)
    
    -- ══════════════════════════════════════════════════════════
    -- CONTENT AREA
    -- ══════════════════════════════════════════════════════════
    local ContentArea = Create("Frame", {
        Name = "ContentArea",
        Size = UDim2.new(1, 0, 1, -80),
        Position = UDim2.new(0, 0, 0, 80),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 11,
        Parent = MainFrame,
    })
    
    -- ══════════════════════════════════════════════════════════
    -- DRAG
    -- ══════════════════════════════════════════════════════════
    do
        local dragging, dragStart, startPos
        TitleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = MainFrame.Position
            end
        end)
        TitleBar.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                MainFrame.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end)
    end
    
    -- ══════════════════════════════════════════════════════════
    -- WINDOW OBJECT
    -- ══════════════════════════════════════════════════════════
    local Window = {}
    Window.Tabs = {}
    Window.ActiveTab = nil
    Window.IsOpen = false
    
    local openPos   = MOBILE and UDim2.new(0.5, -W/2, 0.5, 0) or UDim2.new(0, 20, 0.5, 0)
    local closedPos = UDim2.new(-0.6, 0, 0.5, 0)
    
    function Window:Open()
        if self.IsOpen then return end
        self.IsOpen = true
        MainFrame.Visible = true
        MainFrame.Position = closedPos
        MainFrame.BackgroundTransparency = 1
        mainBorder.Transparency = 1
        Tween(MainFrame, 0.55, {Position = openPos, BackgroundTransparency = 0}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        Tween(mainBorder, 0.4, {Transparency = 0})
    end
    
    function Window:Close()
        if not self.IsOpen then return end
        self.IsOpen = false
        Tween(MainFrame, 0.38, {Position = closedPos, BackgroundTransparency = 1}, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        Tween(mainBorder, 0.3, {Transparency = 1})
        task.delay(0.4, function()
            if not self.IsOpen then
                MainFrame.Visible = false
            end
        end)
    end
    
    function Window:Toggle()
        if self.IsOpen then
            self:Close()
        else
            self:Open()
        end
    end
    
    function Window:Destroy()
        ScreenGui:Destroy()
    end
    
    closeBtn.MouseButton1Click:Connect(function() Window:Close() end)
    closeBtn.TouchTap:Connect(function() Window:Close() end)
    
    -- ══════════════════════════════════════════════════════════
    -- MOBILE BUTTON / DESKTOP KEY
    -- ══════════════════════════════════════════════════════════
    if MOBILE then
        local mobileBtn = Create("TextButton", {
            Size = UDim2.new(0, 54, 0, 54),
            Position = UDim2.new(0, 14, 1, -70),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
            Text = "⚡",
            TextSize = 22,
            Font = Enum.Font.GothamBold,
            TextColor3 = Color3.new(1, 1, 1),
            ZIndex = 200,
            AutoButtonColor = false,
            Parent = ScreenGui,
        })
        Corner(mobileBtn, 14)
        local mbs = Stroke(mobileBtn, Theme.AccentGlow, 2)
        
        task.spawn(function()
            while mobileBtn.Parent do
                Tween(mbs, 1.3, {Transparency = 0.8}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                task.wait(1.3)
                Tween(mbs, 1.3, {Transparency = 0}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                task.wait(1.3)
            end
        end)
        
        mobileBtn.TouchTap:Connect(function()
            Window:Toggle()
        end)
    else
        -- Desktop hint
        local hint = Create("Frame", {
            Size = UDim2.new(0, 200, 0, 28),
            Position = UDim2.new(0, 10, 1, -44),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = Theme.BG2,
            BackgroundTransparency = 0.1,
            BorderSizePixel = 0,
            ZIndex = 5,
            Parent = ScreenGui,
        })
        Corner(hint, 8)
        local hs = Stroke(hint, Theme.Border, 1)
        
        Create("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = "[ " .. ToggleKey.Name:upper() .. " ]  Otwórz / Zamknij",
            Font = Enum.Font.Gotham,
            TextSize = 12,
            TextColor3 = Theme.TextDim,
            ZIndex = 6,
            Parent = hint,
        })
        
        task.delay(6, function()
            Tween(hint, 1.5, {BackgroundTransparency = 1})
            Tween(hs, 1.5, {Transparency = 1})
        end)
        
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == ToggleKey then
                Window:Toggle()
            end
        end)
    end
    
    -- ══════════════════════════════════════════════════════════
    -- CREATE TAB
    -- ══════════════════════════════════════════════════════════
    local tabIndex = 0
    
    function Window:CreateTab(tabConfig)
        tabConfig = tabConfig or {}
        tabIndex = tabIndex + 1
        local index = tabIndex
        local isFirst = index == 1
        
        -- Tab button
        local tabBtn = Create("TextButton", {
            Size = UDim2.new(0, 0, 0, 26),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Text = "",
            ZIndex = 12,
            AutoButtonColor = false,
            LayoutOrder = index,
            AutomaticSize = Enum.AutomaticSize.X,
            Parent = TabsContainer,
        })
        
        local tabBtnInner = Create("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 13,
            Parent = tabBtn,
        })
        
        -- Active underline
        local underline = Create("Frame", {
            Size = UDim2.new(1, 0, 0, 2),
            Position = UDim2.new(0, 0, 1, 0),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
            BackgroundTransparency = isFirst and 0 or 1,
            ZIndex = 14,
            Parent = tabBtnInner,
        })
        
        local tabLabel = Create("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = "  " .. (tabConfig.Icon or "") .. " " .. (tabConfig.Name or "Tab") .. "  ",
            Font = Enum.Font.Gotham,
            TextSize = 11,
            TextColor3 = isFirst and Theme.Accent or Theme.TextMuted,
            ZIndex = 13,
            AutomaticSize = Enum.AutomaticSize.X,
            Parent = tabBtnInner,
        })
        
        -- Tab content scroll
        local tabScroll = Create("ScrollingFrame", {
            Name = "TabContent_" .. index,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = isFirst,
            ZIndex = 12,
            Parent = ContentArea,
        })
        
        local contentList = ListLayout(tabScroll, 6)
        Padding(tabScroll, 10)
        
        contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabScroll.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 20)
        end)
        
        table.insert(Window.Tabs, {
            Button = tabBtn,
            Scroll = tabScroll,
            Index = index,
            Underline = underline,
            Label = tabLabel,
        })
        
        if isFirst then
            Window.ActiveTab = index
        end
        
        -- Switch tab
        local function SwitchToTab()
            for _, tab in ipairs(Window.Tabs) do
                tab.Scroll.Visible = false
                Tween(tab.Underline, 0.15, {BackgroundTransparency = 1})
                Tween(tab.Label, 0.15, {TextColor3 = Theme.TextMuted})
            end
            tabScroll.Visible = true
            Tween(underline, 0.15, {BackgroundTransparency = 0})
            Tween(tabLabel, 0.15, {TextColor3 = Theme.Accent})
            Window.ActiveTab = index
        end
        
        tabBtn.MouseButton1Click:Connect(SwitchToTab)
        tabBtn.TouchTap:Connect(SwitchToTab)
        
        tabBtn.MouseEnter:Connect(function()
            if index ~= Window.ActiveTab then
                Tween(tabLabel, 0.15, {TextColor3 = Theme.TextDim})
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if index ~= Window.ActiveTab then
                Tween(tabLabel, 0.15, {TextColor3 = Theme.TextMuted})
            end
        end)
        
        -- ══════════════════════════════════════════════════════
        -- TAB API
        -- ══════════════════════════════════════════════════════
        local Tab = {}
        Tab._scroll = tabScroll
        Tab._order = 0
        
        local function NextOrder()
            Tab._order = Tab._order + 1
            return Tab._order
        end
        
        -- ── Section ──
        function Tab:AddSection(name)
            local section = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 24),
                BackgroundTransparency = 1,
                ZIndex = 13,
                LayoutOrder = NextOrder(),
                Parent = self._scroll,
            })
            
            Create("TextLabel", {
                Size = UDim2.new(1, -60, 1, 0),
                BackgroundTransparency = 1,
                Text = (name or "SECTION"):upper(),
                Font = Enum.Font.GothamBold,
                TextSize = 9,
                TextColor3 = Theme.TextMuted,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 14,
                Parent = section,
            })
            
            local line = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 1, -4),
                BackgroundColor3 = Theme.Border,
                BorderSizePixel = 0,
                ZIndex = 14,
                Parent = section,
            })
        end
        
        -- ── Button ──
        function Tab:AddButton(config)
            config = config or {}
            local hasDesc = config.Description and config.Description ~= ""
            local btnHeight = hasDesc and 54 or 44
            
            local row = Create("Frame", {
                Size = UDim2.new(1, 0, 0, btnHeight),
                BackgroundColor3 = Theme.BG2,
                BorderSizePixel = 0,
                ZIndex = 13,
                LayoutOrder = NextOrder(),
                Parent = self._scroll,
            })
            Corner(row, 7)
            local rowBorder = Stroke(row, Theme.Border, 1)
            
            -- Make entire row clickable
            local clickBtn = Create("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 15,
                AutoButtonColor = false,
                Parent = row,
            })
            
            -- Icon
            if config.Icon then
                Create("TextLabel", {
                    Size = UDim2.new(0, 28, 0, 28),
                    Position = UDim2.new(0, 12, 0, hasDesc and 6 or 8),
                    BackgroundColor3 = Color3.fromRGB(139, 92, 246),
                    BackgroundTransparency = 0.85,
                    BorderSizePixel = 0,
                    Text = config.Icon,
                    TextSize = 14,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = Theme.Accent,
                    ZIndex = 14,
                    Parent = row,
                }).Parent = row
                Corner(row:FindFirstChild("TextLabel"), 7)
            end
            
            -- Title
            Create("TextLabel", {
                Size = UDim2.new(1, -90, 0, hasDesc and 20 or btnHeight),
                Position = UDim2.new(0, config.Icon and 48 or 12, 0, hasDesc and 6 or 0),
                BackgroundTransparency = 1,
                Text = config.Name or "Button",
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextColor3 = Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 14,
                Parent = row,
            })
            
            -- Description
            if hasDesc then
                Create("TextLabel", {
                    Size = UDim2.new(1, -90, 0, 18),
                    Position = UDim2.new(0, config.Icon and 48 or 12, 0, 28),
                    BackgroundTransparency = 1,
                    Text = config.Description,
                    Font = Enum.Font.Gotham,
                    TextSize = 10,
                    TextColor3 = Theme.TextMuted,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = 14,
                    Parent = row,
                })
            end
            
            -- Arrow
            Create("TextLabel", {
                Size = UDim2.new(0, 20, 1, 0),
                Position = UDim2.new(1, -26, 0, 0),
                BackgroundTransparency = 1,
                Text = "›",
                TextSize = 18,
                Font = Enum.Font.GothamBold,
                TextColor3 = Theme.TextDim,
                ZIndex = 14,
                Parent = row,
            })
            
            clickBtn.MouseEnter:Connect(function()
                Tween(row, 0.15, {BackgroundColor3 = Theme.BG3})
                Tween(rowBorder, 0.15, {Color = Theme.BorderLight})
            end)
            clickBtn.MouseLeave:Connect(function()
                Tween(row, 0.15, {BackgroundColor3 = Theme.BG2})
                Tween(rowBorder, 0.15, {Color = Theme.Border})
            end)
            clickBtn.MouseButton1Down:Connect(function()
                Tween(row, 0.1, {BackgroundColor3 = Theme.BG4})
            end)
            clickBtn.MouseButton1Up:Connect(function()
                Tween(row, 0.1, {BackgroundColor3 = Theme.BG3})
                if config.Callback then
                    task.spawn(pcall, config.Callback)
                end
            end)
            clickBtn.TouchTap:Connect(function()
                Tween(row, 0.1, {BackgroundColor3 = Theme.BG4})
                task.wait(0.1)
                Tween(row, 0.1, {BackgroundColor3 = Theme.BG3})
                if config.Callback then
                    task.spawn(pcall, config.Callback)
                end
            end)
        end
        
        -- ── Toggle ──
        function Tab:AddToggle(config)
            config = config or {}
            local state = config.CurrentValue or false
            local hasDesc = config.Description and config.Description ~= ""
            local rowHeight = hasDesc and 54 or 44
            
            local row = Create("Frame", {
                Size = UDim2.new(1, 0, 0, rowHeight),
                BackgroundColor3 = Theme.BG2,
                BorderSizePixel = 0,
                ZIndex = 13,
                LayoutOrder = NextOrder(),
                Parent = self._scroll,
            })
            Corner(row, 7)
            Stroke(row, Theme.Border, 1)
            
            -- Icon
            if config.Icon then
                local iconFrame = Create("Frame", {
                    Size = UDim2.new(0, 28, 0, 28),
                    Position = UDim2.new(0, 12, 0, hasDesc and 6 or 8),
                    BackgroundColor3 = Color3.fromRGB(139, 92, 246),
                    BackgroundTransparency = 0.85,
                    BorderSizePixel = 0,
                    ZIndex = 14,
                    Parent = row,
                })
                Corner(iconFrame, 7)
                Create("TextLabel", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = config.Icon,
                    TextSize = 14,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = Theme.Accent,
                    ZIndex = 15,
                    Parent = iconFrame,
                })
            end
            
            -- Title
            Create("TextLabel", {
                Size = UDim2.new(1, -110, 0, hasDesc and 20 or rowHeight),
                Position = UDim2.new(0, config.Icon and 48 or 12, 0, hasDesc and 6 or 0),
                BackgroundTransparency = 1,
                Text = config.Name or "Toggle",
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextColor3 = Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 14,
                Parent = row,
            })
            
            -- Description
            if hasDesc then
                Create("TextLabel", {
                    Size = UDim2.new(1, -110, 0, 18),
                    Position = UDim2.new(0, config.Icon and 48 or 12, 0, 28),
                    BackgroundTransparency = 1,
                    Text = config.Description,
                    Font = Enum.Font.Gotham,
                    TextSize = 10,
                    TextColor3 = Theme.TextMuted,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = 14,
                    Parent = row,
                })
            end
            
            -- Toggle switch
            local toggleContainer = Create("Frame", {
                Size = UDim2.new(0, 38, 0, 20),
                Position = UDim2.new(1, -50, 0.5, -10),
                BackgroundTransparency = 1,
                ZIndex = 14,
                Parent = row,
            })
            
            local track = Create("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundColor3 = state and Theme.Accent or Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = state and 0 or 0.9,
                BorderSizePixel = 0,
                ZIndex = 15,
                Parent = toggleContainer,
            })
            Corner(track, 20)
            local trackBorder = Stroke(track, state and Theme.Accent or Color3.fromRGB(255, 255, 255), 1, state and 0 or 0.85)
            
            local thumb = Create("Frame", {
                Size = UDim2.new(0, 14, 0, 14),
                Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BorderSizePixel = 0,
                ZIndex = 16,
                Parent = track,
            })
            Corner(thumb, 999)
            
            local clickArea = Create("TextButton", {
                Size = UDim2.new(1, 60, 1, 0),
                Position = UDim2.new(1, -98, 0, 0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 17,
                AutoButtonColor = false,
                Parent = row,
            })
            
            local toggleObj = {
                Value = state,
            }
            
            local function SetValue(value)
                state = value
                toggleObj.Value = value
                
                Tween(track, 0.2, {
                    BackgroundColor3 = value and Theme.Accent or Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = value and 0 or 0.9,
                }, Enum.EasingStyle.Quad)
                
                Tween(trackBorder, 0.2, {
                    Color = value and Theme.Accent or Color3.fromRGB(255, 255, 255),
                    Transparency = value and 0 or 0.85,
                })
                
                Tween(thumb, 0.2, {
                    Position = value and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7),
                }, Enum.EasingStyle.Quad)
                
                if config.Callback then
                    task.spawn(pcall, config.Callback, value)
                end
            end
            
            toggleObj.Set = function(_, value)
                SetValue(value)
            end
            
            clickArea.MouseButton1Click:Connect(function()
                SetValue(not state)
            end)
            clickArea.TouchTap:Connect(function()
                SetValue(not state)
            end)
            
            return toggleObj
        end
        
        -- ── Slider ──
        function Tab:AddSlider(config)
            config = config or {}
            local min = config.Min or 0
            local max = config.Max or 100
            local step = config.Increment or 1
            local current = math.clamp(config.CurrentValue or min, min, max)
            local suffix = config.Suffix or ""
            local hasDesc = config.Description and config.Description ~= ""
            
            local row = Create("Frame", {
                Size = UDim2.new(1, 0, 0, hasDesc and 64 or 56),
                BackgroundColor3 = Theme.BG2,
                BorderSizePixel = 0,
                ZIndex = 13,
                LayoutOrder = NextOrder(),
                Parent = self._scroll,
            })
            Corner(row, 7)
            Stroke(row, Theme.Border, 1)
            
            -- Title
            Create("TextLabel", {
                Size = UDim2.new(0.6, 0, 0, hasDesc and 20 or 28),
                Position = UDim2.new(0, 12, 0, hasDesc and 6 or 6),
                BackgroundTransparency = 1,
                Text = config.Name or "Slider",
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextColor3 = Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 14,
                Parent = row,
            })
            
            -- Description
            if hasDesc then
                Create("TextLabel", {
                    Size = UDim2.new(0.6, 0, 0, 16),
                    Position = UDim2.new(0, 12, 0, 26),
                    BackgroundTransparency = 1,
                    Text = config.Description,
                    Font = Enum.Font.Gotham,
                    TextSize = 10,
                    TextColor3 = Theme.TextMuted,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 14,
                    Parent = row,
                })
            end
            
            -- Value label
            local valueLabel = Create("TextLabel", {
                Size = UDim2.new(0.4, -12, 0, hasDesc and 20 or 28),
                Position = UDim2.new(0.6, 0, 0, hasDesc and 6 or 6),
                BackgroundTransparency = 1,
                Text = tostring(current) .. suffix,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextColor3 = Theme.Accent,
                TextXAlignment = Enum.TextXAlignment.Right,
                ZIndex = 14,
                Parent = row,
            })
            
            -- Slider track
            local trackBg = Create("Frame", {
                Size = UDim2.new(1, -24, 0, 4),
                Position = UDim2.new(0, 12, 0, hasDesc and 46 or 38),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0.9,
                BorderSizePixel = 0,
                ZIndex = 14,
                Parent = row,
            })
            Corner(trackBg, 2)
            
            local fillPercent = (current - min) / (max - min)
            local fill = Create("Frame", {
                Size = UDim2.new(fillPercent, 0, 1, 0),
                BackgroundColor3 = Theme.Accent,
                BorderSizePixel = 0,
                ZIndex = 15,
                Parent = trackBg,
            })
            Corner(fill, 2)
            
            local thumb = Create("Frame", {
                Size = UDim2.new(0, 14, 0, 14),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(fillPercent, 0, 0.5, 0),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BorderSizePixel = 0,
                ZIndex = 16,
                Parent = trackBg,
            })
            Corner(thumb, 999)
            
            local sliderObj = {
                Value = current,
            }
            
            local sliding = false
            
            local function SetValue(value)
                value = math.clamp(math.round(value / step) * step, min, max)
                current = value
                sliderObj.Value = value
                local percent = (value - min) / (max - min)
                valueLabel.Text = tostring(value) .. suffix
                fill.Size = UDim2.new(percent, 0, 1, 0)
                thumb.Position = UDim2.new(percent, 0, 0.5, 0)
                
                if config.Callback then
                    task.spawn(pcall, config.Callback, value)
                end
            end
            
            sliderObj.Set = function(_, value)
                SetValue(value)
            end
            
            local function UpdateSlider(inputPos)
                local percent = math.clamp((inputPos - trackBg.AbsolutePosition.X) / trackBg.AbsoluteSize.X, 0, 1)
                SetValue(min + (max - min) * percent)
            end
            
            trackBg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    sliding = true
                    UpdateSlider(input.Position.X)
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    UpdateSlider(input.Position.X)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    sliding = false
                end
            end)
            
            return sliderObj
        end
        
        -- ── Dropdown ──
        function Tab:AddDropdown(config)
            config = config or {}
            local options = config.Options or {}
            local selected = config.CurrentOption or options[1] or ""
            local isOpen = false
            
            local row = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 44),
                BackgroundColor3 = Theme.BG2,
                BorderSizePixel = 0,
                ClipsDescendants = false,
                ZIndex = 13,
                LayoutOrder = NextOrder(),
                Parent = self._scroll,
            })
            Corner(row, 7)
            Stroke(row, Theme.Border, 1)
            
            local header = Create("TextButton", {
                Size = UDim2.new(1, 0, 0, 44),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 14,
                AutoButtonColor = false,
                Parent = row,
            })
            
            Create("TextLabel", {
                Size = UDim2.new(0.5, 0, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Text = config.Name or "Dropdown",
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextColor3 = Theme.TextDim,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 15,
                Parent = header,
            })
            
            local valueLabel = Create("TextLabel", {
                Size = UDim2.new(0.48, 0, 1, 0),
                Position = UDim2.new(0.5, 0, 0, 0),
                BackgroundTransparency = 1,
                Text = selected,
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                TextColor3 = Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Right,
                TextTruncate = Enum.TextTruncate.AtEnd,
                ZIndex = 15,
                Parent = header,
            })
            
            local arrow = Create("TextLabel", {
                Size = UDim2.new(0, 20, 1, 0),
                Position = UDim2.new(1, -26, 0, 0),
                BackgroundTransparency = 1,
                Text = "▾",
                TextSize = 12,
                Font = Enum.Font.GothamBold,
                TextColor3 = Theme.TextDim,
                ZIndex = 15,
                Parent = header,
            })
            
            local dropList = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 1, 4),
                BackgroundColor3 = Theme.BG3,
                BorderSizePixel = 0,
                ClipsDescendants = true,
                Visible = false,
                ZIndex = 100,
                Parent = row,
            })
            Corner(dropList, 7)
            Stroke(dropList, Theme.Border, 1)
            ListLayout(dropList, 0)
            
            local dropObj = {
                Value = selected,
            }
            
            local function BuildList()
                for _, child in ipairs(dropList:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
                
                for i, option in ipairs(options) do
                    local isSelected = option == selected
                    local optionBtn = Create("TextButton", {
                        Size = UDim2.new(1, 0, 0, 32),
                        BackgroundColor3 = isSelected and Theme.Accent or Theme.BG3,
                        BackgroundTransparency = isSelected and 0.7 or 1,
                        BorderSizePixel = 0,
                        Text = "",
                        ZIndex = 101,
                        AutoButtonColor = false,
                        LayoutOrder = i,
                        Parent = dropList,
                    })
                    
                    Create("TextLabel", {
                        Size = UDim2.new(1, -20, 1, 0),
                        Position = UDim2.new(0, 12, 0, 0),
                        BackgroundTransparency = 1,
                        Text = option,
                        Font = Enum.Font.Gotham,
                        TextSize = 12,
                        TextColor3 = isSelected and Theme.Text or Theme.TextDim,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        ZIndex = 102,
                        Parent = optionBtn,
                    })
                    
                    optionBtn.MouseEnter:Connect(function()
                        if not isSelected then
                            Tween(optionBtn, 0.15, {BackgroundTransparency = 0.5, BackgroundColor3 = Theme.Accent})
                        end
                    end)
                    optionBtn.MouseLeave:Connect(function()
                        if not isSelected then
                            Tween(optionBtn, 0.15, {BackgroundTransparency = 1})
                        end
                    end)
                    
                    local function SelectOption()
                        selected = option
                        dropObj.Value = option
                        valueLabel.Text = option
                        isOpen = false
                        Tween(dropList, 0.2, {Size = UDim2.new(1, 0, 0, 0)})
                        Tween(arrow, 0.2, {Rotation = 0})
                        task.delay(0.22, function()
                            dropList.Visible = false
                        end)
                        BuildList()
                        if config.Callback then
                            task.spawn(pcall, config.Callback, option)
                        end
                    end
                    
                    optionBtn.MouseButton1Click:Connect(SelectOption)
                    optionBtn.TouchTap:Connect(SelectOption)
                end
            end
            
            BuildList()
            
            local function ToggleDropdown()
                isOpen = not isOpen
                if isOpen then
                    dropList.Visible = true
                    Tween(dropList, 0.25, {Size = UDim2.new(1, 0, 0, #options * 32)}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                    Tween(arrow, 0.2, {Rotation = 180})
                else
                    Tween(dropList, 0.2, {Size = UDim2.new(1, 0, 0, 0)})
                    Tween(arrow, 0.2, {Rotation = 0})
                    task.delay(0.22, function()
                        dropList.Visible = false
                    end)
                end
            end
            
            header.MouseButton1Click:Connect(ToggleDropdown)
            header.TouchTap:Connect(ToggleDropdown)
            
            dropObj.Set = function(_, value)
                selected = value
                dropObj.Value = value
                valueLabel.Text = value
                BuildList()
            end
            
            dropObj.Refresh = function(_, newOptions)
                options = newOptions
                selected = newOptions[1] or ""
                dropObj.Value = selected
                valueLabel.Text = selected
                BuildList()
            end
            
            return dropObj
        end
        
        -- ── Label ──
        function Tab:AddLabel(text)
            Create("TextLabel", {
                Size = UDim2.new(1, 0, 0, 24),
                BackgroundTransparency = 1,
                Text = text or "",
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextColor3 = Theme.TextDim,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                ZIndex = 13,
                LayoutOrder = NextOrder(),
                Parent = self._scroll,
            })
        end
        
        -- ── Paragraph ──
        function Tab:AddParagraph(config)
            config = config or {}
            local para = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = Theme.BG2,
                BorderSizePixel = 0,
                ZIndex = 13,
                LayoutOrder = NextOrder(),
                Parent = self._scroll,
            })
            Corner(para, 7)
            Stroke(para, Theme.Border, 1)
            
            local paraList = ListLayout(para, 4)
            Padding(para, 12)
            
            Create("TextLabel", {
                Size = UDim2.new(1, 0, 0, 18),
                BackgroundTransparency = 1,
                Text = config.Title or "",
                Font = Enum.Font.GothamBold,
                TextSize = 13,
                TextColor3 = Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 14,
                LayoutOrder = 1,
                Parent = para,
            })
            
            Create("TextLabel", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = config.Content or "",
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextColor3 = Theme.TextDim,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                ZIndex = 14,
                LayoutOrder = 2,
                Parent = para,
            })
        end
        
        return Tab
    end
    
    return Window
end

-- ══════════════════════════════════════════════════════════════
-- NOTIFICATIONS
-- ══════════════════════════════════════════════════════════════
--[[
    Library.Notify({
        Title    = "Tytuł",
        Content  = "Treść",
        Duration = 4,
        Type     = "Success" | "Error" | "Warning" | "Info"
    })
]]
function Library.Notify(config)
    config = config or {}
    
    local typeColors = {
        Success = {Theme.Green, "✓"},
        Error   = {Theme.Red, "✕"},
        Warning = {Theme.Orange, "⚠"},
        Info    = {Theme.Accent, "ℹ"},
    }
    
    local notifType = config.Type or "Info"
    local color = typeColors[notifType] and typeColors[notifType][1] or Theme.Accent
    local icon  = typeColors[notifType] and typeColors[notifType][2] or "ℹ"
    
    local sg
    pcall(function()
        for _, child in ipairs(CoreGui:GetChildren()) do
            if child.Name == "E404Notifs" then
                sg = child
                break
            end
        end
    end)
    
    if not sg then
        sg = MakeSG("E404Notifs", 9999)
    end
    
    local holder = sg:FindFirstChild("NotifHolder")
    if not holder then
        holder = Create("Frame", {
            Name = "NotifHolder",
            Size = UDim2.new(0, 290, 1, -16),
            Position = UDim2.new(1, -306, 0, 8),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 500,
            Parent = sg,
        })
        local holderList = ListLayout(holder, 8)
        holderList.VerticalAlignment = Enum.VerticalAlignment.Bottom
    end
    
    local notif = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 70),
        BackgroundColor3 = Theme.BG3,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 501,
        Parent = holder,
    })
    Corner(notif, 10)
    local notifBorder = Stroke(notif, color, 1, 0.5)
    
    -- Side bar
    Create("Frame", {
        Size = UDim2.new(0, 3, 1, -4),
        Position = UDim2.new(0, 0, 0, 2),
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        ZIndex = 502,
        Parent = notif,
    })
    
    -- Icon
    local iconFrame = Create("Frame", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(0, 12, 0.5, -15),
        BackgroundColor3 = color,
        BackgroundTransparency = 0.82,
        BorderSizePixel = 0,
        ZIndex = 502,
        Parent = notif,
    })
    Corner(iconFrame, 8)
    
    Create("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = icon,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = color,
        ZIndex = 503,
        Parent = iconFrame,
    })
    
    -- Title
    Create("TextLabel", {
        Size = UDim2.new(1, -58, 0, 22),
        Position = UDim2.new(0, 50, 0, 10),
        BackgroundTransparency = 1,
        Text = config.Title or "Notification",
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 502,
        Parent = notif,
    })
    
    -- Content
    Create("TextLabel", {
        Size = UDim2.new(1, -58, 0, 26),
        Position = UDim2.new(0, 50, 0, 32),
        BackgroundTransparency = 1,
        Text = config.Content or "",
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextColor3 = Theme.TextDim,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        ZIndex = 502,
        Parent = notif,
    })
    
    -- Progress bar
    local progress = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, -2),
        BackgroundColor3 = Theme.Border,
        BorderSizePixel = 0,
        ZIndex = 502,
        Parent = notif,
    })
    
    local progressFill = Create("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        ZIndex = 503,
        Parent = progress,
    })
    
    -- Animate in
    Tween(notif, 0.4, {BackgroundTransparency = 0}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    
    local duration = config.Duration or 4
    Tween(progressFill, duration, {Size = UDim2.new(0, 0, 1, 0)}, Enum.EasingStyle.Linear)
    
    task.delay(duration, function()
        Tween(notif, 0.3, {BackgroundTransparency = 1}, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        Tween(notifBorder, 0.3, {Transparency = 1})
        task.delay(0.35, function()
            notif:Destroy()
        end)
    end)
end

-- ══════════════════════════════════════════════════════════════
-- WINDOW WITH INTRO
-- ══════════════════════════════════════════════════════════════
local OriginalCreateWindow = Library.CreateWindow

function Library.CreateWindow(config)
    config = config or {}
    
    if config.ShowIntro == false then
        local win = OriginalCreateWindow(config)
        task.delay(0.1, function()
            win:Open()
        end)
        return win
    end
    
    local windowReady = false
    local windowRef = nil
    
    task.spawn(function()
        PlayIntro(function()
            windowRef = OriginalCreateWindow(config)
            task.delay(0.25, function()
                windowRef:Open()
                windowReady = true
            end)
        end)
    end)
    
    -- Proxy that waits for window
    return setmetatable({}, {
        __index = function(_, key)
            return function(self, ...)
                local timeout = tick() + 30
                while not windowReady and tick() < timeout do
                    task.wait(0.05)
                end
                if windowRef and type(windowRef[key]) == "function" then
                    return windowRef[key](windowRef, ...)
                end
            end
        end,
    })
end

return Library
