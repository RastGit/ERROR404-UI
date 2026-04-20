# ⚡ ERROR 404 UI Library

<div align="center">

![Version](https://img.shields.io/badge/version-2.0-blueviolet?style=for-the-badge)
![Roblox](https://img.shields.io/badge/platform-Roblox-red?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)

**Lekka, stylowa biblioteka GUI dla Roblox.**  
Rayfield-style API | Ciemny motyw | Animowane intro `ERROR → 404` | PC + Mobile

</div>

---

## 📋 Spis treści

- [Szybki start](#-szybki-start)
- [CreateWindow](#-createwindow)
- [CreateTab](#-createtab)
- [Elementy UI](#-elementy-ui)
  - [CreateSection](#createsection)
  - [CreateButton](#createbutton)
  - [CreateToggle](#createtoggle)
  - [CreateSlider](#createslider)
  - [CreateDropdown](#createdropdown)
  - [CreateInput](#createinput)
  - [CreateKeybind](#createkeybind)
  - [CreateLabel](#createlabel)
  - [AddParagraph](#addparagraph)
  - [CreateDivider](#createdivider)
- [Notify](#-notify)
- [Metody okna](#-metody-okna)
- [FAQ](#-faq)

---

## 🚀 Szybki start

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RastGit/ERROR404-UI/refs/heads/main/Error404ui.lua?token=GHSAT0AAAAAADRHFUKXZYGUEEQQ7XY6UFEK2PGCFTQ"
))()

local Window = Library.CreateWindow({
    Name            = "Mój Script",
    LoadingSubtitle = "by Ktoś | v1.0",
    ToggleUIKeybind = Enum.KeyCode.Insert,
    ShowIntro       = true,
})

local Tab = Window:CreateTab({ Name = "Główna", Icon = "🏠" })

Tab:CreateSection("Gracz")

Tab:CreateButton({
    Name     = "Kliknij mnie",
    Callback = function()
        print("Kliknięto!")
    end,
})
```

---

## 🪟 CreateWindow

```lua
local Window = Library.CreateWindow({
    Name             = "Nazwa okna",       -- Tytuł w pasku
    LoadingSubtitle  = "v1.0 • autor",    -- Podtytuł pod tytułem
    ToggleUIKeybind  = Enum.KeyCode.Insert, -- Klawisz otwierania (PC)
    ShowIntro        = true,               -- Animacja ERROR/404 (domyślnie: true)
})
```

| Parametr | Typ | Domyślnie | Opis |
|----------|-----|-----------|------|
| `Name` | `string` | `"ERROR 404 UI"` | Tytuł okna |
| `LoadingSubtitle` | `string` | `"v2.0"` | Podtytuł |
| `ToggleUIKeybind` | `Enum.KeyCode` | `Insert` | Klawisz toggle (PC) |
| `ShowIntro` | `bool` | `true` | Animacja intro |

> Na **mobile** zamiast klawisza pojawia się pływający przycisk ⚡ w lewym dolnym rogu.  
> Okno **otwiera się automatycznie** po zakończeniu intro.

---

## 📑 CreateTab

```lua
local Tab = Window:CreateTab({
    Name = "Gracz",   -- Tooltip po najechaniu na ikonę
    Icon = "🏃",      -- Ikona w bocznym pasku (emoji)
})
```

| Parametr | Typ | Opis |
|----------|-----|------|
| `Name` | `string` | Tooltip zakładki |
| `Icon` | `string` | Emoji / znak Unicode |

**Zwraca:** obiekt `Tab` z metodami poniżej.

---

## 🎛️ Elementy UI

### CreateSection

Nagłówek grupujący elementy.

```lua
Tab:CreateSection("Nazwa sekcji")
```

---

### CreateButton

```lua
Tab:CreateButton({
    Name     = "Zrób coś",
    Callback = function()
        -- twój kod
    end,
})
```

---

### CreateToggle

```lua
local MyToggle = Tab:CreateToggle({
    Name         = "Fly",
    CurrentValue = false,
    Callback     = function(Value)
        print(Value) -- true / false
    end,
})

-- Ustawienie z kodu:
MyToggle:Set(true)

-- Odczyt:
print(MyToggle.Value)
```

---

### CreateSlider

```lua
local MySlider = Tab:CreateSlider({
    Name         = "WalkSpeed",
    Range        = {16, 250},   -- {Min, Max}
    Increment    = 1,
    Suffix       = " sp/s",     -- tekst po wartości (opcjonalny)
    CurrentValue = 16,
    Callback     = function(Value)
        print(Value)
    end,
})

MySlider:Set(100)
print(MySlider.Value)
```

---

### CreateDropdown

```lua
local MyDropdown = Tab:CreateDropdown({
    Name          = "Lokacja",
    Options       = {"Spawn", "Sklep", "Boss"},
    CurrentOption = "Spawn",
    Callback      = function(Value)
        print(Value)
    end,
})

MyDropdown:Set("Sklep")
MyDropdown:Refresh({"Nowa1", "Nowa2"})
print(MyDropdown.Value)
```

---

### CreateInput

```lua
local MyInput = Tab:CreateInput({
    Name            = "Pole tekstowe",
    PlaceholderText = "Wpisz coś...",
    CurrentString   = "",
    Callback        = function(Value)
        -- wywołuje się po Enter / utracie focusu
        print(Value)
    end,
})

MyInput:Set("nowy tekst")
print(MyInput.Value)
```

---

### CreateKeybind

```lua
local MyKeybind = Tab:CreateKeybind({
    Name           = "Sprint",
    CurrentKeybind = "LeftShift",  -- nazwa z Enum.KeyCode
    Callback       = function(Value)
        print(Value.Name) -- Enum.KeyCode
    end,
})

MyKeybind:Set(Enum.KeyCode.F)
print(MyKeybind.Value) -- Enum.KeyCode
```

> Kliknij przycisk w UI → wciśnij klawisz → zostaje zapisany.

---

### CreateLabel

```lua
Tab:CreateLabel("Tekst informacyjny")
```

---

### AddParagraph

```lua
Tab:AddParagraph({
    Title   = "Nagłówek",
    Content = "Dłuższy tekst opisu...",
})
```

---

### CreateDivider

Pozioma linia oddzielająca.

```lua
Tab:CreateDivider()
```

---

## 🔔 Notify

Globalna funkcja – nie wymaga instancji okna.

```lua
Library.Notify({
    Title    = "Tytuł",
    Content  = "Treść powiadomienia",
    Duration = 4,       -- sekundy (domyślnie 4)
    Type     = "success" -- "success" | "error" | "warning" | "info"
})
```

| Typ | Kolor | Ikona |
|-----|-------|-------|
| `"success"` | 🟢 Zielony | ✓ |
| `"error"` | 🔴 Czerwony | ✕ |
| `"warning"` | 🟡 Pomarańczowy | ⚠ |
| `"info"` | 🟣 Fioletowy | ℹ |

---

## 🔧 Metody okna

```lua
Window:Open()     -- Otwórz menu
Window:Close()    -- Zamknij menu
Window:Toggle()   -- Przełącz open/close
Window:Destroy()  -- Usuń całe GUI
```

---

## ❓ FAQ

**Q: Intro się nie pokazuje?**  
A: Upewnij się że `ShowIntro = true` (domyślnie). Intro działa przez `CoreGui` z fallbackiem na `PlayerGui`.

**Q: Okno nie otwiera się po intro?**  
A: Okno otwiera się automatycznie po zakończeniu intro. Nie wywołuj `Window:Open()` ręcznie jeśli `ShowIntro = true`.

**Q: Działa na mobile?**  
A: Tak. Na mobile automatycznie pojawia się przycisk ⚡ w lewym dolnym rogu ekranu.

**Q: Jak zmienić klawisz otwierania?**  
A: Ustaw `ToggleUIKeybind = Enum.KeyCode.TWÓJ_KLAWISZ` przy tworzeniu okna.

**Q: Jak wyłączyć intro?**  
A: `ShowIntro = false`

**Q: Mogę mieć wiele okien?**  
A: Tak, każdy `Library.CreateWindow()` to niezależne okno.

---

## 📁 Pliki

```
Error404UI/
├── Error404ui.lua   ← główna biblioteka
├── Example.lua      ← przykład użycia
└── README.md        ← dokumentacja
```

---

<div align="center">
Made with ⚡ — <b>ERROR 404 UI</b> by RastGit
</div>
