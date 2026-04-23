--[[
    ╔══════════════════════════════════════════════════════╗
    ║           ERROR 404 UI LIBRARY  v5.0                 ║
    ║    Gwarantowane działanie na każdym executorze       ║
    ║    PC + Mobile | Intro | Wszystkie elementy          ║
    ╚══════════════════════════════════════════════════════╝

    UŻYCIE:
        local UI = loadstring(game:HttpGet("URL"))()
        local Win = UI.new("Tytuł", "v1.0")
        local Tab = Win:Tab("Gracz", "👤")
        Tab:Button("Kliknij", function() print("ok") end)
        Win:Show()   -- otwiera okno
]]

-- ═══════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players          = game:GetService("Players")
local CoreGui          = game:GetService("CoreGui")

local LP     = Players.LocalPlayer
local MOBILE = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- ═══════════════════════════════════════════
-- KOLORY
-- ═══════════════════════════════════════════
local C = {
    BG      = Color3.fromRGB(13, 13, 22),
    PANEL   = Color3.fromRGB(20, 20, 34),
    CARD    = Color3.fromRGB(26, 26, 42),
    CARD2   = Color3.fromRGB(32, 32, 52),
    ACC     = Color3.fromRGB(139, 92, 246),
    ACC2    = Color3.fromRGB(109, 62, 216),
    BORDER  = Color3.fromRGB(50, 44, 82),
    BORDER2 = Color3.fromRGB(72, 64, 110),
    TXT     = Color3.fromRGB(225, 230, 245),
    TXT2    = Color3.fromRGB(148, 158, 180),
    TXT3    = Color3.fromRGB(95, 105, 125),
    GREEN   = Color3.fromRGB(34, 197, 94),
    RED     = Color3.fromRGB(239, 68, 68),
    ORANGE  = Color3.fromRGB(249, 115, 22),
    TOG_OFF = Color3.fromRGB(50, 45, 75),
}

-- ═══════════════════════════════════════════
-- HELPERY
-- ═══════════════════════════════════════════
local function N(cls, p) -- New Instance
    local o = Instance.new(cls)
    for k,v in pairs(p or {}) do
        if k ~= "_" then
            pcall(function() o[k] = v end)
        end
    end
    if p and p._ then o.Parent = p._ end
    return o
end

local function TW(obj, t, props, es, ed)
    pcall(function()
        TweenService:Create(obj,
            TweenInfo.new(t, es or Enum.EasingStyle.Quint, ed or Enum.EasingDirection.Out),
            props):Play()
    end)
end

local function Rnd(parent, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = parent
end

local function Str(parent, col, thick, transp)
    local s = Instance.new("UIStroke")
    s.Color = col or C.BORDER
    s.Thickness = thick or 1
    s.Transparency = transp or 0
    s.Parent = parent
    return s
end

local function SG(name, order) -- ScreenGui safe
    local sg
    pcall(function()
        sg = N("ScreenGui", {
            Name = name,
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            IgnoreGuiInset = true,
            DisplayOrder = order or 100,
            _ = CoreGui
        })
    end)
    if not sg then
        sg = N("ScreenGui", {
            Name = name,
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            IgnoreGuiInset = true,
            _ = LP:WaitForChild("PlayerGui")
        })
    end
    return sg
end

-- ═══════════════════════════════════════════
-- INTRO (osobna funkcja, nie blokuje)
-- ═══════════════════════════════════════════
local function RunIntro(onDone)
    task.spawn(function()
        local sg = SG("E404_Intro", 9999)

        local function Word(txt, col, glow)
            local f = N("Frame",{
                Size=UDim2.new(0,760,0,125),
                AnchorPoint=Vector2.new(0.5,0.5),
                BackgroundTransparency=1,
                ZIndex=500, _=sg
            })
            N("TextLabel",{
                Size=UDim2.new(1,14,1,14),
                Position=UDim2.new(0,-7,0,-7),
                BackgroundTransparency=1,
                Text=txt, Font=Enum.Font.GothamBold,
                TextSize=86, TextColor3=glow,
                TextTransparency=0.62, ZIndex=500, _=f
            })
            local lbl = N("TextLabel",{
                Size=UDim2.new(1,0,1,0),
                BackgroundTransparency=1,
                Text=txt, Font=Enum.Font.GothamBold,
                TextSize=86, TextColor3=col,
                TextTransparency=0, ZIndex=501, _=f
            })
            Str(lbl, glow, 2.5, 0.22)
            return f, lbl
        end

        local function Pulse(lbl, n)
            for _=1,n do
                TW(lbl,.2,{TextTransparency=0.48},Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
                task.wait(.2)
                TW(lbl,.2,{TextTransparency=0},Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
                task.wait(.2)
            end
        end

        local tIn  = TweenInfo.new(0.58, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local tOut = TweenInfo.new(0.44, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        local ctr  = UDim2.new(0.5,0,0.5,0)

        local c1,l1 = Word("ERROR", Color3.fromRGB(192,90,255), Color3.fromRGB(148,0,255))
        c1.Position = UDim2.new(-0.65,0,0.5,0)
        TweenService:Create(c1,tIn,{Position=ctr}):Play()
        task.wait(0.62); task.spawn(Pulse,l1,4); task.wait(2)
        TweenService:Create(c1,tOut,{Position=UDim2.new(1.65,0,0.5,0)}):Play()
        task.wait(0.5); c1:Destroy(); task.wait(0.1)

        local c2,l2 = Word("404", Color3.fromRGB(255,55,125), Color3.fromRGB(255,0,75))
        c2.Position = UDim2.new(1.65,0,0.5,0)
        TweenService:Create(c2,tIn,{Position=ctr}):Play()
        task.wait(0.62); task.spawn(Pulse,l2,4); task.wait(2)
        TweenService:Create(c2,tOut,{Position=UDim2.new(-0.65,0,0.5,0)}):Play()
        task.wait(0.5); c2:Destroy(); task.wait(0.2)

        pcall(function() sg:Destroy() end)
        if onDone then onDone() end
    end)
end

-- ═══════════════════════════════════════════════════════════════════
-- POWIADOMIENIA
-- ═══════════════════════════════════════════════════════════════════
local NotifSG = nil

local function GetNotifSG()
    if NotifSG and NotifSG.Parent then return NotifSG end
    NotifSG = SG("E404_Notifs", 9998)
    local holder = N("Frame",{
        Name="Holder",
        Size=UDim2.new(0,288,1,-20),
        Position=UDim2.new(1,-302,0,10),
        BackgroundTransparency=1,
        ZIndex=100, _=NotifSG
    })
    local lay = Instance.new("UIListLayout")
    lay.SortOrder = Enum.SortOrder.LayoutOrder
    lay.VerticalAlignment = Enum.VerticalAlignment.Bottom
    lay.Padding = UDim.new(0,8)
    lay.Parent = holder
    return NotifSG
end

--[[
    Notify({
        Title    = "...",
        Content  = "...",
        Duration = 4,
        Type     = "Success" | "Error" | "Warning" | "Info"
    })
]]
local function Notify(cfg)
    cfg = cfg or {}
    local sg = GetNotifSG()
    local holder = sg:FindFirstChild("Holder")
    if not holder then return end

    local tc = {
        Success = {C.GREEN, "✓"},
        Error   = {C.RED,   "✕"},
        Warning = {C.ORANGE,"⚠"},
        Info    = {C.ACC,   "ℹ"},
    }
    local tp   = cfg.Type or "Info"
    local col  = (tc[tp] or tc.Info)[1]
    local ico  = (tc[tp] or tc.Info)[2]
    local dur  = cfg.Duration or 4

    -- Karta
    local card = N("Frame",{
        Size=UDim2.new(1,0,0,70),
        BackgroundColor3=C.CARD,
        BackgroundTransparency=0.05,
        ZIndex=101, _=holder
    })
    Rnd(card, 10)
    Str(card, col, 1, 0.5)

    -- Pasek boczny
    N("Frame",{
        Size=UDim2.new(0,3,1,-4),
        Position=UDim2.new(0,0,0,2),
        BackgroundColor3=col, ZIndex=102, _=card
    })

    -- Ikona
    local icoF = N("Frame",{
        Size=UDim2.new(0,30,0,30),
        Position=UDim2.new(0,12,0.5,-15),
        BackgroundColor3=col, BackgroundTransparency=0.82,
        ZIndex=102, _=card
    })
    Rnd(icoF, 8)
    N("TextLabel",{
        Size=UDim2.new(1,0,1,0),
        BackgroundTransparency=1,
        Text=ico, Font=Enum.Font.GothamBold,
        TextSize=14, TextColor3=col,
        ZIndex=103, _=icoF
    })

    N("TextLabel",{
        Size=UDim2.new(1,-58,0,22),
        Position=UDim2.new(0,50,0,10),
        BackgroundTransparency=1,
        Text=cfg.Title or "Info",
        Font=Enum.Font.GothamBold,
        TextSize=13, TextColor3=C.TXT,
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=102, _=card
    })
    N("TextLabel",{
        Size=UDim2.new(1,-58,0,26),
        Position=UDim2.new(0,50,0,32),
        BackgroundTransparency=1,
        Text=cfg.Content or "",
        Font=Enum.Font.Gotham,
        TextSize=11, TextColor3=C.TXT2,
        TextXAlignment=Enum.TextXAlignment.Left,
        TextWrapped=true, ZIndex=102, _=card
    })

    -- Progress
    local pgBg = N("Frame",{Size=UDim2.new(1,0,0,2),Position=UDim2.new(0,0,1,-2),BackgroundColor3=C.BORDER,ZIndex=102,_=card})
    local pgFill = N("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=col,ZIndex=103,_=pgBg})

    TW(pgFill, dur, {Size=UDim2.new(0,0,1,0)}, Enum.EasingStyle.Linear)
    task.delay(dur, function()
        TW(card, 0.3, {BackgroundTransparency=1})
        task.delay(0.35, function() pcall(function() card:Destroy() end) end)
    end)
end

-- ═══════════════════════════════════════════════════════════════════
-- GŁÓWNA FUNKCJA: UI.new
-- ═══════════════════════════════════════════════════════════════════
--[[
    local Win = UI.new(title, version, key, showIntro)
    
    Win:Tab(name, icon)   → TabObject
    Win:Show()            → otwiera okno
    Win:Hide()            → zamyka okno
    Win:Toggle()          → przełącza
    Win.Notify(cfg)       → powiadomienie (alias)
]]

local UI = {}
UI.Notify = Notify  -- globalny alias

function UI.new(title, version, key, showIntro)
    title     = title or "ERROR 404 UI"
    version   = version or "v5.0"
    key       = key or Enum.KeyCode.Insert
    if showIntro == nil then showIntro = true end

    local W = MOBILE and 318 or 345
    local H = MOBILE and 530 or 555

    -- ─────────────────────────────────────────
    -- SCREENGUI
    -- ─────────────────────────────────────────
    local sg = SG("E404_Main", 100)

    -- ─────────────────────────────────────────
    -- GŁÓWNA RAMKA
    -- ─────────────────────────────────────────
    local frame = N("Frame",{
        Name="E404Frame",
        Size=UDim2.new(0,W,0,H),
        AnchorPoint=Vector2.new(0,0.5),
        Position=UDim2.new(-0.6,0,0.5,0),
        BackgroundColor3=C.BG,
        BorderSizePixel=0,
        Visible=false, ZIndex=10, _=sg
    })
    Rnd(frame, 14)
    local fBorder = Str(frame, C.BORDER, 1.5)

    -- Shadow
    N("ImageLabel",{
        AnchorPoint=Vector2.new(0.5,0.5),
        Position=UDim2.new(0.5,0,0.5,8),
        Size=UDim2.new(1,60,1,60),
        BackgroundTransparency=1,
        Image="rbxassetid://5028857084",
        ImageColor3=Color3.new(0,0,0),
        ImageTransparency=0.65,
        ScaleType=Enum.ScaleType.Slice,
        SliceCenter=Rect.new(24,24,276,276),
        ZIndex=9, _=frame
    })

    -- ─────────────────────────────────────────
    -- TITLEBAR
    -- ─────────────────────────────────────────
    local titlebar = N("Frame",{
        Size=UDim2.new(1,0,0,46),
        BackgroundColor3=C.PANEL,
        BorderSizePixel=0,
        ZIndex=11, _=frame
    })
    Rnd(titlebar, 14)
    -- fix bottom corners
    N("Frame",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,1,-14),BackgroundColor3=C.PANEL,ZIndex=11,_=titlebar})
    -- bottom line
    N("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=C.BORDER,ZIndex=12,_=titlebar})

    -- Logo box
    local logoF = N("Frame",{
        Size=UDim2.new(0,26,0,26),
        Position=UDim2.new(0,12,0.5,-13),
        BackgroundColor3=C.ACC, ZIndex=12, _=titlebar
    })
    Rnd(logoF, 7)
    N("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="⚡",TextSize=14,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),ZIndex=13,_=logoF})

    -- Title
    N("TextLabel",{
        Size=UDim2.new(1,-120,1,0),
        Position=UDim2.new(0,46,0,0),
        BackgroundTransparency=1,
        Text=title,
        Font=Enum.Font.GothamBold,
        TextSize=14, TextColor3=C.TXT,
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=12, _=titlebar
    })

    -- Version badge
    local vbadge = N("TextLabel",{
        Size=UDim2.new(0,0,0,15),
        Position=UDim2.new(0,46,1,-20),
        BackgroundColor3=C.ACC,
        BackgroundTransparency=0.86,
        Text="  "..version.."  ",
        Font=Enum.Font.GothamBold,
        TextSize=9, TextColor3=C.ACC,
        AutomaticSize=Enum.AutomaticSize.X,
        ZIndex=12, _=titlebar
    })
    Rnd(vbadge,4)
    Str(vbadge, C.ACC, 1, 0.72)

    -- Close
    local closeB = N("TextButton",{
        Size=UDim2.new(0,26,0,26),
        Position=UDim2.new(1,-38,0.5,-13),
        BackgroundColor3=C.CARD,
        BorderSizePixel=0,
        Text="✕", Font=Enum.Font.GothamBold,
        TextSize=12, TextColor3=C.TXT2,
        ZIndex=13, AutoButtonColor=false, _=titlebar
    })
    Rnd(closeB,7)
    Str(closeB, C.BORDER, 1)

    -- ─────────────────────────────────────────
    -- TABS BAR
    -- ─────────────────────────────────────────
    local tabsBar = N("Frame",{
        Size=UDim2.new(1,0,0,34),
        Position=UDim2.new(0,0,0,46),
        BackgroundColor3=C.PANEL,
        ZIndex=11, _=frame
    })
    N("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=C.BORDER,ZIndex=12,_=tabsBar})

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0,2)
    tabLayout.Parent = tabsBar
    local tabPad = Instance.new("UIPadding")
    tabPad.PaddingLeft = UDim.new(0,10)
    tabPad.PaddingTop  = UDim.new(0,6)
    tabPad.Parent = tabsBar

    -- ─────────────────────────────────────────
    -- CONTENT HOLDER
    -- ─────────────────────────────────────────
    local contentHolder = N("Frame",{
        Size=UDim2.new(1,0,1,-80),
        Position=UDim2.new(0,0,0,80),
        BackgroundTransparency=1,
        ClipsDescendants=true,
        ZIndex=11, _=frame
    })

    -- ─────────────────────────────────────────
    -- DRAG
    -- ─────────────────────────────────────────
    do
        local drag, ds, dp
        titlebar.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                drag=true; ds=i.Position; dp=frame.Position
            end
        end)
        titlebar.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end
        end)
        UserInputService.InputChanged:Connect(function(i)
            if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                local d=i.Position-ds
                frame.Position=UDim2.new(dp.X.Scale,dp.X.Offset+d.X,dp.Y.Scale,dp.Y.Offset+d.Y)
            end
        end)
    end

    -- ─────────────────────────────────────────
    -- OPEN / CLOSE / TOGGLE
    -- ─────────────────────────────────────────
    local isOpen = false
    local oPos = MOBILE and UDim2.new(0.5,-W/2,0.5,0) or UDim2.new(0,18,0.5,0)
    local cPos = UDim2.new(-0.6,0,0.5,0)

    local Win = {}
    Win.Notify = Notify

    function Win:Show()
        if isOpen then return end
        isOpen = true
        frame.Visible = true
        frame.Position = cPos
        frame.BackgroundTransparency = 1
        fBorder.Transparency = 1
        TW(frame,.52,{Position=oPos,BackgroundTransparency=0},Enum.EasingStyle.Back,Enum.EasingDirection.Out)
        TW(fBorder,.38,{Transparency=0})
    end

    function Win:Hide()
        if not isOpen then return end
        isOpen = false
        TW(frame,.36,{Position=cPos,BackgroundTransparency=1})
        TW(fBorder,.28,{Transparency=1})
        task.delay(.4,function() if not isOpen then frame.Visible=false end end)
    end

    function Win:Toggle()
        if isOpen then self:Hide() else self:Show() end
    end

    function Win:Destroy()
        pcall(function() sg:Destroy() end)
    end

    closeB.MouseButton1Click:Connect(function() Win:Hide() end)
    closeB.TouchTap:Connect(function() Win:Hide() end)
    closeB.MouseEnter:Connect(function() TW(closeB,.15,{BackgroundColor3=C.RED,TextColor3=Color3.new(1,1,1)}) end)
    closeB.MouseLeave:Connect(function() TW(closeB,.15,{BackgroundColor3=C.CARD,TextColor3=C.TXT2}) end)

    -- ─────────────────────────────────────────
    -- TOGGLE BUTTON (mobile/desktop)
    -- ─────────────────────────────────────────
    if MOBILE then
        local mb = N("TextButton",{
            Size=UDim2.new(0,54,0,54),
            Position=UDim2.new(0,14,1,-70),
            AnchorPoint=Vector2.new(0,1),
            BackgroundColor3=C.ACC, BorderSizePixel=0,
            Text="⚡", TextSize=22,
            Font=Enum.Font.GothamBold,
            TextColor3=Color3.new(1,1,1),
            ZIndex=200, AutoButtonColor=false, _=sg
        })
        Rnd(mb,14)
        local ms = Str(mb, C.ACC, 2)
        task.spawn(function()
            while mb.Parent do
                TW(ms,1.2,{Transparency=0.8},Enum.EasingStyle.Sine,Enum.EasingDirection.InOut); task.wait(1.2)
                TW(ms,1.2,{Transparency=0},Enum.EasingStyle.Sine,Enum.EasingDirection.InOut); task.wait(1.2)
            end
        end)
        mb.TouchTap:Connect(function() Win:Toggle() end)
        mb.MouseButton1Click:Connect(function() Win:Toggle() end)
    else
        local hint = N("Frame",{
            Size=UDim2.new(0,205,0,28),
            Position=UDim2.new(0,10,1,-44),
            AnchorPoint=Vector2.new(0,1),
            BackgroundColor3=C.PANEL,
            BackgroundTransparency=0.1,
            ZIndex=5, _=sg
        })
        Rnd(hint,8); local hs=Str(hint,C.BORDER,1)
        local hl=N("TextLabel",{
            Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
            Text="[ "..key.Name:upper().." ]  Otwórz / Zamknij",
            Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.TXT2,ZIndex=6,_=hint
        })
        task.delay(7,function()
            TW(hint,1.5,{BackgroundTransparency=1})
            TW(hl,1.5,{TextTransparency=1})
            TW(hs,1.5,{Transparency=1})
        end)
        UserInputService.InputBegan:Connect(function(i,gp)
            if gp then return end
            if i.KeyCode==key then Win:Toggle() end
        end)
    end

    -- ─────────────────────────────────────────
    -- TAB SYSTEM
    -- ─────────────────────────────────────────
    local tabCount  = 0
    local allTabs   = {}  -- {btn, scroll, underline, label}
    local activeIdx = 0

    local function SwitchTab(idx)
        activeIdx = idx
        for i, t in ipairs(allTabs) do
            t.scroll.Visible = (i == idx)
            TW(t.underline,.15,{BackgroundTransparency = i==idx and 0 or 1})
            TW(t.label,.15,{TextColor3 = i==idx and C.ACC or C.TXT3})
        end
    end

    -- ═══════════════════════════════════════
    -- Win:Tab(name, icon)
    -- ═══════════════════════════════════════
    --[[
        local Tab = Win:Tab("Gracz", "👤")

        Tab:Section("Sekcja")
        Tab:Button("Nazwa", function() end)
        Tab:Button("Nazwa", function() end, "Opis", "🎯")
        Tab:Toggle("Nazwa", false, function(v) end)
        Tab:Toggle("Nazwa", false, function(v) end, "Opis", "⚡")
        Tab:Slider("Nazwa", 0, 100, 50, 1, function(v) end, "%")
        Tab:Dropdown("Nazwa", {"A","B"}, "A", function(v) end)
        Tab:Input("Nazwa", "Hint...", function(v) end)
        Tab:Keybind("Nazwa", Enum.KeyCode.F, function(k) end)
        Tab:Label("Tekst")
        Tab:Para("Tytuł","Treść")
    ]]
    function Win:Tab(tabName, tabIcon)
        tabCount = tabCount + 1
        local idx = tabCount
        local first = (idx == 1)

        -- Tab button
        local tbtn = N("TextButton",{
            Size=UDim2.new(0,0,0,22),
            BackgroundTransparency=1,
            Text="",
            ZIndex=12, AutoButtonColor=false,
            LayoutOrder=idx,
            AutomaticSize=Enum.AutomaticSize.X,
            _=tabsBar
        })

        local tbLabel = N("TextLabel",{
            Size=UDim2.new(1,0,1,0),
            BackgroundTransparency=1,
            Text=(tabIcon and (tabIcon.." ") or "")..(tabName or "Tab"),
            Font=Enum.Font.Gotham,
            TextSize=11,
            TextColor3=first and C.ACC or C.TXT3,
            ZIndex=13,
            AutomaticSize=Enum.AutomaticSize.X,
            _=tbtn
        })
        local lPad = Instance.new("UIPadding")
        lPad.PaddingLeft=UDim.new(0,6); lPad.PaddingRight=UDim.new(0,6)
        lPad.Parent=tbLabel

        local underline = N("Frame",{
            Size=UDim2.new(1,0,0,2),
            Position=UDim2.new(0,0,1,4),
            BackgroundColor3=C.ACC,
            BackgroundTransparency=first and 0 or 1,
            ZIndex=14, _=tbtn
        })

        -- Scroll frame
        local scroll = N("ScrollingFrame",{
            Name="TabScroll_"..idx,
            Size=UDim2.new(1,0,1,0),
            BackgroundTransparency=1,
            BorderSizePixel=0,
            ScrollBarThickness=3,
            ScrollBarImageColor3=C.ACC,
            CanvasSize=UDim2.new(0,0,0,0),
            Visible=first,
            ZIndex=12, _=contentHolder
        })

        local lay = Instance.new("UIListLayout")
        lay.Padding=UDim.new(0,6)
        lay.SortOrder=Enum.SortOrder.LayoutOrder
        lay.Parent=scroll

        local inPad = Instance.new("UIPadding")
        inPad.PaddingTop=UDim.new(0,10)
        inPad.PaddingBottom=UDim.new(0,10)
        inPad.PaddingLeft=UDim.new(0,10)
        inPad.PaddingRight=UDim.new(0,10)
        inPad.Parent=scroll

        lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            scroll.CanvasSize=UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+24)
        end)

        local tabEntry = {btn=tbtn, scroll=scroll, underline=underline, label=tbLabel}
        table.insert(allTabs, tabEntry)

        if first then activeIdx=1 end

        tbtn.MouseButton1Click:Connect(function() SwitchTab(idx) end)
        tbtn.TouchTap:Connect(function() SwitchTab(idx) end)

        -- ─────────────────────────────────
        -- TAB OBJECT
        -- ─────────────────────────────────
        local Tab = {}
        Tab._s = scroll   -- scroll frame
        Tab._o = 0        -- layout order counter

        local function O(t) t._o=t._o+1; return t._o end

        -- ─── Section ───────────────────
        --[[  Tab:Section("Ruch")  ]]
        function Tab:Section(name)
            local f = N("Frame",{
                Size=UDim2.new(1,0,0,24),
                BackgroundTransparency=1,
                ZIndex=13, LayoutOrder=O(self), _=self._s
            })
            N("TextLabel",{
                Size=UDim2.new(1,0,0,16),
                Position=UDim2.new(0,2,0,0),
                BackgroundTransparency=1,
                Text=(name or "SEKCJA"):upper(),
                Font=Enum.Font.GothamBold,
                TextSize=9,
                TextColor3=C.TXT3,
                TextXAlignment=Enum.TextXAlignment.Left,
                ZIndex=14, _=f
            })
            N("Frame",{
                Size=UDim2.new(1,0,0,1),
                Position=UDim2.new(0,0,1,-2),
                BackgroundColor3=C.BORDER,
                ZIndex=14, _=f
            })
        end

        -- ─── Button ────────────────────
        --[[
            Tab:Button("Nazwa", callback)
            Tab:Button("Nazwa", callback, "Opis pod spodem", "🎯")
        ]]
        function Tab:Button(name, callback, desc, icon)
            local hasDesc = desc and desc ~= ""
            local h = hasDesc and 54 or 44

            local row = N("Frame",{
                Size=UDim2.new(1,0,0,h),
                BackgroundColor3=C.CARD,
                ZIndex=13, LayoutOrder=O(self), _=self._s
            })
            Rnd(row,8); Str(row,C.BORDER,1)

            if icon then
                local iF=N("Frame",{
                    Size=UDim2.new(0,28,0,28),
                    Position=UDim2.new(0,12,0,hasDesc and 6 or 8),
                    BackgroundColor3=C.ACC,
                    BackgroundTransparency=0.84,
                    ZIndex=14, _=row
                })
                Rnd(iF,7)
                N("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=icon,TextSize=14,Font=Enum.Font.GothamBold,TextColor3=C.ACC,ZIndex=15,_=iF})
            end

            local lx = icon and 48 or 12
            N("TextLabel",{
                Size=UDim2.new(1,-lx-30,0,hasDesc and 20 or h),
                Position=UDim2.new(0,lx,0,hasDesc and 7 or 0),
                BackgroundTransparency=1,
                Text=name or "Button",
                Font=Enum.Font.Gotham, TextSize=13, TextColor3=C.TXT,
                TextXAlignment=Enum.TextXAlignment.Left,
                ZIndex=14, _=row
            })
            if hasDesc then
                N("TextLabel",{
                    Size=UDim2.new(1,-lx-30,0,16),
                    Position=UDim2.new(0,lx,0,28),
                    BackgroundTransparency=1, Text=desc,
                    Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.TXT3,
                    TextXAlignment=Enum.TextXAlignment.Left,
                    TextTruncate=Enum.TextTruncate.AtEnd,
                    ZIndex=14, _=row
                })
            end
            local arr=N("TextLabel",{
                Size=UDim2.new(0,20,1,0),Position=UDim2.new(1,-26,0,0),
                BackgroundTransparency=1,Text="›",TextSize=20,
                Font=Enum.Font.GothamBold,TextColor3=C.TXT2,ZIndex=14,_=row
            })

            -- Clickable overlay
            local cl=N("TextButton",{
                Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",
                ZIndex=16,AutoButtonColor=false,_=row
            })
            cl.MouseEnter:Connect(function() TW(row,.15,{BackgroundColor3=C.CARD2}) TW(arr,.15,{Position=UDim2.new(1,-22,0,0)}) end)
            cl.MouseLeave:Connect(function() TW(row,.15,{BackgroundColor3=C.CARD}) TW(arr,.15,{Position=UDim2.new(1,-26,0,0)}) end)
            cl.MouseButton1Down:Connect(function() TW(row,.08,{BackgroundColor3=C.ACC2}) end)
            cl.MouseButton1Up:Connect(function()
                TW(row,.12,{BackgroundColor3=C.CARD2})
                if callback then task.spawn(pcall,callback) end
            end)
            cl.TouchTap:Connect(function()
                TW(row,.08,{BackgroundColor3=C.ACC2}); task.wait(.1)
                TW(row,.12,{BackgroundColor3=C.CARD2})
                if callback then task.spawn(pcall,callback) end
            end)
        end

        -- ─── Toggle ────────────────────
        --[[
            local t = Tab:Toggle("Latanie", false, function(v) print(v) end)
            local t = Tab:Toggle("Latanie", false, function(v) end, "Opis", "✈️")
            t:Set(true)
            print(t.Value)
        ]]
        function Tab:Toggle(name, default, callback, desc, icon)
            local state = default or false
            local hasDesc = desc and desc ~= ""
            local h = hasDesc and 54 or 44

            local row = N("Frame",{
                Size=UDim2.new(1,0,0,h),
                BackgroundColor3=C.CARD,
                ZIndex=13, LayoutOrder=O(self), _=self._s
            })
            Rnd(row,8); Str(row,C.BORDER,1)

            if icon then
                local iF=N("Frame",{
                    Size=UDim2.new(0,28,0,28),
                    Position=UDim2.new(0,12,0,hasDesc and 6 or 8),
                    BackgroundColor3=C.ACC,BackgroundTransparency=0.84,
                    ZIndex=14,_=row
                })
                Rnd(iF,7)
                N("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=icon,TextSize=14,Font=Enum.Font.GothamBold,TextColor3=C.ACC,ZIndex=15,_=iF})
            end

            local lx = icon and 48 or 12
            N("TextLabel",{
                Size=UDim2.new(1,-lx-60,0,hasDesc and 20 or h),
                Position=UDim2.new(0,lx,0,hasDesc and 7 or 0),
                BackgroundTransparency=1,
                Text=name or "Toggle",
                Font=Enum.Font.Gotham,TextSize=13,TextColor3=C.TXT,
                TextXAlignment=Enum.TextXAlignment.Left,
                ZIndex=14,_=row
            })
            if hasDesc then
                N("TextLabel",{
                    Size=UDim2.new(1,-lx-60,0,16),
                    Position=UDim2.new(0,lx,0,28),
                    BackgroundTransparency=1,Text=desc,
                    Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.TXT3,
                    TextXAlignment=Enum.TextXAlignment.Left,
                    TextTruncate=Enum.TextTruncate.AtEnd,
                    ZIndex=14,_=row
                })
            end

            -- Track
            local track=N("Frame",{
                Size=UDim2.new(0,40,0,22),
                Position=UDim2.new(1,-52,0.5,-11),
                BackgroundColor3=state and C.ACC or C.TOG_OFF,
                ZIndex=14,_=row
            })
            Rnd(track,999)

            -- Knob
            local knob=N("Frame",{
                Size=UDim2.new(0,16,0,16),
                Position=state and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8),
                BackgroundColor3=Color3.new(1,1,1),
                ZIndex=15,_=track
            })
            Rnd(knob,999)

            local OBJ={Value=state}

            local function Set(v, noCallback)
                state=v; OBJ.Value=v
                TW(track,.2,{BackgroundColor3=v and C.ACC or C.TOG_OFF},Enum.EasingStyle.Quad)
                TW(knob,.2,{Position=v and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8)},Enum.EasingStyle.Quad)
                if not noCallback and callback then task.spawn(pcall,callback,v) end
            end

            -- CLICKABLE AREA — pokrywa całą prawą część row (szeroka, łatwa do kliknięcia)
            local cl=N("TextButton",{
                Size=UDim2.new(0,80,1,0),
                Position=UDim2.new(1,-82,0,0),
                BackgroundTransparency=1,
                Text="",ZIndex=17,AutoButtonColor=false,_=row
            })
            cl.MouseButton1Click:Connect(function() Set(not state) end)
            cl.TouchTap:Connect(function() Set(not state) end)

            OBJ.Set=function(_,v) Set(v,true) end
            return OBJ
        end

        -- ─── Slider ────────────────────
        --[[
            local s = Tab:Slider("Speed", 0, 100, 50, 1, function(v) print(v) end, "%")
            local s = Tab:Slider("Speed", 0, 100, 50, 1, function(v) end, "%", "Opis")
            s:Set(75)
            print(s.Value)
        ]]
        function Tab:Slider(name, min, max, default, step, callback, suffix, desc)
            min=min or 0; max=max or 100; step=step or 1; suffix=suffix or ""
            local cur=math.clamp(default or min, min, max)
            local hasDesc=desc and desc~=""
            local h=hasDesc and 64 or 56

            local row=N("Frame",{
                Size=UDim2.new(1,0,0,h),
                BackgroundColor3=C.CARD,
                ZIndex=13,LayoutOrder=O(self),_=self._s
            })
            Rnd(row,8); Str(row,C.BORDER,1)

            N("TextLabel",{
                Size=UDim2.new(0.65,0,0,hasDesc and 20 or 28),
                Position=UDim2.new(0,12,0,hasDesc and 7 or 8),
                BackgroundTransparency=1,Text=name or "Slider",
                Font=Enum.Font.Gotham,TextSize=13,TextColor3=C.TXT,
                TextXAlignment=Enum.TextXAlignment.Left,ZIndex=14,_=row
            })
            if hasDesc then
                N("TextLabel",{
                    Size=UDim2.new(0.65,0,0,14),
                    Position=UDim2.new(0,12,0,27),
                    BackgroundTransparency=1,Text=desc,
                    Font=Enum.Font.Gotham,TextSize=10,TextColor3=C.TXT3,
                    TextXAlignment=Enum.TextXAlignment.Left,ZIndex=14,_=row
                })
            end

            local vLbl=N("TextLabel",{
                Size=UDim2.new(0.35,-14,0,hasDesc and 20 or 28),
                Position=UDim2.new(0.65,0,0,hasDesc and 7 or 8),
                BackgroundTransparency=1,
                Text=tostring(cur)..suffix,
                Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.ACC,
                TextXAlignment=Enum.TextXAlignment.Right,ZIndex=14,_=row
            })

            -- Track
            local trkBg=N("Frame",{
                Size=UDim2.new(1,-24,0,5),
                Position=UDim2.new(0,12,0,hasDesc and 46 or 38),
                BackgroundColor3=C.BORDER,ZIndex=14,_=row
            })
            Rnd(trkBg,3)
            local p0=(cur-min)/(max-min)
            local fill=N("Frame",{
                Size=UDim2.new(p0,0,1,0),
                BackgroundColor3=C.ACC,ZIndex=15,_=trkBg
            })
            Rnd(fill,3)
            local thumb=N("Frame",{
                Size=UDim2.new(0,14,0,14),
                AnchorPoint=Vector2.new(0.5,0.5),
                Position=UDim2.new(p0,0,0.5,0),
                BackgroundColor3=Color3.new(1,1,1),
                ZIndex=16,_=trkBg
            })
            Rnd(thumb,999)
            Str(thumb,C.ACC,2)

            local OBJ={Value=cur}
            local sliding=false

            local function SV(v)
                v=math.clamp(math.round(v/step)*step,min,max)
                cur=v; OBJ.Value=v
                local p=(v-min)/(max-min)
                vLbl.Text=tostring(v)..suffix
                fill.Size=UDim2.new(p,0,1,0)
                thumb.Position=UDim2.new(p,0,0.5,0)
                if callback then task.spawn(pcall,callback,v) end
            end

            OBJ.Set=function(_,v) SV(v) end

            local function fromX(x)
                local p=math.clamp((x-trkBg.AbsolutePosition.X)/trkBg.AbsoluteSize.X,0,1)
                SV(min+(max-min)*p)
            end

            trkBg.InputBegan:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    sliding=true; fromX(i.Position.X)
                end
            end)
            UserInputService.InputChanged:Connect(function(i)
                if sliding and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                    fromX(i.Position.X)
                end
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    sliding=false
                end
            end)

            return OBJ
        end

        -- ─── Dropdown ──────────────────
        --[[
            local d = Tab:Dropdown("Lokacja", {"Spawn","Sklep"}, "Spawn", function(v) end)
            d:Set("Sklep")
            d:Reload({"A","B","C"})
            print(d.Value)
        ]]
        function Tab:Dropdown(name, options, selected, callback)
            options=options or {}; selected=selected or options[1] or ""
            local open=false

            local row=N("Frame",{
                Size=UDim2.new(1,0,0,44),
                BackgroundColor3=C.CARD,
                ClipsDescendants=false,
                ZIndex=13,LayoutOrder=O(self),_=self._s
            })
            Rnd(row,8); Str(row,C.BORDER,1)

            local hdr=N("TextButton",{
                Size=UDim2.new(1,0,0,44),
                BackgroundTransparency=1,Text="",
                ZIndex=14,AutoButtonColor=false,_=row
            })
            N("TextLabel",{
                Size=UDim2.new(0.52,0,1,0),Position=UDim2.new(0,12,0,0),
                BackgroundTransparency=1,Text=name or "Dropdown",
                Font=Enum.Font.Gotham,TextSize=13,TextColor3=C.TXT2,
                TextXAlignment=Enum.TextXAlignment.Left,ZIndex=15,_=hdr
            })
            local vLbl=N("TextLabel",{
                Size=UDim2.new(0.45,0,1,0),Position=UDim2.new(0.52,0,0,0),
                BackgroundTransparency=1,Text=selected,
                Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.TXT,
                TextXAlignment=Enum.TextXAlignment.Right,
                TextTruncate=Enum.TextTruncate.AtEnd,
                ZIndex=15,_=hdr
            })
            local arrL=N("TextLabel",{
                Size=UDim2.new(0,22,1,0),Position=UDim2.new(1,-26,0,0),
                BackgroundTransparency=1,Text="▾",TextSize=12,
                Font=Enum.Font.GothamBold,TextColor3=C.TXT2,ZIndex=15,_=hdr
            })

            local dList=N("Frame",{
                Size=UDim2.new(1,0,0,0),Position=UDim2.new(0,0,1,4),
                BackgroundColor3=C.CARD2,ClipsDescendants=true,
                Visible=false,ZIndex=50,_=row
            })
            Rnd(dList,8); Str(dList,C.BORDER,1)

            local dLay=Instance.new("UIListLayout")
            dLay.SortOrder=Enum.SortOrder.LayoutOrder; dLay.Parent=dList

            local OBJ={Value=selected}

            local function Build()
                for _,c2 in ipairs(dList:GetChildren()) do
                    if c2:IsA("TextButton") then c2:Destroy() end
                end
                for i,op in ipairs(options) do
                    local isSel=(op==selected)
                    local ob=N("TextButton",{
                        Size=UDim2.new(1,0,0,32),
                        BackgroundColor3=isSel and C.ACC or C.CARD2,
                        BackgroundTransparency=isSel and 0.65 or 1,
                        Text="",ZIndex=51,AutoButtonColor=false,LayoutOrder=i,_=dList
                    })
                    N("TextLabel",{
                        Size=UDim2.new(1,-20,1,0),Position=UDim2.new(0,12,0,0),
                        BackgroundTransparency=1,Text=op,
                        Font=Enum.Font.Gotham,TextSize=12,
                        TextColor3=isSel and C.TXT or C.TXT2,
                        TextXAlignment=Enum.TextXAlignment.Left,ZIndex=52,_=ob
                    })
                    ob.MouseEnter:Connect(function() if not isSel then TW(ob,.12,{BackgroundTransparency=0.5,BackgroundColor3=C.ACC}) end end)
                    ob.MouseLeave:Connect(function() if not isSel then TW(ob,.12,{BackgroundTransparency=1}) end end)
                    local function pick()
                        selected=op; OBJ.Value=op; vLbl.Text=op
                        open=false
                        TW(dList,.18,{Size=UDim2.new(1,0,0,0)})
                        TW(arrL,.18,{Rotation=0})
                        task.delay(.2,function() dList.Visible=false end)
                        Build()
                        if callback then task.spawn(pcall,callback,op) end
                    end
                    ob.MouseButton1Click:Connect(pick)
                    ob.TouchTap:Connect(pick)
                end
            end
            Build()

            local function Toggle2()
                open=not open
                if open then
                    dList.Visible=true
                    TW(dList,.22,{Size=UDim2.new(1,0,0,#options*32)},Enum.EasingStyle.Back,Enum.EasingDirection.Out)
                    TW(arrL,.18,{Rotation=180})
                else
                    TW(dList,.18,{Size=UDim2.new(1,0,0,0)})
                    TW(arrL,.18,{Rotation=0})
                    task.delay(.2,function() dList.Visible=false end)
                end
            end
            hdr.MouseButton1Click:Connect(Toggle2)
            hdr.TouchTap:Connect(Toggle2)

            OBJ.Set=function(_,v) selected=v;OBJ.Value=v;vLbl.Text=v;Build() end
            OBJ.Reload=function(_,opts) options=opts;selected=opts[1] or "";OBJ.Value=selected;vLbl.Text=selected;Build() end
            return OBJ
        end

        -- ─── Input ─────────────────────
        --[[
            local i = Tab:Input("Nazwa", "Hint...", function(text) end)
            i:Set("wartość")
            print(i.Value)
        ]]
        function Tab:Input(name, hint, callback)
            local row=N("Frame",{
                Size=UDim2.new(1,0,0,54),
                BackgroundColor3=C.CARD,
                ZIndex=13,LayoutOrder=O(self),_=self._s
            })
            Rnd(row,8); Str(row,C.BORDER,1)

            N("TextLabel",{
                Size=UDim2.new(1,-14,0,20),Position=UDim2.new(0,12,0,5),
                BackgroundTransparency=1,Text=name or "Input",
                Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.TXT2,
                TextXAlignment=Enum.TextXAlignment.Left,ZIndex=14,_=row
            })
            local iWrap=N("Frame",{
                Size=UDim2.new(1,-24,0,22),Position=UDim2.new(0,12,0,28),
                BackgroundColor3=C.BG,ZIndex=14,_=row
            })
            Rnd(iWrap,6)
            local iStr=Str(iWrap,C.BORDER,1)
            local tb=N("TextBox",{
                Size=UDim2.new(1,-16,1,0),Position=UDim2.new(0,8,0,0),
                BackgroundTransparency=1,
                Text="",
                PlaceholderText=hint or "Wpisz...",
                PlaceholderColor3=C.TXT3,
                Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.TXT,
                TextXAlignment=Enum.TextXAlignment.Left,
                ClearTextOnFocus=false,ZIndex=15,_=iWrap
            })
            tb.Focused:Connect(function() TW(iStr,.18,{Color=C.ACC}) end)
            tb.FocusLost:Connect(function()
                TW(iStr,.18,{Color=C.BORDER})
                if callback then task.spawn(pcall,callback,tb.Text) end
            end)
            local OBJ={Value=tb.Text}
            OBJ.Set=function(_,v) tb.Text=v;OBJ.Value=v end
            tb:GetPropertyChangedSignal("Text"):Connect(function() OBJ.Value=tb.Text end)
            return OBJ
        end

        -- ─── Keybind ───────────────────
        --[[
            local k = Tab:Keybind("Sprint", Enum.KeyCode.LeftShift, function(key) end)
            k:Set(Enum.KeyCode.F)
            print(k.Value.Name)
        ]]
        function Tab:Keybind(name, defaultKey, callback)
            local curKey = defaultKey or Enum.KeyCode.Unknown
            local listening = false

            local row=N("Frame",{
                Size=UDim2.new(1,0,0,44),
                BackgroundColor3=C.CARD,
                ZIndex=13,LayoutOrder=O(self),_=self._s
            })
            Rnd(row,8); Str(row,C.BORDER,1)

            N("TextLabel",{
                Size=UDim2.new(0.6,0,1,0),Position=UDim2.new(0,12,0,0),
                BackgroundTransparency=1,Text=name or "Keybind",
                Font=Enum.Font.Gotham,TextSize=13,TextColor3=C.TXT,
                TextXAlignment=Enum.TextXAlignment.Left,ZIndex=14,_=row
            })
            local kbtn=N("TextButton",{
                Size=UDim2.new(0,74,0,24),Position=UDim2.new(1,-84,0.5,-12),
                BackgroundColor3=C.PANEL,BorderSizePixel=0,
                Text=curKey.Name,Font=Enum.Font.GothamBold,
                TextSize=11,TextColor3=C.ACC,
                ZIndex=14,AutoButtonColor=false,_=row
            })
            Rnd(kbtn,7); Str(kbtn,C.ACC,1,0.35)

            local OBJ={Value=curKey}
            OBJ.Set=function(_,k2) curKey=k2;OBJ.Value=k2;kbtn.Text=k2.Name end

            kbtn.MouseButton1Click:Connect(function()
                if listening then return end
                listening=true; kbtn.Text="..."
                TW(kbtn,.15,{BackgroundColor3=C.ACC,TextColor3=Color3.new(1,1,1)})
            end)
            kbtn.TouchTap:Connect(function()
                if listening then return end
                listening=true; kbtn.Text="..."
                TW(kbtn,.15,{BackgroundColor3=C.ACC,TextColor3=Color3.new(1,1,1)})
            end)
            UserInputService.InputBegan:Connect(function(i,gp)
                if not listening then return end
                if i.UserInputType==Enum.UserInputType.Keyboard then
                    listening=false; curKey=i.KeyCode; OBJ.Value=i.KeyCode; kbtn.Text=i.KeyCode.Name
                    TW(kbtn,.15,{BackgroundColor3=C.PANEL,TextColor3=C.ACC})
                    if callback then task.spawn(pcall,callback,i.KeyCode) end
                end
            end)
            return OBJ
        end

        -- ─── Label ─────────────────────
        --[[  Tab:Label("Tekst...")  ]]
        function Tab:Label(text)
            N("TextLabel",{
                Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,
                Text=text or "",Font=Enum.Font.Gotham,TextSize=12,
                TextColor3=C.TXT2,TextXAlignment=Enum.TextXAlignment.Left,
                TextWrapped=true,ZIndex=13,LayoutOrder=O(self),_=self._s
            })
        end

        -- ─── Paragraph ─────────────────
        --[[
            Tab:Para("Tytuł", "Treść tekstu która może być długa i zawierać\nnowe linie")
        ]]
        function Tab:Para(ptitle, content)
            local box=N("Frame",{
                Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,
                BackgroundColor3=C.CARD,ZIndex=13,
                LayoutOrder=O(self),_=self._s
            })
            Rnd(box,8); Str(box,C.BORDER,1)
            local bLay=Instance.new("UIListLayout")
            bLay.Padding=UDim.new(0,4); bLay.SortOrder=Enum.SortOrder.LayoutOrder; bLay.Parent=box
            local bPad=Instance.new("UIPadding")
            bPad.PaddingTop=UDim.new(0,10);bPad.PaddingBottom=UDim.new(0,10)
            bPad.PaddingLeft=UDim.new(0,14);bPad.PaddingRight=UDim.new(0,14)
            bPad.Parent=box
            N("TextLabel",{
                Size=UDim2.new(1,0,0,18),BackgroundTransparency=1,
                Text=ptitle or "",Font=Enum.Font.GothamBold,
                TextSize=13,TextColor3=C.TXT,
                TextXAlignment=Enum.TextXAlignment.Left,ZIndex=14,LayoutOrder=1,_=box
            })
            N("TextLabel",{
                Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,
                BackgroundTransparency=1,Text=content or "",
                Font=Enum.Font.Gotham,TextSize=12,TextColor3=C.TXT2,
                TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,
                ZIndex=14,LayoutOrder=2,_=box
            })
        end

        return Tab
    end -- Win:Tab()

    -- ─────────────────────────────────────────
    -- INTRO → SHOW
    -- ─────────────────────────────────────────
    if showIntro then
        RunIntro(function()
            task.wait(0.2)
            Win:Show()
        end)
    else
        task.delay(0.1, function() Win:Show() end)
    end

    return Win
end -- UI.new()

return UI
