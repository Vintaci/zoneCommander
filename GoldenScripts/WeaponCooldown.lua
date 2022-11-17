local timer = timer
local Group = Group
local mist = mist

local function ChangeGroupROE(groupName, roe)
    local group = Group.getByName(groupName)
    local controller = nil

    if(nil ~= group) then
        controller = group:getController()
    end

    if roe == "WeaponFree" then
        controller:setOption(0, 0) -- weapon free
    elseif roe == "ReturnFire" then
        controller:setOption(0, 3) -- return fire
    end
end

function WeaponCooldown(groupName, delay)
    ChangeGroupROE(groupName, "ReturnFire")
    mist.scheduleFunction(ChangeGroupROE, { groupName, "WeaponFree" }, timer.getTime() + delay)
end
