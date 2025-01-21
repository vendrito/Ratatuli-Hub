
-- Cargar la librería GUI (Rayfield)
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- Crear la ventana principal
local Window = Rayfield:CreateWindow({
    Name = "Ratatuli Hub - Fish",
    LoadingTitle = "Ratatuli Hub",
    LoadingSubtitle = "Cargando opciones para Fish...",
    ConfigurationSaving = {
        Enabled = false -- No guarda configuraciones
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false -- Sin sistema de claves
})

-- Sección de Auto Farm
local FarmingTab = Window:CreateTab("Auto Farm", 4483362458) -- Ícono predeterminado
local AutoFarmToggle = false

-- Auto Farm para pescar automáticamente
FarmingTab:CreateToggle({
    Name = "Activar Auto Farm (Pescar)",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        AutoFarmToggle = Value
        if AutoFarmToggle then
            Rayfield:Notify({
                Title = "Auto Farm Activado",
                Content = "El Auto Farm de pesca está funcionando.",
                Duration = 5,
            })

            while AutoFarmToggle do
                pcall(function()
                    -- Buscar el área de pesca y moverse hacia ella
                    local fishingArea = workspace:FindFirstChild("FishingArea") or workspace:FindFirstChild("FishZone")
                    if fishingArea then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = fishingArea.CFrame
                    end

                    -- Simular la acción de pescar
                    local tool = game.Players.LocalPlayer.Character:FindFirstChild("Fishing Rod") or game.Players.LocalPlayer.Backpack:FindFirstChild("Fishing Rod")
                    if tool then
                        tool:Activate() -- Acción de usar la caña
                    end
                end)
                wait(1) -- Intervalo entre acciones
            end
        else
            Rayfield:Notify({
                Title = "Auto Farm Desactivado",
                Content = "El Auto Farm ha sido detenido.",
                Duration = 5
            })
        end
    end
})

-- Sección de Teletransportes
local TeleportTab = Window:CreateTab("Teleports", 4483362458) -- Ícono predeterminado
local TeleportLocations = {
    ["Zona de Pesca (Principal)"] = Vector3.new(250, 5, 300), -- Coordenadas de la zona de pesca
    ["Tienda de Pesca"] = Vector3.new(-150, 5, 120), -- Tienda de pesca para vender y comprar equipo
    ["Isla de Eventos"] = Vector3.new(500, 20, -400), -- Coordenadas de una isla para eventos
    ["Spawn (Inicio del juego)"] = Vector3.new(0, 10, 0) -- Spawn predeterminado
}

-- Crear botones para cada ubicación
for location, coords in pairs(TeleportLocations) do
    TeleportTab:CreateButton({
        Name = location,
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(coords)
        end
    })
end

-- Sección de Configuraciones Misc
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateButton({
    Name = "Aumentar Velocidad",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100 -- Cambiar velocidad aquí
        Rayfield:Notify({
            Title = "Velocidad Aumentada",
            Content = "Tu velocidad se ha aumentado a 100.",
            Duration = 5
        })
    end
})

MiscTab:CreateButton({
    Name = "Restaurar Velocidad",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- Velocidad predeterminada
        Rayfield:Notify({
            Title = "Velocidad Restaurada",
            Content = "Tu velocidad se ha restaurado a la predeterminada.",
            Duration = 5
        })
    end
})

MiscTab:CreateButton({
    Name = "Aumentar Salto",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100 -- Cambiar altura aquí
        Rayfield:Notify({
            Title = "Salto Aumentado",
            Content = "Tu altura de salto se ha aumentado.",
            Duration = 5
        })
    end
})

MiscTab:CreateButton({
    Name = "Restaurar Salto",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50 -- Altura predeterminada
        Rayfield:Notify({
            Title = "Salto Restaurado",
            Content = "Tu altura de salto se ha restaurado a la predeterminada.",
            Duration = 5
        })
    end
})

-- Notificación inicial
Rayfield:Notify({
    Title = "Ratatuli Hub Cargado",
    Content = "¡El script está listo para usar en el juego Fish!",
    Duration = 5
})
