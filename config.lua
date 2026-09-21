Config = {}

-- Speed display/configuration unit: 'mph' or 'kmh'
Config.Unit = 'mph'

-- 'global' = one default server speed limit
-- 'class'  = limits based on GTA vehicle class
Config.Mode = 'global'

-- Hard safety cap. The resource will never grant a configured limit above 250 MPH.
Config.AbsoluteMaxMPH = 250

-- Used when Config.Mode = 'global'
Config.GlobalSpeedLimit = 120

-- ACE bypass does NOT mean unlimited speed. It grants the absolute 250 MPH cap.
Config.Bypass = {
    Enabled = true,
    Permission = 'kruiger.speed.bypass'
}

-- Optional ACE speed tiers. Players receive the highest tier they have.
-- Values are interpreted using Config.Unit and are still capped at 250 MPH equivalent.
Config.SpeedPermissions = {
    ['kruiger.speed.150'] = 150,
    ['kruiger.speed.180'] = 180
}

-- Used when Config.Mode = 'class'. GTA vehicle class IDs 0-22.
Config.ClassLimits = {
    [0] = 100,  -- Compacts
    [1] = 110,  -- Sedans
    [2] = 110,  -- SUVs
    [3] = 115,  -- Coupes
    [4] = 120,  -- Muscle
    [5] = 120,  -- Sports Classics
    [6] = 130,  -- Sports
    [7] = 150,  -- Super
    [8] = 130,  -- Motorcycles
    [9] = 100,  -- Off-road
    [10] = 90,  -- Industrial
    [11] = 100, -- Utility
    [12] = 105, -- Vans
    [17] = 130, -- Service
    [18] = 160, -- Emergency
    [20] = 100  -- Commercial
}

-- Fallback for a class not listed above.
Config.DefaultClassLimit = 120

-- Optional per-model limits. These override global/class limits for normal players.
Config.VehicleOverrides = {
    -- [`police`] = 155,
    -- [`adder`] = 180
}
