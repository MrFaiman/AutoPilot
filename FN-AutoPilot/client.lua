--Made by: FAIMAN#0007

local Speed = Config.Speed
local Drive = Config.Drive
local mode = "normal"

RegisterCommand("autopilot", function(source, args)
    TriggerEvent('chat:addSuggestion', '/autopilot', 'AutoPilot', {
        { name="crazy/normal/help", help="Drive Mode" }
    })
    local ped = GetPlayerPed(source)

    if table.concat(args," ") == 'help' then
        return TriggerEvent('chatMessage', '[^2AutoPilot System^7]'),
        TriggerEvent('chatMessage', '^3/autopilot [normal/crazy] ^7| ^5starting the autopilot'),
        TriggerEvent('chatMessage', '^3/stop-ap ^7| ^5stoping the autopilot')
    end
    if IsPedInAnyVehicle(ped) then

        if table.concat(args," ") == 'normal' then
            mode = "normal"
        end
        if table.concat(args," ") == 'crazy' then
            mode = "crazy"
        end
        if mode == 'crazy' then
            Drive = 1074528293
            Speed = 100.0   
        elseif mode == 'normal' then
            Drive = 786603
        end
        

        if DoesBlipExist(GetFirstBlipInfoId(8)) then
            alert("[AutoPilot] ~g~Activited \n~w~[Mode] ~y~"..mode)
            local blipIterator = GetBlipInfoIdIterator(8)
            local blip = GetFirstBlipInfoId(8, blipIterator)
            local wp = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector())
            ClearPedTasks(ped)
            local v = GetVehiclePedIsIn(ped, false)
            TaskVehicleDriveToCoord(ped, v, wp.x, wp.y, wp.z, tonumber(Speed), 0, v, Drive, 0, true)
            SetDriveTaskDrivingStyle(ped, Drive)


        else
            
            alert("There is ~r~NO~w~ waypoint!")
            
        end

    else
        alert("You are ~r~NOT~w~ in any ~r~VEHICLE")
    end
    
    


end, false)

RegisterCommand("stop-ap", function(source, args)
    if IsPedInAnyVehicle(GetPlayerPed(-1)) then
        ClearPedTasks(GetPlayerPed(-1))
    else
        ClearPedTasksImmediately(GetPlayerPed(-1))
    end
    alert("[AutoPilot] ~r~Disabled")
end, false)