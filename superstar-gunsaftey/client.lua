local QBCore = exports['qb-core']:GetCoreObject()
local gunSafetyOn = false

-- Toggle gun safety with Y key
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(0, 246) then -- 246 = Y key
            gunSafetyOn = not gunSafetyOn

            if gunSafetyOn then
                QBCore.Functions.Notify(" Gun Safety Enabled  You cannot shoot.", "success")
            else
                QBCore.Functions.Notify(" Gun Safety Disabled  Shooting enabled.", "error")
            end
        end
    end
end)

-- Prevent shooting if safety is ON
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if gunSafetyOn then
            DisableControlAction(0, 24, true) -- Disable shooting
            DisableControlAction(0, 25, true) -- Disable aiming (optional)
            DisablePlayerFiring(PlayerPedId(), true) -- Extra backup
        end
    end
end)
