--[[
╔══════════════════════════════════════════════════════════╗
║     ERROR 404 UI  -  Przykład użycia z działającymi     ║
║     funkcjami: Fly, Noclip, ESP, WalkSpeed               ║
╚══════════════════════════════════════════════════════════╝
]]

local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RastGit/ERROR404-UI/main/Error404UI.lua"
))()

-- ══════════════════════════════════════════════════════════════
-- SERVICES
-- ══════════════════════════════════════════════════════════════
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LP = Players.LocalPlayer

-- ══════════════════════════════════════════════════════════════
-- FUNKCJE POMOCNICZE
-- ══════════════════════════════════════════════════════════════
local function GetCharacter()
    return LP.Character
end

local function GetHumanoid()
    local char = GetCharacter()
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function GetRootPart()
    local char = GetCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- ══════════════════════════════════════════════════════════════
-- FLY SYSTEM
-- ══════════════════════════════════════════════════════════════
local FlyEnabled = false
local FlySpeed = 50
local FlyConnection = nil
local FlyBV = nil
local FlyBG = nil

local function StartFly()
    if FlyEnabled then return end
    FlyEnabled = true
    
    local root = GetRootPart()
    if not root then return end
    
    -- BodyVelocity
    FlyBV = Instance.new("BodyVelocity")
    FlyBV.Velocity = Vector3.new(0, 0, 0)
    FlyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    FlyBV.Parent = root
    
    -- BodyGyro
    FlyBG = Instance.new("BodyGyro")
    FlyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    FlyBG.CFrame = root.CFrame
    FlyBG.Parent = root
    
    FlyConnection = RunService.Heartbeat:Connect(function()
        if not FlyEnabled or not GetRootPart() or not FlyBV or not FlyBG then
            return
        end
        
        local cam = workspace.CurrentCamera
        local direction = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + (cam.CFrame.LookVector * FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - (cam.CFrame.LookVector * FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - (cam.CFrame.RightVector * FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + (cam.CFrame.RightVector * FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            direction = direction + Vector3.new(0, FlySpeed, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            direction = direction - Vector3.new(0, FlySpeed, 0)
        end
        
        FlyBV.Velocity = direction
        FlyBG.CFrame = cam.CFrame
    end)
end

local function StopFly()
    if not FlyEnabled then return end
    FlyEnabled = false
    
    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end
    
    if FlyBV then
        FlyBV:Destroy()
        FlyBV = nil
    end
    
    if FlyBG then
        FlyBG:Destroy()
        FlyBG = nil
    end
end

-- ══════════════════════════════════════════════════════════════
-- NOCLIP SYSTEM
-- ══════════════════════════════════════════════════════════════
local NoclipEnabled = false
local NoclipConnection = nil

local function StartNoclip()
    if NoclipEnabled then return end
    NoclipEnabled = true
    
    NoclipConnection = RunService.Stepped:Connect(function()
        if not NoclipEnabled then return end
        
        local char = GetCharacter()
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function StopNoclip()
    if not NoclipEnabled then return end
    NoclipEnabled = false
    
    if NoclipConnection then
        NoclipConnection:Disconnect()
        NoclipConnection = nil
    end
    
    local char = GetCharacter()
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- ══════════════════════════════════════════════════════════════
-- ESP SYSTEM
-- ══════════════════════════════════════════════════════════════
local ESPEnabled = false
local ESPConnections = {}
local ESPBoxes = {}

local function CreateESPBox(player)
    if player == LP then return end
    
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESP_" .. player.Name
    box.Size = Vector3.new(4, 5, 1)
    box.Color3 = Color3.fromRGB(139, 92, 246)
    box.Transparency = 0.7
    box.ZIndex = 10
    box.AlwaysOnTop = true
    box.Adornee = nil
    box.Parent = game.CoreGui
    
    ESPBoxes[player] = box
    
    local function UpdateBox()
        if not ESPEnabled or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            box.Adornee = nil
            return
        end
        box.Adornee = player.Character.HumanoidRootPart
    end
    
    local conn = RunService.RenderStepped:Connect(UpdateBox)
    ESPConnections[player] = conn
    
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        UpdateBox()
    end)
end

local function RemoveESPBox(player)
    if ESPBoxes[player] then
        ESPBoxes[player]:Destroy()
        ESPBoxes[player] = nil
    end
    if ESPConnections[player] then
        ESPConnections[player]:Disconnect()
        ESPConnections[player] = nil
    end
end

local function StartESP()
    if ESPEnabled then return end
    ESPEnabled = true
    
    for _, player in pairs(Players:GetPlayers()) do
        CreateESPBox(player)
    end
    
    Players.PlayerAdded:Connect(function(player)
        if ESPEnabled then
            CreateESPBox(player)
        end
    end)
    
    Players.PlayerRemoving:Connect(function(player)
        RemoveESPBox(player)
    end)
end

local function StopESP()
    if not ESPEnabled then return end
    ESPEnabled = false
    
    for player, _ in pairs(ESPBoxes) do
        RemoveESPBox(player)
    end
end

-- ══════════════════════════════════════════════════════════════
-- WINDOW
-- ══════════════════════════════════════════════════════════════
local Window = Library.CreateWindow({
    Name = "ERROR 404 Script",
    Version = "v4.0",
    ToggleKey = Enum.KeyCode.Insert,
    ShowIntro = true,
})

-- ══════════════════════════════════════════════════════════════
-- ZAKŁADKA 1: GRACZ
-- ══════════════════════════════════════════════════════════════
local TabPlayer = Window:CreateTab({
    Name = "Gracz",
    Icon = "👤",
})

TabPlayer:AddSection("Ruch")

-- Fly Toggle
local FlyToggle = TabPlayer:AddToggle({
    Name = "Latanie (Fly)",
    Description = "WASD + Space/Shift do sterowania",
    Icon = "✈️",
    CurrentValue = false,
    Callback = function(value)
        if value then
            StartFly()
            Library.Notify({
                Title = "Fly włączony",
                Content = "Użyj WASD + Space/Shift",
                Type = "Success",
                Duration = 3,
            })
        else
            StopFly()
            Library.Notify({
                Title = "Fly wyłączony",
                Content = "Powrót do normalnego ruchu",
                Type = "Info",
                Duration = 2,
            })
        end
    end,
})

-- Fly Speed Slider
local FlySpeedSlider = TabPlayer:AddSlider({
    Name = "Prędkość lotu",
    Description = "Dostosuj prędkość latania",
    Min = 10,
    Max = 200,
    Increment = 5,
    CurrentValue = 50,
    Suffix = "",
    Callback = function(value)
        FlySpeed = value
    end,
})

-- Noclip Toggle
local NoclipToggle = TabPlayer:AddToggle({
    Name = "NoClip",
    Description = "Przechodzenie przez ściany",
    Icon = "👻",
    CurrentValue = false,
    Callback = function(value)
        if value then
            StartNoclip()
            Library.Notify({
                Title = "NoClip włączony",
                Content = "Możesz przechodzić przez ściany",
                Type = "Success",
                Duration = 2,
            })
        else
            StopNoclip()
            Library.Notify({
                Title = "NoClip wyłączony",
                Content = "Normalne kolizje przywrócone",
                Type = "Info",
                Duration = 2,
            })
        end
    end,
})

-- WalkSpeed Slider
local WalkSpeedSlider = TabPlayer:AddSlider({
    Name = "Prędkość chodzenia",
    Description = "Zmień WalkSpeed (16 = domyślnie)",
    Min = 16,
    Max = 250,
    Increment = 1,
    CurrentValue = 16,
    Suffix = " sp/s",
    Callback = function(value)
        local humanoid = GetHumanoid()
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end,
})

-- JumpPower Slider
local JumpPowerSlider = TabPlayer:AddSlider({
    Name = "Siła skoku",
    Description = "Zmień wysokość skoku",
    Min = 50,
    Max = 500,
    Increment = 5,
    CurrentValue = 50,
    Suffix = "",
    Callback = function(value)
        local humanoid = GetHumanoid()
        if humanoid then
            humanoid.JumpPower = value
        end
    end,
})

TabPlayer:AddSection("Akcje")

-- Reset Button
TabPlayer:AddButton({
    Name = "Resetuj postać",
    Description = "Zabija i respawnuje postać",
    Icon = "🔄",
    Callback = function()
        local char = GetCharacter()
        if char then
            char:BreakJoints()
            Library.Notify({
                Title = "Reset",
                Content = "Postać została zresetowana",
                Type = "Info",
            })
        end
    end,
})

-- Reset Speed Button
TabPlayer:AddButton({
    Name = "Resetuj prędkości",
    Description = "Przywraca domyślne wartości",
    Icon = "⚡",
    Callback = function()
        WalkSpeedSlider:Set(16)
        JumpPowerSlider:Set(50)
        FlySpeedSlider:Set(50)
        Library.Notify({
            Title = "Reset prędkości",
            Content = "Wszystkie wartości przywrócone",
            Type = "Success",
        })
    end,
})

-- ══════════════════════════════════════════════════════════════
-- ZAKŁADKA 2: VISUAL
-- ══════════════════════════════════════════════════════════════
local TabVisual = Window:CreateTab({
    Name = "Visual",
    Icon = "👁",
})

TabVisual:AddSection("ESP")

-- ESP Toggle
local ESPToggle = TabVisual:AddToggle({
    Name = "ESP (Box)",
    Description = "Pokazuje graczy przez ściany",
    Icon = "📦",
    CurrentValue = false,
    Callback = function(value)
        if value then
            StartESP()
            Library.Notify({
                Title = "ESP włączony",
                Content = "Widzisz wszystkich graczy",
                Type = "Success",
            })
        else
            StopESP()
            Library.Notify({
                Title = "ESP wyłączony",
                Content = "ESP został ukryty",
                Type = "Info",
            })
        end
    end,
})

TabVisual:AddLabel("Więcej opcji visual wkrótce...")

-- ══════════════════════════════════════════════════════════════
-- ZAKŁADKA 3: MISC
-- ══════════════════════════════════════════════════════════════
local TabMisc = Window:CreateTab({
    Name = "Misc",
    Icon = "⚙️",
})

TabMisc:AddSection("Ustawienia")

-- FOV Slider
TabMisc:AddSlider({
    Name = "FOV (Pole widzenia)",
    Description = "Zmień kąt widzenia kamery",
    Min = 70,
    Max = 120,
    Increment = 1,
    CurrentValue = 70,
    Suffix = "°",
    Callback = function(value)
        workspace.CurrentCamera.FieldOfView = value
    end,
})

TabMisc:AddSection("Powiadomienia - Test")

TabMisc:AddButton({
    Name = "Sukces ✓",
    Callback = function()
        Library.Notify({
            Title = "Sukces!",
            Content = "Operacja zakończona pomyślnie",
            Type = "Success",
            Duration = 3,
        })
    end,
})

TabMisc:AddButton({
    Name = "Błąd ✕",
    Callback = function()
        Library.Notify({
            Title = "Błąd!",
            Content = "Coś poszło nie tak",
            Type = "Error",
            Duration = 3,
        })
    end,
})

TabMisc:AddButton({
    Name = "Ostrzeżenie ⚠",
    Callback = function()
        Library.Notify({
            Title = "Uwaga",
            Content = "Sprawdź ustawienia przed kontynuacją",
            Type = "Warning",
            Duration = 3,
        })
    end,
})

TabMisc:AddButton({
    Name = "Info ℹ",
    Callback = function()
        Library.Notify({
            Title = "Informacja",
            Content = "Wersja biblioteki: 4.0",
            Type = "Info",
            Duration = 3,
        })
    end,
})

-- ══════════════════════════════════════════════════════════════
-- ZAKŁADKA 4: INFO
-- ══════════════════════════════════════════════════════════════
local TabInfo = Window:CreateTab({
    Name = "Info",
    Icon = "ℹ️",
})

TabInfo:AddParagraph({
    Title = "ERROR 404 UI Library v4.0",
    Content = "Darmowa biblioteka GUI dla Roblox. Styl inspirowany nowoczesnym designem z własnym API. Działa na wszystkich popularnych executorach.",
})

TabInfo:AddParagraph({
    Title = "Skróty klawiszowe",
    Content = "INSERT - Otwórz / zamknij menu (PC)\n⚡ Przycisk - Otwórz / zamknij menu (Mobile)\nWASD - Latanie (gdy Fly włączony)\nSpace/Shift - Góra/Dół podczas latania",
})

TabInfo:AddParagraph({
    Title = "Funkcje",
    Content = "✓ Fly z regulacją prędkości\n✓ NoClip (przechodzenie przez ściany)\n✓ ESP (widzenie graczy)\n✓ WalkSpeed i JumpPower\n✓ FOV (pole widzenia)",
})

TabInfo:AddSection("Linki")

TabInfo:AddLabel("GitHub: github.com/RastGit/ERROR404-UI")
TabInfo:AddLabel("Wsparcie: Discord (wkrótce)")

-- ══════════════════════════════════════════════════════════════
-- CLEANUP
-- ══════════════════════════════════════════════════════════════
LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    if FlyEnabled then
        StopFly()
        FlyToggle:Set(false)
    end
end)

print("✓ ERROR 404 UI załadowany pomyślnie")
