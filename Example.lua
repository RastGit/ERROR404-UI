-- ╔══════════════════════════════════════════════════════════╗
-- ║         ERROR 404 UI - Przykład użycia                   ║
-- ╚══════════════════════════════════════════════════════════╝

-- Załaduj bibliotekę (zmień URL na swój rawgithub link)
local Error404UI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/TWOJ_GITHUB/Error404UI/main/Error404UI.lua"
))()

-- ══════════════════════════════════════════════════════════════
-- TWORZENIE OKNA
-- ══════════════════════════════════════════════════════════════
local Window = Error404UI.new({
    Title     = "Mój Cheat",
    Subtitle  = "v1.0 • by Ktoś",
    ToggleKey = Enum.KeyCode.Insert,  -- klawisz otwierania (desktop)
    ShowIntro = true,                 -- animacja ERROR / 404 na starcie
})

-- ══════════════════════════════════════════════════════════════
-- ZAKŁADKA 1 – GŁÓWNA
-- ══════════════════════════════════════════════════════════════
local TabMain = Window:AddTab({
    Title = "Główna",
    Icon  = "🏠",
})

-- Sekcja
local SectionPlayer = TabMain:AddSection("Gracz")

-- Toggle
local flyToggle = SectionPlayer:AddToggle({
    Title    = "Latanie (Fly)",
    Default  = false,
    Callback = function(value)
        print("Fly:", value)
        -- tu twój kod latania
    end,
})

-- Toggle z własnym wywołaniem
local speedToggle = SectionPlayer:AddToggle({
    Title    = "Szybkość x2",
    Default  = false,
    Callback = function(value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = value and 32 or 16
        end
    end,
})

-- Slider
local speedSlider = SectionPlayer:AddSlider({
    Title    = "WalkSpeed",
    Min      = 16,
    Max      = 200,
    Default  = 16,
    Suffix   = " studs/s",
    Callback = function(value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = value
        end
    end,
})

-- Separator
SectionPlayer:AddSeparator()

-- Label
SectionPlayer:AddLabel("Ustawienia jump power:")

-- Slider dla skoku
local jumpSlider = SectionPlayer:AddSlider({
    Title    = "JumpPower",
    Min      = 50,
    Max      = 500,
    Default  = 50,
    Suffix   = "",
    Callback = function(value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = value
        end
    end,
})

-- Przycisk
SectionPlayer:AddButton({
    Title    = "Resetuj Postać",
    Callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
    end,
})

-- ══════════════════════════════════════════════════════════════
-- ZAKŁADKA 2 – USTAWIENIA
-- ══════════════════════════════════════════════════════════════
local TabSettings = Window:AddTab({
    Title = "Ustawienia",
    Icon  = "⚙️",
})

local SectionUI = TabSettings:AddSection("Interfejs")

-- Dropdown
local themeDropdown = SectionUI:AddDropdown({
    Title    = "Motyw",
    Options  = {"Fioletowy", "Czerwony", "Niebieski"},
    Default  = "Fioletowy",
    Callback = function(selected)
        print("Wybrany motyw:", selected)
        Error404UI.Notify({
            Title   = "Motyw zmieniony",
            Message = "Wybrano: " .. selected,
            Type    = "success",
            Duration = 3,
        })
    end,
})

-- TextBox
local nameBox = SectionUI:AddTextBox({
    Title       = "Nazwa postaci",
    Placeholder = "Wpisz nick...",
    Default     = "",
    Callback    = function(text)
        print("Wpisano:", text)
    end,
})

-- Keybind
local keybind = SectionUI:AddKeybind({
    Title    = "Skrót Fly",
    Default  = Enum.KeyCode.F,
    Callback = function(key)
        print("Nowy klawisz:", key.Name)
    end,
})

-- ══════════════════════════════════════════════════════════════
-- ZAKŁADKA 3 – NARZĘDZIA
-- ══════════════════════════════════════════════════════════════
local TabTools = Window:AddTab({
    Title = "Narzędzia",
    Icon  = "🔧",
})

local SectionTools = TabTools:AddSection("Teleport")

-- Dropdown
local mapDropdown = SectionTools:AddDropdown({
    Title    = "Lokacja",
    Options  = {"Spawn", "Sklep", "Boss", "Sekretne miejsce"},
    Default  = "Spawn",
    Callback = function(v) end,
})

SectionTools:AddButton({
    Title    = "Teleportuj",
    Callback = function()
        local selected = mapDropdown.Value
        Error404UI.Notify({
            Title   = "Teleport",
            Message = "Teleportuję do: " .. selected,
            Type    = "info",
        })
    end,
})

-- ══════════════════════════════════════════════════════════════
-- ZAKŁADKA 4 – INFO
-- ══════════════════════════════════════════════════════════════
local TabInfo = Window:AddTab({
    Title = "Info",
    Icon  = "ℹ️",
})

local SectionInfo = TabInfo:AddSection("O bibliotece")

TabInfo:AddLabel("ERROR 404 UI Library v1.0")
TabInfo:AddLabel("Darmowa biblioteka GUI dla Roblox.")
TabInfo:AddLabel("github.com/TWOJ_GITHUB/Error404UI")

TabInfo:AddSeparator()

TabInfo:AddButton({
    Title    = "Pokaż powiadomienie sukcesu",
    Callback = function()
        Error404UI.Notify({ Title = "Sukces!", Message = "Wszystko działa poprawnie.", Type = "success" })
    end,
})

TabInfo:AddButton({
    Title    = "Pokaż błąd",
    Callback = function()
        Error404UI.Notify({ Title = "Błąd!", Message = "Coś poszło nie tak.", Type = "error" })
    end,
})

TabInfo:AddButton({
    Title    = "Pokaż ostrzeżenie",
    Callback = function()
        Error404UI.Notify({ Title = "Uwaga", Message = "Sprawdź ustawienia.", Type = "warning" })
    end,
})
