# ⚡ ERROR 404 UI Library

<div align="center">

![Version](https://img.shields.io/badge/version-1.0-blueviolet?style=for-the-badge)
![Roblox](https://img.shields.io/badge/platform-Roblox-red?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)

**Lekka, stylowa biblioteka GUI dla Roblox.**  
Ciemny motyw, płynne animacje, intro `ERROR` → `404`, pełna obsługa PC i mobile.

</div>

---

## 📋 Spis treści

- [Szybki start](#-szybki-start)
- [Tworzenie okna](#-tworzenie-okna-windowcreate)
- [Zakładki (Tabs)](#-zakładki-tabs)
- [Sekcje](#-sekcje)
- [Elementy UI](#-elementy-ui)
  - [Przycisk](#przycisk-addbutton)
  - [Toggle](#toggle-addtoggle)
  - [Slider](#slider-addslider)
  - [Dropdown](#dropdown-adddropdown)
  - [TextBox](#textbox-addtextbox)
  - [Keybind](#keybind-addkeybind)
  - [Label](#label-addlabel)
  - [Separator](#separator-addseparator)
- [Powiadomienia](#-powiadomienia)
- [Własny motyw](#-własny-motyw)
- [Metody okna](#-metody-okna)
- [FAQ](#-faq)

---

## 🚀 Szybki start

```lua
local Error404UI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/TWOJ_GITHUB/Error404UI/main/Error404UI.lua"
))()

local Window = Error404UI.new({
    Title     = "Mój Script",
    Subtitle  = "v1.0",
    ShowIntro = true,
})

local Tab = Window:AddTab({ Title = "Główna", Icon = "🏠" })
local Section = Tab:AddSection("Gracz")

Section:AddButton({
    Title    = "Kliknij mnie",
    Callback = function()
        print("Kliknięto!")
    end,
})
```

---

## 🪟 Tworzenie okna (`Error404UI.new`)

```lua
local Window = Error404UI.new({
    Title     = "Nazwa menu",        -- Tytuł w pasku (string)
    Subtitle  = "v1.0 • autor",      -- Podtytuł pod tytułem (string)
    ToggleKey = Enum.KeyCode.Insert, -- Klawisz otwierania na PC (domyślnie: Insert)
    ShowIntro = true,                -- Czy pokazać intro ERROR/404 (domyślnie: true)
    Size      = {                    -- Opcjonalny rozmiar okna
        Width  = 340,
        Height = 540,
    },
    Theme = {                        -- Opcjonalne nadpisanie kolorów (patrz: Własny motyw)
        Accent = Color3.fromRGB(255, 50, 100),
    },
})
```

| Parametr | Typ | Domyślnie | Opis |
|----------|-----|-----------|------|
| `Title` | `string` | `"ERROR 404 UI"` | Tytuł okna |
| `Subtitle` | `string` | `"v1.0"` | Podtytuł |
| `ToggleKey` | `Enum.KeyCode` | `Insert` | Klawisz toggle (PC) |
| `ShowIntro` | `bool` | `true` | Animacja intro |
| `Size.Width` | `number` | `340` | Szerokość okna w px |
| `Size.Height` | `number` | `540` | Wysokość okna w px |
| `Theme` | `table` | *(domyślny motyw)* | Nadpisanie kolorów |

---

## 📑 Zakładki (Tabs)

Zakładki to główne sekcje menu, widoczne jako ikony na lewym pasku.

```lua
local Tab = Window:AddTab({
    Title = "Gracz",   -- Tekst tooltipa przy hoverze
    Icon  = "🏠",      -- Emoji lub znak (wyświetlany w pasku bocznym)
})
```

| Parametr | Typ | Opis |
|----------|-----|------|
| `Title` | `string` | Tooltip pokazujący się po najechaniu |
| `Icon` | `string` | Ikona (emoji lub Unicode) |

**Zwraca:** obiekt `Tab`, na którym wywołujesz dalsze metody.

---

## 📦 Sekcje

Sekcje grupują elementy wewnątrz zakładki z nagłówkiem.

```lua
local Section = Tab:AddSection("Ustawienia gracza")
```

Elementy dodane do `Section` zachowują kolejność layoutu.  
Możesz dodawać elementy **bezpośrednio do zakładki** (`Tab:AddButton(...)`) lub **do sekcji** (`Section:AddButton(...)`).

---

## 🎛️ Elementy UI

### Przycisk (`AddButton`)

```lua
Section:AddButton({
    Title    = "Teleportuj do spawna",
    Callback = function()
        -- kod po kliknięciu
    end,
    Color = Color3.fromRGB(220, 50, 90), -- opcjonalny kolor tła (domyślnie: Surface)
})
```

| Parametr | Typ | Opis |
|----------|-----|------|
| `Title` | `string` | Tekst przycisku |
| `Callback` | `function` | Funkcja wywoływana po kliknięciu |
| `Color` | `Color3` | Kolor tła (opcjonalny) |

---

### Toggle (`AddToggle`)

Przełącznik włącz/wyłącz.

```lua
local myToggle = Section:AddToggle({
    Title    = "Fly",
    Default  = false,      -- stan początkowy
    Callback = function(value)
        print("Toggle:", value)  -- value = true/false
    end,
})

-- Odczyt wartości:
print(myToggle.Value)

-- Ustawienie wartości z kodu:
myToggle:SetValue(true)
```

| Parametr | Typ | Opis |
|----------|-----|------|
| `Title` | `string` | Etykieta |
| `Default` | `bool` | Stan początkowy |
| `Callback` | `function(bool)` | Wywołanie przy zmianie |

**Zwraca:** `{ Value: bool, SetValue(bool) }`

---

### Slider (`AddSlider`)

Suwak z zakresem liczbowym.

```lua
local mySlider = Section:AddSlider({
    Title    = "WalkSpeed",
    Min      = 16,
    Max      = 200,
    Default  = 16,
    Suffix   = " studs/s",   -- tekst po wartości (opcjonalny)
    Callback = function(value)
        print("Slider:", value)
    end,
})

-- Odczyt:
print(mySlider.Value)

-- Ustawienie:
mySlider:SetValue(50)
```

| Parametr | Typ | Opis |
|----------|-----|------|
| `Title` | `string` | Etykieta |
| `Min` | `number` | Minimalna wartość |
| `Max` | `number` | Maksymalna wartość |
| `Default` | `number` | Wartość startowa |
| `Suffix` | `string` | Tekst po wartości (np. `"%"`) |
| `Callback` | `function(number)` | Wywołanie przy zmianie |

**Zwraca:** `{ Value: number, SetValue(number) }`

---

### Dropdown (`AddDropdown`)

Lista rozwijana z opcjami.

```lua
local myDropdown = Section:AddDropdown({
    Title    = "Lokacja",
    Options  = {"Spawn", "Sklep", "Boss"},
    Default  = "Spawn",
    Callback = function(selected)
        print("Wybrano:", selected)
    end,
})

-- Odczyt:
print(myDropdown.Value)

-- Ustawienie:
myDropdown:SetValue("Sklep")

-- Odświeżenie opcji:
myDropdown:Refresh({"Nowa opcja 1", "Nowa opcja 2"})
```

| Parametr | Typ | Opis |
|----------|-----|------|
| `Title` | `string` | Etykieta |
| `Options` | `{string}` | Lista opcji |
| `Default` | `string` | Domyślna opcja |
| `Callback` | `function(string)` | Wywołanie przy wyborze |

**Zwraca:** `{ Value: string, SetValue(str), Refresh(table) }`

---

### TextBox (`AddTextBox`)

Pole tekstowe do wpisywania tekstu.

```lua
local myTextBox = Section:AddTextBox({
    Title       = "Nazwa",
    Placeholder = "Wpisz nick...",
    Default     = "",
    Callback    = function(text)
        -- wywoływane po utracie fokusa lub naciśnięciu Enter
        print("Tekst:", text)
    end,
})

-- Odczyt:
print(myTextBox.Value)

-- Ustawienie:
myTextBox:SetValue("nowy tekst")
```

| Parametr | Typ | Opis |
|----------|-----|------|
| `Title` | `string` | Etykieta nad polem |
| `Placeholder` | `string` | Tekst pomocniczy |
| `Default` | `string` | Tekst startowy |
| `Callback` | `function(string)` | Wywołanie po zatwierdzeniu |

**Zwraca:** `{ Value: string, SetValue(str) }`

---

### Keybind (`AddKeybind`)

Przycisk do bindowania klawiszy.

```lua
local myKeybind = Section:AddKeybind({
    Title    = "Sprint",
    Default  = Enum.KeyCode.LeftShift,
    Callback = function(keyCode)
        print("Nowy klawisz:", keyCode.Name)
    end,
})

-- Odczyt:
print(myKeybind.Value)  -- zwraca Enum.KeyCode

-- Ustawienie:
myKeybind:SetValue(Enum.KeyCode.F)
```

> Kliknij przycisk w UI → wciśnij dowolny klawisz → zostaje zapisany.

| Parametr | Typ | Opis |
|----------|-----|------|
| `Title` | `string` | Etykieta |
| `Default` | `Enum.KeyCode` | Domyślny klawisz |
| `Callback` | `function(KeyCode)` | Wywołanie po zmianie |

**Zwraca:** `{ Value: KeyCode, SetValue(KeyCode) }`

---

### Label (`AddLabel`)

Tekst informacyjny (read-only).

```lua
Tab:AddLabel("Wersja: 1.0.0")
Tab:AddLabel("Autor: Ktoś")
```

---

### Separator (`AddSeparator`)

Pozioma linia oddzielająca elementy.

```lua
Section:AddSeparator()
```

---

## 🔔 Powiadomienia

Powiadomienia są **globalne** – nie wymagają instancji okna.

```lua
Error404UI.Notify({
    Title    = "Tytuł",
    Message  = "Treść powiadomienia...",
    Duration = 4,             -- czas w sekundach (domyślnie: 4)
    Type     = "success",     -- "success" | "error" | "warning" | "info"
})
```

| Typ | Kolor | Ikona |
|-----|-------|-------|
| `"success"` | Zielony | ✓ |
| `"error"` | Czerwony | ✕ |
| `"warning"` | Pomarańczowy | ⚠ |
| `"info"` | Fioletowy | ℹ |

**Przykłady:**

```lua
-- Sukces
Error404UI.Notify({ Title = "Gotowe!", Message = "Fly włączony.", Type = "success" })

-- Błąd
Error404UI.Notify({ Title = "Błąd", Message = "Nie można połączyć.", Type = "error", Duration = 6 })

-- Ostrzeżenie
Error404UI.Notify({ Title = "Uwaga", Message = "Serwer jest pełny.", Type = "warning" })

-- Info
Error404UI.Notify({ Title = "Info", Message = "Nowa wersja dostępna.", Type = "info" })
```

---

## 🎨 Własny motyw

Podaj tabelę `Theme` przy tworzeniu okna, żeby nadpisać wybrane kolory:

```lua
local Window = Error404UI.new({
    Title = "Red Theme",
    Theme = {
        Accent      = Color3.fromRGB(220, 50, 90),
        AccentLight = Color3.fromRGB(255, 80, 120),
        AccentDark  = Color3.fromRGB(160, 20, 60),
        Toggle_On   = Color3.fromRGB(220, 50, 90),
    },
})
```

### Pełna lista kluczy motywu

| Klucz | Domyślny kolor | Opis |
|-------|---------------|------|
| `Background` | `RGB(14,14,22)` | Tło okna |
| `Surface` | `RGB(22,22,34)` | Tło elementów |
| `SurfaceLight` | `RGB(30,30,46)` | Jaśniejsze tło |
| `SurfaceMid` | `RGB(26,26,40)` | Średnie tło |
| `Accent` | `RGB(100,60,255)` | Kolor akcentu |
| `AccentLight` | `RGB(140,90,255)` | Jasny akcent |
| `AccentDark` | `RGB(60,30,180)` | Ciemny akcent |
| `Text` | `RGB(235,235,255)` | Tekst główny |
| `TextDim` | `RGB(140,135,170)` | Tekst przyciemniony |
| `TextMuted` | `RGB(90,85,120)` | Tekst wyciszony |
| `Border` | `RGB(50,40,85)` | Obramowania |
| `Danger` | `RGB(220,50,90)` | Kolor błędu/danger |
| `Success` | `RGB(60,210,130)` | Kolor sukcesu |
| `Warning` | `RGB(255,175,50)` | Kolor ostrzeżenia |
| `Toggle_On` | `RGB(100,60,255)` | Toggle włączony |
| `Toggle_Off` | `RGB(50,45,75)` | Toggle wyłączony |

---

## 🔧 Metody okna

```lua
-- Otwórz menu
Window:Open()

-- Zamknij menu
Window:Close()

-- Przełącz (open ↔ close)
Window:Toggle()

-- Usuń całe GUI
Window:Destroy()
```

---

## ❓ FAQ

**Q: Czy działa na mobile?**  
A: Tak. Na urządzeniach mobilnych automatycznie pojawia się pływający przycisk ⚡ w lewym dolnym rogu.

**Q: Jak zmienić klawisz otwierania?**  
A: Ustaw `ToggleKey = Enum.KeyCode.TWÓJ_KLAWISZ` przy tworzeniu okna.

**Q: Okno znika po respawnie?**  
A: Biblioteka ustawia `ResetOnSpawn = false` i używa `CoreGui`, więc menu powinno zostać.

**Q: Jak wyłączyć intro animację?**  
A: Ustaw `ShowIntro = false` przy tworzeniu okna.

**Q: Czy mogę mieć kilka okien naraz?**  
A: Tak, każde wywołanie `Error404UI.new(...)` tworzy niezależne okno z własnym ScreenGui.

**Q: Jak zrobić przycisk w kolorze czerwonym (danger)?**  
A: Użyj parametru `Color`:
```lua
Section:AddButton({
    Title = "Usuń",
    Color = Color3.fromRGB(220, 50, 90),
    Callback = function() end,
})
```

---

## 📁 Struktura plików

```
Error404UI/
├── Error404UI.lua    ← główna biblioteka
├── Example.lua       ← przykład użycia
└── README.md         ← ta dokumentacja
```

---

## 📜 Licencja

MIT — możesz używać, modyfikować i dystrybuować dowolnie.

---

<div align="center">
Made with ⚡ — <b>ERROR 404 UI Library</b>
</div>
