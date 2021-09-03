local insidePoly, isOpen = false, false

RegisterNUICallback('getVotingInfo', function(data, cb)
    if isOpen then
        isOpen = false
        SendNUIMessage({action = 'hide'})
        SetNuiFocus(isOpen, isOpen)
        if data then
            TriggerServerEvent('ev:getVotingId', data)
        end
    end
    cb({})
end)

-- Polyzones
local mainZone <const> = PolyZone:Create({
    vector2(-517.09259033203, -210.04969787598),
    vector2(-516.14776611328, -211.74938964844),
    vector2(-518.28448486328, -213.0166015625),
    vector2(-519.30853271484, -211.27700805664)
}, {
    name="mainTicket",
    minZ = 37.141624450684,
    maxZ = 39.170108795166,
    lazyGrid = true,
    debugPoly = false
})

mainZone:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        if not insidePoly then
            insidePoly = true
            showNoti(PlayerPedId())
        end
    else
        if insidePoly then
            insidePoly = false
            showNoti()
        end
    end
end)

-- Noti
function showNoti(ped)
    ---Returns a floating notification on coords
    ---@param message string
    ---@param coords number
    local function showFloatingNotification(message, coords)
        AddTextEntry('votingNoti', message)
        SetFloatingHelpTextWorldPosition(1, coords)
        SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
        BeginTextCommandDisplayHelp('votingNoti')
        EndTextCommandDisplayHelp(2, false, false, -1)
    end
    if insidePoly and not isOpen then
        CreateThread(function()
            while insidePoly do
                local coords = GetEntityCoords(ped)
                showFloatingNotification(Config.openText, vec3(coords.x, coords.y, coords.z + 1))
                if IsControlJustPressed(0, Config.openKey) then
                    isOpen = true
                    SetNuiFocus(isOpen, isOpen)
                    SendNUIMessage({action = 'show'})
                    break
                end
                Wait(5)
            end
        end)
    end
end

---Returns a GTA notification
---@param message string
local function showNotification(message)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(0, 1)
end

RegisterNetEvent('ev:showNotification', function(message)
    showNotification(message)
end)