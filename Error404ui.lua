-- ╔══════════════════════════════════════════════════╗
-- ║          ERROR 404 UI  •  v3.0                   ║
-- ║   Własne API | Rayfield-inspired look            ║
-- ╚══════════════════════════════════════════════════╝

local E404 = {}

-- ══════════════════════════
-- SERVICES
-- ══════════════════════════
local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui          = game:GetService("CoreGui")

local LP       = Players.LocalPlayer
local MOBILE   = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- ══════════════════════════
-- THEME
-- ══════════════════════════
E404.Theme = {
    Win        = Color3.fromRGB(12, 12, 20),
    Panel      = Color3.fromRGB(18, 18, 28),
    Card       = Color3.fromRGB(23, 23, 36),
    CardHover  = Color3.fromRGB(30, 30, 46),
    Sidebar    = Color3.fromRGB(15, 15, 24),
    Accent     = Color3.fromRGB(100, 55, 255),
    AccentB    = Color3.fromRGB(135, 85, 255),
    AccentDark = Color3.fromRGB(58, 25, 175),
    Border     = Color3.fromRGB(42, 36, 72),
    BorderLight= Color3.fromRGB(60, 52, 100),
    Text       = Color3.fromRGB(238, 238, 255),
    TextSub    = Color3.fromRGB(140, 132, 170),
    TextMuted  = Color3.fromRGB(80, 74, 110),
    Green      = Color3.fromRGB(50, 200, 120),
    Red        = Color3.fromRGB(210, 45, 85),
    Yellow     = Color3.fromRGB(248, 170, 45),
    TogOff     = Color3.fromRGB(42, 38, 66),
}

-- ══════════════════════════
-- UTILS
-- ══════════════════════════
local TH = E404.Theme

local function inst(cls, props)
    local o = Instance.new(cls)
    for k, v in pairs(props or {}) do o[k] = v end
    return o
end

local function tw(obj, t, props, es, ed)
    TweenService:Create(obj,
        TweenInfo.new(t, es or Enum.EasingStyle.Quint, ed or Enum.EasingDirection.Out),
        props):Play()
end

local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = p
end

local function stroke(p, col, th2, tr)
    local s = Instance.new("UIStroke")
    s.Color = col; s.Thickness = th2 or 1.5; s.Transparency = tr or 0
    s.Parent = p
    return s
end

local function grad(p, c0, c1, rot)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,c0), ColorSequenceKeypoint.new(1,c1)}
    g.Rotation = rot or 0; g.Parent = p
end

local function list(p, pad, ha)
    local l = Instance.new("UIListLayout")
    l.Padding = UDim.new(0, pad or 6)
    l.HorizontalAlignment = ha or Enum.HorizontalAlignment.Left
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Parent = p
    return l
end

local function pad(p, t, b, l, r)
    local u = Instance.new("UIPadding")
    u.PaddingTop = UDim.new(0,t or 0); u.PaddingBottom = UDim.new(0,b or 0)
    u.PaddingLeft = UDim.new(0,l or 0); u.PaddingRight = UDim.new(0,r or 0)
    u.Parent = p
end

local function autoCanvas(sf, lay)
    lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sf.CanvasSize = UDim2.new(0,0,0, lay.AbsoluteContentSize.Y + 24)
    end)
end

-- ScreenGui safe
local function makeSG(name, order)
    local sg
    pcall(function()
        sg = inst("ScreenGui", {
            Name = name, ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            IgnoreGuiInset = true, DisplayOrder = order or 500,
            Parent = CoreGui,
        })
    end)
    if not sg then
        sg = inst("ScreenGui", {
            Name = name, ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            IgnoreGuiInset = true,
            Parent = LP:WaitForChild("PlayerGui"),
        })
    end
    return sg
end

-- ══════════════════════════════════════════════════════
-- INTRO  (ERROR → 404, bez tła)
-- ══════════════════════════════════════════════════════
local function runIntro(cb)
    local sg = makeSG("E404_Intro", 9999)

    local function makeWord(txt, col, glow)
        local f = inst("Frame", {
            Size=UDim2.new(0,760,0,125), AnchorPoint=Vector2.new(0.5,0.5),
            BackgroundTransparency=1, ZIndex=300, Parent=sg,
        })
        -- shadow
        inst("TextLabel", {
            Size=UDim2.new(1,14,1,14), Position=UDim2.new(0,-7,0,-7),
            BackgroundTransparency=1, Text=txt,
            Font=Enum.Font.GothamBold, TextSize=86,
            TextColor3=glow, TextTransparency=0.62, ZIndex=300, Parent=f,
        })
        local lbl = inst("TextLabel", {
            Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
            Text=txt, Font=Enum.Font.GothamBold, TextSize=86,
            TextColor3=col, TextTransparency=0, ZIndex=301, Parent=f,
        })
        local s = Instance.new("UIStroke")
        s.Color=glow; s.Thickness=2.8; s.Transparency=0.22; s.Parent=lbl
        return f, lbl
    end

    local function pulse(lbl, n)
        for _=1,n do
            tw(lbl,.2,{TextTransparency=0.48},Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
            task.wait(.2)
            tw(lbl,.2,{TextTransparency=0},Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
            task.wait(.2)
        end
    end

    local tIn  = TweenInfo.new(0.58, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local tOut = TweenInfo.new(0.44, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    local ctr  = UDim2.new(0.5,0,0.5,0)

    -- ERROR
    local c1,l1 = makeWord("ERROR", Color3.fromRGB(192,95,255), Color3.fromRGB(148,0,255))
    c1.Position = UDim2.new(-0.65,0,0.5,0)
    TweenService:Create(c1,tIn,{Position=ctr}):Play()
    task.wait(0.62); task.spawn(pulse,l1,4); task.wait(2.0)
    TweenService:Create(c1,tOut,{Position=UDim2.new(1.65,0,0.5,0)}):Play()
    task.wait(0.5); c1:Destroy(); task.wait(0.08)

    -- 404
    local c2,l2 = makeWord("404", Color3.fromRGB(255,55,125), Color3.fromRGB(255,0,75))
    c2.Position = UDim2.new(1.65,0,0.5,0)
    TweenService:Create(c2,tIn,{Position=ctr}):Play()
    task.wait(0.62); task.spawn(pulse,l2,4); task.wait(2.0)
    TweenService:Create(c2,tOut,{Position=UDim2.new(-0.65,0,0.5,0)}):Play()
    task.wait(0.5); c2:Destroy(); task.wait(0.18)

    sg:Destroy()
    if cb then cb() end
end

-- ══════════════════════════════════════════════════════════════
-- WINDOW
-- ══════════════════════════════════════════════════════════════
--[[
    E404.Window({
        Title      = "Tytuł",
        Subtitle   = "v1.0",
        Key        = Enum.KeyCode.Insert,
        Intro      = true,
    })
    returns WindowObject
]]
function E404.Window(cfg)
    cfg = cfg or {}
    local KEY   = cfg.Key or Enum.KeyCode.Insert
    local W     = MOBILE and 318 or 350
    local H     = MOBILE and 530 or 555
    local SIDE  = 52      -- szerokość sidebara

    local sg = makeSG("E404_Window", 500)

    -- ╔═══════════════════════════════╗
    -- ║  GŁÓWNA RAMKA                 ║
    -- ╚═══════════════════════════════╝
    local frame = inst("Frame", {
        Name="E404Frame",
        Size=UDim2.new(0,W,0,H),
        AnchorPoint=Vector2.new(0,0.5),
        Position=UDim2.new(-0.6,0,0.5,0),
        BackgroundColor3=TH.Win,
        BorderSizePixel=0,
        ClipsDescendants=false,
        Visible=false, ZIndex=10,
        Parent=sg,
    })
    corner(frame, 16)
    local frameBorder = stroke(frame, TH.Border, 1.5)

    -- Zewnętrzny blask (glow)
    local glow = inst("ImageLabel", {
        Name="Glow",
        AnchorPoint=Vector2.new(0.5,0.5),
        Position=UDim2.new(0.5,0,0.5,4),
        Size=UDim2.new(1,60,1,60),
        BackgroundTransparency=1,
        Image="rbxassetid://5028857084",
        ImageColor3=TH.Accent,
        ImageTransparency=0.88,
        ScaleType=Enum.ScaleType.Slice,
        SliceCenter=Rect.new(24,24,276,276),
        ZIndex=9,
        Parent=frame,
    })

    -- ╔═══════════════════════════════╗
    -- ║  SIDEBAR                      ║
    -- ╚═══════════════════════════════╝
    local sidebar = inst("Frame", {
        Name="Sidebar",
        Size=UDim2.new(0,SIDE,1,0),
        BackgroundColor3=TH.Sidebar,
        BorderSizePixel=0,
        ZIndex=12,
        ClipsDescendants=true,
        Parent=frame,
    })
    corner(sidebar, 16)
    -- fix: right side flat
    inst("Frame", {
        Size=UDim2.new(0,16,1,0), Position=UDim2.new(1,-16,0,0),
        BackgroundColor3=TH.Sidebar, BorderSizePixel=0, ZIndex=12, Parent=sidebar,
    })
    -- Divider
    inst("Frame", {
        Size=UDim2.new(0,1,1,0), Position=UDim2.new(1,-1,0,0),
        BackgroundColor3=TH.Border, BorderSizePixel=0, ZIndex=13, Parent=sidebar,
    })

    -- Logo na górze sidebara
    local logoWrap = inst("Frame", {
        Size=UDim2.new(0,34,0,34),
        Position=UDim2.new(0.5,-17,0,10),
        BackgroundColor3=TH.Accent,
        BorderSizePixel=0, ZIndex=13, Parent=sidebar,
    })
    corner(logoWrap, 10)
    grad(logoWrap, TH.AccentB, TH.AccentDark, 135)
    inst("TextLabel", {
        Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
        Text="⚡", TextSize=17, Font=Enum.Font.GothamBold,
        TextColor3=Color3.new(1,1,1), ZIndex=14, Parent=logoWrap,
    })

    -- Tab buttons container
    local sideList = list(sidebar, 6, Enum.HorizontalAlignment.Center)
    pad(sidebar, 54, 8, 0, 0)

    -- ╔═══════════════════════════════╗
    -- ║  TOPBAR                       ║
    -- ╚═══════════════════════════════╝
    local topbar = inst("Frame", {
        Name="Topbar",
        Size=UDim2.new(1,-SIDE,0,52),
        Position=UDim2.new(0,SIDE,0,0),
        BackgroundColor3=TH.Panel,
        BorderSizePixel=0,
        ZIndex=12,
        Parent=frame,
    })
    -- flat left side
    inst("Frame", {
        Size=UDim2.new(0,12,1,0),
        BackgroundColor3=TH.Panel,
        BorderSizePixel=0, ZIndex=12, Parent=topbar,
    })
    corner(topbar, 14)
    -- fix bottom corners
    inst("Frame", {
        Size=UDim2.new(1,0,0,16), Position=UDim2.new(0,0,1,-16),
        BackgroundColor3=TH.Panel, BorderSizePixel=0, ZIndex=12, Parent=topbar,
    })

    -- Linia gradient pod topbarem
    local topLine = inst("Frame", {
        Size=UDim2.new(1,0,0,2), Position=UDim2.new(0,0,1,-2),
        BackgroundColor3=TH.Accent, BorderSizePixel=0, ZIndex=13, Parent=topbar,
    })
    local tlg = Instance.new("UIGradient")
    tlg.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0,Color3.new(0,0,0)),
        ColorSequenceKeypoint.new(0.1,Color3.new(1,1,1)),
        ColorSequenceKeypoint.new(0.9,Color3.new(1,1,1)),
        ColorSequenceKeypoint.new(1,Color3.new(0,0,0)),
    }
    tlg.Parent = topLine

    -- Tytuł
    inst("TextLabel", {
        Size=UDim2.new(1,-80,0,22), Position=UDim2.new(0,14,0,7),
        BackgroundTransparency=1, Text=cfg.Title or "ERROR 404 UI",
        Font=Enum.Font.GothamBold, TextSize=15, TextColor3=TH.Text,
        TextXAlignment=Enum.TextXAlignment.Left, ZIndex=13, Parent=topbar,
    })
    inst("TextLabel", {
        Size=UDim2.new(1,-80,0,14), Position=UDim2.new(0,14,0,30),
        BackgroundTransparency=1, Text=cfg.Subtitle or "v3.0",
        Font=Enum.Font.Gotham, TextSize=11, TextColor3=TH.TextSub,
        TextXAlignment=Enum.TextXAlignment.Left, ZIndex=13, Parent=topbar,
    })

    -- Close button
    local closeBtn = inst("TextButton", {
        Size=UDim2.new(0,26,0,26), Position=UDim2.new(1,-36,0.5,-13),
        BackgroundColor3=TH.Card, BorderSizePixel=0,
        Text="✕", Font=Enum.Font.GothamBold, TextSize=12,
        TextColor3=TH.TextSub, ZIndex=14, AutoButtonColor=false, Parent=topbar,
    })
    corner(closeBtn, 8)
    closeBtn.MouseEnter:Connect(function()
        tw(closeBtn,.15,{BackgroundColor3=TH.Red, TextColor3=Color3.new(1,1,1)})
    end)
    closeBtn.MouseLeave:Connect(function()
        tw(closeBtn,.15,{BackgroundColor3=TH.Card, TextColor3=TH.TextSub})
    end)

    -- ╔═══════════════════════════════╗
    -- ║  CONTENT AREA                 ║
    -- ╚═══════════════════════════════╝
    local contentArea = inst("Frame", {
        Name="ContentArea",
        Size=UDim2.new(1,-SIDE,1,-52),
        Position=UDim2.new(0,SIDE,0,52),
        BackgroundTransparency=1,
        BorderSizePixel=0,
        ClipsDescendants=true,
        ZIndex=11,
        Parent=frame,
    })

    -- ╔══════════════════════════════════╗
    -- ║  DRAG                            ║
    -- ╚══════════════════════════════════╝
    do
        local dragging, dStart, dStartPos
        topbar.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                dragging=true; dStart=i.Position; dStartPos=frame.Position
            end
        end)
        topbar.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                dragging=false
            end
        end)
        UserInputService.InputChanged:Connect(function(i)
            if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                local d=i.Position-dStart
                frame.Position=UDim2.new(dStartPos.X.Scale,dStartPos.X.Offset+d.X,dStartPos.Y.Scale,dStartPos.Y.Offset+d.Y)
            end
        end)
    end

    -- ╔══════════════════════════════════╗
    -- ║  OPEN / CLOSE                    ║
    -- ╚══════════════════════════════════╝
    local isOpen = false
    local openPos   = MOBILE and UDim2.new(0.5,-W/2,0.5,0) or UDim2.new(0,18,0.5,0)
    local closedPos = UDim2.new(-0.55,0,0.5,0)

    local WIN = {}

    function WIN:Open()
        if isOpen then return end
        isOpen = true
        frame.Visible = true
        frame.Position = closedPos
        frame.BackgroundTransparency = 1
        frameBorder.Transparency = 1
        glow.ImageTransparency = 1
        tw(frame,.54,{Position=openPos,BackgroundTransparency=0},Enum.EasingStyle.Back,Enum.EasingDirection.Out)
        tw(frameBorder,.38,{Transparency=0})
        tw(glow,.45,{ImageTransparency=0.88})
    end

    function WIN:Close()
        if not isOpen then return end
        isOpen = false
        tw(frame,.36,{Position=closedPos,BackgroundTransparency=1})
        tw(frameBorder,.28,{Transparency=1})
        tw(glow,.28,{ImageTransparency=1})
        task.delay(.38,function() if not isOpen then frame.Visible=false end end)
    end

    function WIN:Toggle()
        if isOpen then self:Close() else self:Open() end
    end

    function WIN:Destroy() sg:Destroy() end

    closeBtn.MouseButton1Click:Connect(function() WIN:Close() end)
    closeBtn.TouchTap:Connect(function() WIN:Close() end)

    -- ── Mobile button ──
    if MOBILE then
        local mb = inst("TextButton", {
            Size=UDim2.new(0,52,0,52), Position=UDim2.new(0,14,1,-68),
            AnchorPoint=Vector2.new(0,1), BackgroundColor3=TH.Accent,
            BorderSizePixel=0, Text="⚡", TextSize=21,
            Font=Enum.Font.GothamBold, TextColor3=Color3.new(1,1,1),
            ZIndex=20, AutoButtonColor=false, Parent=sg,
        })
        corner(mb,14); grad(mb,TH.AccentB,TH.AccentDark,135)
        local ms=stroke(mb,TH.AccentB,2)
        task.spawn(function()
            while mb.Parent do
                tw(ms,1.3,{Transparency=0.78},Enum.EasingStyle.Sine,Enum.EasingDirection.InOut); task.wait(1.3)
                tw(ms,1.3,{Transparency=0},Enum.EasingStyle.Sine,Enum.EasingDirection.InOut); task.wait(1.3)
            end
        end)
        mb.TouchTap:Connect(function() WIN:Toggle() end)
    else
        -- Hint
        local hf = inst("Frame", {
            Size=UDim2.new(0,195,0,28), Position=UDim2.new(0,10,1,-44),
            AnchorPoint=Vector2.new(0,1), BackgroundColor3=TH.Panel,
            BackgroundTransparency=0.1, BorderSizePixel=0, ZIndex=5, Parent=sg,
        })
        corner(hf,8); local hs=stroke(hf,TH.Border,1)
        local hl=inst("TextLabel", {
            Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
            Text="[ "..KEY.Name:upper().." ]  Otwórz / Zamknij",
            Font=Enum.Font.Gotham, TextSize=12, TextColor3=TH.TextSub, ZIndex=6, Parent=hf,
        })
        task.delay(6,function()
            tw(hf,1.4,{BackgroundTransparency=1})
            tw(hl,1.4,{TextTransparency=1})
            tw(hs,1.4,{Transparency=1})
        end)
        UserInputService.InputBegan:Connect(function(i,gpe)
            if gpe then return end
            if i.KeyCode==KEY then WIN:Toggle() end
        end)
    end

    -- ╔══════════════════════════════════════╗
    -- ║  TAB SYSTEM                          ║
    -- ╚══════════════════════════════════════╝
    local tabIdx    = 0
    local tabFrames = {}
    local tabBtns   = {}
    WIN._active     = 0

    --[[
        WIN:Tab({
            Label = "Gracz",
            Icon  = "🏃",
        })
        returns TabObject
    ]]
    function WIN:Tab(tcfg)
        tcfg = tcfg or {}
        tabIdx = tabIdx + 1
        local ti = tabIdx
        local first = (ti == 1)

        -- ── Sidebar tab button ──
        local tb = inst("TextButton", {
            Size=UDim2.new(0,36,0,36),
            BackgroundColor3 = first and TH.Accent or Color3.new(0,0,0),
            BackgroundTransparency = first and 0 or 1,
            BorderSizePixel=0,
            Text = tcfg.Icon or "●",
            TextSize=16, Font=Enum.Font.GothamBold,
            TextColor3 = first and Color3.new(1,1,1) or TH.TextSub,
            ZIndex=14, LayoutOrder=ti,
            AutoButtonColor=false, Parent=sidebar,
        })
        corner(tb, 10)
        if first then
            grad(tb, TH.AccentB, TH.AccentDark, 135)
        end

        -- Tooltip
        local tip = inst("TextLabel", {
            Size=UDim2.new(0,0,0,24), Position=UDim2.new(1,10,0.5,-12),
            BackgroundColor3=TH.Card, BackgroundTransparency=1,
            BorderSizePixel=0,
            Text="  "..(tcfg.Label or "Tab").."  ",
            Font=Enum.Font.Gotham, TextSize=11,
            TextColor3=TH.Text, TextTransparency=1,
            AutomaticSize=Enum.AutomaticSize.X,
            ZIndex=80, Parent=tb,
        })
        corner(tip, 7); stroke(tip, TH.Border, 1, 0)

        tb.MouseEnter:Connect(function()
            tw(tip,.14,{TextTransparency=0, BackgroundTransparency=0.05})
            if ti ~= WIN._active then
                tw(tb,.18,{BackgroundTransparency=0.6, BackgroundColor3=TH.Accent})
            end
        end)
        tb.MouseLeave:Connect(function()
            tw(tip,.14,{TextTransparency=1, BackgroundTransparency=1})
            if ti ~= WIN._active then
                tw(tb,.18,{BackgroundTransparency=1})
            end
        end)

        -- ── Tab scroll frame ──
        local sf = inst("ScrollingFrame", {
            Name="TabSF_"..ti,
            Size=UDim2.new(1,0,1,0),
            BackgroundTransparency=1, BorderSizePixel=0,
            ScrollBarThickness=3, ScrollBarImageColor3=TH.Accent,
            CanvasSize=UDim2.new(0,0,0,0),
            ZIndex=12, Visible=first, Parent=contentArea,
        })
        local lay = list(sf, 7)
        pad(sf, 10, 10, 10, 10)
        autoCanvas(sf, lay)

        tabFrames[ti] = sf
        tabBtns[ti]   = tb
        if first then WIN._active = 1 end

        local function activate()
            for i, f in pairs(tabFrames) do f.Visible = false end
            for i, b in pairs(tabBtns) do
                tw(b,.18,{BackgroundTransparency=1, TextColor3=TH.TextSub})
                -- remove gradient if any (simple reset)
                local g2 = b:FindFirstChildOfClass("UIGradient")
                if g2 then g2:Destroy() end
            end
            sf.Visible = true
            WIN._active = ti
            tw(tb,.18,{BackgroundTransparency=0, BackgroundColor3=TH.Accent, TextColor3=Color3.new(1,1,1)})
            grad(tb, TH.AccentB, TH.AccentDark, 135)
        end

        tb.MouseButton1Click:Connect(activate)
        tb.TouchTap:Connect(activate)

        -- ╔══════════════════════════════════╗
        -- ║  TAB API                         ║
        -- ╚══════════════════════════════════╝
        local TAB  = {_sf=sf, _lay=lay, _ord=0}

        local function no(t) t._ord=t._ord+1; return t._ord end

        -- ── Section header ──
        --[[  TAB:Section("Nazwa")  ]]
        function TAB:Section(name)
            local wrap = inst("Frame", {
                Size=UDim2.new(1,0,0,26), BackgroundTransparency=1,
                ZIndex=13, LayoutOrder=no(self), Parent=self._sf,
            })
            inst("TextLabel", {
                Size=UDim2.new(1,-4,0,16), Position=UDim2.new(0,2,0,0),
                BackgroundTransparency=1, Text=(name or "SEKCJA"):upper(),
                Font=Enum.Font.GothamBold, TextSize=10,
                TextColor3=TH.Accent, TextXAlignment=Enum.TextXAlignment.Left,
                ZIndex=14, Parent=wrap,
            })
            inst("Frame", {
                Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,1,-1),
                BackgroundColor3=TH.Border, BorderSizePixel=0, ZIndex=14, Parent=wrap,
            })
        end

        -- ── Button ──
        --[[
            TAB:Button({
                Label    = "Kliknij",
                Desc     = "Opis (opcjonalny)",
                Callback = function() end,
            })
        ]]
        function TAB:Button(c)
            c = c or {}
            local hasDesc = c.Desc and c.Desc ~= ""
            local btnH = hasDesc and 50 or 40

            local btn = inst("TextButton", {
                Size=UDim2.new(1,0,0,btnH), BackgroundColor3=TH.Card,
                BorderSizePixel=0, Text="", ZIndex=13,
                AutoButtonColor=false, LayoutOrder=no(self), Parent=self._sf,
            })
            corner(btn, 10)
            local bs = stroke(btn, TH.Border, 1, 0.3)
            grad(btn, TH.Card, TH.Panel, 90)

            inst("TextLabel", {
                Size=UDim2.new(1,-44,0,hasDesc and 20 or btnH), Position=UDim2.new(0,14,0,hasDesc and 6 or 0),
                BackgroundTransparency=1, Text=c.Label or "Button",
                Font=Enum.Font.GothamBold, TextSize=13, TextColor3=TH.Text,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=14, Parent=btn,
            })
            if hasDesc then
                inst("TextLabel", {
                    Size=UDim2.new(1,-44,0,16), Position=UDim2.new(0,14,0,28),
                    BackgroundTransparency=1, Text=c.Desc,
                    Font=Enum.Font.Gotham, TextSize=11, TextColor3=TH.TextSub,
                    TextXAlignment=Enum.TextXAlignment.Left, ZIndex=14, Parent=btn,
                })
            end
            local arr = inst("TextLabel", {
                Size=UDim2.new(0,24,1,0), Position=UDim2.new(1,-30,0,0),
                BackgroundTransparency=1, Text="›", TextSize=22,
                Font=Enum.Font.GothamBold, TextColor3=TH.TextSub, ZIndex=14, Parent=btn,
            })
            btn.MouseEnter:Connect(function()
                tw(btn,.18,{BackgroundColor3=TH.Accent})
                tw(arr,.18,{TextColor3=Color3.new(1,1,1), Position=UDim2.new(1,-26,0,0)})
                tw(bs,.18,{Transparency=1})
            end)
            btn.MouseLeave:Connect(function()
                tw(btn,.18,{BackgroundColor3=TH.Card})
                tw(arr,.18,{TextColor3=TH.TextSub, Position=UDim2.new(1,-30,0,0)})
                tw(bs,.18,{Transparency=0.3})
            end)
            btn.MouseButton1Down:Connect(function() tw(btn,.08,{BackgroundColor3=TH.AccentDark}) end)
            btn.MouseButton1Up:Connect(function()
                tw(btn,.14,{BackgroundColor3=TH.Accent})
                if c.Callback then task.spawn(pcall, c.Callback) end
            end)
            btn.TouchTap:Connect(function()
                tw(btn,.08,{BackgroundColor3=TH.AccentDark}); task.wait(.1)
                tw(btn,.14,{BackgroundColor3=TH.Accent})
                if c.Callback then task.spawn(pcall, c.Callback) end
            end)
        end

        -- ── Toggle ──
        --[[
            local t = TAB:Toggle({
                Label    = "Fly",
                Desc     = "Włącz latanie",
                Value    = false,
                Callback = function(v) end,
            })
            t:Set(true)
            print(t.Value)
        ]]
        function TAB:Toggle(c)
            c = c or {}
            local state = c.Value or false
            local hasDesc = c.Desc and c.Desc ~= ""

            local row = inst("Frame", {
                Size=UDim2.new(1,0,0,hasDesc and 50 or 40), BackgroundColor3=TH.Card,
                BorderSizePixel=0, ZIndex=13,
                LayoutOrder=no(self), Parent=self._sf,
            })
            corner(row,10); stroke(row, TH.Border, 1, 0.3)
            grad(row, TH.Card, TH.Panel, 90)

            inst("TextLabel", {
                Size=UDim2.new(1,-62,0,hasDesc and 20 or 40), Position=UDim2.new(0,14,0,hasDesc and 6 or 0),
                BackgroundTransparency=1, Text=c.Label or "Toggle",
                Font=Enum.Font.GothamBold, TextSize=13, TextColor3=TH.Text,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=14, Parent=row,
            })
            if hasDesc then
                inst("TextLabel", {
                    Size=UDim2.new(1,-62,0,16), Position=UDim2.new(0,14,0,28),
                    BackgroundTransparency=1, Text=c.Desc,
                    Font=Enum.Font.Gotham, TextSize=11, TextColor3=TH.TextSub,
                    TextXAlignment=Enum.TextXAlignment.Left, ZIndex=14, Parent=row,
                })
            end

            local track = inst("Frame", {
                Size=UDim2.new(0,40,0,22), Position=UDim2.new(1,-52,0.5,-11),
                BackgroundColor3=state and TH.Accent or TH.TogOff,
                BorderSizePixel=0, ZIndex=14, Parent=row,
            })
            corner(track, 999)
            local knob = inst("Frame", {
                Size=UDim2.new(0,16,0,16),
                Position=state and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8),
                BackgroundColor3=Color3.new(1,1,1), BorderSizePixel=0, ZIndex=15, Parent=track,
            })
            corner(knob,999)

            local OBJ={Value=state}
            local function set(v)
                state=v; OBJ.Value=v
                tw(track,.24,{BackgroundColor3=v and TH.Accent or TH.TogOff},Enum.EasingStyle.Back)
                tw(knob,.24,{Position=v and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8)},Enum.EasingStyle.Back)
                if c.Callback then task.spawn(pcall,c.Callback,v) end
            end
            OBJ.Set=function(_,v) set(v) end

            local ca=inst("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=16,Parent=row})
            ca.MouseButton1Click:Connect(function() set(not state) end)
            ca.TouchTap:Connect(function() set(not state) end)
            return OBJ
        end

        -- ── Slider ──
        --[[
            local s = TAB:Slider({
                Label    = "Speed",
                Desc     = "",
                Min      = 0,
                Max      = 100,
                Step     = 1,
                Value    = 50,
                Unit     = "%",
                Callback = function(v) end,
            })
            s:Set(75)
        ]]
        function TAB:Slider(c)
            c = c or {}
            local Min=c.Min or 0; local Max=c.Max or 100
            local step=c.Step or 1; local unit=c.Unit or ""
            local cur=math.clamp(c.Value or Min, Min, Max)
            local hasDesc = c.Desc and c.Desc ~= ""

            local container = inst("Frame", {
                Size=UDim2.new(1,0,0,hasDesc and 62 or 54), BackgroundColor3=TH.Card,
                BorderSizePixel=0, ZIndex=13,
                LayoutOrder=no(self), Parent=self._sf,
            })
            corner(container,10); stroke(container,TH.Border,1,0.3)
            grad(container,TH.Card,TH.Panel,90)

            inst("TextLabel", {
                Size=UDim2.new(0.62,0,0,hasDesc and 20 or 26), Position=UDim2.new(0,14,0,hasDesc and 6 or 4),
                BackgroundTransparency=1, Text=c.Label or "Slider",
                Font=Enum.Font.GothamBold, TextSize=13, TextColor3=TH.Text,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=14, Parent=container,
            })
            if hasDesc then
                inst("TextLabel", {
                    Size=UDim2.new(0.62,0,0,14), Position=UDim2.new(0,14,0,26),
                    BackgroundTransparency=1, Text=c.Desc,
                    Font=Enum.Font.Gotham, TextSize=11, TextColor3=TH.TextSub,
                    TextXAlignment=Enum.TextXAlignment.Left, ZIndex=14, Parent=container,
                })
            end

            local valLbl=inst("TextLabel", {
                Size=UDim2.new(0.38,-14,0,hasDesc and 20 or 26), Position=UDim2.new(0.62,0,0,hasDesc and 6 or 4),
                BackgroundTransparency=1, Text=tostring(cur)..unit,
                Font=Enum.Font.GothamBold, TextSize=12, TextColor3=TH.Accent,
                TextXAlignment=Enum.TextXAlignment.Right, ZIndex=14, Parent=container,
            })

            local trkBg=inst("Frame", {
                Size=UDim2.new(1,-28,0,6), Position=UDim2.new(0,14,0,hasDesc and 44 or 36),
                BackgroundColor3=TH.Border, BorderSizePixel=0, ZIndex=14, Parent=container,
            })
            corner(trkBg,999)
            local p0=(cur-Min)/(Max-Min)
            local fill=inst("Frame", {
                Size=UDim2.new(p0,0,1,0), BackgroundColor3=TH.Accent,
                BorderSizePixel=0, ZIndex=15, Parent=trkBg,
            })
            corner(fill,999)
            grad(fill, TH.AccentB, TH.Accent, 90)
            local knob=inst("Frame", {
                Size=UDim2.new(0,14,0,14), AnchorPoint=Vector2.new(0.5,0.5),
                Position=UDim2.new(p0,0,0.5,0), BackgroundColor3=Color3.new(1,1,1),
                BorderSizePixel=0, ZIndex=16, Parent=trkBg,
            })
            corner(knob,999); stroke(knob,TH.Accent,2)

            local OBJ={Value=cur}
            local sliding=false
            local function sv(v)
                v=math.clamp(math.round(v/step)*step,Min,Max)
                cur=v; OBJ.Value=v
                local p=(v-Min)/(Max-Min)
                valLbl.Text=tostring(v)..unit
                fill.Size=UDim2.new(p,0,1,0)
                knob.Position=UDim2.new(p,0,0.5,0)
                if c.Callback then task.spawn(pcall,c.Callback,v) end
            end
            OBJ.Set=function(_,v) sv(v) end

            local function sx(x)
                local p=math.clamp((x-trkBg.AbsolutePosition.X)/trkBg.AbsoluteSize.X,0,1)
                sv(Min+(Max-Min)*p)
            end
            trkBg.InputBegan:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    sliding=true; sx(i.Position.X)
                end
            end)
            UserInputService.InputChanged:Connect(function(i)
                if sliding and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                    sx(i.Position.X)
                end
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    sliding=false
                end
            end)
            return OBJ
        end

        -- ── Dropdown ──
        --[[
            local d = TAB:Dropdown({
                Label    = "Wybierz",
                Desc     = "",
                Options  = {"A","B","C"},
                Selected = "A",
                Callback = function(v) end,
            })
            d:Set("B"); d:Reload({"X","Y"})
        ]]
        function TAB:Dropdown(c)
            c = c or {}
            local opts=c.Options or {}
            local sel=c.Selected or opts[1] or ""
            local open=false

            local container=inst("Frame", {
                Size=UDim2.new(1,0,0,40), BackgroundColor3=TH.Card,
                BorderSizePixel=0, ClipsDescendants=false, ZIndex=13,
                LayoutOrder=no(self), Parent=self._sf,
            })
            corner(container,10); stroke(container,TH.Border,1,0.3)
            grad(container,TH.Card,TH.Panel,90)

            local hdr=inst("TextButton", {
                Size=UDim2.new(1,0,0,40), BackgroundTransparency=1,
                BorderSizePixel=0, Text="", ZIndex=14,
                AutoButtonColor=false, Parent=container,
            })
            inst("TextLabel", {
                Size=UDim2.new(0.52,0,1,0), Position=UDim2.new(0,14,0,0),
                BackgroundTransparency=1, Text=c.Label or "Dropdown",
                Font=Enum.Font.Gotham, TextSize=13, TextColor3=TH.TextSub,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=15, Parent=hdr,
            })
            local vLbl=inst("TextLabel", {
                Size=UDim2.new(0.44,0,1,0), Position=UDim2.new(0.52,0,0,0),
                BackgroundTransparency=1, Text=sel,
                Font=Enum.Font.GothamBold, TextSize=12, TextColor3=TH.Text,
                TextXAlignment=Enum.TextXAlignment.Right, ZIndex=15, Parent=hdr,
            })
            local arrLbl=inst("TextLabel", {
                Size=UDim2.new(0,22,1,0), Position=UDim2.new(1,-26,0,0),
                BackgroundTransparency=1, Text="▾", TextSize=12,
                Font=Enum.Font.GothamBold, TextColor3=TH.TextSub, ZIndex=15, Parent=hdr,
            })

            local dList=inst("Frame", {
                Size=UDim2.new(1,0,0,0), Position=UDim2.new(0,0,1,4),
                BackgroundColor3=TH.Panel, BorderSizePixel=0,
                ClipsDescendants=true, Visible=false, ZIndex=50, Parent=container,
            })
            corner(dList,10); stroke(dList,TH.Border,1)
            list(dList,0)

            local OBJ={Value=sel}

            local function build()
                for _,ch in ipairs(dList:GetChildren()) do
                    if ch:IsA("TextButton") then ch:Destroy() end
                end
                for i,op in ipairs(opts) do
                    local isSel=op==sel
                    local ob=inst("TextButton", {
                        Size=UDim2.new(1,0,0,32),
                        BackgroundColor3=isSel and TH.Accent or TH.Panel,
                        BackgroundTransparency=isSel and 0.3 or 1,
                        BorderSizePixel=0, Text="", ZIndex=51,
                        AutoButtonColor=false, LayoutOrder=i, Parent=dList,
                    })
                    inst("TextLabel", {
                        Size=UDim2.new(1,-20,1,0), Position=UDim2.new(0,12,0,0),
                        BackgroundTransparency=1, Text=op,
                        Font=Enum.Font.Gotham, TextSize=12,
                        TextColor3=isSel and TH.Text or TH.TextSub,
                        TextXAlignment=Enum.TextXAlignment.Left, ZIndex=52, Parent=ob,
                    })
                    ob.MouseEnter:Connect(function()
                        if not isSel then tw(ob,.12,{BackgroundTransparency=0.5,BackgroundColor3=TH.Accent}) end
                    end)
                    ob.MouseLeave:Connect(function()
                        if not isSel then tw(ob,.12,{BackgroundTransparency=1}) end
                    end)
                    local function pick()
                        sel=op; OBJ.Value=op; vLbl.Text=op
                        open=false
                        tw(dList,.18,{Size=UDim2.new(1,0,0,0)})
                        tw(arrLbl,.18,{Rotation=0})
                        task.delay(.2,function() dList.Visible=false end)
                        build()
                        if c.Callback then task.spawn(pcall,c.Callback,op) end
                    end
                    ob.MouseButton1Click:Connect(pick); ob.TouchTap:Connect(pick)
                end
            end
            build()

            local function toggle()
                open=not open
                if open then
                    dList.Visible=true
                    tw(dList,.22,{Size=UDim2.new(1,0,0,#opts*32)},Enum.EasingStyle.Back,Enum.EasingDirection.Out)
                    tw(arrLbl,.18,{Rotation=180})
                else
                    tw(dList,.18,{Size=UDim2.new(1,0,0,0)})
                    tw(arrLbl,.18,{Rotation=0})
                    task.delay(.2,function() dList.Visible=false end)
                end
            end
            hdr.MouseButton1Click:Connect(toggle); hdr.TouchTap:Connect(toggle)
            OBJ.Set=function(_,v) sel=v;OBJ.Value=v;vLbl.Text=v;build() end
            OBJ.Reload=function(_,newOpts) opts=newOpts;sel=newOpts[1] or "";OBJ.Value=sel;vLbl.Text=sel;build() end
            return OBJ
        end

        -- ── TextInput ──
        --[[
            local i = TAB:Input({
                Label   = "Pole",
                Hint    = "Wpisz...",
                Default = "",
                Callback = function(txt) end,
            })
        ]]
        function TAB:Input(c)
            c = c or {}
            local cont=inst("Frame", {
                Size=UDim2.new(1,0,0,54), BackgroundColor3=TH.Card,
                BorderSizePixel=0, ZIndex=13,
                LayoutOrder=no(self), Parent=self._sf,
            })
            corner(cont,10); stroke(cont,TH.Border,1,0.3)
            grad(cont,TH.Card,TH.Panel,90)

            inst("TextLabel", {
                Size=UDim2.new(1,-14,0,20), Position=UDim2.new(0,14,0,4),
                BackgroundTransparency=1, Text=c.Label or "Input",
                Font=Enum.Font.Gotham, TextSize=12, TextColor3=TH.TextSub,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=14, Parent=cont,
            })
            local iWrap=inst("Frame", {
                Size=UDim2.new(1,-28,0,22), Position=UDim2.new(0,14,0,28),
                BackgroundColor3=TH.Win, BorderSizePixel=0, ZIndex=14, Parent=cont,
            })
            corner(iWrap,6)
            local iS=stroke(iWrap,TH.Border,1)
            local tb=inst("TextBox", {
                Size=UDim2.new(1,-16,1,0), Position=UDim2.new(0,8,0,0),
                BackgroundTransparency=1, Text=c.Default or "",
                PlaceholderText=c.Hint or "Wpisz...",
                PlaceholderColor3=TH.TextMuted,
                Font=Enum.Font.Gotham, TextSize=12, TextColor3=TH.Text,
                TextXAlignment=Enum.TextXAlignment.Left,
                ClearTextOnFocus=false, ZIndex=15, Parent=iWrap,
            })
            tb.Focused:Connect(function() tw(iS,.18,{Color=TH.Accent}) end)
            tb.FocusLost:Connect(function()
                tw(iS,.18,{Color=TH.Border})
                if c.Callback then task.spawn(pcall,c.Callback,tb.Text) end
            end)
            local OBJ={Value=tb.Text}
            OBJ.Set=function(_,v) tb.Text=v;OBJ.Value=v end
            tb:GetPropertyChangedSignal("Text"):Connect(function() OBJ.Value=tb.Text end)
            return OBJ
        end

        -- ── Keybind ──
        --[[
            local k = TAB:Keybind({
                Label    = "Sprint",
                Default  = "LeftShift",
                Callback = function(key) end,
            })
        ]]
        function TAB:Keybind(c)
            c = c or {}
            local curKey=Enum.KeyCode[c.Default or "Unknown"] or Enum.KeyCode.Unknown
            local listening=false

            local row=inst("Frame", {
                Size=UDim2.new(1,0,0,40), BackgroundColor3=TH.Card,
                BorderSizePixel=0, ZIndex=13,
                LayoutOrder=no(self), Parent=self._sf,
            })
            corner(row,10); stroke(row,TH.Border,1,0.3)
            grad(row,TH.Card,TH.Panel,90)

            inst("TextLabel", {
                Size=UDim2.new(0.6,0,1,0), Position=UDim2.new(0,14,0,0),
                BackgroundTransparency=1, Text=c.Label or "Keybind",
                Font=Enum.Font.Gotham, TextSize=13, TextColor3=TH.Text,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=14, Parent=row,
            })
            local kbtn=inst("TextButton", {
                Size=UDim2.new(0,74,0,24), Position=UDim2.new(1,-84,0.5,-12),
                BackgroundColor3=TH.Panel, BorderSizePixel=0,
                Text=curKey.Name, Font=Enum.Font.GothamBold, TextSize=11,
                TextColor3=TH.Accent, ZIndex=14, AutoButtonColor=false, Parent=row,
            })
            corner(kbtn,7); stroke(kbtn,TH.Accent,1,0.3)

            local OBJ={Value=curKey}
            OBJ.Set=function(_,k2) curKey=k2;OBJ.Value=k2;kbtn.Text=k2.Name end

            kbtn.MouseButton1Click:Connect(function()
                if listening then return end
                listening=true; kbtn.Text="..."
                tw(kbtn,.15,{BackgroundColor3=TH.Accent,TextColor3=Color3.new(1,1,1)})
            end)
            UserInputService.InputBegan:Connect(function(i,gpe)
                if not listening then return end
                if i.UserInputType==Enum.UserInputType.Keyboard then
                    listening=false; curKey=i.KeyCode; OBJ.Value=i.KeyCode; kbtn.Text=i.KeyCode.Name
                    tw(kbtn,.15,{BackgroundColor3=TH.Panel,TextColor3=TH.Accent})
                    if c.Callback then task.spawn(pcall,c.Callback,i.KeyCode) end
                end
            end)
            return OBJ
        end

        -- ── Label ──
        function TAB:Label(txt)
            inst("TextLabel", {
                Size=UDim2.new(1,0,0,22), BackgroundTransparency=1,
                Text=txt or "", Font=Enum.Font.Gotham, TextSize=12,
                TextColor3=TH.TextSub, TextXAlignment=Enum.TextXAlignment.Left,
                TextWrapped=true, ZIndex=13,
                LayoutOrder=no(self), Parent=self._sf,
            })
        end

        -- ── Paragraph ──
        --[[
            TAB:Paragraph({ Title="T", Body="treść" })
        ]]
        function TAB:Paragraph(c)
            c = c or {}
            local box=inst("Frame", {
                Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y,
                BackgroundColor3=TH.Card, BorderSizePixel=0, ZIndex=13,
                LayoutOrder=no(self), Parent=self._sf,
            })
            corner(box,10); stroke(box,TH.Border,1,0.3)
            local bList=list(box,4)
            pad(box,10,10,14,14)
            inst("TextLabel", {
                Size=UDim2.new(1,0,0,18), BackgroundTransparency=1,
                Text=c.Title or "", Font=Enum.Font.GothamBold, TextSize=13,
                TextColor3=TH.Text, TextXAlignment=Enum.TextXAlignment.Left,
                ZIndex=14, LayoutOrder=1, Parent=box,
            })
            inst("TextLabel", {
                Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y,
                BackgroundTransparency=1, Text=c.Body or "",
                Font=Enum.Font.Gotham, TextSize=12, TextColor3=TH.TextSub,
                TextXAlignment=Enum.TextXAlignment.Left, TextWrapped=true,
                ZIndex=14, LayoutOrder=2, Parent=box,
            })
        end

        -- ── Divider ──
        function TAB:Divider()
            inst("Frame", {
                Size=UDim2.new(1,0,0,1), BackgroundColor3=TH.Border,
                BorderSizePixel=0, ZIndex=13,
                LayoutOrder=no(self), Parent=self._sf,
            })
        end

        return TAB
    end

    return WIN
end

-- ══════════════════════════════════════════════════════════
-- NOTIFY
-- ══════════════════════════════════════════════════════════
--[[
    E404.Notify({
        Title    = "Tytuł",
        Message  = "Treść",
        Duration = 4,
        Type     = "ok" | "fail" | "warn" | "info"
    })
]]
function E404.Notify(cfg)
    cfg = cfg or {}
    local map = {
        ok   = {TH.Green,  "✓"},
        fail = {TH.Red,    "✕"},
        warn = {TH.Yellow, "⚠"},
        info = {TH.Accent, "ℹ"},
    }
    local tp     = cfg.Type or "info"
    local accent = map[tp] and map[tp][1] or TH.Accent
    local icon   = map[tp] and map[tp][2] or "ℹ"

    local sg
    pcall(function()
        for _,v in ipairs(CoreGui:GetChildren()) do
            if v.Name=="E404_Notifs" then sg=v; break end
        end
    end)
    if not sg then sg=makeSG("E404_Notifs", 9998) end

    local holder=sg:FindFirstChild("NH")
    if not holder then
        holder=inst("Frame",{
            Name="NH", Size=UDim2.new(0,288,1,-16),
            Position=UDim2.new(1,-304,0,8),
            BackgroundTransparency=1, BorderSizePixel=0,
            ZIndex=100, Parent=sg,
        })
        local hl=list(holder,8)
        hl.VerticalAlignment=Enum.VerticalAlignment.Bottom
    end

    local card=inst("Frame",{
        Size=UDim2.new(1,0,0,72), BackgroundColor3=TH.Panel,
        BackgroundTransparency=1, BorderSizePixel=0,
        ZIndex=101, Parent=holder,
    })
    corner(card,11)
    stroke(card, accent, 1, 0.45)

    -- Bar boczny
    inst("Frame",{
        Size=UDim2.new(0,3,1,-4), Position=UDim2.new(0,0,0,2),
        BackgroundColor3=accent, BorderSizePixel=0, ZIndex=102, Parent=card,
    })

    local ico=inst("TextLabel",{
        Size=UDim2.new(0,30,0,30), Position=UDim2.new(0,12,0.5,-15),
        BackgroundColor3=accent, BackgroundTransparency=0.82,
        Text=icon, Font=Enum.Font.GothamBold, TextSize=14,
        TextColor3=accent, ZIndex=102, Parent=card,
    })
    corner(ico,8)

    inst("TextLabel",{
        Size=UDim2.new(1,-58,0,22), Position=UDim2.new(0,50,0,10),
        BackgroundTransparency=1, Text=cfg.Title or "Info",
        Font=Enum.Font.GothamBold, TextSize=13, TextColor3=TH.Text,
        TextXAlignment=Enum.TextXAlignment.Left, ZIndex=102, Parent=card,
    })
    inst("TextLabel",{
        Size=UDim2.new(1,-58,0,26), Position=UDim2.new(0,50,0,32),
        BackgroundTransparency=1, Text=cfg.Message or "",
        Font=Enum.Font.Gotham, TextSize=11, TextColor3=TH.TextSub,
        TextXAlignment=Enum.TextXAlignment.Left, TextWrapped=true,
        ZIndex=102, Parent=card,
    })

    local pg=inst("Frame",{Size=UDim2.new(1,0,0,2),Position=UDim2.new(0,0,1,-2),BackgroundColor3=TH.Border,BorderSizePixel=0,ZIndex=102,Parent=card})
    local pf=inst("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=accent,BorderSizePixel=0,ZIndex=103,Parent=pg})

    tw(card,.42,{BackgroundTransparency=0},Enum.EasingStyle.Back,Enum.EasingDirection.Out)
    local dur=cfg.Duration or 4
    tw(pf,dur,{Size=UDim2.new(0,0,1,0)},Enum.EasingStyle.Linear)
    task.delay(dur,function()
        tw(card,.3,{BackgroundTransparency=1})
        task.delay(.35,function() card:Destroy() end)
    end)
end

-- ══════════════════════════════════════════════════════════
-- WEJŚCIE  (intro → open)
-- ══════════════════════════════════════════════════════════
local _origWindow = E404.Window
function E404.Window(cfg)
    cfg = cfg or {}
    if cfg.Intro == false then
        local w = _origWindow(cfg)
        task.delay(0.1, function() w:Open() end)
        return w
    end

    local ready = false
    local wRef  = nil

    task.spawn(function()
        runIntro(function()
            wRef = _origWindow(cfg)
            task.delay(0.2, function()
                wRef:Open()
                ready = true
            end)
        end)
    end)

    return setmetatable({}, {
        __index = function(_, k)
            return function(self, ...)
                local t0=tick()
                while not ready and tick()-t0<25 do task.wait(0.05) end
                if wRef and type(wRef[k])=="function" then
                    return wRef[k](wRef, ...)
                end
            end
        end,
    })
end

return E404
