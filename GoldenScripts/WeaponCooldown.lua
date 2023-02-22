local function StopFiring(groupName, groupType)
    local group = Group.getByName(groupName)

    if nil == group then
        return
    end

    if "Air" == groupType then
        group:getController():setOption(AI.Option.Air.id.ROE, AI.Option.Air.val.ROE.WEAPON_HOLD)
        group:getController():setOption(AI.Option.Air.id.REACTION_ON_THREAT, AI.Option.Air.val.REACTION_ON_THREAT.NO_REACTION)
    elseif "Ground" == groupType then
        group:getController():setOption(AI.Option.Ground.id.ROE, AI.Option.Ground.val.ROE.WEAPON_HOLD)
    elseif "Naval" == groupType then
        group:getController():setOption(AI.Option.Naval.id.ROE, AI.Option.Naval.val.ROE.WEAPON_HOLD)
    end
end

local function StartFiring(groupName, groupType)
    local group = Group.getByName(groupName)

    if nil == group then
        return
    end

    if "Air" == groupType then
        group:getController():setOption(AI.Option.Air.id.ROE, AI.Option.Air.val.ROE.WEAPON_FREE)
        group:getController():setOption(AI.Option.Air.id.REACTION_ON_THREAT, AI.Option.Air.val.REACTION_ON_THREAT.EVADE_FIRE)
    elseif "Ground" == groupType then
        group:getController():setOption(AI.Option.Ground.id.ROE, AI.Option.Ground.val.ROE.OPEN_FIRE)
    elseif "Naval" == groupType then
        group:getController():setOption(AI.Option.Naval.id.ROE, AI.Option.Naval.val.ROE.OPEN_FIRE)
    end
end

function WeaponCooldown(groupName, groupType, delay)
    mist.scheduleFunction(StopFiring, { groupName, groupType }, timer.getTime() + 3)
    mist.scheduleFunction(StartFiring, { groupName, groupType }, timer.getTime() + delay)
end
