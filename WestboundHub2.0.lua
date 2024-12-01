local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("WestbounHackV0.1", "Ocean")

local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Main")


-- Аимбот по нажатию T
Section:NewButton("Aimbot(PressT)", "ButtonInfo", function()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/Aimbot/refs/heads/main/aimbot.lua"))()
end)



--спидхак по нажатию X
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local bodyVelocity = nil
local userInputService = game:GetService("UserInputService")

local speed = 100  -- Начальная скорость (можно будет изменять через TextBox)

-- Функция для обновления персонажа при возрождении
local function onCharacterAdded(newCharacter)
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end

-- Функция для включения спидхака
local function speedHack()
    if not bodyVelocity then
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = humanoidRootPart.CFrame.LookVector * speed
        bodyVelocity.Parent = humanoidRootPart
    else
        bodyVelocity.Velocity = humanoidRootPart.CFrame.LookVector * speed
    end
end

-- Функция для выключения спидхака
local function disableSpeedHack()
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
end

-- Отслеживание нажатия клавиши X
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.X then
        speedHack()
    end
end)

-- Отслеживание отпускания клавиши X
userInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.X then
        disableSpeedHack()
    end
end)

-- Подписка на событие возрождения
player.CharacterAdded:Connect(onCharacterAdded)

-- TextBox для изменения скорости
Section:NewTextBox("Speedhack(PressX)", "TextboxInfo", function(txt)
    local newSpeed = tonumber(txt)  -- Преобразуем текст в число
    if newSpeed then
        speed = newSpeed  -- Обновляем скорость
        print("Скорость изменена на:", speed)
    else
        print("Введите числовое значение скорости!")
    end
end)

local speed = 0 -- Начальная скорость (по умолчанию 0)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Функция для настройки перемещения
local function setupMovement()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    -- Подключаемся к RenderStepped
    game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
        if not humanoidRootPart or not humanoidRootPart.Parent then return end

        local moveDirection = Vector3.new(0, 0, 0)
        local userInputService = game:GetService("UserInputService")

        -- Проверяем нажатие клавиш WASD
        if userInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + Vector3.new(0, 0, -1)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection + Vector3.new(0, 0, 1)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection + Vector3.new(-1, 0, 0)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + Vector3.new(1, 0, 0)
        end

        -- Нормализуем и перемещаем персонажа
        if moveDirection.Magnitude > 0 and speed > 0 then
            moveDirection = moveDirection.Unit
            local worldDirection = humanoidRootPart.CFrame:VectorToWorldSpace(moveDirection)
            local newPosition = humanoidRootPart.Position + worldDirection * speed * deltaTime

            -- Перемещаем персонажа без изменения его ориентации
            humanoidRootPart.CFrame = CFrame.new(newPosition, newPosition + humanoidRootPart.CFrame.LookVector)
        end
    end)
end

-- Добавляем текстбокс для изменения скорости
Section:NewTextBox("SpeedhackCFrame", "Defolt 0", function(txt)
    local newSpeed = tonumber(txt)
    if newSpeed then
        speed = newSpeed
        print("Скорость изменена на:", speed)
    else
        print("Введите корректное число!")
    end
end)

-- Обновляем переменные после смерти
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    setupMovement()
end)

-- Настраиваем движение для текущего персонажа
setupMovement()


--кнопка антидие по нажатию N
Section:NewButton("AntiDie(PressN)", "ButtonInfo", function()
    local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

local NoclipConnection = nil

local function enableNoclip()
    NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end


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


local function moveTo(targetCFrame, speed)
    enableNoclip() 
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
    disableNoclip() 
end


local targetCFrame = CFrame.new(-1297.74146, 182.349976, -561.831299, 0.649706721, 1.66775997e-08, -0.760184944, 1.41014356e-09, 1, 2.31440787e-08, 0.760184944, -1.61088334e-08, 0.649706721)


game:GetService("UserInputService").InputBegan:Connect(function(input, isProcessed)
    if isProcessed then return end 
    if input.KeyCode == Enum.KeyCode.N then
        moveTo(targetCFrame, 400) 
    end
end)
end)

-- НоуЛассо 
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

-- Переключатель ноуклип
Section:NewToggle("NoClip", "ToggleInfo", function(state)
    if state then
        local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local function noclip()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end


local function clip()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

noclip()


    else
        local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local function enableCollisions()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

enableCollisions()

    end
end)



--Секция визуал
local Tab = Window:NewTab("Visual")
local Section = Tab:NewSection("Visual")

Section:NewToggle("Chams", "ToggleInfo", function(state)
    if state then
        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/ChamsTeamColor/refs/heads/main/ChamsColorTeam.lua"))()
    else
        _G.ESP_Enabled = false

for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
    if player.Character then
        for _, v in ipairs(player.Character:GetChildren()) do
            if v:IsA("Highlight") then
                v:Destroy()
            end
        end
    end
end
    end
end)
getgenv().Toggled = false


-- Переключатель Blur
Section:NewToggle("Blur", "ToggleInfo", function(state)
    if state then
        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/Blur/refs/heads/main/blur.lua"))()
    else
        game:GetService("Lighting"):ClearAllChildren()
    end
end)

-- Переключатель фулбридж
Section:NewToggle("Fullbright", "ToggleInfo", function(state)
    if state then
        _G.LightingEnabled = true

local Lighting = game:GetService("Lighting")

if _G.LightingEnabled then
  
    Lighting.Ambient = Color3.new(1, 1, 1)
    Lighting.Brightness = 2
    Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    Lighting.FogEnd = 1e10

   
    Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
        if _G.LightingEnabled then
            Lighting.Ambient = Color3.new(1, 1, 1)
        end
    end)

    Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
        if _G.LightingEnabled then
            Lighting.Brightness = 2
        end
    end)

    Lighting:GetPropertyChangedSignal("OutdoorAmbient"):Connect(function()
        if _G.LightingEnabled then
            Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        end
    end)

    Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
        if _G.LightingEnabled then
            Lighting.FogEnd = 1e10
        end
    end)
end

    else
        _G.LightingEnabled = false

local Lighting = game:GetService("Lighting")

-- Устанавливаем чуть более светлый нейтральный свет
Lighting.Ambient = Color3.new(0.7, 0.7, 0.7) -- Легкий серый оттенок
Lighting.Brightness = 1 -- Стандартная яркость
Lighting.OutdoorAmbient = Color3.new(0.7, 0.7, 0.7) -- Тот же светлый серый
Lighting.FogEnd = 100000 -- Ограничение на дальность тумана

    end
end)
getgenv().Toggled = false

-- ESP
Section:NewButton("ESP", "ButtonInfo", function()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ThirdScripts/ESPteamcolor/refs/heads/main/ESP.lua"))()
end)


-- чинахат

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local coneColor = Color3.fromRGB(173, 216, 230) -- Нежно-голубой цвет
local coneCreated = false -- Конус ещё не создан

-- Функция для создания конуса
local function createCone(character)
    if not coneColor then return end -- Создаём конус только если цвет выбран

    local head = character:FindFirstChild("Head")
    if not head then return end

    local cone = Instance.new("Part")
    cone.Size = Vector3.new(1, 1, 1)
    cone.BrickColor = BrickColor.new("White")
    cone.Transparency = 0.3
    cone.Anchored = false
    cone.CanCollide = false

    local mesh = Instance.new("SpecialMesh", cone)
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://1033714"
    mesh.Scale = Vector3.new(1.7, 1.1, 1.7)

    local weld = Instance.new("Weld")
    weld.Part0 = head
    weld.Part1 = cone
    weld.C0 = CFrame.new(0, 0.9, 0)

    cone.Parent = character
    weld.Parent = cone

    -- Добавляем Highlight
    local highlight = Instance.new("Highlight", cone)
    highlight.FillColor = coneColor
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = coneColor
    highlight.OutlineTransparency = 0

    coneCreated = true -- Помечаем, что конус создан
end

-- Пересоздаём конус после респавна
local function onCharacterAdded(character)
    if coneCreated then -- Если конус уже был создан, пересоздаём
        createCone(character)
    end
end

player.CharacterAdded:Connect(onCharacterAdded)

-- Если персонаж уже существует
if player.Character then
    onCharacterAdded(player.Character)
end

-- ColorPicker
Section:NewColorPicker("Chinahat", "Color Info", Color3.fromRGB(173, 216, 230), function(color)
    coneColor = color -- Обновляем цвет для конуса
    if player.Character and not coneCreated then
        createCone(player.Character) -- Создаём конус только после выбора цвета
    elseif player.Character and coneCreated then
        -- Обновляем цвет существующего конуса
        for _, v in ipairs(player.Character:GetChildren()) do
            if v:IsA("Part") and v:FindFirstChild("Highlight") then
                local highlight = v:FindFirstChild("Highlight")
                highlight.FillColor = coneColor
                highlight.OutlineColor = coneColor
            end
        end
    end
end)





--Секция автофарм
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


-- секция килл алл
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






