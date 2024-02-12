local QBCore = exports['qb-core']:GetCoreObject()

-- ADMIN OWN CAR
QBCore.Commands.Add('savecar',{}, {}, false, function(source, _)
    TriggerClientEvent('icarussr:client:SaveCar', source)
end, 'admin')

RegisterNetEvent('icarussr:server:SaveCar', function(mods, vehicle, _, plate)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        local Player = QBCore.Functions.GetPlayer(src)
        local result = MySQL.query.await('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
        if result[1] == nil then
            MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
                Player.PlayerData.license,
                Player.PlayerData.citizenid,
                vehicle.model,
                vehicle.hash,
                json.encode(mods),
                plate,
                0
            })
            TriggerClientEvent('QBCore:Notify', src,"You now own this car!", 'success', 5000)
        else
            TriggerClientEvent('QBCore:Notify', src,"Couldnt do that!", 'error', 3000)
        end
    else
        BanPlayer(src)
    end
end)

RegisterCommand("window", function(source, args)

    local window = args[1]
    if not args[1] then
        TriggerClientEvent("SeatDAWA", source)
    else
        TriggerClientEvent("CarWindowS", -1, source, window)
    end
end, false)


