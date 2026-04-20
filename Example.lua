-- ╔══════════════════════════════════════════════════════════╗
-- ║         ERROR 404 UI - Przykład użycia (Rayfield API)    ║
-- ╚══════════════════════════════════════════════════════════╝

local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RastGit/ERROR404-UI/refs/heads/main/Error404ui.lua?token=GHSAT0AAAAAADRHFUKXZYGUEEQQ7XY6UFEK2PGCFTQ"
))()

-- ══════════════════════════════════════════════════════════════
-- TWORZENIE OKNA
-- Intro ERROR → 404 odpala się automatycznie
-- Okno otworzy się samo po intro
-- ══════════════════════════════════════════════════════════════
local Window = Library.CreateWindow({
    Name             = "Mój Script",
    LoadingSubtitle  = "by Ktoś | v1.0",
    ToggleUIKeybind  = Enum.KeyCode.Insert,
    ShowIntro        = true,
})

-- ══════════════════════════════════════════════════════════════
-- ZAKŁADKA 1 – GRACZ
-- ══════════════════════════════════════════════════════════════
local TabGracz = Window:CreateTab({
    Name = "Gracz",
    Icon = "🏃",
})

TabGracz:CreateSection("Ruch")

local Fly = TabGracz:CreateToggle({
    Name         = "Latanie",
    CurrentValue = false,
    Callback     = function(Value)
        print("Fly:", Value)
    end,
})

local SpeedSlider = TabGracz:CreateSlider({
    Name         = "WalkSpeed",
    Range        = {16, 250},
    Increment    = 1,
    Suffix       = " sp/s",
    CurrentValue = 16,
    Callback     = function(Value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = Value
        end
    end,
})

local JumpSlider = TabGracz:CreateSlider({
    Name         = "JumpPower",
    Range        = {50, 500},
    Increment    = 5,
    Suffix       = "",
    CurrentValue = 50,
    Callback     = function(Value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = Value
        end
    end,
})

TabGracz:CreateDivider()
TabGracz:CreateSection("Akcje")

TabGracz:CreateButton({
    Name     = "Resetuj postać",
    Callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
    end,
})

TabGracz:CreateButton({
    Name     = "Resetuj prędkość",
    Callback = function()
        SpeedSlider:Set(16)
        JumpSlider:Set(50)
        Library.Notify({
            Title   = "Reset",
            Content = "Prędkości zostały zresetowane.",
            Type    = "success",
        })
    end,
})

-- ══════════════════════════════════════════════════════════════
-- ZAKŁADKA 2 – NARZĘDZIA
-- ══════════════════════════════════════════════════════════════
local TabTools = Window:CreateTab({
    Name = "Narzędzia",
    Icon = "🔧",
})

TabTools:CreateSection("Teleport")

local MapDropdown = TabTools:CreateDropdown({
    Name          = "Lokacja",
    Options       = {"Spawn", "Sklep", "Boss", "Sekretne", "Plaza"},
    CurrentOption = "Spawn",
    Callback      = function(Value)
        print("Wybrano:", Value)
    end,
})

TabTools:CreateButton({
    Name     = "Teleportuj",
    Callback = function()
        Library.Notify({
            Title    = "Teleport",
            Content  = "Teleportuję do: " .. MapDropdown.Value,
            Type     = "info",
            Duration = 3,
        })
    end,
})

TabTools:CreateDivider()
TabTools:CreateSection("Misc")

local GodToggle = TabTools:CreateToggle({
    Name         = "GodMode (NoClip)",
    CurrentValue = false,
    Callback     = function(Value)
        -- Przykładowy noclip
        if Value then
            game:GetService("RunService").Stepped:Connect(function()
                if GodToggle.Value then
                    for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
    end,
})

-- ══════════════════════════════════════════════════════════════
-- ZAKŁADKA 3 – USTAWIENIA
-- ══════════════════════════════════════════════════════════════
local TabSettings = Window:CreateTab({
    Name = "Ustawienia",
    Icon = "⚙️",
})

TabSettings:CreateSection("Interfejs")

local FlyKeybind = TabSettings:CreateKeybind({
    Name           = "Klawisz Fly",
    CurrentKeybind = "F",
    Callback       = function(Value)
        Library.Notify({
            Title   = "Keybind zmieniony",
            Content = "Nowy klawisz: " .. Value.Name,
            Type    = "success",
        })
    end,
})

TabSettings:CreateInput({
    Name            = "Własna wiadomość",
    PlaceholderText = "Wpisz coś...",
    CurrentString   = "",
    Callback        = function(Value)
        print("Input:", Value)
    end,
})

TabSettings:CreateDivider()
TabSettings:CreateSection("Powiadomienia - test")

TabSettings:CreateButton({
    Name     = "Sukces ✓",
    Callback = function()
        Library.Notify({ Title="Sukces!", Content="Operacja zakończona pomyślnie.", Type="success", Duration=4 })
    end,
})

TabSettings:CreateButton({
    Name     = "Błąd ✕",
    Callback = function()
        Library.Notify({ Title="Błąd!", Content="Coś poszło nie tak.", Type="error", Duration=4 })
    end,
})

TabSettings:CreateButton({
    Name     = "Ostrzeżenie ⚠",
    Callback = function()
        Library.Notify({ Title="Uwaga", Content="Sprawdź ustawienia.", Type="warning", Duration=4 })
    end,
})

TabSettings:CreateButton({
    Name     = "Info ℹ",
    Callback = function()
        Library.Notify({ Title="Info", Content="Nowa wersja dostępna.", Type="info", Duration=4 })
    end,
})

-- ══════════════════════════════════════════════════════════════
-- ZAKŁADKA 4 – INFO
-- ══════════════════════════════════════════════════════════════
local TabInfo = Window:CreateTab({
    Name = "Info",
    Icon = "ℹ️",
})

TabInfo:AddParagraph({
    Title   = "ERROR 404 UI Library v2.0",
    Content = "Darmowa, open-source biblioteka GUI dla Roblox. Styl inspirowany Rayfield. Działa na PC i mobile.",
})

TabInfo:AddParagraph({
    Title   = "Jak używać",
    Content = "INSERT - otwiera/zamyka menu (PC)\nPrzycisk ⚡ - otwiera/zamyka menu (Mobile)",
})

TabInfo:CreateLabel("github.com/RastGit/ERROR404-UI")
