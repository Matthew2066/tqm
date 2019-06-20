explosionType = 0
vehicleGunVehicle = "adder"

explosions = {
          {"EXPLOSION_GRENADE", 0}, {"EXPLOSION_GRENADELAUNCHER", 1},
          {"EXPLOSION_STICKYBOMB", 2}, {"EXPLOSION_MOLOTOV", 3},
          {"EXPLOSION_ROCKET", 4}, {"EXPLOSION_TANKSHELL", 5},
          {"EXPLOSION_HI_OCTANE", 6}, {"EXPLOSION_CAR", 7},
          {"EXPLOSION_PLANE", 8}, {"EXPLOSION_PETROL_PUMP", 9},
          {"EXPLOSION_BIKE", 10}, {"EXPLOSION_DIR_STEAM", 11},
          {"EXPLOSION_DIR_FLAME", 12}, {"EXPLOSION_DIR_WATER_HYDRANT", 13},
          {"EXPLOSION_DIR_GAS_CANISTER", 14}, {"EXPLOSION_BOAT", 15},
          {"EXPLOSION_SHIP_DESTROY", 16}, {"EXPLOSION_TRUCK", 17},
          {"EXPLOSION_BULLET", 18}, {"EXPLOSION_SMOKEGRENADELAUNCHER", 19},
          {"EXPLOSION_SMOKEGRENADE", 20}, {"EXPLOSION_BZGAS", 21},
          {"EXPLOSION_FLARE", 22}, {"EXPLOSION_GAS_CANISTER", 23},
          {"EXPLOSION_EXTINGUISHER", 24}, {"EXPLOSION_PROGRAMMABLEAR", 25},
          {"EXPLOSION_TRAIN", 26}, {"EXPLOSION_BARREL", 27},
          {"EXPLOSION_PROPANE", 28}, {"EXPLOSION_BLIMP", 29},
          {"EXPLOSION_DIR_FLAME_EXPLODE", 30}, {"EXPLOSION_TANKER", 31},
          {"EXPLOSION_PLANE_ROCKET", 32}, {"EXPLOSION_VEHICLE_BULLET", 33},
          {"EXPLOSION_GAS_TANK", 34}, {"EXPLOSION_XERO_BLIMP", 37},
          {"EXPLOSION_FIREWORK", 38}
}

function drawNotification(string)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(string)
  DrawNotification(true, false)
end

function LoadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function getTableLength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end

function getEntity(player)
	local result, entity = GetEntityPlayerIsFreeAimingAt(player)
	return entity
end

function bulletCoords()
  local result, coord = GetPedLastWeaponImpactCoord(GetPlayerPed(-1))
  return coord
end

function getGroundZ(x, y, z)
		local result, groundZ = GetGroundZFor_3dCoord(x + 0.0, y + 0.0, z + 0.0, Citizen.ReturnResultAnyway())
		return groundZ
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10000) -- 10 seconds
  end
end)
