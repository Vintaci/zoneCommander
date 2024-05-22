local MoveToNearestEnemy = nil
local IsEnemyLeaderUnitDead = nil

function EnableAutoAttackForGroup(currentGroupName, searchRange, searchDuration, initialDelay)
    timer.scheduleFunction(MoveToNearestEnemy, { currentGroupName, searchRange, searchDuration }, timer.getTime() + initialDelay)
end

MoveToNearestEnemy = function(params)
    local currentGroupName = params[1]
    local searchRange = params[2]
    local searchDuration = params[3]

    local currentGroup = Group.getByName(currentGroupName)
    if currentGroup == nil or mist.groupIsDead(currentGroupName) == true then return nil end

    local enemyCoalition = (currentGroup:getCoalition() == 1 and 2) or 1
    local enemyGroupList = coalition.getGroups(enemyCoalition, Group.Category.GROUND)

    local currentGroupPosition = mist.getLeadPos(currentGroupName)
    local closestTargetDistance = searchRange
    local nearestEnemyGroupName = nil

    for index, value in pairs(enemyGroupList) do
        local enemyGroupDistance = mist.utils.get2DDist(currentGroupPosition, mist.getLeadPos(value))

        if enemyGroupDistance <= closestTargetDistance then
            closestTargetDistance = enemyGroupDistance
            nearestEnemyGroupName = value:getName()
        end
    end

    if nearestEnemyGroupName == nil or mist.groupIsDead(nearestEnemyGroupName) == true then return nil end

    local enemyGroup = Group.getByName(nearestEnemyGroupName)
    if enemyGroup == nil then return nil end

    local enemyLeaderUnit = enemyGroup:getUnit(1)
    if enemyLeaderUnit == nil then return nil end

    local nearestEnemyGroupPosition = mist.getLeadPos(nearestEnemyGroupName)
    local path = {}
    path[#path + 1] = mist.ground.buildWP(currentGroupPosition, 'Rank', 100)
    path[#path + 1] = mist.ground.buildWP(nearestEnemyGroupPosition, 'Rank', 100)

    mist.goRoute(currentGroupName, path)

    timer.scheduleFunction(IsEnemyLeaderUnitDead, { enemyLeaderUnit, currentGroupName, nearestEnemyGroupName, searchRange, searchDuration }, timer.getTime() + searchDuration)

    return nil
end

IsEnemyLeaderUnitDead = function(params)
    local enemyLeaderUnit = params[1]
    local currentGroupName = params[2]
    local nearestEnemyGroupName = params[3]
    local searchRange = params[4]
    local searchDuration = params[5]

    if enemyLeaderUnit == nil or mist.groupIsDead(currentGroupName) == true then return nil end

    if enemyLeaderUnit:isExist() == true then
        local currentGroupPosition = mist.getLeadPos(currentGroupName)
        local nearestEnemyGroupPosition = mist.getLeadPos(nearestEnemyGroupName)

        local path = {}
        path[#path + 1] = mist.ground.buildWP(currentGroupPosition, 'Rank', 100)
        path[#path + 1] = mist.ground.buildWP(nearestEnemyGroupPosition, 'Rank', 100)

        mist.goRoute(currentGroupName, path)

        timer.scheduleFunction(IsEnemyLeaderUnitDead, { enemyLeaderUnit, currentGroupName, nearestEnemyGroupName, searchRange, searchDuration }, timer.getTime() + searchDuration)
    else
        MoveToNearestEnemy({ currentGroupName, searchRange, searchDuration })
    end
    
    return nil
end
