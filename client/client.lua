local QBCore = exports['qb-core']:GetCoreObject()

-- ICARUS SMALL RESOURCES
-- Some snippets custom made, some snippets made from other creators 

-- SPAM PUNCHING
Citizen.CreateThread(function()
   while Config.spdisable do
   Citizen.Wait(0)
   DisableControlAction(1, 140, true)
   if not IsPlayerTargettingAnything(PlayerId()) then
   DisableControlAction(1, 141, true)
   DisableControlAction(1, 142, true)
   end
  end
end)

local ragdoll_chance = Config.rdchance

Citizen.CreateThread(function()
    while Config.hatgone do
        Citizen.Wait(1000)
        SetPedCanLosePropsOnDamage(PlayerPedId(), false, 0)
    end
end)


local function getVehicleFromVehList(hash)
	for _, v in pairs(QBCore.Shared.Vehicles) do
		if hash == v.hash then
			return v.model
		end
	end
end

-- BLIND FIRE
Citizen.CreateThread(function()
	while Config.bfdisable do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if IsPedInCover(ped, 1) and not IsPedAimingFromCover(ped, 1) then 
			DisableControlAction(2, 24, true) 
			DisableControlAction(2, 142, true)
			DisableControlAction(2, 257, true)
		end		
	end
end)

RegisterNetEvent('icarussr:client:SaveCar', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)

    if veh ~= nil and veh ~= 0 then
        local plate = QBCore.Functions.GetPlate(veh)
        local props = QBCore.Functions.GetVehicleProperties(veh)
        local hash = props.model
        local vehname = getVehicleFromVehList(hash)
        if QBCore.Shared.Vehicles[vehname] ~= nil and next(QBCore.Shared.Vehicles[vehname]) ~= nil then
            TriggerServerEvent('icarussr:server:SaveCar', props, QBCore.Shared.Vehicles[vehname], GetHashKey(veh), plate)
        else
            QBCore.Functions.Notify(Lang:t("error.no_store_vehicle_garage"), 'error')
        end
    else
        QBCore.Functions.Notify(Lang:t("error.no_vehicle"), 'error')
    end
end)

Citizen.CreateThread(function()
	while Config.crdisable do
		Citizen.Wait(0)
		if IsPedArmed(GetPlayerPed(-1), 4 | 2) and IsControlPressed(0, 25) then
			DisableControlAction(0, 22, true)
		end
	end
end)

CreateThread(function()
	while Config.amdisable do
		local playerPed = PlayerPedId()
		if IsPedUsingActionMode(playerPed) then
			SetPedUsingActionMode(playerPed, false, -1, 0)
        else
            Wait(500)
        end
        Wait(0)
	end
end)

SetFlashLightKeepOnWhileMoving(true)

if Config.FPShooting then
    CreateThread(function()
        while true do
            local ped = PlayerPedId()
            local _, weapon = GetCurrentPedWeapon(ped)
            local unarmed = `WEAPON_UNARMED`
            local inVeh = GetVehiclePedIsIn(PlayerPedId(), false)
            sleep = 1000
            if IsPedInAnyVehicle(PlayerPedId()) and weapon ~= unarmed then
                sleep = 1
                if IsControlJustPressed(0, 25) then
                    SetFollowVehicleCamViewMode(3)
                elseif IsControlJustReleased(0, 25) then
                    SetFollowVehicleCamViewMode(0)
                end
            end
            Wait(sleep)
        end
    end)
end


Citizen.CreateThread(function()
	while Config.bhdisable do
		Citizen.Wait(100) -- check every 100 ticks, performance matters
		local ped = PlayerPedId()
		if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then
			local chance_result = math.random()
			if chance_result < ragdoll_chance then 
				Citizen.Wait(600)
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
				SetPedToRagdoll(ped, 5000, 1, 2)
			else
				Citizen.Wait(2000)
			end
		end
	end
end)

Citizen.CreateThread(function()
    for k,v in pairs(isr.Blips) do
        local blip = AddBlipForCoord(v.Coords.x,v.Coords.y,v.Coords.z)
        SetBlipSprite(blip, v.Sprite)
        SetBlipScale(blip, v.Size)
        SetBlipColour(blip, v.Color)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(k)
        EndTextCommandSetBlipName(blip)
    end
end
end)

AddEventHandler('onResourceStop', function()
    for k, v in pairs(isr.Blips) do
        local blip = AddBlipForCoord(v.Coords.x,v.Coords.y,v.Coords.z)
        RemoveBlip(blip)
    end
end)


