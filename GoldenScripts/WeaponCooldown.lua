local timer = timer
local Group = Group
local mist = mist

local roeIndex =
{
    -- Ground and naval group does not support 0 and 1
    ["WEAPON_FREE"] = 0, -- engage any threat
    ["OPEN_FIRE_WEAPON_FREE"] = 1, -- engage any threat while prioritize its task target
    ["OPEN_FIRE"] = 2, -- engage its task target only
    ["RETURN_FIRE"] = 3, -- engage threars that shoot first
    ["WEAPON_HOLD"] = 4, -- do not fire
}

local function ChangeGroupROE(groupName, roe)
    local group = Group.getByName(groupName)

    if (nil == group) then
        env.info("ChangeGroupROE: group " .. groupName .. " is nil")
        return
    end

    group:getController():setOption(0, roeIndex[roe])
    env.info("ChangeGroupROE: set group ".. groupName .." ROE to " .. roe .. "(" .. roeIndex[roe] .. ")")
end

function WeaponCooldown(groupName, groupType, delay)
    local defaultROE = "WEAPON_FREE";
    
    if ("Surface" == groupType) then
        defaultROE = "OPEN_FIRE";
    end

    mist.scheduleFunction(ChangeGroupROE, { groupName, "WEAPON_HOLD" }, timer.getTime() + 1) -- ChangeGroupROE(groupName, "WEAPON_HOLD")
    mist.scheduleFunction(ChangeGroupROE, { groupName, defaultROE }, timer.getTime() + delay)
end
