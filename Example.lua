-- ╔══════════════════════════════════════════════════════╗
-- ║     ERROR 404 UI  •  Przykład użycia                 ║
-- ╚══════════════════════════════════════════════════════╝

local E404 = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RastGit/ERROR404-UI/main/Error404ui.lua"
))()

-- ══════════════════════════════════════
-- OKNO
-- Intro ERROR → 404 odpala się samo
-- Okno otwiera się automatycznie po intro
-- ══════════════════════════════════════
local Win = E404.Window({
    Title    = "Mój Script",
    Subtitle = "v1.0  •  by Ktoś",
    Key      = Enum.KeyCode.Insert,
    Intro    = true,          -- false = pomiń intro
})

-- ══════════════════════════════════════
-- ZAKŁADKA 1  –  GRACZ
-- ══════════════════════════════════════
local T1 = Win:Tab({ Label="Gracz", Icon="🏃" })

T1:Section("Ruch")

local flyToggle = T1:Toggle({
    Label    = "Latanie",
    Desc     = "Włącza tryb lotu",
    Value    = false,
    Callback = function(v)
        print("Fly:", v)
    end,
})

local speedSlider = T1:Slider({
    Label    = "WalkSpeed",
    Desc     = "Prędkość chodzenia",
    Min      = 16,
    Max      = 250,
    Step     = 1,
    Value    = 16,
    Unit     = " sp/s",
    Callback = function(v)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = v
        end
    end,
})

local jumpSlider = T1:Slider({
    Label    = "JumpPower",
    Min      = 50,
    Max      = 500,
    Step     = 5,
    Value    = 50,
    Unit     = "",
    Callback = function(v)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = v
        end
    end,
})

T1:Divider()
T1:Section("Akcje")

T1:Button({
    Label    = "Resetuj postać",
    Desc     = "Zabija i respawnuje",
    Callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
    end,
})

T1:Button({
    Label    = "Resetuj prędkości",
    Callback = function()
        speedSlider:Set(16)
        jumpSlider:Set(50)
        E404.Notify({ Title="Reset", Message="Prędkości zresetowane.", Type="ok" })
    end,
})

-- ══════════════════════════════════════
-- ZAKŁADKA 2  –  NARZĘDZIA
-- ══════════════════════════════════════
local T2 = Win:Tab({ Label="Narzędzia", Icon="🔧" })

T2:Section("Teleport")

local mapDrop = T2:Dropdown({
    Label    = "Lokacja",
    Options  = {"Spawn", "Sklep", "Boss", "Sekretne"},
    Selected = "Spawn",
    Callback = function(v)
        print("Lokacja:", v)
    end,
})

T2:Button({
    Label    = "Teleportuj",
    Desc     = "Teleportuje do wybranej lokacji",
    Callback = function()
        E404.Notify({
            Title   = "Teleport",
            Message = "Lecę do: " .. mapDrop.Value,
            Type    = "info",
            Duration = 3,
        })
    end,
})

T2:Divider()
T2:Section("Inne")

local noclip = T2:Toggle({
    Label    = "NoClip",
    Value    = false,
    Callback = function(v)
        -- Przykładowy noclip
        if v then
            game:GetService("RunService").Stepped:Connect(function()
                if noclip.Value then
                    for _, p in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if p:IsA("BasePart") then p.CanCollide = false end
                    end
                end
            end)
        end
    end,
})

-- ══════════════════════════════════════
-- ZAKŁADKA 3  –  USTAWIENIA
-- ══════════════════════════════════════
local T3 = Win:Tab({ Label="Ustawienia", Icon="⚙️" })

T3:Section("Interfejs")

local keyBind = T3:Keybind({
    Label    = "Klawisz Fly",
    Default  = "F",
    Callback = function(key)
        E404.Notify({ Title="Keybind", Message="Nowy: "..key.Name, Type="ok" })
    end,
})

T3:Input({
    Label    = "Custom tag",
    Hint     = "Wpisz coś...",
    Default  = "",
    Callback = function(txt)
        print("Input:", txt)
    end,
})

T3:Divider()
T3:Section("Testy powiadomień")

T3:Button({ Label="✓ Sukces",      Callback=function() E404.Notify({Title="Sukces",  Message="Operacja zakończona.", Type="ok"})   end })
T3:Button({ Label="✕ Błąd",        Callback=function() E404.Notify({Title="Błąd",    Message="Coś poszło nie tak.",  Type="fail"}) end })
T3:Button({ Label="⚠ Ostrzeżenie", Callback=function() E404.Notify({Title="Uwaga",   Message="Sprawdź ustawienia.", Type="warn"}) end })
T3:Button({ Label="ℹ Info",        Callback=function() E404.Notify({Title="Info",    Message="Wersja: 3.0",         Type="info"}) end })

-- ══════════════════════════════════════
-- ZAKŁADKA 4  –  INFO
-- ══════════════════════════════════════
local T4 = Win:Tab({ Label="Info", Icon="ℹ️" })

T4:Paragraph({
    Title = "ERROR 404 UI  •  v3.0",
    Body  = "Własna biblioteka GUI dla Roblox. Styl inspirowany Rayfield, własne API.",
})

T4:Paragraph({
    Title = "Skróty",
    Body  = "INSERT — otwórz / zamknij menu (PC)\n⚡ przycisk — otwórz / zamknij menu (Mobile)",
})

T4:Divider()
T4:Label("github.com/RastGit/ERROR404-UI")
