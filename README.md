# ⚡ ERROR 404 UI Library

<div align="center">

![Version](https://img.shields.io/badge/version-4.0-blueviolet?style=for-the-badge)
![Roblox](https://img.shields.io/badge/Roblox-Executor_Safe-success?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-blue?style=for-the-badge)

**Nowoczesna biblioteka GUI dla Roblox**  
Własne API | PC + Mobile | Wszystkie executory | Działające funkcje

[Szybki Start](#-szybki-start) • [Dokumentacja](#-dokumentacja) • [Przykłady](#-przykłady)

</div>

---

## 📋 Spis treści

- [Funkcje](#-funkcje)
- [Instalacja](#-instalacja)
- [Szybki start](#-szybki-start)
- [Dokumentacja](#-dokumentacja)
  - [CreateWindow](#createwindow)
  - [CreateTab](#createtab)
  - [Elementy UI](#elementy-ui)
    - [AddSection](#addsection)
    - [AddButton](#addbutton)
    - [AddToggle](#addtoggle)
    - [AddSlider](#addslider)
    - [AddDropdown](#adddropdown)
    - [AddLabel](#addlabel)
    - [AddParagraph](#addparagraph)
  - [Notify](#notify)
- [Metody okna](#metody-okna)
- [Pełny przykład](#-pełny-przykład)
- [FAQ](#-faq)

---

## ⚡ Funkcje

- ✅ **Executor-safe** — działa na wszystkich popularnych executorach
- ✅ **PC + Mobile** — automatyczne dostosowanie interfejsu
- ✅ **Intro animacja** — `ERROR → 404` z pulsującym tekstem
- ✅ **Nowoczesny design** — ciemny motyw, zaokrąglone rogi (10px radius)
- ✅ **Drag & drop** — przeciąganie okna za titlebar
- ✅ **Własne API** — proste, czytelne, inspirowane Rayfield
- ✅ **Działające funkcje** — Fly, NoClip, ESP, WalkSpeed w example
- ✅ **Powiadomienia** — 4 typy z paskiem postępu

---

## 📦 Instalacja

### Jak uzyskać stały link (bez tokenu)?

⚠️ **Token w raw URL wygasa po kilku godzinach!**

Aby link działał **zawsze**:

1. Wejdź w swoje repo na GitHub
2. **Settings** → **Danger Zone** → **Change visibility** → **Make public**
3. Twój stały link:
```
https://raw.githubusercontent.com/RastGit/ERROR404-UI/main/Error404UI.lua
```

Bez `?token=...` — działa wiecznie dla wszystkich.

---

## 🚀 Szybki start

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RastGit/ERROR404-UI/main/Error404UI.lua"
))()

local Window = Library.CreateWindow({
    Name = "Mój Script",
    Version = "v1.0",
    ToggleKey = Enum.KeyCode.Insert,
    ShowIntro = true,
})

local Tab = Window:CreateTab({
    Name = "Główna",
    Icon = "🏠",
})

Tab:AddSection("Gracz")

Tab:AddButton({
    Name = "Teleport do spawna",
    Callback = function()
        print("Teleportowanie...")
    end,
})
```

**Co się stanie:**
1. Odtworzy się intro `ERROR → 404` (5 sekund)
2. Okno otworzy się automatycznie po intro
3. Na **mobile** pojawi się pływający przycisk ⚡ w lewym dolnym rogu
4. Na **PC** klawisz `INSERT` otwiera/zamyka menu

---

## 📚 Dokumentacja

### CreateWindow

Tworzy główne okno aplikacji.

```lua
local Window = Library.CreateWindow({
    Name        = "Nazwa scriptu",    -- Tytuł w titlebarze
    Version     = "v1.0",             -- Badge wersji
    ToggleKey   = Enum.KeyCode.Insert, -- Klawisz toggle (tylko PC)
    ShowIntro   = true,               -- false = pomiń intro
})
```

**Parametry:**

| Parametr | Typ | Domyślnie | Opis |
|----------|-----|-----------|------|
| `Name` | `string` | `"ERROR 404 UI"` | Tytuł okna |
| `Version` | `string` | `"v4.0"` | Wersja w badge |
| `ToggleKey` | `Enum.KeyCode` | `Insert` | Klawisz do otwierania/zamykania (PC) |
| `ShowIntro` | `boolean` | `true` | Czy pokazać animację intro |

**Uwagi:**
- Okno **otwiera się automatycznie** po zakończeniu intro
- Na mobile `ToggleKey` jest ignorowany — pojawia się przycisk ⚡
- Jeśli `ShowIntro = false`, okno otworzy się natychmiast

**Przykład:**
```lua
local Window = Library.CreateWindow({
    Name = "Admin Commands",
    Version = "v2.5",
    ToggleKey = Enum.KeyCode.RightShift,
    ShowIntro = false,  -- bez intro
})
```

---

### CreateTab

Tworzy zakładkę (tab) w menu.

```lua
local Tab = Window:CreateTab({
    Name = "Nazwa zakładki",  -- Tekst w górnym pasku
    Icon = "🏠",               -- Emoji/ikona
})
```

**Parametry:**

| Parametr | Typ | Opis |
|----------|-----|------|
| `Name` | `string` | Nazwa zakładki wyświetlana w górnym pasku |
| `Icon` | `string` | Emoji lub znak Unicode przed nazwą |

**Przykłady:**
```lua
local TabPlayer = Window:CreateTab({ Name = "Gracz", Icon = "👤" })
local TabVisual = Window:CreateTab({ Name = "Visual", Icon = "👁" })
local TabSettings = Window:CreateTab({ Name = "Ustawienia", Icon = "⚙️" })
```

**Uwagi:**
- Pierwsza zakładka jest aktywna domyślnie
- Maksymalnie ~6-8 zakładek zmieści się w pasku (responsywne)
- Ikony są opcjonalne ale zalecane dla czytelności

---

## Elementy UI

### AddSection

Dodaje nagłówek sekcji — grupuje elementy wizualnie.

```lua
Tab:AddSection("Nazwa sekcji")
```

**Przykład:**
```lua
Tab:AddSection("Ruch")
-- elementy ruchu

Tab:AddSection("Akcje")
-- elementy akcji
```

**Wygląd:** Wielkie litery + linia oddzielająca

---

### AddButton

Dodaje klikalny przycisk.

```lua
Tab:AddButton({
    Name        = "Nazwa przycisku",
    Description = "Opis pod nazwą (opcjonalny)",  -- może być nil
    Icon        = "🎯",                           -- opcjonalny
    Callback    = function()
        -- kod wykonywany po kliknięciu
    end,
})
```

**Parametry:**

| Parametr | Typ | Wymagany | Opis |
|----------|-----|----------|------|
| `Name` | `string` | ✅ | Tekst przycisku |
| `Description` | `string` | ❌ | Drugi wiersz opisu (mniejszy tekst) |
| `Icon` | `string` | ❌ | Emoji w kwadratowym boxie po lewej |
| `Callback` | `function` | ✅ | Funkcja wywoływana po kliknięciu |

**Przykłady:**
```lua
-- Prosty przycisk
Tab:AddButton({
    Name = "Resetuj postać",
    Callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
    end,
})

-- Z opisem i ikoną
Tab:AddButton({
    Name = "Teleport do spawna",
    Description = "Przenosi do punktu startowego",
    Icon = "📍",
    Callback = function()
        -- kod teleportacji
    end,
})
```

**Wygląd:**
- Bez opisu: wysokość 44px
- Z opisem: wysokość 54px
- Hover: jaśniejsze tło
- Click: ciemniejsze tło → animacja

---

### AddToggle

Przełącznik włącz/wyłącz.

```lua
local MyToggle = Tab:AddToggle({
    Name         = "Nazwa toggle",
    Description  = "Opis (opcjonalny)",
    Icon         = "⚡",                -- opcjonalny
    CurrentValue = false,              -- stan początkowy
    Callback     = function(Value)
        print(Value)  -- true lub false
    end,
})

-- Ustawienie z kodu:
MyToggle:Set(true)

-- Odczyt wartości:
print(MyToggle.Value)  -- true/false
```

**Parametry:**

| Parametr | Typ | Wymagany | Domyślnie | Opis |
|----------|-----|----------|-----------|------|
| `Name` | `string` | ✅ | - | Tekst togglea |
| `Description` | `string` | ❌ | `nil` | Opis pod nazwą |
| `Icon` | `string` | ❌ | `nil` | Emoji w boxie |
| `CurrentValue` | `boolean` | ❌ | `false` | Stan początkowy |
| `Callback` | `function(bool)` | ✅ | - | Wywoływane przy zmianie |

**Metody:**

| Metoda | Opis |
|--------|------|
| `:Set(value)` | Ustawia toggle na `true` lub `false` |
| `.Value` | Właściwość — aktualny stan (`true`/`false`) |

**Przykład praktyczny — Fly:**
```lua
local FlyEnabled = false

local FlyToggle = Tab:AddToggle({
    Name = "Latanie (Fly)",
    Description = "WASD + Space/Shift do sterowania",
    Icon = "✈️",
    CurrentValue = false,
    Callback = function(Value)
        FlyEnabled = Value
        if Value then
            -- włącz fly
            StartFly()
        else
            -- wyłącz fly
            StopFly()
        end
    end,
})

-- Później w kodzie:
if jakaśKondycja then
    FlyToggle:Set(false)  -- wyłącz z kodu
end
```

**Uwagi:**
- Callback NIE jest wywoływany przy `:Set()` — tylko przy kliknięciu użytkownika
- Toggle ma osobną clickable area — nie nakłada się z resztą row

---

### AddSlider

Suwak do wyboru wartości liczbowej.

```lua
local MySlider = Tab:AddSlider({
    Name         = "Nazwa slidera",
    Description  = "Opis (opcjonalny)",
    Min          = 0,                 -- minimum
    Max          = 100,               -- maximum
    Increment    = 1,                 -- krok (co ile zmienia się wartość)
    CurrentValue = 50,                -- wartość startowa
    Suffix       = "%",               -- tekst za wartością (opcjonalny)
    Callback     = function(Value)
        print(Value)  -- liczba
    end,
})

-- Ustawienie z kodu:
MySlider:Set(75)

-- Odczyt wartości:
print(MySlider.Value)  -- 75
```

**Parametry:**

| Parametr | Typ | Wymagany | Domyślnie | Opis |
|----------|-----|----------|-----------|------|
| `Name` | `string` | ✅ | - | Tekst slidera |
| `Description` | `string` | ❌ | `nil` | Opis pod nazwą |
| `Min` | `number` | ❌ | `0` | Wartość minimalna |
| `Max` | `number` | ❌ | `100` | Wartość maksymalna |
| `Increment` | `number` | ❌ | `1` | Krok zmiany (np. `5` = co 5) |
| `CurrentValue` | `number` | ❌ | `Min` | Wartość początkowa |
| `Suffix` | `string` | ❌ | `""` | Tekst po wartości (np. `"%"`, `" sp/s"`) |
| `Callback` | `function(number)` | ✅ | - | Wywoływane przy zmianie |

**Metody:**

| Metoda | Opis |
|--------|------|
| `:Set(value)` | Ustawia wartość slidera |
| `.Value` | Właściwość — aktualna wartość |

**Przykłady:**
```lua
-- WalkSpeed
local SpeedSlider = Tab:AddSlider({
    Name = "Prędkość chodzenia",
    Description = "16 = domyślnie",
    Min = 16,
    Max = 250,
    Increment = 1,
    CurrentValue = 16,
    Suffix = " sp/s",
    Callback = function(Value)
        local humanoid = game.Players.LocalPlayer.Character.Humanoid
        humanoid.WalkSpeed = Value
    end,
})

-- FOV
local FOVSlider = Tab:AddSlider({
    Name = "Pole widzenia (FOV)",
    Min = 70,
    Max = 120,
    Increment = 1,
    CurrentValue = 70,
    Suffix = "°",
    Callback = function(Value)
        workspace.CurrentCamera.FieldOfView = Value
    end,
})

-- Volume (0-100%)
local VolumeSlider = Tab:AddSlider({
    Name = "Głośność",
    Min = 0,
    Max = 100,
    Increment = 5,
    CurrentValue = 50,
    Suffix = "%",
    Callback = function(Value)
        game.SoundService.Volume = Value / 100
    end,
})
```

**Wygląd:**
- Bez opisu: wysokość 56px
- Z opisem: wysokość 64px
- Fioletowy fill + biały thumb (kółko)
- Wartość wyświetlana po prawej stronie

---

### AddDropdown

Lista rozwijana z opcjami.

```lua
local MyDropdown = Tab:AddDropdown({
    Name          = "Nazwa dropdown",
    Options       = {"Opcja 1", "Opcja 2", "Opcja 3"},
    CurrentOption = "Opcja 1",  -- domyślnie wybrana
    Callback      = function(Value)
        print(Value)  -- string
    end,
})

-- Ustawienie z kodu:
MyDropdown:Set("Opcja 2")

-- Odczyt:
print(MyDropdown.Value)  -- "Opcja 2"

-- Zmiana opcji (nowa lista):
MyDropdown:Refresh({"Nowa A", "Nowa B", "Nowa C"})
```

**Parametry:**

| Parametr | Typ | Wymagany | Opis |
|----------|-----|----------|------|
| `Name` | `string` | ✅ | Etykieta dropdown |
| `Options` | `{string}` | ✅ | Tablica opcji |
| `CurrentOption` | `string` | ❌ | Domyślnie wybrana (pierwsza jeśli nil) |
| `Callback` | `function(string)` | ✅ | Wywoływane przy wyborze |

**Metody:**

| Metoda | Opis |
|--------|------|
| `:Set(value)` | Wybiera opcję o podanej nazwie |
| `:Refresh(options)` | Zamienia listę opcji na nową |
| `.Value` | Właściwość — aktualnie wybrana opcja |

**Przykład — teleport:**
```lua
local locations = {
    Spawn = Vector3.new(0, 5, 0),
    Shop = Vector3.new(100, 5, 200),
    Boss = Vector3.new(-50, 10, 300),
}

local LocationDropdown = Tab:AddDropdown({
    Name = "Lokacja",
    Options = {"Spawn", "Shop", "Boss"},
    CurrentOption = "Spawn",
    Callback = function(Value)
        print("Wybrano:", Value)
    end,
})

Tab:AddButton({
    Name = "Teleportuj",
    Callback = function()
        local selected = LocationDropdown.Value
        local pos = locations[selected]
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
    end,
})
```

**Wygląd:**
- Wysokość zamknięta: 44px
- Po kliknięciu: animacja rozwinięcia (Back easing)
- Hover na opcjach: fioletowe tło
- Wybrana opcja: półprzezroczyste fioletowe tło

---

### AddLabel

Tekst informacyjny (nie ma interakcji).

```lua
Tab:AddLabel("Jakiś tekst informacyjny")
```

**Przykład:**
```lua
Tab:AddSection("Informacje")
Tab:AddLabel("Wersja: 4.0")
Tab:AddLabel("Autor: RastGit")
Tab:AddLabel("Discord: wkrótce...")
```

**Wygląd:** Szary tekst, wysokość 24px

---

### AddParagraph

Blok tekstu z tytułem — do dłuższych opisów.

```lua
Tab:AddParagraph({
    Title   = "Nagłówek",
    Content = "Dłuższy tekst...\nMoże mieć wiele linii.",
})
```

**Parametry:**

| Parametr | Typ | Opis |
|----------|-----|------|
| `Title` | `string` | Tytuł (bold, większy) |
| `Content` | `string` | Treść (mniejszy tekst, wrapped) |

**Przykład:**
```lua
Tab:AddParagraph({
    Title = "O bibliotece",
    Content = "ERROR 404 UI to nowoczesna biblioteka GUI dla Roblox. Działa na wszystkich executorach i wspiera PC oraz mobile.",
})

Tab:AddParagraph({
    Title = "Skróty klawiszowe",
    Content = "INSERT - Otwórz/zamknij menu\nWASD - Latanie (gdy Fly włączony)\nSpace - W górę\nShift - W dół",
})
```

**Wygląd:**
- Zaokrąglony box (7px radius)
- Padding 12px
- Auto-height (dostosowuje się do treści)
- Tytuł: bold, 13px
- Content: 12px, wrapped text

---

## Notify

Globalna funkcja do wyświetlania powiadomień.

```lua
Library.Notify({
    Title    = "Tytuł powiadomienia",
    Content  = "Treść wiadomości...",
    Duration = 4,              -- sekundy (domyślnie 4)
    Type     = "Success",      -- "Success" | "Error" | "Warning" | "Info"
})
```

**Parametry:**

| Parametr | Typ | Domyślnie | Opis |
|----------|-----|-----------|------|
| `Title` | `string` | `"Notification"` | Tytuł powiadomienia |
| `Content` | `string` | `""` | Treść wiadomości |
| `Duration` | `number` | `4` | Czas wyświetlania w sekundach |
| `Type` | `string` | `"Info"` | Typ powiadomienia |

**Typy powiadomień:**

| Typ | Kolor | Ikona | Użycie |
|-----|-------|-------|--------|
| `"Success"` | 🟢 Zielony | ✓ | Operacja zakończona sukcesem |
| `"Error"` | 🔴 Czerwony | ✕ | Błąd / niepowodzenie |
| `"Warning"` | 🟡 Pomarańczowy | ⚠ | Ostrzeżenie |
| `"Info"` | 🟣 Fioletowy | ℹ | Informacja neutralna |

**Przykłady:**
```lua
-- Sukces
Library.Notify({
    Title = "Zapisano!",
    Content = "Ustawienia zostały zapisane",
    Type = "Success",
    Duration = 3,
})

-- Błąd
Library.Notify({
    Title = "Błąd połączenia",
    Content = "Nie udało się połączyć z serwerem",
    Type = "Error",
    Duration = 5,
})

-- Ostrzeżenie
Library.Notify({
    Title = "Niska prędkość",
    Content = "WalkSpeed poniżej 16 może spowodować problemy",
    Type = "Warning",
})

-- Info
Library.Notify({
    Title = "Aktualizacja",
    Content = "Nowa wersja dostępna: v4.1",
    Type = "Info",
})
```

**Wygląd:**
- Pozycja: prawy dolny róg
- Animacja wejścia: slide-in z prawej
- Pasek postępu na dole (odlicza Duration)
- Automatyczne znikanie po Duration sekundach
- Radius: 10px (lekko zaokrąglone)

---

## Metody okna

Window (obiekt zwracany przez `CreateWindow`) ma następujące metody:

```lua
Window:Open()     -- Otwiera menu
Window:Close()    -- Zamyka menu
Window:Toggle()   -- Przełącza open/close
Window:Destroy()  -- Usuwa całe GUI (nie da się cofnąć)
```

**Przykład:**
```lua
-- Programowe zamknięcie po 10 sekundach
task.delay(10, function()
    Window:Close()
end)

-- Binding własnego klawisza
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Q then
        Window:Toggle()
    end
end)
```

**Uwagi:**
- `Open()` / `Close()` mają animacje (nie są instant)
- `Destroy()` usuwa ScreenGui — nie można przywrócić
- `Toggle()` sprawdza czy jest otwarte i wykonuje odpowiednią akcję

---

## 📖 Pełny przykład

Kompletny working script z Fly, NoClip, ESP:

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RastGit/ERROR404-UI/main/Error404UI.lua"
))()

local Window = Library.CreateWindow({
    Name = "Mój Cheat",
    Version = "v1.0",
    ShowIntro = true,
})

-- ══════════════════════════════════════════
-- ZAKŁADKA: GRACZ
-- ══════════════════════════════════════════
local TabPlayer = Window:CreateTab({ Name = "Gracz", Icon = "👤" })

TabPlayer:AddSection("Ruch")

-- Fly
local FlyEnabled = false
local FlyToggle = TabPlayer:AddToggle({
    Name = "Latanie",
    Description = "WASD + Space/Shift",
    CurrentValue = false,
    Callback = function(Value)
        FlyEnabled = Value
        -- tutaj kod fly (patrz Example.lua)
    end,
})

-- WalkSpeed
TabPlayer:AddSlider({
    Name = "Prędkość chodzenia",
    Min = 16,
    Max = 250,
    CurrentValue = 16,
    Suffix = " sp/s",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})

TabPlayer:AddSection("Akcje")

TabPlayer:AddButton({
    Name = "Reset postaci",
    Icon = "🔄",
    Callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
    end,
})

-- ══════════════════════════════════════════
-- ZAKŁADKA: VISUAL
-- ══════════════════════════════════════════
local TabVisual = Window:CreateTab({ Name = "Visual", Icon = "👁" })

TabVisual:AddToggle({
    Name = "ESP",
    Description = "Box ESP dla graczy",
    CurrentValue = false,
    Callback = function(Value)
        -- tutaj kod ESP (patrz Example.lua)
    end,
})

-- ══════════════════════════════════════════
-- ZAKŁADKA: USTAWIENIA
-- ══════════════════════════════════════════
local TabSettings = Window:CreateTab({ Name = "Ustawienia", Icon = "⚙️" })

TabSettings:AddParagraph({
    Title = "O skrypcie",
    Content = "Wersja: 1.0\nAutor: Ty\nDziała na wszystkich executorach",
})

-- ══════════════════════════════════════════
-- POWIADOMIENIE STARTOWE
-- ══════════════════════════════════════════
task.delay(6, function()  -- po intro
    Library.Notify({
        Title = "Załadowano!",
        Content = "Skrypt gotowy do użycia",
        Type = "Success",
        Duration = 4,
    })
end)
```

---

## ❓ FAQ

### **Q: Intro się nie wyświetla?**
**A:** Upewnij się że `ShowIntro = true` (domyślnie). Intro działa przez `CoreGui` z fallbackiem na `PlayerGui` — powinno działać na wszystkich executorach.

### **Q: Okno nie otwiera się po intro?**
**A:** Okno **automatycznie** się otwiera po intro. Nie wywołuj `Window:Open()` ręcznie jeśli `ShowIntro = true`.

### **Q: Toggle nie działa — klikam 100 razy?**
**A:** Naprawione w v4.0 — toggle ma teraz osobną clickable area która NIE nakłada się z resztą row. Jeden klik = jedna zmiana.

### **Q: Fly nie działa?**
**A:** Sprawdź czy:
- Używasz `StartFly()` z Example.lua (nie tylko ustawiasz flagę)
- Masz `HumanoidRootPart` w postaci
- Executor obsługuje `BodyVelocity` i `BodyGyro`

### **Q: Działa na mobile?**
**A:** Tak. Na mobile automatycznie pojawia się przycisk ⚡ w lewym dolnym rogu. `ToggleKey` jest ignorowany.

### **Q: Jak zmienić kolory?**
**A:** Edytuj zmienną `Theme` w `Error404UI.lua` (linie 30-50). Zmień wartości RGB.

### **Q: Czy mogę mieć więcej niż jedno okno?**
**A:** Tak, każde `Library.CreateWindow()` tworzy niezależne okno. Ale zalecane jest używanie zakładek zamiast wielu okien.

### **Q: Executor mówi "attempt to index nil"?**
**A:** Sprawdź czy:
- Link do biblioteki jest poprawny
- Repo jest **public** (bez tokenu w URL)
- Czekasz aż loadstring się wykona przed użyciem

### **Q: Jak wyłączyć intro na stałe?**
**A:** W `CreateWindow` ustaw `ShowIntro = false`.

### **Q: WalkSpeed slider nie działa?**
**A:** Upewnij się że postać istnieje i ma `Humanoid`. Dodaj check:
```lua
local humanoid = game.Players.LocalPlayer.Character and 
                 game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
if humanoid then
    humanoid.WalkSpeed = Value
end
```

### **Q: Mogę usunąć badge "v4.0"?**
**A:** Tak, w kodzie biblioteki znajdź `versionBadge` (linia ~550) i usuń lub ustaw `Visible = false`.

---

## 📄 Licencja

MIT License — możesz używać, modyfikować i dystrybuować.

---

<div align="center">

⚡ **ERROR 404 UI Library v4.0**  
Made by **RastGit**

[GitHub](https://github.com/RastGit/ERROR404-UI) • [Issues](https://github.com/RastGit/ERROR404-UI/issues)

</div>
