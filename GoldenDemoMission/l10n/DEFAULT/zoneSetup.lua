-- Make functions local to make them run faster
local pairs = pairs
local ipairs = ipairs
local table = table
local Group = Group
local mist = mist
local lfs = lfs
local timer = timer
local trigger = trigger

local hint = "You need to capture all the zones to win the battle."

-- Cargo

local function merge(tbls)
	local res = {}
	for i, v in ipairs(tbls) do
		for i2, v2 in ipairs(v) do
			table.insert(res, v2)
		end
	end
	return res
end

local function allExcept(tbls, except)
	local tomerge = {}
	for i, v in pairs(tbls) do
		if i ~= except then
			table.insert(tomerge, v)
		end
	end
	return merge(tomerge)
end

local cargoSpawns = { -- This should be the unit name instead of group name
	["Anapa"] = { "cargo-anapa-ammo-1", "cargo-anapa-crate-1", "cargo-anapa-fuel-1" },
	["Krymsk"] = { "cargo-krymsk-ammo-1", "cargo-krymsk-crate-1", "cargo-krymsk-fuel-1" },
	["Novoro"] = { "cargo-novoro-ammo-1", "cargo-novoro-crate-1", "cargo-novoro-fuel-1" },
	["Gelend"] = { "cargo-gelend-ammo-1", "cargo-gelend-crate-1", "cargo-gelend-fuel-1" },
	["Kelas"] = { "cargo-kelas-ammo-1", "cargo-kelas-crate-1", "cargo-kelas-fuel-1" },
	["Kras"] = { "cargo-Kras-ammo-1", "cargo-Kras-crate-1", "cargo-Kras-fuel-1" },
	["Factory"] = { "cargo-factory-crate1-1", "cargo-factory-crate2-1", "cargo-factory-crate3-1" },
	["Oil Fields"] = { "cargo-oilfields-fuel1-1", "cargo-oilfields-fuel2-1", "cargo-oilfields-fuel3-1" },
	["SAM Site"] = { "cargo-samsite-ammo1-1", "cargo-samsite-ammo2-1", "cargo-samsite-ammo3-1" },
}

local cargoAccepts = {
	anapa = allExcept(cargoSpawns, "Anapa"),
	novoro = allExcept(cargoSpawns, "Novoro"),
	krymsk = allExcept(cargoSpawns, "Krymsk"),
	gelend = allExcept(cargoSpawns, "Gelend"),
	kelas = allExcept(cargoSpawns, "Kelas"),
	kras = allExcept(cargoSpawns, "Kras"),
	factory = allExcept(cargoSpawns, "Factory"),
	oilfields = allExcept(cargoSpawns, "Oil Fields"),
	samsite = allExcept(cargoSpawns, "SAM Site"),
	all = allExcept(cargoSpawns),
}

-- Cargo Done

-- FARP Trucks

local farpTrucks = {
	["Bravo"] = {"farp-trucks-bravo"},
	["Delta"] = {"farp-trucks-delta"},
	["Foxtrot"] = {"farp-trucks-foxtrot"},
}

-- FARP Trucks Done

-- Zone Upgrades

local zoneUpgrades = {
	normal = {
		blue = { "bInfantry", "bArmor", "bSamIR", "bSam", "bSam2" },
		red = { "rInfantry", "rArmor", "rSamIR", "rSam", "rSam2" }
	},
	sam = {
		blue = { "bSamIR", "bSam", "bSam2", "bSamBig", "bSamFinal" },
		red = { "rSamIR", "rSam", "rSam2", "rSamBig", "rSamFinal" }
	},
	infantry = {
		blue = { "bInfantry", "bInfantry", "bArmor", "bArmor", "bSamIR" },
		red = { "rInfantry", "rInfantry", "rArmor", "rArmor", "rSamIR" }
	},
	armor = {
		blue = { "bArmor", "bArmor", "bSamIR", "bSamIR", "bSamIR" },
		red = { "rArmor", "rArmor", "rSamIR", "rSamIR", "rSamIR" }
	},
	airfield = {
		blue = { "bArmor", "bSamIR", "bSam", "bSam2", "bSamBig" },
		red = { "rArmor", "rSamIR", "rSam", "rSam2", "rSamBig" }
	},
	airfieldPlus = {
		blue = { "bSamIR", "bSam", "bSam2", "bSamBig", "bSamFinal" },
		red = { "rSamIR", "rSam", "rSam2", "rSamBig", "rSamFinal" }
	},
	airfieldPlusPlus = {
		blue = { "bSamBig", "bSamFinal", "bSam3", "bSam3", "bSam3" },
		red = { "rSamBig", "rSamFinal", "rSam3", "rSam3", "rSam3" }
	},
	blueAirfield = {
		blue = { "bArmor", "bSamIR", "bSam", "bSam2", "bSam3" },
		red = {}
	},
	blueShip = { -- For zones on sea, their "upgrades" MUST ONLY have one side
		blue = { "bShip", "bShip", "bShip" },
		red = {}
	},
	redShip = {
		blue = {},
		red = { "rShip", "rShip", "rShip" }
	},
}

-- Zone Upgrades Done

-- BattleCommander Initialization

local filepath = 'Caucasus-NW-Saved-Data.lua'
if lfs then
	local dir = lfs.writedir()..'Missions/Saves/'
	lfs.mkdir(dir)
	filepath = dir..filepath
	env.info('Foothold - Save file path: '..filepath)
end
bc = BattleCommander:new(filepath, 10, 60) -- This MUST be global, as zoneCommander.lua gets zone list though it for support menu to work

-- BattleCommander Initialization Done

-- Zone Definition

local zones = {
	carrier = {
		zoneCommanderProperties = {
			zone = "Carrier Group",
			side = 2, -- 0 = neutral, 1 = red, 2 = blue
			level = 3,
			upgrades = zoneUpgrades.blueShip,
			crates = cargoAccepts.all,
			flavorText = hint,
			income = 0,
		},
		dispatches = {
			{
				name = "b-patrol-cvn73-cvn73-f18c",
				mission = "patrol", -- patrol, supply, attack
				targetzone = "Carrier Group",
				type = "carrier_air" -- air, carrier_air, surface
			},
		},
		criticalObjects = {},
		connections = {},
	},

	anapa = {
		zoneCommanderProperties = {
			zone = "Anapa",
			side = 2,
			level = 5,
			upgrades = zoneUpgrades.blueAirfield,
			crates = cargoAccepts.anapa,
			flavorText = hint,
			income = 0,
		},
		dispatches = {
			{ name = "b-attack-anapa-krymsk-a10c2", mission = "attack", targetzone = "Krymsk" },

			{ name = "b-patrol-anapa-krymsk-f15c", mission = "patrol", targetzone = "Krymsk" },
			{ name = "b-patrol-anapa-novoro-f15c", mission = "patrol", targetzone = "Novoro" },

			{ name = "b-supply-anapa-famer-uh60a", mission = "supply", targetzone = "Famer" },
			{ name = "b-supply-anapa-novoro-uh60a", mission = "supply", targetzone = "Novoro" },
			{ name = "b-supply-anapa-alpha-uh60a", mission = "supply", targetzone = "Alpha" },
			{ name = "b-supply-anapa-krymsk-uh60a", mission = "supply", targetzone = "Krymsk" },
			{ name = "b-supply-anapa-bravo-uh60a", mission = "supply", targetzone = "Bravo" },
			{ name = "b-supply-anapa-convoy-uh60a", mission = "supply", targetzone = "Convoy" },
			{ name = "b-supply-anapa-oilfields-uh60a", mission = "supply", targetzone = "Oil Fields" },
			{ name = "b-supply-anapa-charlie-uh60a", mission = "supply", targetzone = "Charlie" },
			{ name = "b-supply-anapa-cvn74-uh60a", mission = "supply", targetzone = "Carrier Group", type = "carrier_air" },
		},
		criticalObjects = {},
		connections = {
			"Alpha",
			"Charlie",
			"Famer",
		},
	},

	novoro = {
		zoneCommanderProperties = {
			zone = "Novoro",
			side = 2,
			level = 5,
			upgrades = zoneUpgrades.blueAirfield,
			crates = cargoAccepts.novoro,
			flavorText = hint,
			income = 0,
		},
		dispatches = {
			{ name = "b-attack-novoro-krymsk-a10c2", mission = "attack", targetzone = "Krymsk" },

			{ name = "b-patrol-novoro-krymsk-f15c", mission = "patrol", targetzone = "Krymsk" },

			{ name = "b-supply-novoro-famer-uh60a", mission = "supply", targetzone = "Famer" },
			{ name = "b-supply-novoro-anapa-uh60a", mission = "supply", targetzone = "Anapa" },
			{ name = "b-supply-novoro-alpha-uh60a", mission = "supply", targetzone = "Alpha" },
			{ name = "b-supply-novoro-bravo-uh60a", mission = "supply", targetzone = "Bravo" },
			{ name = "b-supply-novoro-krymsk-uh60a", mission = "supply", targetzone = "Krymsk" },
			{ name = "b-supply-novoro-radiotower-uh60a", mission = "supply", targetzone = "Radio Tower" },
			{ name = "b-supply-novoro-factory-uh60a", mission = "supply", targetzone = "Factory" },
			{ name = "b-supply-novoro-four-uh60a", mission = "supply", targetzone = "Four" },
			{ name = "b-supply-novoro-gelend-uh60a", mission = "supply", targetzone = "Gelend" },
			{ name = "b-supply-novoro-sochi-uh60a", mission = "supply", targetzone = "Sochi" },
			{ name = "b-supply-novoro-cvn73-uh60a", mission = "supply", targetzone = "Carrier Group", type = "carrier_air" },
		},
		criticalObjects = {},
		connections = {
			"Famer",
			"Gelend",
			"Radio Tower"
		},
	},

	gelend = {
		zoneCommanderProperties = {
			zone = "Gelend",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.airfield,
			crates = cargoAccepts.gelend,
			flavorText = hint,
			income = 1,
		},
		dispatches = {
			{ name = "r-attack-gelend-anapa-f16c", mission = "attack", targetzone = "Anapa" },
			{ name = "r-attack-gelend-novoro-jf17", mission = "attack", targetzone = "Novoro" },
			{ name = "r-attack-gelend-krymsk-su25t", mission = "attack", targetzone = "Krymsk" },

			{ name = "r-patrol-gelend-krymsk-f16c", mission = "patrol", targetzone = "Krymsk" },

			{ name = "r-supply-gelend-novoro-uh60a", mission = "supply", targetzone = "Novoro" },
			{ name = "r-supply-gelend-famer-uh60a", mission = "supply", targetzone = "Famer" },
			{ name = "r-supply-gelend-alpha-mi8mtv2", mission = "supply", targetzone = "Alpha" },
			{ name = "r-supply-gelend-bravo-mi8mtv2", mission = "supply", targetzone = "Bravo" },
			{ name = "r-supply-gelend-krymsk-mi8mtv2", mission = "supply", targetzone = "Krymsk" },
			{ name = "r-supply-gelend-radiotower-mi8mtv2", mission = "supply", targetzone = "Radio Tower" },
			{ name = "r-supply-gelend-factory-mi8mtv2", mission = "supply", targetzone = "Factory" },
			{ name = "r-supply-gelend-four-uh60a", mission = "supply", targetzone = "Four" },
			{ name = "r-supply-gelend-apple-uh60a", mission = "supply", targetzone = "Apple" },
			{ name = "r-supply-gelend-sochi-mi8", mission = "supply", targetzone = "Sochi" },

			{ name = "b-supply-gelend-four-uh60a", mission = "supply", targetzone = "Four" },
			{ name = "b-supply-gelend-apple-uh60a", mission = "supply", targetzone = "Apple" },
			{ name = "b-supply-gelend-novoro-uh60a", mission = "supply", targetzone = "Novoro" },
			{ name = "b-supply-gelend-factory-uh60a", mission = "supply", targetzone = "Factory" },
			{ name = "b-supply-gelend-radiotower-uh60a", mission = "supply", targetzone = "Radio Tower" },
			{ name = "b-supply-gelend-sochi-uh60a", mission = "supply", targetzone = "Sochi" },
		},
		criticalObjects = {},
		connections = {
			"Four",
			"Factory",
			"Radio Tower",
		},
	},

	krymsk = {
		zoneCommanderProperties = {
			zone = "Krymsk",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.airfield,
			crates = cargoAccepts.krymsk,
			flavorText = hint,
			income = 1,
		},
		dispatches = {
			{ name = "r-attack-krymsk-bravo-armor", mission = "attack", targetzone = "Bravo", type = "surface" },

			{ name = "r-attack-krymsk-gelend-a10c2", mission = "attack", targetzone = "Gelend" },
			{ name = "r-attack-krymsk-anapa-f18c", mission = "attack", targetzone = "Anapa" },
			{ name = "r-attack-krymsk-novoro-f16c", mission = "attack", targetzone = "Novoro" },

			{ name = "r-patrol-krymsk-krymsk-m2000c", mission = "patrol", targetzone = "Krymsk" },
			{ name = "r-patrol-krymsk-charlie-f14b", mission = "patrol", targetzone = "Charlie" },

			{ name = "r-supply-krymsk-alpha-mi24p", mission = "supply", targetzone = "Alpha" },
			{ name = "r-supply-krymsk-bravo-mi24p", mission = "supply", targetzone = "Bravo" },
			{ name = "r-supply-krymsk-convoy-mi24p", mission = "supply", targetzone = "Convoy" },
			{ name = "r-supply-krymsk-oilfields-mi24p", mission = "supply", targetzone = "Oil Fields" },
			{ name = "r-supply-krymsk-radiotower-mi24p", mission = "supply", targetzone = "Radio Tower" },

			{ name = "r-supply-krymsk-famer-uh60a", mission = "supply", targetzone = "Famer" },
			{ name = "r-supply-krymsk-charlie-uh60a", mission = "supply", targetzone = "Charlie" },
			{ name = "r-supply-krymsk-samsite-mi8mtv2", mission = "supply", targetzone = "SAM Site" },
			{ name = "r-supply-krymsk-echo-uh60a", mission = "supply", targetzone = "Echo" },
			{ name = "r-supply-krymsk-delta-mi8mtv2", mission = "supply", targetzone = "Delta" },
			{ name = "r-supply-krymsk-factory-mi8mtv2", mission = "supply", targetzone = "Factory" },
			{ name = "r-supply-krymsk-gelend-mi8mtv2", mission = "supply", targetzone = "Gelend" },
			{ name = "r-supply-krymsk-ever-mi8", mission = "supply", targetzone = "Ever" },
			{ name = "r-supply-krymsk-kelas-mi8", mission = "supply", targetzone = "Kelas" },

			{ name = "b-patrol-krymsk-krymsk-m2000c", mission = "patrol", targetzone = "Krymsk" },

			{ name = "b-supply-krymsk-bravo-uh60a", mission = "supply", targetzone = "Bravo" },
			{ name = "b-supply-krymsk-radiotower-uh60a", mission = "supply", targetzone = "Radio Tower" },
			{ name = "b-supply-krymsk-delta-uh60a", mission = "supply", targetzone = "Delta" },
			{ name = "b-supply-krymsk-foxtrot-uh60a", mission = "supply", targetzone = "Foxtrot" },
			{ name = "b-supply-krymsk-factory-uh60a", mission = "supply", targetzone = "Factory" },
			{ name = "b-supply-krymsk-samsite-uh60a", mission = "supply", targetzone = "SAM Site" },
			{ name = "b-supply-krymsk-convoy-uh60a", mission = "supply", targetzone = "Convoy" },
			{ name = "b-supply-krymsk-oilfields-uh60a", mission = "supply", targetzone = "Oil Fields" },
			{ name = "b-supply-krymsk-echo-uh60a", mission = "supply", targetzone = "Echo" },
			{ name = "b-supply-krymsk-ever-uh60a", mission = "supply", targetzone = "Ever" },
			{ name = "b-supply-krymsk-kelas-uh60a", mission = "supply", targetzone = "Kelas" },
		},
		criticalObjects = {},
		connections = {
			"Delta",
			"Convoy",
			"Radio Tower",
			"Factory",
			"SAM Site",
			"Oil Fields",
		},
	},

	kelas = {
		zoneCommanderProperties = {
			zone = "Kelas",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.airfieldPlus,
			crates = cargoAccepts.kelas,
			flavorText = hint,
			income = 3,
		},
		dispatches = {
			{ name = "r-attack-kelas-four-su25t", mission = "attack", targetzone = "Four" },
			{ name = "r-attack-kelas-foxtrot-ah64d", mission = "attack", targetzone = "Foxtrot" },
			{ name = "r-attack-kelas-gelend-f18c", mission = "attack", targetzone = "Gelend" },
			{ name = "r-attack-kelas-factory-su25t", mission = "attack", targetzone = "Factory" },
			{ name = "r-attack-kelas-radiotower-su25t", mission = "attack", targetzone = "Radio Tower" },
			{ name = "r-attack-kelas-krymsk-f18c", mission = "attack", targetzone = "Krymsk" },
			{ name = "r-attack-kelas-delta-a10c2", mission = "attack", targetzone = "Delta" },
			{ name = "r-attack-kelas-echo-su25t", mission = "attack", targetzone = "Echo" },
			{ name = "r-attack-kelas-samsite-a10c2", mission = "attack", targetzone = "SAM Site" },
			{ name = "r-attack-kelas-ever-su25t", mission = "attack", targetzone = "Ever" },
			{ name = "r-attack-kelas-kras-ah64d", mission = "attack", targetzone = "Kras" },
			{ name = "r-attack-kelas-apple-su25t", mission = "attack", targetzone = "Apple" },

			{ name = "r-patrol-kelas-krymsk-f16c", mission = "patrol", targetzone = "Krymsk" },
			{ name = "r-patrol-kelas-apple-f16c", mission = "patrol", targetzone = "Apple" },
			{ name = "r-patrol-kelas-gelend-f14b", mission = "patrol", targetzone = "Gelend" },
			{ name = "r-patrol-kelas-kelas-f14b", mission = "patrol", targetzone = "Kelas" },

			{ name = "r-supply-kelas-kras-truck", mission = "supply", targetzone = "Kras", type = "surface" },

			{ name = "r-supply-kelas-four-mi8", mission = "supply", targetzone = "Four" },
			{ name = "r-supply-kelas-foxtrot-uh60a", mission = "supply", targetzone = "Foxtrot" },
			{ name = "r-supply-kelas-gelend-uh60a", mission = "supply", targetzone = "Gelend" },
			{ name = "r-supply-kelas-factory-mi8", mission = "supply", targetzone = "Factory" },
			{ name = "r-supply-kelas-radiotower-uh60a", mission = "supply", targetzone = "Radio Tower" },
			{ name = "r-supply-kelas-krymsk-mi8", mission = "supply", targetzone = "Krymsk" },
			{ name = "r-supply-kelas-delta-mi8", mission = "supply", targetzone = "Delta" },
			{ name = "r-supply-kelas-echo-uh60a", mission = "supply", targetzone = "Echo" },
			{ name = "r-supply-kelas-samsite-mi8", mission = "supply", targetzone = "SAM Site" },
			{ name = "r-supply-kelas-ever-mi8", mission = "supply", targetzone = "Ever" },
			{ name = "r-supply-kelas-kras-uh60a", mission = "supply", targetzone = "Kras" },
			{ name = "r-supply-kelas-apple-mi8", mission = "supply", targetzone = "Apple" },

			{ name = "b-supply-kelas-four-uh60a", mission = "supply", targetzone = "Four" },
			{ name = "b-supply-kelas-foxtrot-uh60a", mission = "supply", targetzone = "Foxtrot" },
			{ name = "b-supply-kelas-delta-uh60a", mission = "supply", targetzone = "Delta" },
			{ name = "b-supply-kelas-echo-uh60a", mission = "supply", targetzone = "Echo" },
			{ name = "b-supply-kelas-samsite-uh60a", mission = "supply", targetzone = "SAM Site" },
			{ name = "b-supply-kelas-ever-uh60a", mission = "supply", targetzone = "Ever" },
			{ name = "b-supply-kelas-kras-uh60a", mission = "supply", targetzone = "Kras" },
			{ name = "b-supply-kelas-apple-uh60a", mission = "supply", targetzone = "Apple" },
		},
		criticalObjects = {},
		connections = {},
	},

	kras = {
		zoneCommanderProperties = {
			zone = "Kras",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.airfieldPlus,
			crates = cargoAccepts.kras,
			flavorText = hint,
			income = 3,
		},
		dispatches = {
			{ name = "r-attack-kras-four-su34", mission = "attack", targetzone = "Four" },
			{ name = "r-attack-kras-sochi-su34", mission = "attack", targetzone = "Sochi" },
			{ name = "r-attack-kras-kelas-su34", mission = "attack", targetzone = "Kelas" },
			{ name = "r-attack-kras-krymsk-su34", mission = "attack", targetzone = "Krymsk" },
			{ name = "r-attack-kras-samsite-su34", mission = "attack", targetzone = "SAM Site" },

			{ name = "r-attack-kras-kelas-ka50", mission = "attack", targetzone = "Kelas" },
			{ name = "r-attack-kras-foxtrot-ka50", mission = "attack", targetzone = "Foxtrot" },

			{ name = "r-patrol-kras-kras-su33", mission = "patrol", targetzone = "Kras" },
			{ name = "r-patrol-kras-gelend-su27", mission = "patrol", targetzone = "Gelend" },
			{ name = "r-patrol-kras-samsite-mig29s", mission = "patrol", targetzone = "SAM Site" },
			{ name = "r-patrol-kras-sochi-mig31", mission = "patrol", targetzone = "Sochi" },

			{ name = "r-supply-kras-kelas-truck", mission = "supply", targetzone = "Kelas", type = "surface" },

			{ name = "r-supply-kras-echo-mi8", mission = "supply", targetzone = "Echo" },
			{ name = "r-supply-kras-foxtrot-mi8", mission = "supply", targetzone = "Foxtrot" },
			{ name = "r-supply-kras-apple-mi8", mission = "supply", targetzone = "Apple" },
			{ name = "r-supply-kras-four-mi8", mission = "supply", targetzone = "Four" },
			{ name = "r-supply-kras-ever-mi8", mission = "supply", targetzone = "Ever" },
			{ name = "r-supply-kras-kelas-mi8", mission = "supply", targetzone = "Kelas" },
			{ name = "r-supply-kras-sochi-mi8", mission = "supply", targetzone = "Sochi" },
		},
		criticalObjects = {},
		connections = {
			"Apple",
			"Kelas",
		},
	},

	sochi = {
		zoneCommanderProperties = {
			zone = "Sochi",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.airfieldPlusPlus,
			crates = cargoAccepts.all,
			flavorText = hint,
			income = 3,
		},
		dispatches = {
			{ name = "r-attack-sochi-gelend-su34", mission = "attack", targetzone = "Gelend" },

			{ name = "r-patrol-sochi-sochi-su33", mission = "patrol", targetzone = "Sochi" },

			{ name = "r-supply-sochi-apple-mi8", mission = "supply", targetzone = "Apple" },
			{ name = "r-supply-sochi-four-mi8", mission = "supply", targetzone = "Four" },
			{ name = "r-supply-sochi-gelend-mi8", mission = "supply", targetzone = "Gelend" },
		},
		criticalObjects = {},
		connections = {
			"Gelend",
			"Apple",
			"Four",
		},
	},

	alpha = {
		zoneCommanderProperties = {
			zone = "Alpha",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.armor,
			crates = cargoAccepts.all,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {
			"Bravo",
			"Charlie",
			"Famer",
			"Novoro",
			"Radio Tower",
		},
	},

	bravo = {
		zoneCommanderProperties = {
			zone = "Bravo",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			crates = cargoAccepts.all,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {
			"Charlie",
			"Convoy",
			"Krymsk",
			"Radio Tower",
		},
	},

	charlie = {
		zoneCommanderProperties = {
			zone = "Charlie",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.armor,
			crates = cargoAccepts.all,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {
			"Convoy",
			"Oil Fields",
		},
	},

	delta = {
		zoneCommanderProperties = {
			zone = "Delta",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			crates = cargoAccepts.all,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {
			"Echo",
			"SAM Site",
			"Factory",
		},
	},

	echo = {
		zoneCommanderProperties = {
			zone = "Echo",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			crates = cargoAccepts.all,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {
			"Foxtrot",
			"Kelas",
			"SAM Site",
			"Factory",
		},
	},

	foxtrot = {
		zoneCommanderProperties = {
			zone = "Foxtrot",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			crates = cargoAccepts.all,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {
			"Kelas",
			"Kras",
			"Factory",
			"Four",
			"Apple",
		},
	},

	famer = {
		zoneCommanderProperties = {
			zone = "Famer",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.armor,
			crates = cargoAccepts.all,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {},
	},

	four = {
		zoneCommanderProperties = {
			zone = "Four",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			crates = cargoAccepts.all,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {},
	},

	ever = {
		zoneCommanderProperties = {
			zone = "Ever",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			crates = cargoAccepts.all,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {
			"Echo",
			"Oil Fields",
			"SAM Site",
			"Kelas",
		},
	},

	apple = {
		zoneCommanderProperties = {
			zone = "Apple",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.normal,
			crates = cargoAccepts.all,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {},
		connections = {
			"Four",
		},
	},

	oilfields = {
		zoneCommanderProperties = {
			zone = "Oil Fields",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.armor,
			crates = cargoAccepts.oilfields,
			flavorText = hint,
			income = 1,
		},
		dispatches = {
			{ name = "r-supply-oilfields-krymsk-truck", mission = "supply", targetzone = "Krymsk", type = "surface" },
		},
		criticalObjects = {
			"oilref1",
			"oilref2",
		},
		connections = {
			"Convoy",
			"SAM Site",
		},
	},

	factory = {
		zoneCommanderProperties = {
			zone = "Factory",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.armor,
			crates = cargoAccepts.factory,
			flavorText = hint,
			income = 1,
		},
		dispatches = {
			{ name = "r-attack-factory-krymsk-armor", mission = "attack", targetzone = "Krymsk", type = "surface" },

			{ name = "r-supply-factory-krymsk-truck", mission = "supply", targetzone = "Krymsk", type = "surface" },
			{ name = "r-supply-factory-delta-truck", mission = "supply", targetzone = "Delta", type = "surface" },
			{ name = "r-supply-factory-echo-truck", mission = "supply", targetzone = "Echo", type = "surface" },
			{ name = "r-supply-factory-foxtrot-truck", mission = "supply", targetzone = "Foxtrot", type = "surface" },
		},
		criticalObjects = {
			"FactoryBuilding1",
			"FactoryBuilding2",
		},
		connections = {
			"Four",
			"Radio Tower",
		},
	},

	convoy = {
		zoneCommanderProperties = {
			zone = "Convoy",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.armor,
			crates = cargoAccepts.all,
			flavorText = hint,
			income = 1,
		},
		dispatches = {},
		criticalObjects = {
			"convoy1",
			"convoy2",
			"convoy3",
			"convoy4",
		},
		connections = {},
	},

	samsite = {
		zoneCommanderProperties = {
			zone = "SAM Site",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.sam,
			crates = cargoAccepts.samsite,
			flavorText = hint,
			income = 1,
		},
		dispatches = {
			{ name = "r-attack-samsite-krymsk-armor", mission = "attack", targetzone = "Krymsk", type = "surface" },
		},
		criticalObjects = {
			"CommandCenter",
		},
		connections = {},
	},

	radiotower = {
		zoneCommanderProperties = {
			zone = "Radio Tower",
			side = 1,
			level = 3,
			upgrades = zoneUpgrades.armor,
			crates = cargoAccepts.all,
			flavorText = hint,
			income = 0,
		},
		dispatches = {},
		criticalObjects = {
			"RadioTower",
		},
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

-- Resource Point Triggers

zones.convoy.zoneCommander:registerTrigger('lost', function(event, sender)
	local convoyItems = { 'convoy1', 'convoy2', 'convoy3', 'convoy4' }

	local message = "Convoy liberated"
	local totalLost = 0
	for i, v in ipairs(convoyItems) do
		if not StaticObject.getByName(v) then
			totalLost = totalLost + 1
		end
	end

	if totalLost > 0 then
		local percentLost = math.ceil((totalLost / #convoyItems) * 100)
		percentLost = math.min(percentLost, 100)
		percentLost = math.max(percentLost, 1)
		message = message .. ' but we lost ' .. percentLost .. '% of the trucks.'
	else
		message = message .. '. We recovered all of the supplies.'
	end

	local creditsEarned = (#convoyItems - totalLost) * 250
	message = message .. '\n\n+' .. creditsEarned .. ' credits'

	bc:addFunds(2, creditsEarned)

	trigger.action.outTextForCoalition(2, message, 60)
end, 'convoyLost', 1)

local showCredIncrease = function(event, sender)
	trigger.action.outTextForCoalition(sender.side, '+' .. math.floor(sender.income * 360) .. ' Credits/Hour', 60)
end

zones.oilfields.zoneCommander:registerTrigger('captured', showCredIncrease, 'oilfieldcaptured')
zones.factory.zoneCommander:registerTrigger('captured', showCredIncrease, 'factorycaptured')

-- Resource Point Triggers Done

-- Mission Complete Check

local missionCompleteCheckSheduler = {}

local missionCompleteCheck = function(event, sender)
	local done = true
	for i, v in ipairs(bc:getZones()) do
		if v.side == 1 then
			done = false
			break
		end
	end

	if done then
		trigger.action.outText("敌军已被彻底击败！任务完成！ \n\n服务器将于90秒后重启！", 90)
		mist.removeFunction(missionCompleteCheckSheduler)
		mist.scheduleFunction(function(event, sender)
			os.remove(filepath)
			trigger.action.setUserFlag("TriggerFlagMissionComplete", true)
		end, {}, timer.getTime() + 90)
	end
end

missionCompleteCheckSheduler = mist.scheduleFunction(missionCompleteCheck, {}, timer.getTime() + 60, 60)

-- for i,v in ipairs(bc:getZones()) do
-- 	v:registerTrigger('lost', checkMissionComplete, 'missioncompleted')
-- end

-- Mission Complete Check Done

-- Scheduled Restart

local restartTime = 14400 -- 4 hours
local restartHintTime = { 60, 180, 300, 900 }

for key, value in pairs(restartHintTime) do -- Restart hint
	mist.scheduleFunction(function(event, sender)
		trigger.action.outText("服务器将于" .. value / 60 .. "分钟后定时重启！", 60)
	end, {}, timer.getTime() + restartTime - value)
end

mist.scheduleFunction(function(event, sender) -- Restart
	bc:update()
	bc:saveToDisk()
	trigger.action.setUserFlag("TriggerFlagScheduledRestart", true)
end, {}, timer.getTime() + restartTime)

-- Scheduled Restart Done

-- Blue Support

Group.getByName('sead1'):destroy()
local seadTargetMenu = nil
bc:registerShopItem('sead', 'F/A-18C 防空压制任务', 1500, function(sender)
	local gr = Group.getByName('sead1')
	if gr and gr:getSize() > 0 and gr:getController():hasTask() then
		return '防空压制任务仍在进行中'
	end
	mist.respawnGroup('sead1', true)

	if seadTargetMenu then
		return '请使用 F10 菜单指派攻击目标'
	end

	local launchAttack = function(target)
		if Group.getByName('sead1') then
			local err = bc:engageZone(target, 'sead1')
			if err then
				return err
			end

			trigger.action.outTextForCoalition(2, 'F/A-18C 正在对' .. target .. '战区进行防空压制', 60)
		else
			trigger.action.outTextForCoalition(2, '支援单位已离开战区或已被击毁', 60)
		end

		seadTargetMenu = nil
	end

	seadTargetMenu = bc:showTargetZoneMenu(2, '指派 F/A-18C 防空压制目标', launchAttack, 1)

	trigger.action.outTextForCoalition(2, 'F/A-18C 已就绪，请使用 F10 菜单指派攻击目标', 60)
end,
	function(sender, params)
		if params.zone and params.zone.side == 1 then
			local gr = Group.getByName('sead1')
			if gr and gr:getSize() > 0 and gr:getController():hasTask() then
				return '防空压制任务仍在进行中'
			end

			mist.respawnGroup('sead1', true)
			mist.scheduleFunction(function(target)
				if Group.getByName('sead1') then
					local err = bc:engageZone(target, 'sead1')
					if err then
						return err
					end

					trigger.action.outTextForCoalition(2, 'F/A-18C 正在对' .. target .. '战区进行防空压制', 60)
				end
			end, { params.zone.zone }, timer.getTime() + 2)
		else
			return '仅允许攻击敌方占领区'
		end
	end)

Group.getByName('sweep1'):destroy()
bc:registerShopItem('sweep', 'F-14B 战斗机扫荡任务', 1500, function(sender)
	local gr = Group.getByName('sweep1')
	if gr and gr:getSize() > 0 and gr:getController():hasTask() then
		return '战斗机扫荡任务仍在进行中'
	end
	mist.respawnGroup('sweep1', true)
end,
	function(sender, params)
		local gr = Group.getByName('sweep1')
		if gr and gr:getSize() > 0 and gr:getController():hasTask() then
			return '战斗机扫荡任务仍在进行中'
		end
		mist.respawnGroup('sweep1', true)
	end)

Group.getByName('cas1'):destroy()
local casTargetMenu = nil
bc:registerShopItem('cas', 'F-16CM 对地攻击任务', 1500, function(sender)
	local gr = Group.getByName('cas1')
	if gr and gr:getSize() > 0 and gr:getController():hasTask() then
		return '对地攻击任务仍在进行中'
	end

	mist.respawnGroup('cas1', true)

	if casTargetMenu then
		return '请使用 F10 菜单指派攻击目标'
	end

	local launchAttack = function(target)
		if casTargetMenu then
			if Group.getByName('cas1') then
				local err = bc:engageZone(target, 'cas1')
				if err then
					return err
				end

				trigger.action.outTextForCoalition(2, 'F-16CM 正在对' .. target .. '战区进行对地攻击', 60)
			else
				trigger.action.outTextForCoalition(2, '支援单位已离开战区或已被击毁', 60)
			end

			casTargetMenu = nil
		end
	end

	casTargetMenu = bc:showTargetZoneMenu(2, '指派 F-16CM 对地攻击目标', launchAttack, 1)

	trigger.action.outTextForCoalition(2, 'F-16CM 已就绪，请使用 F10 菜单指派攻击目标', 60)
end,
	function(sender, params)
		if params.zone and params.zone.side == 1 then
			local gr = Group.getByName('cas1')
			if gr and gr:getSize() > 0 and gr:getController():hasTask() then
				return '对地攻击任务仍在进行中'
			end

			mist.respawnGroup('cas1', true)
			mist.scheduleFunction(function(target)
				if Group.getByName('cas1') then
					local err = bc:engageZone(target, 'cas1')
					if err then
						return err
					end

					trigger.action.outTextForCoalition(2, 'F-16CM 正在对' .. target .. '战区进行对地攻击', 60)
				end
			end, { params.zone.zone }, timer.getTime() + 2)
		else
			return '仅允许攻击敌方占领区'
		end
	end)

bc:addMonitoredROE('bCruise1')
local cruiseMissileTargetMenu = nil
bc:registerShopItem('cruisemsl', '巡航导弹打击', 2500, function(sender)
	if cruiseMissileTargetMenu then
		return '请使用 F10 菜单指派攻击目标'
	end

	local launchAttack = function(target)
		if cruiseMissileTargetMenu then
			local err = bc:fireAtZone(target, 'bCruise1', true, 8)
			if err then
				return err
			end

			cruiseMissileTargetMenu = nil
			trigger.action.outTextForCoalition(2, '正在对' .. target .. '战区进行巡航导弹打击', 60)
		end
	end

	cruiseMissileTargetMenu = bc:showTargetZoneMenu(2, '指派巡航导弹打击目标', launchAttack, 1)

	trigger.action.outTextForCoalition(2, '巡航导弹已就绪，请使用 F10 菜单指派攻击目标', 60)
end,
	function(sender, params)
		if params.zone and params.zone.side == 1 then
			local err = bc:fireAtZone(params.zone.zone, 'bCruise1', true, 8)
			if err then
				return err
			end

			trigger.action.outTextForCoalition(2, '正在对' .. params.zone.zone .. '战区进行巡航导弹打击', 60)
		else
			return '仅允许攻击敌方占领区'
		end
	end)

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

local JTAC = JTAC
Group.getByName('jtacDrone'):destroy()
local jtacTargetMenu = nil
drone = JTAC:new({ name = 'jtacDrone' }) -- This MUST be global, as JTAC in zomeCommander.lua will directly refer to this value
bc:registerShopItem('jtac', 'MQ-1A JTAC 侦查任务', 100, function(sender)

	if jtacTargetMenu then
		return '请使用 F10 菜单指派侦查目标'
	end

	local spawnAndOrbit = function(target)
		if jtacTargetMenu then
			local zn = bc:getZoneByName(target)
			drone:deployAtZone(zn)
			drone:showMenu()
			trigger.action.outTextForCoalition(2, 'MQ-1A 已部署于' .. target .. '战区上空', 60)
			jtacTargetMenu = nil
		end
	end

	jtacTargetMenu = bc:showTargetZoneMenu(2, '部署 MQ-1A', spawnAndOrbit, 1)

	trigger.action.outTextForCoalition(2, 'MQ-1A 已就绪，请使用 F10 菜单指派侦查区域', 60)
end,
	function(sender, params)
		if params.zone and params.zone.side == 1 then
			drone:deployAtZone(params.zone)
			drone:showMenu()
			trigger.action.outTextForCoalition(2, 'MQ-1A 已部署于' .. params.zone.zone .. '战区上空', 60)
		else
			return '仅允许侦查敌方占领区'
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

local spawnAwacs = function(sender)
	local gr = Group.getByName('awacs1')
	if gr and gr:getSize() > 0 and gr:getController():hasTask() then
		return 'E-2D 空中预警机 仍在执行任务\n呼号：Darkstar\n无线电频率：255.00 MHz AM'
	end
	mist.respawnGroup('awacs1', true)
	trigger.action.outTextForCoalition(2, 'E-2D 空中预警机已上线\n呼号：Darkstar\n无线电频率：255.00 MHz AM', 60)
end
Group.getByName('awacs1'):destroy()
bc:registerShopItem('awacs', 'E-2D 空中预警机(AWACS)', 100, spawnAwacs, spawnAwacs)

local spawnAirrefuelSoft = function(sender)
	local gr = Group.getByName('airrefuel-soft')
	if gr and gr:getSize() > 0 and gr:getController():hasTask() then
		return 'KC-135MPRS 空中加油机(软管) 仍在执行任务\n呼号：Texaco\n无线电频率：251.00 MHz AM'
	end
	mist.respawnGroup('airrefuel-soft', true)
	trigger.action.outTextForCoalition(2, 'KC-135MPRS 空中加油机(软管) 已上线\n呼号：Texaco\n无线电频率：251.00 MHz AM', 60)
end
Group.getByName('airrefuel-soft'):destroy()
bc:registerShopItem('airrefuel-soft', 'KC-135MPRS 空中加油机(软管)', 100, spawnAirrefuelSoft, spawnAirrefuelSoft)

local spawnAirrefuelHard = function(sender)
	local gr = Group.getByName('airrefuel-hard')
	if gr and gr:getSize() > 0 and gr:getController():hasTask() then
		return 'KC-135 空中加油机(硬管) 仍在执行任务\n呼号：Arco\n无线电频率：252.00 MHz AM'
	end
	mist.respawnGroup('airrefuel-hard', true)
	trigger.action.outTextForCoalition(2, 'KC-135 空中加油机(硬管) 已上线\n呼号：Arco\n无线电频率：252.00 MHz AM', 60)
end
Group.getByName('airrefuel-hard'):destroy()
bc:registerShopItem('airrefuel-hard', 'KC-135 空中加油机(硬管)', 100, spawnAirrefuelHard, spawnAirrefuelHard)

Group.getByName('ewAircraft'):destroy()
local jamMenu = nil
bc:registerShopItem('jam', '雷达干扰 (Radar Jamming)', 500, function(sender)
	local gr = Group.getByName('ewAircraft')
	if Utils.isGroupActive(gr) then
		return '雷达干扰任务仍在进行中'
	end
	mist.respawnGroup('ewAircraft', true)
	if jamMenu then
		return '请使用 F10 菜单指派目标区域'
	end
	local startJam = function(target)
		if jamMenu then
			bc:jamRadarsAtZone('ewAircraft', target)
			jamMenu = nil
			trigger.action.outTextForCoalition(2, "E/A-18 Growler 正在干扰 " .. target .. " 区域的雷达", 60)
		end
	end
	jamMenu = bc:showTargetZoneMenu(2, '指派雷达干扰目标', startJam, 1)
	trigger.action.outTextForCoalition(2, '请使用 F10 菜单指派目标区域', 60)
end,
function(sender, params)
	if params.zone and params.zone.side == 1 then
		local gr = Group.getByName('ewAircraft')
		if Utils.isGroupActive(gr) then
			return '雷达干扰任务仍在进行中'
		end
		mist.respawnGroup('ewAircraft', true)
		mist.scheduleFunction(function(target)
			local ew = Group.getByName('ewAircraft')
			if ew then
				local err = bc:jamRadarsAtZone('ewAircraft', target)
				if err then
					return err
				end
				trigger.action.outTextForCoalition(2, "E/A-18 Growler 正在干扰 " .. target .. " 区域的雷达", 60)
			end
		end,{params.zone.zone},timer.getTime() + 2)
	else
		return '只能对敌方占领区进行雷达干扰'
	end
end)

Group.getByName('ca-tanks'):destroy()
local tanksMenu = nil
bc:registerShopItem('ca-tanks', '部署坦克', 150, function(sender)
	if tanksMenu then
		return "请使用 F10 菜单选择部署区域"
	end
	local deployTanks = function(target)
		if tanksMenu then
			local zn = CustomZone:getByName(target)
			zn:spawnGroup('ca-tanks')
			tanksMenu = nil
			trigger.action.outTextForCoalition(2, '友方坦克已部署于 '..target, 60)
		end
	end
	tanksMenu = bc:showTargetZoneMenu(2, '部署坦克 (请选择友方占领区域)', deployTanks, 2)
	trigger.action.outTextForCoalition(2, "请使用 F10 菜单选择部署区域", 60)
end,
function(sender, params)
	if params.zone and params.zone.side == 2 then
		local zn = CustomZone:getByName(params.zone.zone)
		zn:spawnGroup('ca-tanks')
		trigger.action.outTextForCoalition(2, '友方坦克已部署于 '..params.zone.zone, 60)
	else
		return '只能在友方占领区部署地面单位'
	end
end)

Group.getByName('ca-arty'):destroy()
local artyMenu = nil
bc:registerShopItem('ca-arty', '部署火炮', 250, function(sender)
	if artyMenu then
		return "请使用 F10 菜单选择部署区域"
	end
	local deployArty = function(target)
		if artyMenu then
			local zn = CustomZone:getByName(target)
			zn:spawnGroup('ca-arty')
			artyMenu = nil
			trigger.action.outTextForCoalition(2, '友方火炮已部署于 '..target, 60)
		end
	end
	artyMenu = bc:showTargetZoneMenu(2, '部署火炮 (请选择友方占领区域)', deployArty, 2)
	trigger.action.outTextForCoalition(2, "请使用 F10 菜单选择部署区域", 60)
end,
function(sender, params)
	if params.zone and params.zone.side == 2 then
		local zn = CustomZone:getByName(params.zone.zone)
		zn:spawnGroup('ca-arty')
		trigger.action.outTextForCoalition(2, '友方火炮已部署于 '..params.zone.zone, 60)
	else
		return '只能在友方占领区部署地面单位'
	end
end)

Group.getByName('ca-supply'):destroy()
local caSupplyMenu = nil
bc:registerShopItem('ca-supply', '部署补给卡车', 100, function(sender)
	if caSupplyMenu then
		return "请使用 F10 菜单选择部署区域"
	end
	local deployRecon = function(target)
		if caSupplyMenu then
			local zn = CustomZone:getByName(target)
			zn:spawnGroup('ca-supply')
			caSupplyMenu = nil
			trigger.action.outTextForCoalition(2, "补给卡车已部署于 " .. target, 60)
		end
	end
	caSupplyMenu = bc:showTargetZoneMenu(2, "部署补给卡车 (请选择友方占领区域)", deployRecon, 2)
	trigger.action.outTextForCoalition(2, "请使用 F10 菜单选择补给卡车的部署区域", 60)
end,
function(sender, params)
	if params.zone and params.zone.side == 2 then
		local zn = CustomZone:getByName(params.zone.zone)
		zn:spawnGroup('ca-supply')
		trigger.action.outTextForCoalition(2, "补给卡车已部署于 "..params.zone.zone, 60)
	else
		return "只能在友方占领区部署地面单位"
	end
end)

Group.getByName('ca-airdef'):destroy()
local airdefMenu = nil
bc:registerShopItem('ca-airdef', '部署防空车', 300, function(sender)
	if airdefMenu then
		return "请使用 F10 菜单选择部署区域"
	end
	local deployAirDef = function(target)
		if airdefMenu then
			local zn = CustomZone:getByName(target)
			zn:spawnGroup('ca-airdef')
			airdefMenu = nil
			trigger.action.outTextForCoalition(2, '友方防空车已部署于 '..target, 60)
		end
	end
	airdefMenu = bc:showTargetZoneMenu(2, '部署防空车 (请选择友方占领区域)', deployAirDef, 2)
	trigger.action.outTextForCoalition(2, "请使用 F10 菜单选择部署区域", 60)
end,
function(sender, params)
	if params.zone and params.zone.side == 2 then
		local zn = CustomZone:getByName(params.zone.zone)
		zn:spawnGroup('ca-airdef')
		trigger.action.outTextForCoalition(2, '友方防空车已部署于 '..params.zone.zone, 60)
	else
		return '只能在友方占领区部署地面单位'
	end
end)

bc:addShopItem(2, 'sead', -1)
bc:addShopItem(2, 'sweep', -1)
bc:addShopItem(2, 'cas', -1)
bc:addShopItem(2, 'cruisemsl', -1)
bc:addShopItem(2, 'supplies', -1)
bc:addShopItem(2, 'jtac', -1)
bc:addShopItem(2, 'smoke', -1)
bc:addShopItem(2, 'awacs', -1)
bc:addShopItem(2, 'airrefuel-soft', -1)
bc:addShopItem(2, 'airrefuel-hard', -1)
bc:addShopItem(2, 'jam', -1)
bc:addShopItem(2, 'ca-tanks', -1)
bc:addShopItem(2, 'ca-arty', -1)
bc:addShopItem(2, 'ca-supply', -1)
bc:addShopItem(2, 'ca-airdef', -1)

-- bc:addFunds(2, 100000)

-- Blue Support Done

-- Group Functions, used by red supports
local GroupFunctions = {}

function GroupFunctions:getGroupsByNames(names)
	local groups = {}
	for key, value in pairs(names) do
		table.insert(groups, Group.getByName(value))
	end
	return groups
end

function GroupFunctions:destroyGroups(groups)
	for key, value in pairs(groups) do
		value:destroy()
	end
end

function GroupFunctions:destroyGroupsByNames(names)
	GroupFunctions:destroyGroups(GroupFunctions:getGroupsByNames(names))
end

function GroupFunctions:respawnGroupsByNames(names, task)
	for key, value in pairs(names) do
		mist.respawnGroup(value, task)
	end
end

function GroupFunctions:areGroupsActive(groups)
	local active = false
	for key, value in pairs(groups) do
		active = active or value and value:getSize() > 0 and value:getController():hasTask()
	end
	return active
end

function GroupFunctions:areGroupsActiveByNames(names)
	-- Each time a group is respawned, it is a NEW group, so it MUST be done during runtime
	return GroupFunctions:areGroupsActive(GroupFunctions:getGroupsByNames(names))
end

function GroupFunctions:zoneMatch(zones)
	local zoneMatch = true
	for key, value in pairs(zones) do
		zoneMatch = zoneMatch and bc:getZoneByName(value.name).side == value.side
	end
	return zoneMatch
end

-- Group Functions Done

-- Red Support

local redSupports = {
	shipAttack = {
		name = "r-support-frigate-sochi-carrier",
		description = "Ship Attack",
		price = 1000,
		random = 50, -- Any value <= 0 or >= 100 will always spawn all groups
		groupNames = {
			"r-support-frigate-sochi-carrier-1",
			"r-support-frigate-sochi-carrier-2",
		},
		zones = {
			base = {
				name = "Sochi",
				side = 1,
			},
			target = {
				name = "Carrier Group",
				side = 2,
			},
		},
		hint = {
			side = 2,
			text = "敌军正在派遣舰队攻击我方航母！\n起点：索契\n攻击目标：蓝方航母作战集群",
		},
	},
	antishipSochiToCarrier = {
		name = "r-support-antiship-sochi-carrier",
		description = "Anti-ship Attack from Sochi to Carrier",
		price = 1000,
		random = 25,
		groupNames = {
			"r-support-antiship-sochi-carrier-tu22m3",
			"r-support-antiship-sochi-carrier-f16c",
			"r-support-antiship-sochi-carrier-su34",
		},
		zones = {
			base = {
				name = "Sochi",
				side = 1,
			},
			target = {
				name = "Carrier Group",
				side = 2,
			},
		},
		hint = {
			side = 2,
			text = "敌军正在派遣机队攻击我方航母！\n起点：索契\n攻击目标：蓝方航母作战集群",
		},
	},
	bomberKelasToKrymsk = {
		name = "r-support-bomber-kelas-krymsk",
		description = "Bomber Attack from Kelas to Krymsk",
		price = 1000,
		random = 0,
		groupNames = {
			"r-support-bomber-kelas-krymsk-tu22m3",
			"r-support-bomber-kelas-krymsk-f16c",
		},
		zones = {
			base = {
				name = "Kelas",
				side = 1,
			},
			target = {
				name = "Krymsk",
				side = 2,
			},
		},
		hint = {
			side = 2,
			text = "敌军正在派遣轰炸机机队攻击我方机场！\n起点：克拉斯诺达尔-中心区\n攻击目标：克雷姆斯克",
		},
	},
}

local function NewRedSupport(support)
	GroupFunctions:destroyGroupsByNames(support.groupNames)
	bc:registerShopItem(support.name, support.description, support.price, function(sender)
		if not GroupFunctions:zoneMatch(support.zones) then
			return "zones mismatch"
		end
		if GroupFunctions:areGroupsActiveByNames(support.groupNames) then
			return "groups still active"
		end
		local selectedGroupNames = {}
		if support.random > 0 and support.random < 100 then -- Actually spawned group amount based on random value
			for key, value in pairs(support.groupNames) do
				if math.random(1, 100) < support.random then
					table.insert(selectedGroupNames, value)
				end
			end
			if #selectedGroupNames == 0 then -- At least spawn one group
				table.insert(selectedGroupNames, support.groupNames[math.random(1, #support.groupNames)])
			end
		else
			selectedGroupNames = support.groupNames
		end
		GroupFunctions:respawnGroupsByNames(selectedGroupNames)
		trigger.action.outTextForCoalition(support.hint.side, support.hint.text, 60)
	end)
	bc:addShopItem(1, support.name, -1)
end

local function InitRedSupports()
	for key, value in pairs(redSupports) do
		NewRedSupport(value)
	end
end

InitRedSupports()

-- bc:addFunds(1, 100000)
-- BudgetCommander:new({ battleCommander = bc, side = 1, decissionFrequency = 1, decissionVariance = 1, skipChance = 0 }):init()

BudgetCommander:new({ battleCommander = bc, side = 1, decissionFrequency = 30 * 60, decissionVariance = 30 * 60, skipChance = 25 }):init()

-- Red Support Done

-- Red Carrier Patrols
-- This is special as the zone is not registed as a normal zone

local redCarrierPatrols = {
	"r-patrol-rcvn61-rcvn61-su33",
	"r-patrol-rcvn73-rcvn74-f18c",
	"r-patrol-rcvn74-rcvn73-f14b",
}

GroupFunctions:destroyGroupsByNames(redCarrierPatrols)

local Utils = Utils
local redCarrierAirGroupSpawn = function(event, sender)
	for key, value in pairs(redCarrierPatrols) do
		local group = Group.getByName(value)
		if not group or group:getSize() == 0 then
			if group and group:getSize() == 0 then
				group:destroy()
			elseif math.random(1, 100) > 50 then
				mist.respawnGroup(value, true)
			end
		elseif Utils.allGroupIsLanded(group, true) then
			group:destroy()
		end
	end
end

mist.scheduleFunction(redCarrierAirGroupSpawn, {}, timer.getTime() + 300, 900) -- The detect duration should allow aircrafts' first-time take off, at least 60 seconds

-- Red Carrier Patrols Done

-- Logistics Functions
-- Pilot rescue, cargo transport, etc. in F10 Radio Menu

local logisticCommanderSupplyZones = {}
for key, value in pairs(zones) do
	table.insert(logisticCommanderSupplyZones, value.zoneCommanderProperties.zone)
end
local lc = LogisticCommander:new({ battleCommander = bc, supplyZones = logisticCommanderSupplyZones })
lc:init()

-- Logistics Functions Done

-- BattleCommander Initialization

bc:loadFromDisk() --will load and overwrite default zone levels, sides, funds and available shop items
bc:init()
bc:startRewardPlayerContribution(15, { infantry = 5, ground = 15, sam = 25, airplane = 50, ship = 100, helicopter = 25, crate = 150, rescue = 300 })

-- BattleCommander Initialization Done

-- Mission Generator

local mc = MissionCommander:new({side = 2, battleCommander = bc, checkFrequency = 60})

local captureTarget = nil
mc:trackMission({
	title = function() return "Capture "..captureTarget end,
	description = function() return captureTarget.." is neutral. Capture it by delivering supplies" end,
	messageStart = function() return "New mission: Capture "..captureTarget end,
	messageEnd = function() return "Mission ended: Capture "..captureTarget end,
	startAction = function() end,
	endAction = function()
		captureTarget = nil
	end,
	isActive = function()
		if not captureTarget then
			return false
		end
		local targetzn = bc:getZoneByName(captureTarget)
		return targetzn.side == 0 and targetzn.active
	end
})

local function generateCaptureMission()
	if captureTarget ~= nil then return end
		
	local validzones = {}
	for _,v in ipairs(bc.zones) do
		if v.side == 0 and v.active then
			table.insert(validzones, v.zone)
		end
	end
	
	if #validzones == 0 then return end
	
	local choice = math.random(1, #validzones)
	if validzones[choice] then
		captureTarget = validzones[choice]
		return true
	end
end

timer.scheduleFunction(function(_, time)
	if generateCaptureMission() then
		return time+300
	else
		return time+120
	end
end, {}, timer.getTime() + 20)

mc:init()

-- Mission Generator Done

-- Spawn Cargo Supplies and FARP Trucks
-- These are cargos for players' slingload

HercCargoDropSupply.init(bc)

local function respawnStatics()
	for i, v in pairs(cargoSpawns) do
		local farp = bc:getZoneByName(i)
		if farp then
			if farp.side == 2 then
				for ix, vx in ipairs(v) do
					if not StaticObject.getByName(vx) then
						mist.respawnGroup(vx)
					end
				end
			else
				for ix, vx in ipairs(v) do
					local cr = StaticObject.getByName(vx)
					if cr then
						cr:destroy()
					end
				end
			end
		end
	end

	for i,v in pairs(farpTrucks) do
		local farp = bc:getZoneByName(i)
		if farp then
			if farp.side==2 then
				for ix,vx in ipairs(v) do
					local gr = Group.getByName(vx)
					if not gr then
						mist.respawnGroup(vx)
					elseif gr:getSize() < gr:getInitialSize() then
						mist.respawnGroup(vx)
					end
				end
			else
				for ix,vx in ipairs(v) do
					local cr = Group.getByName(vx)
					if cr then
						cr:destroy()
					end
				end
			end
		end
	end
end

mist.scheduleFunction(respawnStatics, {}, timer.getTime() + 1, 30)

-- Spawn Cargo Supplies and FARP Trucks Done

-- Server Info Hint

mist.scheduleFunction(function(event, sender)
	trigger.action.outText("欢迎来到 [金家寨] <高加索：攻占模式> 服务器！\nQQ群：750508967。\n\n如果您觉得本服务器很好玩，欢迎赞助服务器运营资金！\n收款码可在任务简报页面查询。\n\n本服务器已启用游戏内置的语音功能。\n按下 [ LCtrl + LShift + Tab ] 即可打开语音面板。", 60)
end, {}, timer.getTime() + 30, 1800)

-- Server Info Hint Done
