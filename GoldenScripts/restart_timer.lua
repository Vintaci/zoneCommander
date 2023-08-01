-- Zone Complete Check

local function zone_complete_check()
	local red_zone_count = 0
    local blue_zone_count = 0

	for i, v in ipairs(bc:getZones()) do
		if v.side == 1 then
			red_zone_count = red_zone_count + 1
        elseif v.side == 2 then
            blue_zone_count = blue_zone_count + 1
		end
	end

    if red_zone_count == 0 or blue_zone_count == 0 then
        return true
    end

    return false
end

-- Zone Complete Check Done

-- Server Restart Timer Function

local function restartTimer(restartTime, restartHintTimeList, restartFlag, restartHint, restartHintLastsTime, deleteSave)
    for key, value in pairs(restartHintTimeList) do -- Restart hint
        mist.scheduleFunction(function(event, sender)
            trigger.action.outText(string.format(restartHint, value / 60), restartHintLastsTime)
        end, {}, timer.getTime() + restartTime - value)
    end

    mist.scheduleFunction(function(event, sender)
        trigger.action.outText("服务器即将重启！", 180)
    end, {}, timer.getTime() + restartTime - 15)

    mist.scheduleFunction(function(event, sender) -- Restart
        if deleteSave == true and lfs then
            os.remove(lfs.writedir() .. "Missions/Saves/Caucasus-S-Saved-Data.lua")
        end

        trigger.action.setUserFlag(restartFlag, true)
    end, {}, timer.getTime() + restartTime + 15) -- Add 15s offset to avoid conflict with saving system
end

-- Server Restart Timer Function Done

-- Scheduled Restart

local scheduledRestartTime = 10800 -- 3 hours
local scheduledRestartHintTimeList = { 60, 180, 300, 600, 900, 1200, 1500, 1800 }
local scheduledRestartFlag = "FLAG_MISSION_RESTART"
local scheduledRestartHint = "服务器将于 %d 分钟后定时重启！"

restartTimer(scheduledRestartTime, scheduledRestartHintTimeList, scheduledRestartFlag, scheduledRestartHint, 90, false)

-- Scheduled Restart Done

-- Mission Complete Restart

local missionCompleteCheckScheduler = nil

local missionCompleteCheck = function(event, sender)
    if zone_complete_check() then
        local restartTime = 60
        local restartHintTimeList = { 60 }
        local restartFlag = "FLAG_MISSION_RESTART"
        local restartHint = "任务完成！服务器将于 %d 分钟后清档重启！"

        restartTimer(restartTime, restartHintTimeList, restartFlag, restartHint, 90, true)

        mist.removeFunction(missionCompleteCheckScheduler)
    end
end

missionCompleteCheckScheduler = mist.scheduleFunction(missionCompleteCheck, {}, timer.getTime() + 90, 90)

-- Mission Complete Restart Done
