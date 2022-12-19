local pairs = pairs
local table = table
local Group = Group
local mist = mist

GroupFunctions = {}

function GroupFunctions.getGroupsByNames(names)
	local groups = {}
	for key, value in pairs(names) do
		local group = Group.getByName(value)
		if (group ~= nil) then
			table.insert(groups, group)
		end
	end
	return groups
end

function GroupFunctions.destroyGroup(group)
	if (group ~= nil) then
		group:destroy()
	end
end

function GroupFunctions.destroyGroups(groups)
	for key, value in pairs(groups) do
		GroupFunctions.destroyGroup(value)
	end
end

function GroupFunctions.delayedDestroyGroupByName(name, delay)
    mist.scheduleFunction(function(name)
		GroupFunctions.destroyGroup(Group.getByName(name))
    end, {name}, timer.getTime() + delay)
end

function GroupFunctions.destroyGroupsByNames(names)
	GroupFunctions.destroyGroups(GroupFunctions.getGroupsByNames(names))
end

function GroupFunctions.respawnGroupsByNames(names, task)
	for key, value in pairs(names) do
		mist.respawnGroup(value, task)
	end
end

function GroupFunctions.areGroupsActive(groups)
	local active = false
	for key, value in pairs(groups) do
		active = active or value ~= nil and value:getSize() > 0 and value:getController():hasTask()
	end
	return active
end

function GroupFunctions.areGroupsActiveByNames(names)
	-- Each time a group is respawned, it is a NEW group, so it MUST be done during runtime
	return GroupFunctions.areGroupsActive(GroupFunctions.getGroupsByNames(names))
end

function GroupFunctions.isGroupDead(group)
    if group ~= nil and (group:getSize() > 0 or group:isExist() == true) then
        return false
	else
    	return true
	end
end

function GroupFunctions.isGroupDeadByName(name)
    return GroupFunctions.isGroupDead(Group.getByName(name))
end
