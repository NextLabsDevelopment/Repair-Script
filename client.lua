local repairCooldowns = {} 

RegisterCommand('repair', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if DoesEntityExist(vehicle) then
        local vehicleNetId = VehToNet(vehicle)
        local playerId = PlayerId()

        if not repairCooldowns[playerId] or (GetGameTimer() - repairCooldowns[playerId]) > 60000 then
            SetVehicleFixed(vehicle)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleUndriveable(vehicle, false)
            TriggerEvent('chatMessage', '^2Vehicle repaired!')

            repairCooldowns[playerId] = GetGameTimer()
        else
            local remainingCooldown = math.ceil((60000 - (GetGameTimer() - repairCooldowns[playerId])) / 1000)
            TriggerEvent('chatMessage', '^1Please wait ' .. remainingCooldown .. ' seconds before using /repair again.')
        end
    else
        TriggerEvent('chatMessage', '^1You must be inside a vehicle to use /repair.')
    end
end, false)
