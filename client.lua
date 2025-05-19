local scoreboardData = {}

RegisterNetEvent('scoreboard:update')
AddEventHandler('scoreboard:update', function(data)
    scoreboardData = data
    ShowScoreboard()
end)

function ShowScoreboard()
    print("=== SCOREBOARD ===")
    for identifier, stats in pairs(scoreboardData) do
        local ratio = stats.kills / (stats.deaths == 0 and 1 or stats.deaths)
        print(("ID: %s | Kills: %d | Morts: %d | Ratio: %.2f"):format(identifier, stats.kills, stats.deaths, ratio))
    end
end

RegisterCommand("scoreboard", function()
    TriggerServerEvent('scoreboard:request')
end)
