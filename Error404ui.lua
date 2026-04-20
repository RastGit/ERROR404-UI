-- ╔══════════════════════════════════════════════════════╗
-- ║           ERROR 404 UI LIBRARY  v2.0                 ║
-- ║    Rayfield-style API | Executor Compatible          ║
-- ╚══════════════════════════════════════════════════════╝

local Library = {}

-- ══════════════════════════════════════════
-- SERVICES
-- ══════════════════════════════════════════
local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui          = game:GetService("CoreGui")

local LP = Players.LocalPlayer

-- ══════════════════════════════════════════
-- UTILITIES
-- ══════════════════════════════════════════
local function New(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    return obj
end

local function Tween(obj, t, props, style, dir)
    TweenService:Create(obj,
        TweenInfo.new(t, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out),
        props
    ):Play()
end

local function Corner(parent, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = parent
    return c
end

local function Stroke(parent, color, thick, transp)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thick or 1.5
    s.Transparency = transp or 0
    s.Parent = parent
    return s
end

local function ListLayout(parent, padding, halign)
    local l = Instance.new("UIListLayout")
    l.Padding = UDim.new(0, padding or 6)
    l.HorizontalAlignment = halign or Enum.HorizontalAlignment.Left
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Parent = parent
    return l
end

local function Pad(parent, top, bottom, left, right)
    local p = Instance.new("UIPadding")
    p.PaddingTop    = UDim.new(0, top    or 0)
    p.PaddingBottom = UDim.new(0, bottom or 0)
    p.PaddingLeft   = UDim.new(0, left   or 0)
    p.PaddingRight  = UDim.new(0, right  or 0)
    p.Parent = parent
    return p
end

local function AutoCanvas(scroll, layout)
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)
end

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- ══════════════════════════════════════════
-- SCREENGUI (executor-safe)
-- ══════════════════════════════════════════
local function MakeSG(name, order)
    local sg
    local ok = pcall(function()
        sg = New("ScreenGui", {
            Name           = name,
            ResetOnSpawn   = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            IgnoreGuiInset = true,
            DisplayOrder   = order or 999,
            Parent         = CoreGui,
        })
    end)
    if not ok or not sg then
        sg = New("ScreenGui", {
            Name           = name,
            ResetOnSpawn   = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            IgnoreGuiInset = true,
            Parent         = LP:WaitForChild("PlayerGui"),
        })
    end
    return sg
end

-- ══════════════════════════════════════════
-- MOTYW
-- ══════════════════════════════════════════
local T = {
    Background   = Color3.fromRGB(15, 15, 23),
    Surface      = Color3.fromRGB(21, 21, 32),
    SurfaceLight = Color3.fromRGB(29, 29, 44),
    SurfaceDark  = Color3.fromRGB(17, 17, 27),
    Accent       = Color3.fromRGB(103, 58, 255),
    AccentLight  = Color3.fromRGB(143, 98, 255),
    AccentDark   = Color3.fromRGB(63, 28, 180),
    Text         = Color3.fromRGB(240, 240, 255),
    TextDim      = Color3.fromRGB(145, 138, 175),
    TextMuted    = Color3.fromRGB(85, 80, 115),
    Border       = Color3.fromRGB(48, 40, 82),
    Danger       = Color3.fromRGB(215, 48, 88),
    Success      = Color3.fromRGB(55, 205, 125),
    Warning      = Color3.fromRGB(252, 173, 48),
    ToggleOff    = Color3.fromRGB(48, 43, 72),
}

-- ══════════════════════════════════════════════════════════
-- INTRO
-- ══════════════════════════════════════════════════════════
local function PlayIntro(onFinish)
    local sg = MakeSG("E404_Intro", 1000)

    local function makeWord(text, mainColor, glowColor)
        local frame = New("Frame", {
            Size = UDim2.new(0, 750, 0, 120),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            ZIndex = 200,
            Parent = sg,
        })
        New("TextLabel", {
            Size = UDim2.new(1, 12, 1, 12),
            Position = UDim2.new(0, -6, 0, -6),
            BackgroundTransparency = 1,
            Text = text,
            Font = Enum.Font.GothamBold,
            TextSize = 82,
            TextColor3 = glowColor,
            TextTransparency = 0.6,
            ZIndex = 200,
            Parent = frame,
        })
        local lbl = New("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = text,
            Font = Enum.Font.GothamBold,
            TextSize = 82,
            TextColor3 = mainColor,
            TextTransparency = 0,
            ZIndex = 201,
            Parent = frame,
        })
        local s = Instance.new("UIStroke")
        s.Color = glowColor
        s.Thickness = 2.5
        s.Transparency = 0.25
        s.Parent = lbl
        return frame, lbl
    end

    local function pulse(lbl, times)
        for _ = 1, times do
            Tween(lbl, 0.22, {TextTransparency = 0.45}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(0.22)
            Tween(lbl, 0.22, {TextTransparency = 0}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(0.22)
        end
    end

    local tIn  = TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local tOut = TweenInfo.new(0.42, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    local center = UDim2.new(0.5, 0, 0.5, 0)

    -- ERROR (leci z lewej → środek → prawo)
    local c1, l1 = makeWord("ERROR", Color3.fromRGB(195, 98, 255), Color3.fromRGB(155, 0, 255))
    c1.Position = UDim2.new(-0.65, 0, 0.5, 0)
    TweenService:Create(c1, tIn, {Position = center}):Play()
    task.wait(0.6)
    task.spawn(pulse, l1, 4)
    task.wait(2.0)
    TweenService:Create(c1, tOut, {Position = UDim2.new(1.65, 0, 0.5, 0)}):Play()
    task.wait(0.5)
    c1:Destroy()

    task.wait(0.08)

    -- 404 (leci z prawej → środek → lewo)
    local c2, l2 = makeWord("404", Color3.fromRGB(255, 58, 128), Color3.fromRGB(255, 0, 78))
    c2.Position = UDim2.new(1.65, 0, 0.5, 0)
    TweenService:Create(c2, tIn, {Position = center}):Play()
    task.wait(0.6)
    task.spawn(pulse, l2, 4)
    task.wait(2.0)
    TweenService:Create(c2, tOut, {Position = UDim2.new(-0.65, 0, 0.5, 0)}):Play()
    task.wait(0.5)
    c2:Destroy()

    task.wait(0.15)
    sg:Destroy()
    if onFinish then onFinish() end
end

-- ══════════════════════════════════════════════════════════
-- CREATE WINDOW
-- ══════════════════════════════════════════════════════════
function Library.CreateWindow(cfg)
    cfg = cfg or {}

    -- Nadpisanie motywu
    if cfg.Theme then
        for k, v in pairs(cfg.Theme) do T[k] = v end
    end

    local toggleKey = cfg.ToggleUIKeybind or Enum.KeyCode.Insert
    local W = isMobile and 315 or 345
    local H = isMobile and 525 or 550
    local SIDE = 46

    local ScreenGui = MakeSG("Error404UI", 999)

    -- ── Główna ramka ──
    local MenuFrame = New("Frame", {
        Name = "MenuFrame",
        Size = UDim2.new(0, W, 0, H),
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(-0.5, 0, 0.5, 0),
        BackgroundColor3 = T.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Visible = false,
        ZIndex = 10,
        Parent = ScreenGui,
    })
    Corner(MenuFrame, 14)
    local menuBorder = Stroke(MenuFrame, T.Border, 1.5)

    -- ── TitleBar ──
    local TitleBar = New("Frame", {
        Size = UDim2.new(1, 0, 0, 54),
        BackgroundColor3 = T.Surface,
        BorderSizePixel = 0,
        ZIndex = 11,
        Parent = MenuFrame,
    })
    Corner(TitleBar, 14)
    New("Frame", { -- fix dolnych narożników
        Size = UDim2.new(1, 0, 0, 14),
        Position = UDim2.new(0, 0, 1, -14),
        BackgroundColor3 = T.Surface,
        BorderSizePixel = 0,
        ZIndex = 11,
        Parent = TitleBar,
    })

    -- Linia akcentu
    local accentLine = New("Frame", {
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, -2),
        BackgroundColor3 = T.Accent,
        BorderSizePixel = 0,
        ZIndex = 12,
        Parent = TitleBar,
    })
    local alg = Instance.new("UIGradient")
    alg.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    Color3.new(0,0,0)),
        ColorSequenceKeypoint.new(0.12, Color3.new(1,1,1)),
        ColorSequenceKeypoint.new(0.88, Color3.new(1,1,1)),
        ColorSequenceKeypoint.new(1,    Color3.new(0,0,0)),
    })
    alg.Parent = accentLine

    -- Logo
    local logo = New("Frame", {
        Size = UDim2.new(0, 32, 0, 32),
        Position = UDim2.new(0, 12, 0.5, -16),
        BackgroundColor3 = T.Accent,
        BorderSizePixel = 0,
        ZIndex = 12,
        Parent = TitleBar,
    })
    Corner(logo, 999)
    local lg = Instance.new("UIGradient")
    lg.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, T.AccentLight), ColorSequenceKeypoint.new(1, T.AccentDark)})
    lg.Rotation = 135
    lg.Parent = logo
    New("TextLabel", {
        Size = UDim2.new(1,0,1,0), BackgroundTransparency=1,
        Text="⚡", TextSize=16, Font=Enum.Font.GothamBold,
        TextColor3=Color3.new(1,1,1), ZIndex=13, Parent=logo,
    })

    New("TextLabel", {
        Size = UDim2.new(1,-115,0,20), Position = UDim2.new(0,52,0,8),
        BackgroundTransparency=1, Text = cfg.Name or "ERROR 404 UI",
        Font=Enum.Font.GothamBold, TextSize=15, TextColor3=T.Text,
        TextXAlignment=Enum.TextXAlignment.Left, ZIndex=12, Parent=TitleBar,
    })
    New("TextLabel", {
        Size = UDim2.new(1,-115,0,14), Position = UDim2.new(0,52,0,31),
        BackgroundTransparency=1, Text = cfg.LoadingSubtitle or "v2.0",
        Font=Enum.Font.Gotham, TextSize=11, TextColor3=T.TextDim,
        TextXAlignment=Enum.TextXAlignment.Left, ZIndex=12, Parent=TitleBar,
    })

    local CloseBtn = New("TextButton", {
        Size=UDim2.new(0,28,0,28), Position=UDim2.new(1,-40,0.5,-14),
        BackgroundColor3=T.SurfaceLight, BorderSizePixel=0,
        Text="✕", Font=Enum.Font.GothamBold, TextSize=12,
        TextColor3=T.TextDim, ZIndex=13, AutoButtonColor=false, Parent=TitleBar,
    })
    Corner(CloseBtn, 7)
    CloseBtn.MouseEnter:Connect(function() Tween(CloseBtn, 0.15, {BackgroundColor3=T.Danger, TextColor3=Color3.new(1,1,1)}) end)
    CloseBtn.MouseLeave:Connect(function() Tween(CloseBtn, 0.15, {BackgroundColor3=T.SurfaceLight, TextColor3=T.TextDim}) end)

    -- ── Sidebar ──
    local Sidebar = New("Frame", {
        Name="Sidebar", Size=UDim2.new(0,SIDE,1,-54),
        Position=UDim2.new(0,0,0,54), BackgroundColor3=T.Surface,
        BorderSizePixel=0, ZIndex=11, Parent=MenuFrame,
    })
    New("Frame", {
        Size=UDim2.new(0,1,1,0), Position=UDim2.new(1,-1,0,0),
        BackgroundColor3=T.Border, BorderSizePixel=0, ZIndex=12, Parent=Sidebar,
    })
    local sideList = ListLayout(Sidebar, 6, Enum.HorizontalAlignment.Center)
    Pad(Sidebar, 10, 0, 0, 0)

    -- ── ContentHolder ──
    local ContentHolder = New("Frame", {
        Name="ContentHolder", Size=UDim2.new(1,-SIDE,1,-64),
        Position=UDim2.new(0,SIDE,0,64), BackgroundTransparency=1,
        BorderSizePixel=0, ClipsDescendants=true, ZIndex=11, Parent=MenuFrame,
    })

    -- ── Drag ──
    do
        local dragging, dragStart, startPos
        TitleBar.InputBegan:Connect(function(inp)
            if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
                dragging=true; dragStart=inp.Position; startPos=MenuFrame.Position
            end
        end)
        TitleBar.InputEnded:Connect(function(inp)
            if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
                dragging=false
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if dragging and (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) then
                local d=inp.Position-dragStart
                MenuFrame.Position=UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
            end
        end)
    end

    -- ── Open/Close ──
    local isOpen = false
    local openPos   = isMobile and UDim2.new(0.5,-W/2,0.5,0) or UDim2.new(0,16,0.5,0)
    local closedPos = UDim2.new(-0.5,0,0.5,0)

    local Window = {}
    Window.Tabs = {}

    function Window:Open()
        if isOpen then return end
        isOpen = true
        MenuFrame.Visible = true
        MenuFrame.Position = closedPos
        MenuFrame.BackgroundTransparency = 1
        menuBorder.Transparency = 1
        Tween(MenuFrame, 0.52, {Position=openPos, BackgroundTransparency=0}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        Tween(menuBorder, 0.35, {Transparency=0})
    end

    function Window:Close()
        if not isOpen then return end
        isOpen = false
        Tween(MenuFrame, 0.35, {Position=closedPos, BackgroundTransparency=1})
        Tween(menuBorder, 0.28, {Transparency=1})
        task.delay(0.38, function() if not isOpen then MenuFrame.Visible=false end end)
    end

    function Window:Toggle()
        if isOpen then self:Close() else self:Open() end
    end

    function Window:Destroy()
        ScreenGui:Destroy()
    end

    CloseBtn.MouseButton1Click:Connect(function() Window:Close() end)
    CloseBtn.TouchTap:Connect(function() Window:Close() end)

    -- ── Mobile toggle ──
    if isMobile then
        local mBtn = New("TextButton", {
            Size=UDim2.new(0,54,0,54), Position=UDim2.new(0,12,1,-70),
            AnchorPoint=Vector2.new(0,1), BackgroundColor3=T.Accent,
            BorderSizePixel=0, Text="⚡", TextSize=22,
            Font=Enum.Font.GothamBold, TextColor3=Color3.new(1,1,1),
            ZIndex=20, AutoButtonColor=false, Parent=ScreenGui,
        })
        Corner(mBtn, 14)
        local mg = Instance.new("UIGradient")
        mg.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,T.AccentLight),ColorSequenceKeypoint.new(1,T.AccentDark)})
        mg.Rotation=135; mg.Parent=mBtn
        local ms = Stroke(mBtn, T.AccentLight, 2)
        task.spawn(function()
            while mBtn.Parent do
                Tween(ms, 1.2, {Transparency=0.78}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                task.wait(1.2)
                Tween(ms, 1.2, {Transparency=0}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                task.wait(1.2)
            end
        end)
        mBtn.TouchTap:Connect(function() Window:Toggle() end)
    else
        -- Hint
        local hint = New("Frame", {
            Size=UDim2.new(0,192,0,28), Position=UDim2.new(0,10,1,-44),
            AnchorPoint=Vector2.new(0,1), BackgroundColor3=T.Surface,
            BackgroundTransparency=0.12, BorderSizePixel=0, ZIndex=5, Parent=ScreenGui,
        })
        Corner(hint, 8)
        local hs = Stroke(hint, T.Border, 1)
        local hl = New("TextLabel", {
            Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
            Text="[ "..toggleKey.Name:upper().." ]  Otwórz menu",
            Font=Enum.Font.Gotham, TextSize=12, TextColor3=T.TextDim,
            ZIndex=6, Parent=hint,
        })
        task.delay(5, function()
            Tween(hint, 1.2, {BackgroundTransparency=1})
            Tween(hl,   1.2, {TextTransparency=1})
            Tween(hs,   1.2, {Transparency=1})
        end)
        UserInputService.InputBegan:Connect(function(inp, gpe)
            if gpe then return end
            if inp.KeyCode==toggleKey then Window:Toggle() end
        end)
    end

    -- ══════════════════════════════════════
    -- TABS
    -- ══════════════════════════════════════
    local tabCount = 0
    local tabFrames = {}
    local tabBtns   = {}
    Window._activeTab = 0

    function Window:CreateTab(tabCfg)
        tabCfg = tabCfg or {}
        tabCount = tabCount + 1
        local idx = tabCount
        local isFirst = (idx == 1)

        -- Sidebar button
        local tabBtn = New("TextButton", {
            Size=UDim2.new(0,34,0,34),
            BackgroundColor3=isFirst and T.Accent or Color3.new(0,0,0),
            BackgroundTransparency=isFirst and 0 or 1,
            BorderSizePixel=0,
            Text=tabCfg.Icon or "●",
            TextSize=15, Font=Enum.Font.GothamBold,
            TextColor3=isFirst and Color3.new(1,1,1) or T.TextDim,
            ZIndex=13, LayoutOrder=idx,
            AutoButtonColor=false, Parent=Sidebar,
        })
        Corner(tabBtn, 9)

        -- Tooltip
        local tt = New("TextLabel", {
            Size=UDim2.new(0,0,0,22), Position=UDim2.new(1,8,0.5,-11),
            BackgroundColor3=T.SurfaceLight, BackgroundTransparency=1,
            BorderSizePixel=0,
            Text="  "..(tabCfg.Name or "Tab").."  ",
            Font=Enum.Font.Gotham, TextSize=11, TextColor3=T.Text,
            TextTransparency=1, AutomaticSize=Enum.AutomaticSize.X,
            ZIndex=60, Parent=tabBtn,
        })
        Corner(tt, 6)
        Stroke(tt, T.Border, 1)

        tabBtn.MouseEnter:Connect(function()
            Tween(tt, 0.15, {TextTransparency=0, BackgroundTransparency=0.08})
            if tabBtn.BackgroundTransparency > 0.4 then
                Tween(tabBtn, 0.18, {BackgroundTransparency=0.65, BackgroundColor3=T.Accent})
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            Tween(tt, 0.15, {TextTransparency=1, BackgroundTransparency=1})
            if self._activeTab ~= idx then
                Tween(tabBtn, 0.18, {BackgroundTransparency=1})
            end
        end)

        -- ScrollFrame
        local scroll = New("ScrollingFrame", {
            Name="Tab_"..idx, Size=UDim2.new(1,0,1,0),
            BackgroundTransparency=1, BorderSizePixel=0,
            ScrollBarThickness=3, ScrollBarImageColor3=T.Accent,
            CanvasSize=UDim2.new(0,0,0,0), ZIndex=12,
            Visible=isFirst, Parent=ContentHolder,
        })
        local contentList = ListLayout(scroll, 7)
        Pad(scroll, 10, 10, 10, 10)
        AutoCanvas(scroll, contentList)

        tabFrames[idx] = scroll
        tabBtns[idx]   = tabBtn
        if isFirst then self._activeTab = 1 end

        local function switchTab()
            for i, f in pairs(tabFrames) do f.Visible = false end
            for i, b in pairs(tabBtns) do
                Tween(b, 0.18, {BackgroundTransparency=1, TextColor3=T.TextDim})
            end
            scroll.Visible = true
            self._activeTab = idx
            Tween(tabBtn, 0.18, {BackgroundTransparency=0, BackgroundColor3=T.Accent, TextColor3=Color3.new(1,1,1)})
        end
        tabBtn.MouseButton1Click:Connect(switchTab)
        tabBtn.TouchTap:Connect(switchTab)

        -- ════════════════════════════
        -- TAB OBJECT
        -- ════════════════════════════
        local Tab = {}
        Tab._scroll   = scroll
        Tab._list     = contentList
        Tab._order    = 0

        local function nextOrder(tab)
            tab._order = tab._order + 1
            return tab._order
        end

        -- ── CreateSection ──
        function Tab:CreateSection(name)
            New("TextLabel", {
                Size=UDim2.new(1,0,0,24), BackgroundTransparency=1,
                Text=(name or "Sekcja"):upper(),
                Font=Enum.Font.GothamBold, TextSize=10,
                TextColor3=T.Accent, TextXAlignment=Enum.TextXAlignment.Left,
                ZIndex=13, LayoutOrder=nextOrder(self), Parent=self._scroll,
            })
            New("Frame", {
                Size=UDim2.new(1,0,0,1), BackgroundColor3=T.Border,
                BorderSizePixel=0, ZIndex=13,
                LayoutOrder=nextOrder(self), Parent=self._scroll,
            })
        end

        -- ── CreateButton ──
        function Tab:CreateButton(c)
            c = c or {}
            local btn = New("TextButton", {
                Size=UDim2.new(1,0,0,40), BackgroundColor3=T.SurfaceLight,
                BorderSizePixel=0, Text="", ZIndex=13,
                AutoButtonColor=false, LayoutOrder=nextOrder(self), Parent=self._scroll,
            })
            Corner(btn, 9); Stroke(btn, T.Border, 1, 0.4)
            local bg = Instance.new("UIGradient")
            bg.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,T.SurfaceLight),ColorSequenceKeypoint.new(1,T.Surface)})
            bg.Rotation=90; bg.Parent=btn
            New("TextLabel", {
                Size=UDim2.new(1,-40,1,0), Position=UDim2.new(0,13,0,0),
                BackgroundTransparency=1, Text=c.Name or "Button",
                Font=Enum.Font.GothamBold, TextSize=13, TextColor3=T.Text,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=14, Parent=btn,
            })
            local arrow = New("TextLabel", {
                Size=UDim2.new(0,22,1,0), Position=UDim2.new(1,-28,0,0),
                BackgroundTransparency=1, Text="›", TextSize=20,
                Font=Enum.Font.GothamBold, TextColor3=T.TextDim, ZIndex=14, Parent=btn,
            })
            btn.MouseEnter:Connect(function()
                Tween(btn,   0.18, {BackgroundColor3=T.Accent})
                Tween(arrow, 0.18, {TextColor3=Color3.new(1,1,1), Position=UDim2.new(1,-24,0,0)})
            end)
            btn.MouseLeave:Connect(function()
                Tween(btn,   0.18, {BackgroundColor3=T.SurfaceLight})
                Tween(arrow, 0.18, {TextColor3=T.TextDim, Position=UDim2.new(1,-28,0,0)})
            end)
            btn.MouseButton1Down:Connect(function() Tween(btn,0.08,{BackgroundColor3=T.AccentDark}) end)
            btn.MouseButton1Up:Connect(function()
                Tween(btn,0.12,{BackgroundColor3=T.Accent})
                if c.Callback then task.spawn(pcall, c.Callback) end
            end)
            btn.TouchTap:Connect(function()
                Tween(btn,0.08,{BackgroundColor3=T.AccentDark})
                task.wait(0.1)
                Tween(btn,0.12,{BackgroundColor3=T.Accent})
                if c.Callback then task.spawn(pcall, c.Callback) end
            end)
        end

        -- ── CreateToggle ──
        function Tab:CreateToggle(c)
            c = c or {}
            local state = c.CurrentValue or false

            local row = New("Frame", {
                Size=UDim2.new(1,0,0,40), BackgroundColor3=T.SurfaceLight,
                BorderSizePixel=0, ZIndex=13,
                LayoutOrder=nextOrder(self), Parent=self._scroll,
            })
            Corner(row, 9); Stroke(row, T.Border, 1, 0.4)
            New("TextLabel", {
                Size=UDim2.new(1,-62,1,0), Position=UDim2.new(0,13,0,0),
                BackgroundTransparency=1, Text=c.Name or "Toggle",
                Font=Enum.Font.Gotham, TextSize=13, TextColor3=T.Text,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=14, Parent=row,
            })
            local track = New("Frame", {
                Size=UDim2.new(0,38,0,21), Position=UDim2.new(1,-50,0.5,-10),
                BackgroundColor3=state and T.Accent or T.ToggleOff,
                BorderSizePixel=0, ZIndex=14, Parent=row,
            })
            Corner(track, 999)
            local knob = New("Frame", {
                Size=UDim2.new(0,15,0,15),
                Position=state and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7),
                BackgroundColor3=Color3.new(1,1,1),
                BorderSizePixel=0, ZIndex=15, Parent=track,
            })
            Corner(knob, 999)

            local obj = {Value=state}
            local function set(v)
                state=v; obj.Value=v
                Tween(track, 0.22, {BackgroundColor3=v and T.Accent or T.ToggleOff}, Enum.EasingStyle.Back)
                Tween(knob,  0.22, {Position=v and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7)}, Enum.EasingStyle.Back)
                if c.Callback then task.spawn(pcall, c.Callback, v) end
            end
            obj.Set = function(_, v) set(v) end

            local ca = New("TextButton", {
                Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
                Text="", ZIndex=16, Parent=row,
            })
            ca.MouseButton1Click:Connect(function() set(not state) end)
            ca.TouchTap:Connect(function() set(not state) end)
            return obj
        end

        -- ── CreateSlider ──
        function Tab:CreateSlider(c)
            c = c or {}
            local range = c.Range or {0, 100}
            local Min, Max = range[1], range[2]
            local inc = c.Increment or 1
            local suffix = c.Suffix or ""
            local current = math.clamp(c.CurrentValue or Min, Min, Max)

            local container = New("Frame", {
                Size=UDim2.new(1,0,0,54), BackgroundColor3=T.SurfaceLight,
                BorderSizePixel=0, ZIndex=13,
                LayoutOrder=nextOrder(self), Parent=self._scroll,
            })
            Corner(container, 9); Stroke(container, T.Border, 1, 0.4)
            New("TextLabel", {
                Size=UDim2.new(0.65,0,0,26), Position=UDim2.new(0,13,0,4),
                BackgroundTransparency=1, Text=c.Name or "Slider",
                Font=Enum.Font.Gotham, TextSize=13, TextColor3=T.Text,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=14, Parent=container,
            })
            local valLbl = New("TextLabel", {
                Size=UDim2.new(0.35,-13,0,26), Position=UDim2.new(0.65,0,0,4),
                BackgroundTransparency=1, Text=tostring(current)..suffix,
                Font=Enum.Font.GothamBold, TextSize=12, TextColor3=T.Accent,
                TextXAlignment=Enum.TextXAlignment.Right, ZIndex=14, Parent=container,
            })
            local trackBg = New("Frame", {
                Size=UDim2.new(1,-26,0,6), Position=UDim2.new(0,13,0,38),
                BackgroundColor3=T.Border, BorderSizePixel=0, ZIndex=14, Parent=container,
            })
            Corner(trackBg, 999)
            local p0 = (current-Min)/(Max-Min)
            local fill = New("Frame", {
                Size=UDim2.new(p0,0,1,0), BackgroundColor3=T.Accent,
                BorderSizePixel=0, ZIndex=15, Parent=trackBg,
            })
            Corner(fill, 999)
            local fg = Instance.new("UIGradient")
            fg.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,T.AccentLight),ColorSequenceKeypoint.new(1,T.Accent)})
            fg.Rotation=90; fg.Parent=fill
            local knob = New("Frame", {
                Size=UDim2.new(0,14,0,14), AnchorPoint=Vector2.new(0.5,0.5),
                Position=UDim2.new(p0,0,0.5,0), BackgroundColor3=Color3.new(1,1,1),
                BorderSizePixel=0, ZIndex=16, Parent=trackBg,
            })
            Corner(knob, 999); Stroke(knob, T.Accent, 2)

            local obj = {Value=current}
            local sliding = false
            local function setValue(v)
                v = math.clamp(math.round(v/inc)*inc, Min, Max)
                current=v; obj.Value=v
                local p = (v-Min)/(Max-Min)
                valLbl.Text = tostring(v)..suffix
                fill.Size  = UDim2.new(p,0,1,0)
                knob.Position = UDim2.new(p,0,0.5,0)
                if c.Callback then task.spawn(pcall, c.Callback, v) end
            end
            obj.Set = function(_, v) setValue(v) end

            local function slideX(x)
                local p = math.clamp((x-trackBg.AbsolutePosition.X)/trackBg.AbsoluteSize.X,0,1)
                setValue(Min+(Max-Min)*p)
            end
            trackBg.InputBegan:Connect(function(inp)
                if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
                    sliding=true; slideX(inp.Position.X)
                end
            end)
            UserInputService.InputChanged:Connect(function(inp)
                if sliding and (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) then
                    slideX(inp.Position.X)
                end
            end)
            UserInputService.InputEnded:Connect(function(inp)
                if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
                    sliding=false
                end
            end)
            return obj
        end

        -- ── CreateDropdown ──
        function Tab:CreateDropdown(c)
            c = c or {}
            local options  = c.Options or {}
            local selected = c.CurrentOption or options[1] or ""
            local dropOpen = false

            local container = New("Frame", {
                Size=UDim2.new(1,0,0,40), BackgroundColor3=T.SurfaceLight,
                BorderSizePixel=0, ClipsDescendants=false, ZIndex=13,
                LayoutOrder=nextOrder(self), Parent=self._scroll,
            })
            Corner(container, 9); Stroke(container, T.Border, 1, 0.4)

            local header = New("TextButton", {
                Size=UDim2.new(1,0,0,40), BackgroundTransparency=1,
                BorderSizePixel=0, Text="", ZIndex=14,
                AutoButtonColor=false, Parent=container,
            })
            New("TextLabel", {
                Size=UDim2.new(0.55,0,1,0), Position=UDim2.new(0,13,0,0),
                BackgroundTransparency=1, Text=c.Name or "Dropdown",
                Font=Enum.Font.Gotham, TextSize=13, TextColor3=T.TextDim,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=15, Parent=header,
            })
            local valLbl = New("TextLabel", {
                Size=UDim2.new(0.42,0,1,0), Position=UDim2.new(0.54,0,0,0),
                BackgroundTransparency=1, Text=selected,
                Font=Enum.Font.GothamBold, TextSize=12, TextColor3=T.Text,
                TextXAlignment=Enum.TextXAlignment.Right, ZIndex=15, Parent=header,
            })
            local arrowLbl = New("TextLabel", {
                Size=UDim2.new(0,20,1,0), Position=UDim2.new(1,-24,0,0),
                BackgroundTransparency=1, Text="▾", TextSize=12,
                Font=Enum.Font.GothamBold, TextColor3=T.TextDim, ZIndex=15, Parent=header,
            })

            local dropList = New("Frame", {
                Size=UDim2.new(1,0,0,0), Position=UDim2.new(0,0,1,4),
                BackgroundColor3=T.Surface, BorderSizePixel=0,
                ClipsDescendants=true, Visible=false, ZIndex=40, Parent=container,
            })
            Corner(dropList, 9); Stroke(dropList, T.Border, 1)
            ListLayout(dropList, 0)

            local obj = {Value=selected}

            local function buildList()
                for _, ch in ipairs(dropList:GetChildren()) do
                    if ch:IsA("TextButton") then ch:Destroy() end
                end
                for i, opt in ipairs(options) do
                    local isSel = opt==selected
                    local ob = New("TextButton", {
                        Size=UDim2.new(1,0,0,32),
                        BackgroundColor3=isSel and T.Accent or T.Surface,
                        BackgroundTransparency=isSel and 0.35 or 1,
                        BorderSizePixel=0, Text="", ZIndex=41,
                        AutoButtonColor=false, LayoutOrder=i, Parent=dropList,
                    })
                    local ol = New("TextLabel", {
                        Size=UDim2.new(1,-20,1,0), Position=UDim2.new(0,10,0,0),
                        BackgroundTransparency=1, Text=opt,
                        Font=Enum.Font.Gotham, TextSize=12,
                        TextColor3=isSel and T.Text or T.TextDim,
                        TextXAlignment=Enum.TextXAlignment.Left, ZIndex=42, Parent=ob,
                    })
                    ob.MouseEnter:Connect(function()
                        if not isSel then Tween(ob,0.12,{BackgroundTransparency=0.55, BackgroundColor3=T.Accent}) end
                    end)
                    ob.MouseLeave:Connect(function()
                        if not isSel then Tween(ob,0.12,{BackgroundTransparency=1}) end
                    end)
                    local function pick()
                        selected=opt; obj.Value=opt; valLbl.Text=opt
                        dropOpen=false
                        Tween(dropList,0.18,{Size=UDim2.new(1,0,0,0)})
                        Tween(arrowLbl,0.18,{Rotation=0})
                        task.delay(0.2, function() dropList.Visible=false end)
                        buildList()
                        if c.Callback then task.spawn(pcall, c.Callback, opt) end
                    end
                    ob.MouseButton1Click:Connect(pick); ob.TouchTap:Connect(pick)
                end
            end
            buildList()

            local function toggle()
                dropOpen = not dropOpen
                if dropOpen then
                    dropList.Visible=true
                    Tween(dropList,0.22,{Size=UDim2.new(1,0,0,#options*32)}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                    Tween(arrowLbl,0.18,{Rotation=180})
                else
                    Tween(dropList,0.18,{Size=UDim2.new(1,0,0,0)})
                    Tween(arrowLbl,0.18,{Rotation=0})
                    task.delay(0.2, function() dropList.Visible=false end)
                end
            end
            header.MouseButton1Click:Connect(toggle); header.TouchTap:Connect(toggle)

            obj.Set = function(_, v) selected=v; obj.Value=v; valLbl.Text=v; buildList() end
            obj.Refresh = function(_, newOpts)
                options=newOpts; selected=newOpts[1] or ""; obj.Value=selected; valLbl.Text=selected; buildList()
            end
            return obj
        end

        -- ── CreateInput ──
        function Tab:CreateInput(c)
            c = c or {}
            local container = New("Frame", {
                Size=UDim2.new(1,0,0,54), BackgroundColor3=T.SurfaceLight,
                BorderSizePixel=0, ZIndex=13,
                LayoutOrder=nextOrder(self), Parent=self._scroll,
            })
            Corner(container, 9); Stroke(container, T.Border, 1, 0.4)
            New("TextLabel", {
                Size=UDim2.new(1,-13,0,22), Position=UDim2.new(0,13,0,4),
                BackgroundTransparency=1, Text=c.Name or "Input",
                Font=Enum.Font.Gotham, TextSize=12, TextColor3=T.TextDim,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=14, Parent=container,
            })
            local iFrame = New("Frame", {
                Size=UDim2.new(1,-26,0,22), Position=UDim2.new(0,13,0,28),
                BackgroundColor3=T.Background, BorderSizePixel=0, ZIndex=14, Parent=container,
            })
            Corner(iFrame, 6)
            local iStroke = Stroke(iFrame, T.Border, 1)
            local tb = New("TextBox", {
                Size=UDim2.new(1,-16,1,0), Position=UDim2.new(0,8,0,0),
                BackgroundTransparency=1, Text=c.CurrentString or "",
                PlaceholderText=c.PlaceholderText or "Wpisz...",
                PlaceholderColor3=T.TextMuted,
                Font=Enum.Font.Gotham, TextSize=12, TextColor3=T.Text,
                TextXAlignment=Enum.TextXAlignment.Left,
                ClearTextOnFocus=false, ZIndex=15, Parent=iFrame,
            })
            tb.Focused:Connect(function() Tween(iStroke,0.18,{Color=T.Accent}) end)
            tb.FocusLost:Connect(function()
                Tween(iStroke,0.18,{Color=T.Border})
                if c.Callback then task.spawn(pcall, c.Callback, tb.Text) end
            end)
            local obj={Value=tb.Text}
            obj.Set=function(_,v) tb.Text=v; obj.Value=v end
            tb:GetPropertyChangedSignal("Text"):Connect(function() obj.Value=tb.Text end)
            return obj
        end

        -- ── CreateKeybind ──
        function Tab:CreateKeybind(c)
            c = c or {}
            local currentKey = Enum.KeyCode[c.CurrentKeybind or "Unknown"] or Enum.KeyCode.Unknown
            local listening = false

            local row = New("Frame", {
                Size=UDim2.new(1,0,0,40), BackgroundColor3=T.SurfaceLight,
                BorderSizePixel=0, ZIndex=13,
                LayoutOrder=nextOrder(self), Parent=self._scroll,
            })
            Corner(row, 9); Stroke(row, T.Border, 1, 0.4)
            New("TextLabel", {
                Size=UDim2.new(0.6,0,1,0), Position=UDim2.new(0,13,0,0),
                BackgroundTransparency=1, Text=c.Name or "Keybind",
                Font=Enum.Font.Gotham, TextSize=13, TextColor3=T.Text,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=14, Parent=row,
            })
            local kb = New("TextButton", {
                Size=UDim2.new(0,72,0,24), Position=UDim2.new(1,-82,0.5,-12),
                BackgroundColor3=T.Surface, BorderSizePixel=0,
                Text=currentKey.Name, Font=Enum.Font.GothamBold, TextSize=11,
                TextColor3=T.Accent, ZIndex=14, AutoButtonColor=false, Parent=row,
            })
            Corner(kb, 7); Stroke(kb, T.Accent, 1, 0.35)

            local obj={Value=currentKey}
            obj.Set=function(_,key) currentKey=key; obj.Value=key; kb.Text=key.Name end

            kb.MouseButton1Click:Connect(function()
                if listening then return end
                listening=true; kb.Text="..."
                Tween(kb,0.15,{BackgroundColor3=T.Accent, TextColor3=Color3.new(1,1,1)})
            end)
            UserInputService.InputBegan:Connect(function(inp, gpe)
                if not listening then return end
                if inp.UserInputType==Enum.UserInputType.Keyboard then
                    listening=false
                    currentKey=inp.KeyCode; obj.Value=inp.KeyCode; kb.Text=inp.KeyCode.Name
                    Tween(kb,0.15,{BackgroundColor3=T.Surface, TextColor3=T.Accent})
                    if c.Callback then task.spawn(pcall, c.Callback, inp.KeyCode) end
                end
            end)
            return obj
        end

        -- ── CreateLabel ──
        function Tab:CreateLabel(text)
            New("TextLabel", {
                Size=UDim2.new(1,0,0,24), BackgroundTransparency=1,
                Text=text or "", Font=Enum.Font.Gotham, TextSize=12,
                TextColor3=T.TextDim, TextXAlignment=Enum.TextXAlignment.Left,
                TextWrapped=true, ZIndex=13,
                LayoutOrder=nextOrder(self), Parent=self._scroll,
            })
        end

        -- ── AddParagraph ──
        function Tab:AddParagraph(c)
            c = c or {}
            local box = New("Frame", {
                Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y,
                BackgroundColor3=T.SurfaceLight, BorderSizePixel=0, ZIndex=13,
                LayoutOrder=nextOrder(self), Parent=self._scroll,
            })
            Corner(box, 9); Stroke(box, T.Border, 1, 0.4)
            ListLayout(box, 4)
            Pad(box, 8, 8, 13, 13)
            New("TextLabel", {
                Size=UDim2.new(1,0,0,18), BackgroundTransparency=1,
                Text=c.Title or "", Font=Enum.Font.GothamBold, TextSize=13,
                TextColor3=T.Text, TextXAlignment=Enum.TextXAlignment.Left,
                ZIndex=14, LayoutOrder=1, Parent=box,
            })
            New("TextLabel", {
                Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y,
                BackgroundTransparency=1, Text=c.Content or "",
                Font=Enum.Font.Gotham, TextSize=12, TextColor3=T.TextDim,
                TextXAlignment=Enum.TextXAlignment.Left, TextWrapped=true,
                ZIndex=14, LayoutOrder=2, Parent=box,
            })
        end

        -- ── CreateDivider ──
        function Tab:CreateDivider()
            New("Frame", {
                Size=UDim2.new(1,0,0,1), BackgroundColor3=T.Border,
                BorderSizePixel=0, ZIndex=13,
                LayoutOrder=nextOrder(self), Parent=self._scroll,
            })
        end

        table.insert(Window.Tabs, Tab)
        return Tab
    end

    return Window
end

-- ══════════════════════════════════════════════════════════
-- NOTIFY
-- ══════════════════════════════════════════════════════════
function Library.Notify(cfg)
    cfg = cfg or {}
    local typeMap = {
        success = {T.Success, "✓"},
        error   = {T.Danger,  "✕"},
        warning = {T.Warning, "⚠"},
        info    = {T.Accent,  "ℹ"},
    }
    local tType   = cfg.Type or "info"
    local accent  = typeMap[tType] and typeMap[tType][1] or T.Accent
    local icon    = typeMap[tType] and typeMap[tType][2] or "ℹ"

    local sg
    pcall(function() sg = CoreGui:FindFirstChild("E404_Notifs") end)
    if not sg then sg = MakeSG("E404_Notifs", 1001) end

    local holder = sg:FindFirstChild("Holder")
    if not holder then
        holder = New("Frame", {
            Name="Holder", Size=UDim2.new(0,285,1,-16),
            Position=UDim2.new(1,-300,0,8),
            BackgroundTransparency=1, BorderSizePixel=0,
            ZIndex=100, Parent=sg,
        })
        local hl = ListLayout(holder, 8)
        hl.VerticalAlignment = Enum.VerticalAlignment.Bottom
    end

    local card = New("Frame", {
        Size=UDim2.new(1,0,0,74), BackgroundColor3=T.Surface,
        BackgroundTransparency=1, BorderSizePixel=0,
        ZIndex=101, Parent=holder,
    })
    Corner(card, 10); Stroke(card, accent, 1, 0.5)

    New("Frame", {
        Size=UDim2.new(0,3,1,0), BackgroundColor3=accent,
        BorderSizePixel=0, ZIndex=102, Parent=card,
    })
    local ico = New("TextLabel", {
        Size=UDim2.new(0,30,0,30), Position=UDim2.new(0,12,0.5,-15),
        BackgroundColor3=accent, BackgroundTransparency=0.8,
        Text=icon, Font=Enum.Font.GothamBold, TextSize=14,
        TextColor3=accent, ZIndex=102, Parent=card,
    })
    Corner(ico, 8)
    New("TextLabel", {
        Size=UDim2.new(1,-58,0,22), Position=UDim2.new(0,50,0,10),
        BackgroundTransparency=1, Text=cfg.Title or "Powiadomienie",
        Font=Enum.Font.GothamBold, TextSize=13, TextColor3=T.Text,
        TextXAlignment=Enum.TextXAlignment.Left, ZIndex=102, Parent=card,
    })
    New("TextLabel", {
        Size=UDim2.new(1,-58,0,28), Position=UDim2.new(0,50,0,32),
        BackgroundTransparency=1, Text=cfg.Content or "",
        Font=Enum.Font.Gotham, TextSize=11, TextColor3=T.TextDim,
        TextXAlignment=Enum.TextXAlignment.Left, TextWrapped=true,
        ZIndex=102, Parent=card,
    })

    local pgBg = New("Frame", {Size=UDim2.new(1,0,0,2), Position=UDim2.new(0,0,1,-2), BackgroundColor3=T.Border, BorderSizePixel=0, ZIndex=102, Parent=card})
    local pgFill = New("Frame", {Size=UDim2.new(1,0,1,0), BackgroundColor3=accent, BorderSizePixel=0, ZIndex=103, Parent=pgBg})

    Tween(card, 0.42, {BackgroundTransparency=0}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local dur = cfg.Duration or 4
    Tween(pgFill, dur, {Size=UDim2.new(0,0,1,0)}, Enum.EasingStyle.Linear)
    task.delay(dur, function()
        Tween(card, 0.3, {BackgroundTransparency=1}, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        task.delay(0.35, function() card:Destroy() end)
    end)
end

-- ══════════════════════════════════════════════════════════
-- INIT z intro
-- ══════════════════════════════════════════════════════════
Library.PlayIntro = PlayIntro

local _origCreate = Library.CreateWindow
function Library.CreateWindow(cfg)
    cfg = cfg or {}
    if cfg.ShowIntro == false then
        local w = _origCreate(cfg)
        task.delay(0.1, function() w:Open() end)
        return w
    end

    local windowReady = false
    local windowRef   = nil

    task.spawn(function()
        PlayIntro(function()
            windowRef = _origCreate(cfg)
            task.delay(0.2, function() windowRef:Open() end)
            windowReady = true
        end)
    end)

    -- Proxy który czeka aż window będzie gotowy
    local proxy = setmetatable({}, {
        __index = function(_, k)
            return function(self, ...)
                local t0 = tick()
                while not windowReady and tick()-t0 < 20 do task.wait(0.05) end
                if windowRef and type(windowRef[k]) == "function" then
                    return windowRef[k](windowRef, ...)
                end
            end
        end,
        __newindex = function(_, k, v)
            local t0 = tick()
            while not windowReady and tick()-t0 < 20 do task.wait(0.05) end
            if windowRef then windowRef[k] = v end
        end,
    })
    return proxy
end

return Library
