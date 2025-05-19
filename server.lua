-- Utilise 'oxmysql' ou 'ghmattimysql' selon ton serveur. Ici, exemple avec oxmysql.
-- Si tu utilises ghmattimysql, remplace exports.oxmysql par exports.ghmattimysql

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local src = source
    local identifier = GetPlayerIdentifier(src, 0)

    -- Création du joueur si pas en BDD
    exports.oxmysql:execute('INSERT IGNORE INTO scoreboard_stats (identifier, kills, deaths) VALUES (?, 0, 0)', {identifier})
end)

RegisterNetEvent('scoreboard:addKill')
AddEventHandler('scoreboard:addKill', function(targetId)
    local killerId = source
    local killerIdentifier = GetPlayerIdentifier(killerId, 0)
    local victimIdentifier = GetPlayerIdentifier(targetId, 0)

    -- Incrémente les kills du tueur
    exports.oxmysql:execute('UPDATE scoreboard_stats SET kills = kills + 1 WHERE identifier = ?', {killerIdentifier})
    -- Incrémente les morts de la victime
    exports.oxmysql:execute('UPDATE scoreboard_stats SET deaths = deaths + 1 WHERE identifier = ?', {victimIdentifier})

    -- Mets à jour le scoreboard pour tout le monde
    SendScoreboardToAll()
end)

function SendScoreboardToAll()
    -- Récupère les 100 meilleurs joueurs (par kills)
    exports.oxmysql:execute('SELECT * FROM scoreboard_stats ORDER BY kills DESC LIMIT 100', {}, function(result)
        local playerStats = {}
        for _, row in ipairs(result) do
            playerStats[row.identifier] = {kills = row.kills, deaths = row.deaths}
        end
        TriggerClientEvent('scoreboard:update', -1, playerStats)
    end)
end

RegisterNetEvent('scoreboard:request')
AddEventHandler('scoreboard:request', function()
    SendScoreboardToAll()
end)
