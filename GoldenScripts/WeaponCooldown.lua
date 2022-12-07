local timer = timer
local Group = Group
local mist = mist

local function ChangeGroupROE(groupName, optionIndex, roe)
    local group = Group.getByName(groupName)

    if (nil == group) then
        env.info("ChangeGroupROE: group " .. groupName .. " is nil")
        return
    end

    group:getController():setOption(optionIndex, roe)
    env.info("ChangeGroupROE: set group " .. groupName .. " ROE(" .. optionIndex .. ") to " .. roe)
end

function WeaponCooldown(groupName, groupType, delay)
    -- Air
    if ("Air" == groupType) then
        ChangeGroupROE(groupName, AI.Option.Air.id.ROE, AI.Option.Air.val.ROE.WEAPON_HOLD)
        mist.scheduleFunction(ChangeGroupROE, { groupName, AI.Option.Air.id.ROE, AI.Option.Air.val.ROE.WEAPON_FREE }, timer.getTime() + delay)
        return
    end

    -- Ground
    if ("Ground" == groupType) then
        ChangeGroupROE(groupName, AI.Option.Ground.id.ROE, AI.Option.Ground.val.ROE.WEAPON_HOLD)
        mist.scheduleFunction(ChangeGroupROE, { groupName, AI.Option.Ground.id.ROE, AI.Option.Ground.val.ROE.OPEN_FIRE }, timer.getTime() + delay)
        return
    end

    -- Naval
    if ("Naval" == groupType) then
        ChangeGroupROE(groupName, AI.Option.Naval.id.ROE, AI.Option.Naval.val.ROE.WEAPON_HOLD)
        mist.scheduleFunction(ChangeGroupROE, { groupName, AI.Option.Naval.id.ROE, AI.Option.Naval.val.ROE.OPEN_FIRE }, timer.getTime() + delay)
        return
    end
end
