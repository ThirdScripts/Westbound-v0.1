local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("WestbounHackV0.1", "DarkTheme")

local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Main")
Section:NewButton("BigHitBox", "ButtonInfo", function()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/nmhb/refs/heads/main/dc.lua"))()
end)
Section:NewButton("Aimbot", "ButtonInfo", function()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/Aimbot/refs/heads/main/aimbot.lua"))()
end)

Section:NewButton("Speedhack(PressX)", "ButtonInfo", function()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/SpeedhackBypassAntiCheat/refs/heads/main/SpeedHackBypassAnticheat.lua"))()
end)

Section:NewToggle("NoClip", "ToggleInfo", function(state)
    if state then
        local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Функция для включения ноуклипа
local function noclip()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end


-- Функция для выключения ноуклипа (включает столкновения)
local function clip()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

-- Включаем ноуклип вручную
noclip()

-- Чтобы выключить ноуклип вручную, вызовите функцию `clip()`.

    else
        local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Функция для включения столкновений
local function enableCollisions()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

-- Выключаем ноуклип, восстанавливаем столкновения
enableCollisions()

    end
end)


local Tab = Window:NewTab("Visual")
local Section = Tab:NewSection("Visual")

-- Кнопка Chams
Section:NewButton("Chams", "ButtonInfo", function()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/ChamsTeamColor/refs/heads/main/ChamsColorTeam.lua"))()
end)

-- Кнопка Chinahat
Section:NewButton("Chinahat", "ButtonInfo", function()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/ChinaHat/refs/heads/main/Chinahat.lua"))()
end)
-- Переключатель Blur
Section:NewToggle("Blur", "ToggleInfo", function(state)
    if state then
        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/Blur/refs/heads/main/blur.lua"))()
    else
        game:GetService("Lighting"):ClearAllChildren()
    end
end)

local Tab = Window:NewTab("AutoFarm(Demo)")
local Section = Tab:NewSection("AutofarmGrayRidge")
-- Кнопка Chams
Section:NewButton("AutoFly", "ButtonInfo", function()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/AutoFlyWestbound/refs/heads/main/AutoFly.lua"))()
end)
-- Кнопка Chams
Section:NewButton("AutoRob", "ButtonInfo", function()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/AutoFlyWestbound/refs/heads/main/AutoRobOpen.lua"))()
end)

local Tab = Window:NewTab("KillAll(Premium)")
local Section = Tab:NewSection("Premium?? - 30 Subscribers")

-- Кнопка TpAllOutlaws
Section:NewButton("TpAllOutlaws", "ButtonInfo", function()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/west2/refs/heads/main/otlawsNoLocalPlayer.lua"))()
end)
-- Кнопка TpAllCawboys
Section:NewButton("TpAllCawboys", "ButtonInfo", function()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/west/refs/heads/main/TpAllCawboysNoLocalPlayer.lua"))()
end)







