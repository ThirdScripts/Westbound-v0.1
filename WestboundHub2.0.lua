local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("WestbounHackV0.1", "Ocean")

local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Main")
Section:NewButton("BigHitBox", "ButtonInfo", function()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/nmhb/refs/heads/main/dc.lua"))()
end)
Section:NewButton("Aimbot(PressT)", "ButtonInfo", function()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/Aimbot/refs/heads/main/aimbot.lua"))()
end)

Section:NewButton("NoLasso", "ButtonInfo", function()
    while true do
    local args = {
        [1] = "BreakFree"
    }

    game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("LassoEvents"):FireServer(unpack(args))

    -- Добавляем задержку, чтобы не перегружать систему
    task.wait(0.1)  -- Задержка в 0.1 секунду перед повтором
end

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

Section:NewButton("AntiDie(PressN)", "ButtonInfo", function()
    local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

local NoclipConnection = nil

-- Включение ноуклипа
local function enableNoclip()
    NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end

-- Отключение ноуклипа
local function disableNoclip()
    if NoclipConnection then
        NoclipConnection:Disconnect()
        NoclipConnection = nil
    end

    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

-- Функция для перемещения
local function moveTo(targetCFrame, speed)
    enableNoclip() -- Включаем ноуклип
    local targetPosition = targetCFrame.Position
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    bodyVelocity.Velocity = Vector3.zero
    bodyVelocity.Parent = rootPart

    local distance = (targetPosition - rootPart.Position).Magnitude
    local travelTime = distance / speed
    local startTime = tick()

    while tick() - startTime < travelTime do
        local direction = (targetPosition - rootPart.Position).Unit
        bodyVelocity.Velocity = direction * speed
        wait()
    end

    bodyVelocity:Destroy()
    rootPart.CFrame = targetCFrame
    disableNoclip() -- Выключаем ноуклип
end

-- Целевая позиция
local targetCFrame = CFrame.new(-1297.74146, 182.349976, -561.831299, 0.649706721, 1.66775997e-08, -0.760184944, 1.41014356e-09, 1, 2.31440787e-08, 0.760184944, -1.61088334e-08, 0.649706721)

-- Обработка нажатия клавиши N
game:GetService("UserInputService").InputBegan:Connect(function(input, isProcessed)
    if isProcessed then return end -- Игнорируем события, уже обработанные другими скриптами
    if input.KeyCode == Enum.KeyCode.N then
        moveTo(targetCFrame, 400) -- Перемещение с высокой скоростью
    end
end)
end)


local Tab = Window:NewTab("Visual")
local Section = Tab:NewSection("Visual")

Section:NewToggle("ToggleText", "ToggleInfo", function(state)
    if state then
        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/ChamsTeamColor/refs/heads/main/ChamsColorTeam.lua"))()
    else
        _G.DisableESP()
    end
end)
getgenv().Toggled = false

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

-- Кнопка Chams
Section:NewButton("FullBright", "ButtonInfo", function()
    local Lighting = game:GetService("Lighting")

-- Настройка освещения (без изменения времени)
Lighting.Ambient = Color3.new(1, 1, 1)
Lighting.Brightness = 2
Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
Lighting.FogEnd = 1e10

-- Обновление при изменении Lighting
Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
    Lighting.Ambient = Color3.new(1, 1, 1)
end)

Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
    Lighting.Brightness = 2
end)

Lighting:GetPropertyChangedSignal("OutdoorAmbient"):Connect(function()
    Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
end)

Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
    Lighting.FogEnd = 1e10
end)
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







