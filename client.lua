local scoreboardVisible = false

-- Ouvre le scoreboard quand TAB est pressé
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(0, 37) then -- 37 = TAB
            if not scoreboardVisible then
                scoreboardVisible = true
                SetNuiFocus(true, false)
                TriggerServerEvent('scoreboard:request')
            end
        else
            if scoreboardVisible then
                scoreboardVisible = false
                SetNuiFocus(false, false)
                SendNUIMessage({action = "close"})
            end
        end
    end
end)

RegisterNetEvent('scoreboard:update')
AddEventHandler('scoreboard:update', function(data)
    -- Envoie les données à la NUI
    SendNUIMessage({
        action = "open",
        players = data
    })
end)
