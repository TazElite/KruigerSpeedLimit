local function mphToConfigured(mph)
    if string.lower(Config.Unit or 'mph') == 'kmh' then return mph * 1.609344 end
    return mph
end

local function hardCapConfigured() return mphToConfigured(250) end
local function clampLimit(value)
    value = tonumber(value) or 0
    return math.max(0, math.min(value, hardCapConfigured()))
end

local function getAceLimit(src)
    if Config.Bypass.Enabled and IsPlayerAceAllowed(tostring(src), Config.Bypass.Permission) then
        return hardCapConfigured()
    end
    local best = nil
    for permission, speed in pairs(Config.SpeedPermissions or {}) do
        if IsPlayerAceAllowed(tostring(src), permission) then
            local limit = clampLimit(speed)
            if not best or limit > best then best = limit end
        end
    end
    return best
end

RegisterNetEvent('kruiger:serverspeed:requestAceLimit', function()
    local src = source
    TriggerClientEvent('kruiger:serverspeed:setAceLimit', src, getAceLimit(src))
end)
