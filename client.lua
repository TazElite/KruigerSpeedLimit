local aceLimit = nil

local function configuredToMps(speed)
    speed = tonumber(speed) or 0
    if string.lower(Config.Unit or 'mph') == 'kmh' then return speed / 3.6 end
    return speed * 0.44704
end

local function absoluteMaxConfigured()
    if string.lower(Config.Unit or 'mph') == 'kmh' then return 250 * 1.609344 end
    return 250
end

local function clampConfigured(speed)
    return math.max(0, math.min(tonumber(speed) or 0, absoluteMaxConfigured()))
end

local function normalLimit(vehicle)
    local model = GetEntityModel(vehicle)
    local override = Config.VehicleOverrides and Config.VehicleOverrides[model]
    if override then return clampConfigured(override) end

    if string.lower(Config.Mode or 'global') == 'class' then
        local class = GetVehicleClass(vehicle)
        return clampConfigured((Config.ClassLimits and Config.ClassLimits[class]) or Config.DefaultClassLimit)
    end
    return clampConfigured(Config.GlobalSpeedLimit)
end

local function effectiveLimit(vehicle)
    local base = normalLimit(vehicle)
    if aceLimit and aceLimit > base then return clampConfigured(aceLimit) end
    return base
end

RegisterNetEvent('kruiger:serverspeed:setAceLimit', function(limit) aceLimit = limit end)

CreateThread(function()
    TriggerServerEvent('kruiger:serverspeed:requestAceLimit')
    while true do
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) == ped then
            SetEntityMaxSpeed(vehicle, configuredToMps(effectiveLimit(vehicle)))
            Wait(250)
        else
            Wait(750)
        end
    end
end)
