-- BattleCommander Initialization

local filepath = 'Normandy-NW-Saved-Data.lua'
if lfs then
	local dir = lfs.writedir()..'Missions/Saves/'
	lfs.mkdir(dir)
	filepath = dir..filepath
	env.info('Foothold - Save file path: '..filepath)

	if (file.exists(filepath)) then
		file.copy(filepath, filepath..".bak")
	end
end

-- Block player slots for 15 seconds on mission start,
-- prevent players from joining slots before initialization done
trigger.action.setUserFlag("TriggerFlagInitDone", false)

mist.scheduleFunction(function(event, sender)
	trigger.action.setUserFlag("TriggerFlagInitDone", true)
end, {}, timer.getTime() + 15)

-- Difficulty scaling
-- <start> is the base value, all calculation is added onto this
-- overall minimum <difficultyModifier> = <start> + <min>
-- overall maximum <difficultyModifier> = <start> + <max>
-- once a <coalition>'s zone becomes neutral, its <difficultyModifier> increases <escalation>
-- once <coalition> captures a zone, its <difficultyModifier> decreases <escalation>
-- if every <difficultyModifier> hasn't been changed for <fadeTime> seconds, <difficultyModifier> will decreases <fade>
local difficulty = { start = 1, min = 0, max = 7, escalation = 1, fade = 0.001, fadeTime = 30, coalition = 1 }
bc = BattleCommander:new(filepath, 30, 90, difficulty) -- This MUST be global, as zoneCommander.lua gets zone list though it for support menu to work

-- BattleCommander Initialization Done

-- Zone Definition

local hint = "任务目标：占领所有区域！"

local zoneUpgrades = {
	normal = {
		blue = { "b-defense-1", "b-defense-2", "b-defense-3" },
		red = { "r-defense-1", "r-defense-2", "r-defense-3" }
	}
}

local zones = {
	carp = {
		zoneCommanderProperties = {
			zone = "Carp",
			side = 2,
			level = 5,
			upgrades = zoneUpgrades.normal,
			crates = {},
			flavorText = hint,
			income = 1,
		},
		dispatches = {
			{ name = "b-patrol-carp-carp-bf109-1", mission = "patrol", targetzone = "Carp" },
		},
		criticalObjects = {},
		connections = {
			"Rucq",
			"Lanth",
		},
	},

	rucq = {
		zoneCommanderProperties = {
			zone = "Rucq",
			side = 1,
			level = 5,
			upgrades = zoneUpgrades.normal,
			crates = {},
			flavorText = hint,
			income = 1,
		},
		dispatches = {
			{ name = "r-supply-rucq-somm-yak52-1", mission = "supply", targetzone = "Somm" },
			{ name = "r-supply-rucq-lanth-yak52-1", mission = "patrol", targetzone = "Lanth" },

			{ name = "r-patrol-rucq-rucq-bf109-1", mission = "patrol", targetzone = "Rucq" },
			{ name = "r-patrol-rucq-rucq-fw190d9-1", mission = "patrol", targetzone = "Rucq" },
			{ name = "r-patrol-rucq-rucq-spitfire-1", mission = "patrol", targetzone = "Rucq" },

			{ name = "r-attack-rucq-carp-p47d-1", mission = "attack", targetzone = "Carp" },
		},
		criticalObjects = {},
		connections = {
			"Lanth",
			"Somm",
		},
	},

	lanth = {
		zoneCommanderProperties = {
			zone = "Lanth",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			crates = {},
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {
			"Somm",
		},
	},

	somm = {
		zoneCommanderProperties = {
			zone = "Somm",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			crates = {},
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {},
	},

	kenley = {
		zoneCommanderProperties = {
			zone = "Kenley",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			crates = {},
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {},
	},

	villa = {
		zoneCommanderProperties = {
			zone = "Villa",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			crates = {},
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {},
	},
}

-- Zone Definition Done

-- Zone Initialization

local function NewZone(zone)
	zone.zoneCommander = ZoneCommander:new(zone.zoneCommanderProperties)

	local dispatches = {}
	for key, value in pairs(zone.dispatches) do
		table.insert(dispatches, GroupCommander:new(value))
	end

	zone.zoneCommander:addGroups(dispatches)

	for key, value in pairs(zone.criticalObjects) do
		zone.zoneCommander:addCriticalObject(value)
	end

	bc:addZone(zone.zoneCommander)

	for key, value in pairs(zone.connections) do
		bc:addConnection(zone.zoneCommanderProperties.zone, value)
	end
end

local function InitZones()
	for key, value in pairs(zones) do
		NewZone(value)
	end
end

InitZones()

-- Zone Initialization Done

-- Mission Complete Check

local missionCompleteCheckSheduler = nil

local missionCompleteCheck = function(event, sender)
	local done = true
	for i, v in ipairs(bc:getZones()) do
		if v.side == 1 then
			done = false
			break
		end
	end

	if done then
		trigger.action.outText("敌军已被彻底击败！任务完成！ \n\n服务器将于90秒后清档重启！", 90)
		mist.removeFunction(missionCompleteCheckSheduler)

		mist.scheduleFunction(function(event, sender)
			trigger.action.outText("服务器即将清档重启！", 60)
		end, {}, timer.getTime() + 75)

		mist.scheduleFunction(function(event, sender)
			os.remove(filepath)
			trigger.action.setUserFlag("TriggerFlagMissionComplete", true)
		end, {}, timer.getTime() + 90)
	end
end

missionCompleteCheckSheduler = mist.scheduleFunction(missionCompleteCheck, {}, timer.getTime() + 90, 90)

-- Mission Complete Check Done

-- Scheduled Restart

local restartTime = 10800 -- 3 hours
local restartHintTime = { 60, 180, 300, 900 }

for key, value in pairs(restartHintTime) do -- Restart hint
	mist.scheduleFunction(function(event, sender)
		trigger.action.outText("服务器将于" .. value / 60 .. "分钟后定时重启！", 90)
	end, {}, timer.getTime() + restartTime - value)
end

mist.scheduleFunction(function(event, sender)
	trigger.action.outText("服务器即将定时重启！", 60)
end, {}, timer.getTime() + restartTime - 15)

mist.scheduleFunction(function(event, sender) -- Restart
	trigger.action.setUserFlag("TriggerFlagScheduledRestart", true)
end, {}, timer.getTime() + restartTime)

-- Scheduled Restart Done

-- Blue Support


local upgradeMenu = nil
bc:registerShopItem('supplies', '补给友方占领区', 1000, function(sender)
	if upgradeMenu then
		return '请使用 F10 菜单指派补给区域'
	end

	local upgradeZone = function(target)
		if upgradeMenu then
			local zn = bc:getZoneByName(target)
			if zn and zn.side == 2 then
				zn:upgrade()
			else
				return '所选区域不是友方占领区'
			end

			upgradeMenu = nil
		end
	end

	upgradeMenu = bc:showTargetZoneMenu(2, '指派补给区域', upgradeZone, 2)

	trigger.action.outTextForCoalition(2, '补给已就绪，请使用 F10 菜单指派补给区域', 60)
end,
	function(sender, params)
		if params.zone and params.zone.side == 2 then
			params.zone:upgrade()
		else
			return '仅允许补给友方占领区'
		end
	end)

local smoketargets = function(tz)
	local units = {}
	for i, v in pairs(tz.built) do
		local g = Group.getByName(v)
		for i2, v2 in ipairs(g:getUnits()) do
			table.insert(units, v2)
		end
	end

	local tgts = {}
	for i = 1, 3, 1 do
		if #units > 0 then
			local selected = math.random(1, #units)
			table.insert(tgts, units[selected])
			table.remove(units, selected)
		end
	end

	for i, v in ipairs(tgts) do
		local pos = v:getPosition().p
		trigger.action.smoke(pos, 1)
	end
end

local smokeTargetMenu = nil
bc:registerShopItem('smoke', '烟雾标记', 100, function(sender)
	if smokeTargetMenu then
		return '请使用 F10 菜单指派标记区域'
	end

	local launchAttack = function(target)
		if smokeTargetMenu then
			local tz = bc:getZoneByName(target)
			smoketargets(tz)
			smokeTargetMenu = nil
			trigger.action.outTextForCoalition(2, '已用红色烟雾标记' .. target .. '战区的目标', 60)
		end
	end

	smokeTargetMenu = bc:showTargetZoneMenu(2, '指派烟雾标记目标', launchAttack, 1)

	trigger.action.outTextForCoalition(2, '烟雾标记已就绪，请使用 F10 菜单指派标记区域', 60)
end,
	function(sender, params)
		if params.zone and params.zone.side == 1 then
			smoketargets(params.zone)
			trigger.action.outTextForCoalition(2, '已用红色烟雾标记' .. params.zone.zone .. '战区的目标', 60)
		else
			return '仅允许标记敌方占领区'
		end
	end)


bc:addShopItem(2, 'supplies', -1)
bc:addShopItem(2, 'smoke', -1)
-- bc:addFunds(2, 100000)

-- Blue Support Done

-- Red Support

-- bc:addFunds(1, 100000)
-- BudgetCommander:new({ battleCommander = bc, side = 1, decissionFrequency = 1, decissionVariance = 1, skipChance = 0 }):init()

BudgetCommander:new({ battleCommander = bc, side = 1, decissionFrequency = 15 * 60, decissionVariance = 15 * 60, skipChance = 25 }):init()

-- Red Support Done

-- Logistics Functions
-- Pilot rescue, cargo transport, etc. in F10 Radio Menu

local logisticCommanderSupplyZones = {}

for key, value in pairs(zones) do
	table.insert(logisticCommanderSupplyZones, value.zoneCommanderProperties.zone)
end

LogisticCommander:new({ battleCommander = bc, supplyZones = logisticCommanderSupplyZones }):init()

-- Logistics Functions Done

-- BattleCommander Initialization

bc:loadFromDisk() --will load and overwrite default zone levels, sides, funds and available shop items
bc:init()
bc:startRewardPlayerContribution(15, { infantry = 5, ground = 15, sam = 25, airplane = 50, ship = 100, helicopter = 50, crate = 150, rescue = 300 })

-- BattleCommander Initialization Done
