# ⚡ ERROR 404 UI  —  v3.0

<div align="center">

![Version](https://img.shields.io/badge/version-3.0-blueviolet?style=for-the-badge)
![Roblox](https://img.shields.io/badge/Roblox-GUI_Library-red?style=for-the-badge)

**Własna biblioteka GUI dla Roblox.**  
Ciemny motyw | Intro ERROR → 404 | PC + Mobile | Własne API

</div>

---

## 🔗 Jak uzyskać stały raw link (bez tokenu)

Token w raw URL wygasa — żeby link działał **zawsze i dla wszystkich**:

1. Wejdź w repo → **Settings** → **Danger Zone** → **Change visibility** → **Public**
2. Gotowy link wygląda tak:
```
https://raw.githubusercontent.com/RastGit/ERROR404-UI/main/Error404ui.lua
```
Bez żadnego `?token=...` — działa wiecznie.

---

## 🚀 Szybki start

```lua
local E404 = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RastGit/ERROR404-UI/main/Error404ui.lua"
))()

local Win = E404.Window({
    Title    = "Mój Script",
    Subtitle = "v1.0",
    Key      = Enum.KeyCode.Insert,
    Intro    = true,
})

local Tab = Win:Tab({ Label="Główna", Icon="🏠" })

Tab:Section("Gracz")

Tab:Button({
    Label    = "Kliknij",
    Callback = function()
        print("klik!")
    end,
})
```

---

## 🪟 E404.Window

```lua
local Win = E404.Window({
    Title    = "Tytuł okna",
    Subtitle = "v1.0 • autor",
    Key      = Enum.KeyCode.Insert,  -- klawisz toggle na PC
    Intro    = true,                 -- false = brak animacji intro
})
```

> Okno **otwiera się automatycznie** po zakończeniu intro.  
> Na mobile zamiast klawisza pojawia się pływający przycisk ⚡.

---

## 📑 Win:Tab

```lua
local Tab = Win:Tab({
    Label = "Gracz",   -- tooltip w sidebarze
    Icon  = "🏃",      -- emoji w pasku bocznym
})
```

---

## 🎛️ Elementy

### Tab:Section
```lua
Tab:Section("Nazwa sekcji")
```

---

### Tab:Button
```lua
Tab:Button({
    Label    = "Kliknij mnie",
    Desc     = "Opis pod spodem (opcjonalny)",
    Callback = function() end,
})
```

---

### Tab:Toggle
```lua
local t = Tab:Toggle({
    Label    = "Fly",
    Desc     = "Tryb lotu",   -- opcjonalny
    Value    = false,         -- stan startowy
    Callback = function(v) print(v) end,
})

t:Set(true)         -- ustaw z kodu
print(t.Value)      -- odczyt
```

---

### Tab:Slider
```lua
local s = Tab:Slider({
    Label    = "WalkSpeed",
    Desc     = "Prędkość chodzenia",  -- opcjonalny
    Min      = 16,
    Max      = 250,
    Step     = 1,
    Value    = 16,
    Unit     = " sp/s",               -- tekst za liczbą
    Callback = function(v) print(v) end,
})

s:Set(100)
print(s.Value)
```

---

### Tab:Dropdown
```lua
local d = Tab:Dropdown({
    Label    = "Lokacja",
    Options  = {"Spawn", "Sklep", "Boss"},
    Selected = "Spawn",
    Callback = function(v) print(v) end,
})

d:Set("Sklep")              -- ustaw z kodu
d:Reload({"Nowa1","Nowa2"}) -- zamień opcje
print(d.Value)
```

---

### Tab:Input
```lua
local i = Tab:Input({
    Label    = "Pole tekstowe",
    Hint     = "Wpisz coś...",
    Default  = "",
    Callback = function(txt) print(txt) end,  -- po Enter / utracie focusu
})

i:Set("nowy tekst")
print(i.Value)
```

---

### Tab:Keybind
```lua
local k = Tab:Keybind({
    Label    = "Sprint",
    Default  = "LeftShift",   -- nazwa z Enum.KeyCode
    Callback = function(key) print(key.Name) end,
})

k:Set(Enum.KeyCode.F)
print(k.Value)  -- Enum.KeyCode
```

---

### Tab:Label
```lua
Tab:Label("Jakiś tekst informacyjny")
```

---

### Tab:Paragraph
```lua
Tab:Paragraph({
    Title = "Nagłówek",
    Body  = "Dłuższy opis...",
})
```

---

### Tab:Divider
```lua
Tab:Divider()
```

---

## 🔔 E404.Notify

```lua
E404.Notify({
    Title    = "Tytuł",
    Message  = "Treść",
    Duration = 4,       -- sekundy, domyślnie 4
    Type     = "ok",    -- "ok" | "fail" | "warn" | "info"
})
```

| Typ | Kolor | Ikona |
|-----|-------|-------|
| `"ok"`   | 🟢 Zielony       | ✓ |
| `"fail"` | 🔴 Czerwony      | ✕ |
| `"warn"` | 🟡 Pomarańczowy  | ⚠ |
| `"info"` | 🟣 Fioletowy     | ℹ |

---

## 🔧 Metody okna

```lua
Win:Open()     -- otwórz
Win:Close()    -- zamknij
Win:Toggle()   -- przełącz
Win:Destroy()  -- usuń GUI
```

---

## 📁 Pliki

```
Error404UI/
├── Error404ui.lua  ← biblioteka
├── Example.lua     ← przykład
└── README.md       ← docs
```

---

<div align="center">⚡ <b>ERROR 404 UI</b> by RastGit</div>
