function merge(tbls)
	local res = {}
	for i,v in ipairs(tbls) do
		for i2,v2 in ipairs(v) do
			table.insert(res,v2)
		end
	end
	
	return res
end

function allExcept(tbls, except)
	local tomerge = {}
	for i,v in pairs(tbls) do
		if i~=except then
			table.insert(tomerge, v)
		end
	end
	return merge(tomerge)
end

carrier = {
	blue = { "bShip", "bShip", "bShip"},
	red = {}
}

friendlyAirfield = {
	blue = { "bArmor", "bSamIR", "bSam", "bSam2", "bSam3" },
	red = {}
}

airfield = {
	blue = { "bArmor", "bSamIR", "bSam", "bSam2", "bSamBig" },
	red = { "rArmor", "rSamIR", "rSam", "rSam2", "rSamBig" }
}

airfieldEnhanced = {
	blue = { "bSamIR", "bSam", "bSam2", "bSamBig", "bSamFinal" },
	red = { "rSamIR", "rSam", "rSam2", "rSamBig", "rSamFinal" }
}

airfieldFinal = {
	blue = { "bSamBig", "bSamFinal", "bSam3", "bSam3", "bSam3" },
	red = { "rSamBig", "rSamFinal", "rSam3", "rSam3", "rSam3" }
}

regularzone = {
	blue = { "bInfantry", "bArmor", "bSamIR", "bSam", "bSam2" },
	red = { "rInfantry", "rArmor", "rSamIR", "rSam", "rSam2" }
}

farp = {
	blue = { "bInfantry", "bInfantry", "bArmor", "bArmor", "bSamIR" },
	red = { "rInfantry", "rInfantry", "rArmor", "rArmor", "rSamIR" }
}

specialSAM = {
	blue = { "bSamIR", "bSam", "bSam2", "bSamBig", "bSamFinal" },
	red = { "rSamIR", "rSam", "rSam2", "rSamBig", "rSamFinal" }
}

convoy = {
	blue = { "bArmor", "bArmor", "bSamIR", "bSamIR", "bSamIR" },
	red = { "rArmor", "rArmor", "rSamIR", "rSamIR", "rSamIR" }
}

cargoSpawns = {
	["Anapa"] = {"cargo-anapa-ammo-1","cargo-anapa-crate-1","cargo-anapa-fuel-1"},
	["Krymsk"] = {"cargo-krymsk-ammo-1","cargo-krymsk-crate-1","cargo-krymsk-fuel-1"},
	["Novoro"] = {"cargo-novoro-ammo-1","cargo-novoro-crate-1","cargo-novoro-fuel-1"},
	["Gelend"] = {"cargo-gelend-ammo-1","cargo-gelend-crate-1","cargo-gelend-fuel-1"},
	["Factory"] = {"cargo-factory-crate1-1","cargo-factory-crate2-1","cargo-factory-crate3-1"},
	["Oil Fields"] = {"cargo-oilfields-fuel1-1","cargo-oilfields-fuel2-1","cargo-oilfields-fuel3-1"},
}

cargoAccepts = {
	anapa = allExcept(cargoSpawns, 'Anapa'),
	novoro = allExcept(cargoSpawns, 'Novoro'),
	krymsk =  allExcept(cargoSpawns, 'Krymsk'),
	gelend = allExcept(cargoSpawns, 'Gelend'),
	factory = allExcept(cargoSpawns, 'Factory'),
	oilfields = allExcept(cargoSpawns, '"Oil Fields'),
	all = allExcept(cargoSpawns)
}

hint = {
	general = 'You need to capture all the zones to win the battle.',
}

bc = BattleCommander:new('Caucasus-NW-Saved-Data.lua')
-- Edited: Change zone settings
-- Friendly airfields
anapa = ZoneCommander:new({zone='Anapa', side=2, level=5, upgrades=friendlyAirfield, crates=cargoAccepts.anapa, flavorText=hint.general})
novoro = ZoneCommander:new({zone='Novoro', side=2, level=5, upgrades=friendlyAirfield, crates=cargoAccepts.novoro, flavorText=hint.general})
-- Friendly carriers
carrier = ZoneCommander:new({zone='Carrier Group', side=2, level=3, upgrades=carrier, crates=cargoAccepts.all, flavorText=hint.general})
-- Regular zones
alpha = ZoneCommander:new({zone='Alpha', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=hint.general})
bravo = ZoneCommander:new({zone='Bravo', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=hint.general})
echo = ZoneCommander:new({zone='Echo', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=hint.general})
charlie = ZoneCommander:new({zone='Charlie', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=hint.general})
radio = ZoneCommander:new({zone='Radio Tower', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=hint.general})
delta = ZoneCommander:new({zone='Delta', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=hint.general})
foxtrot = ZoneCommander:new({zone='Foxtrot', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=hint.general})
famer = ZoneCommander:new({zone='Famer', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=hint.general})
four = ZoneCommander:new({zone='Four', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=hint.general})
finish = ZoneCommander:new({zone='Finish', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=hint.general})
ever = ZoneCommander:new({zone='Ever', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=hint.general})
-- Resources
factory = ZoneCommander:new({zone='Factory', side=1, level=3, upgrades=farp, crates=cargoAccepts.factory, flavorText=hint.general, income=1})
oilfields = ZoneCommander:new({zone='Oil Fields', side=1, level=3, upgrades=farp, crates=cargoAccepts.oilfields, flavorText=hint.general, income=1})
-- Convoys
convoy = ZoneCommander:new({zone='Convoy', side=1, level=3, upgrades=convoy, crates=cargoAccepts.all, flavorText=hint.general, income=1})
-- SAM sites: specialSAM
samsite = ZoneCommander:new({zone='SAM Site', side=1, level=3, upgrades=specialSAM, crates=cargoAccepts.all, flavorText=hint.general})
apple = ZoneCommander:new({zone='Apple', side=1, level=3, upgrades=specialSAM, crates=cargoAccepts.all, flavorText=hint.general})
banana = ZoneCommander:new({zone='Banana', side=1, level=3, upgrades=specialSAM, crates=cargoAccepts.all, flavorText=hint.general})
-- Airfields
gelend = ZoneCommander:new({zone='Gelend', side=1, level=3, upgrades=airfield, crates=cargoAccepts.gelend, flavorText=hint.general, income=1})
krymsk = ZoneCommander:new({zone='Krymsk', side=1, level=3, upgrades=airfield, crates=cargoAccepts.krymsk, flavorText=hint.general, income=1})
-- Airfields enhanced
kelas = ZoneCommander:new({zone='Kelas', side=1, level=3, upgrades=airfieldEnhanced, crates=cargoAccepts.all, flavorText=hint.general, income=3})
kras = ZoneCommander:new({zone='Kras', side=1, level=3, upgrades=airfieldEnhanced, crates=cargoAccepts.all, flavorText=hint.general, income=3})
-- Airfields final
sochi = ZoneCommander:new({zone='Sochi', side=1, level=3, upgrades=airfieldFinal, crates=cargoAccepts.all, flavorText=hint.general, income=3})
-- Edited: Done

radio:addCriticalObject('RadioTower')
samsite:addCriticalObject('CommandCenter')
factory:addCriticalObject('FactoryBuilding1')
factory:addCriticalObject('FactoryBuilding2')
convoy:addCriticalObject('convoy1')
convoy:addCriticalObject('convoy2')
convoy:addCriticalObject('convoy3')
convoy:addCriticalObject('convoy4')

local oilbuildings = {'oilref1','oilref2'}
for i,v in ipairs(oilbuildings) do
	oilfields:addCriticalObject(v)
end

dispatch = { -- Edited: Add dispatches for more zones
	-- Friendly airfields
	anapa = {
		GroupCommander:new({name='b-attack-anapa-krymsk-a10c2', mission='attack', targetzone='Krymsk'}),

		GroupCommander:new({name='b-patrol-anapa-krymsk-f15c', mission='patrol', targetzone='Krymsk'}),
		GroupCommander:new({name='b-patrol-anapa-novoro-f15c', mission='patrol', targetzone='Novoro'}),

		GroupCommander:new({name='b-supply-anapa-famer-uh60a', mission='supply', targetzone='Famer'}),
		GroupCommander:new({name='b-supply-anapa-novoro-uh60a', mission='supply', targetzone='Novoro'}),
		GroupCommander:new({name='b-supply-anapa-alpha-uh60a', mission='supply', targetzone='Alpha'}),
		GroupCommander:new({name='b-supply-anapa-krymsk-uh60a', mission='supply', targetzone='Krymsk'}),
		GroupCommander:new({name='b-supply-anapa-bravo-uh60a', mission='supply', targetzone='Bravo'}),
		GroupCommander:new({name='b-supply-anapa-convoy-uh60a', mission='supply', targetzone='Convoy'}),
		GroupCommander:new({name='b-supply-anapa-oilfields-uh60a', mission='supply', targetzone='Oil Fields'}),
		GroupCommander:new({name='b-supply-anapa-charlie-uh60a', mission='supply', targetzone='Charlie'}),
	},
	novoro = {
		GroupCommander:new({name='b-attack-novoro-krymsk-a10c2', mission='attack', targetzone='Krymsk'}),

		GroupCommander:new({name='b-patrol-novoro-krymsk-f15c', mission='patrol', targetzone='Krymsk'}),

		GroupCommander:new({name='b-supply-novoro-famer-uh60a', mission='supply', targetzone='Famer'}),
		GroupCommander:new({name='b-supply-novoro-anapa-uh60a', mission='supply', targetzone='Anapa'}),
		GroupCommander:new({name='b-supply-novoro-alpha-uh60a', mission='supply', targetzone='Alpha'}),
		GroupCommander:new({name='b-supply-novoro-bravo-uh60a', mission='supply', targetzone='Bravo'}),
		GroupCommander:new({name='b-supply-novoro-krymsk-uh60a', mission='supply', targetzone='Krymsk'}),
		GroupCommander:new({name='b-supply-novoro-radiotower-uh60a', mission='supply', targetzone='Radio Tower'}),
		GroupCommander:new({name='b-supply-novoro-factory-uh60a', mission='supply', targetzone='Factory'}),
		GroupCommander:new({name='b-supply-novoro-four-uh60a', mission='supply', targetzone='Four'}),
		GroupCommander:new({name='b-supply-novoro-gelend-uh60a', mission='supply', targetzone='Gelend'}),
		GroupCommander:new({name='b-supply-novoro-sochi-uh60a', mission='supply', targetzone='Sochi'}),
		},
	-- Friendly carriers
	carrier = {
		GroupCommander:new({name='b-patrol-cvn73-cvn73-f18c', mission='patrol', targetzone='Carrier Group'}),
	},
	oilfields={
		GroupCommander:new({name='r-supply-oilfields-krymsk-truck', mission='supply', targetzone='Krymsk', type='surface'})
	},
	samsite={
		GroupCommander:new({name='r-attack-samsite-krymsk-armor', mission='attack', targetzone='Krymsk', type='surface'}),
	},
	factory={
		GroupCommander:new({name='r-attack-factory-krymsk-armor', mission='attack', targetzone='Krymsk', type='surface'}),

		GroupCommander:new({name='r-supply-factory-krymsk-truck', mission='supply', targetzone='Krymsk', type='surface'}),
		GroupCommander:new({name='r-supply-factory-delta-truck', mission='supply', targetzone='Delta', type='surface'}),
		GroupCommander:new({name='r-supply-factory-echo-truck', mission='supply', targetzone='Echo', type='surface'}),
		GroupCommander:new({name='r-supply-factory-foxtrot-truck', mission='supply', targetzone='Foxtrot', type='surface'})
	},
	-- Airfields
	krymsk = {
		GroupCommander:new({name='r-attack-krymsk-bravo-armor', mission='attack', targetzone='Bravo', type='surface'}),

		GroupCommander:new({name='r-attack-krymsk-alpha-mi24v', mission='attack', targetzone='Alpha'}),
		GroupCommander:new({name='r-attack-krymsk-bravo-mi24v', mission='attack', targetzone='Bravo'}),
		GroupCommander:new({name='r-attack-krymsk-convoy-mi24v', mission='attack', targetzone='Convoy'}),
		GroupCommander:new({name='r-attack-krymsk-oilfields-mi24v', mission='attack', targetzone='Oil Fields'}),
		GroupCommander:new({name='r-attack-krymsk-radiotower-mi24v', mission='attack', targetzone='Radio Tower'}),

		GroupCommander:new({name='r-attack-krymsk-famer-a10c2', mission='attack', targetzone='Famer'}),
		GroupCommander:new({name='r-attack-krymsk-alpha-a10c2', mission='attack', targetzone='Alpha'}),
		GroupCommander:new({name='r-attack-krymsk-charlie-a10c2', mission='attack', targetzone='Charlie'}),
		GroupCommander:new({name='r-attack-krymsk-factory-su25t', mission='attack', targetzone='Factory'}),
		GroupCommander:new({name='r-attack-krymsk-oilfields-su25t', mission='attack', targetzone='Oil Fields'}),
		GroupCommander:new({name='r-attack-krymsk-anapa-f18c', mission='attack', targetzone='Anapa'}),
		GroupCommander:new({name='r-attack-krymsk-novoro-f16c', mission='attack', targetzone='Novoro'}),
		
		GroupCommander:new({name='r-patrol-krymsk-krymsk-m2000c', mission='patrol', targetzone='Krymsk'}),
		GroupCommander:new({name='r-patrol-krymsk-samsite-f14b', mission='patrol', targetzone='SAM Site'}),
		GroupCommander:new({name='r-patrol-krymsk-famer-f16c', mission='patrol', targetzone='Famer'}),

		GroupCommander:new({name='r-supply-krymsk-famer-uh60a', mission='supply', targetzone='Famer'}),
		GroupCommander:new({name='r-supply-krymsk-alpha-uh60a', mission='supply', targetzone='Alpha'}),
		GroupCommander:new({name='r-supply-krymsk-bravo-mi8mtv2', mission='supply', targetzone='Bravo'}),
		GroupCommander:new({name='r-supply-krymsk-charlie-uh60a', mission='supply', targetzone='Charlie'}),
		GroupCommander:new({name='r-supply-krymsk-convoy-uh60a', mission='supply', targetzone='Convoy'}),
		GroupCommander:new({name='r-supply-krymsk-oilfields-mi8mtv2', mission='supply', targetzone='Oil Fields'}),
		GroupCommander:new({name='r-supply-krymsk-samsite-mi8mtv2', mission='supply', targetzone='SAM Site'}),
		GroupCommander:new({name='r-supply-krymsk-echo-uh60a', mission='supply', targetzone='Echo'}),
		GroupCommander:new({name='r-supply-krymsk-delta-mi8mtv2', mission='supply', targetzone='Delta'}),
		GroupCommander:new({name='r-supply-krymsk-factory-mi8mtv2', mission='supply', targetzone='Factory'}),
		GroupCommander:new({name='r-supply-krymsk-radiotower-mi8mtv2', mission='supply', targetzone='Radio Tower'}),
		GroupCommander:new({name='r-supply-krymsk-gelend-mi8mtv2', mission='supply', targetzone='Gelend'}),
		GroupCommander:new({name='r-supply-krymsk-ever-mi8', mission='supply', targetzone='Ever'}),
		GroupCommander:new({name='r-supply-krymsk-kelas-mi8', mission='supply', targetzone='Kelas'}),

		GroupCommander:new({name='b-patrol-krymsk-krymsk-m2000c', mission='patrol', targetzone='Krymsk'}),
		
		GroupCommander:new({name='b-supply-krymsk-bravo-uh60a', mission='supply', targetzone='Bravo'}),
		GroupCommander:new({name='b-supply-krymsk-radiotower-uh60a', mission='supply', targetzone='Radio Tower'}),
		GroupCommander:new({name='b-supply-krymsk-delta-uh60a', mission='supply', targetzone='Delta'}),
		GroupCommander:new({name='b-supply-krymsk-foxtrot-uh60a', mission='supply', targetzone='Foxtrot'}),
		GroupCommander:new({name='b-supply-krymsk-factory-uh60a', mission='supply', targetzone='Factory'}),
		GroupCommander:new({name='b-supply-krymsk-samsite-uh60a', mission='supply', targetzone='SAM Site'}),
		GroupCommander:new({name='b-supply-krymsk-convoy-uh60a', mission='supply', targetzone='Convoy'}),
		GroupCommander:new({name='b-supply-krymsk-oilfields-uh60a', mission='supply', targetzone='Oil Fields'}),
		GroupCommander:new({name='b-supply-krymsk-echo-uh60a', mission='supply', targetzone='Echo'}),
		GroupCommander:new({name='b-supply-krymsk-ever-uh60a', mission='supply', targetzone='Ever'}),
		GroupCommander:new({name='b-supply-krymsk-kelas-uh60a', mission='supply', targetzone='Kelas'}),
	},
	gelend = {
		GroupCommander:new({name='r-attack-gelend-anapa-f16c', mission='attack', targetzone='Anapa'}),
		GroupCommander:new({name='r-attack-gelend-novoro-jf17', mission='attack', targetzone='Novoro'}),
		GroupCommander:new({name='r-attack-gelend-krymsk-su25t', mission='attack', targetzone='Krymsk'}),

		GroupCommander:new({name='r-patrol-gelend-krymsk-f16c', mission='patrol', targetzone='Krymsk'}),
		GroupCommander:new({name='r-patrol-gelend-kras-su33', mission='patrol', targetzone='Kras'}),

		GroupCommander:new({name='r-supply-gelend-novoro-uh60a', mission='supply', targetzone='Novoro'}),
		GroupCommander:new({name='r-supply-gelend-famer-uh60a', mission='supply', targetzone='Famer'}),
		GroupCommander:new({name='r-supply-gelend-alpha-mi8mtv2', mission='supply', targetzone='Alpha'}),
		GroupCommander:new({name='r-supply-gelend-bravo-mi8mtv2', mission='supply', targetzone='Bravo'}),
		GroupCommander:new({name='r-supply-gelend-krymsk-mi8mtv2', mission='supply', targetzone='Krymsk'}),
		GroupCommander:new({name='r-supply-gelend-radiotower-mi8mtv2', mission='supply', targetzone='Radio Tower'}),
		GroupCommander:new({name='r-supply-gelend-factory-mi8mtv2', mission='supply', targetzone='Factory'}),
		GroupCommander:new({name='r-supply-gelend-four-uh60a', mission='supply', targetzone='Four'}),
		GroupCommander:new({name='r-supply-gelend-apple-uh60a', mission='supply', targetzone='Apple'}),
		GroupCommander:new({name='r-supply-gelend-banana-uh60a', mission='supply', targetzone='Banana'}),
		GroupCommander:new({name='r-supply-gelend-sochi-mi8', mission='supply', targetzone='Sochi'}),

		GroupCommander:new({name='b-supply-gelend-four-uh60a', mission='supply', targetzone='Four'}),
		GroupCommander:new({name='b-supply-gelend-apple-uh60a', mission='supply', targetzone='Apple'}),
		GroupCommander:new({name='b-supply-gelend-banana-uh60a', mission='supply', targetzone='Banana'}),
		GroupCommander:new({name='b-supply-gelend-novoro-uh60a', mission='supply', targetzone='Novoro'}),
		GroupCommander:new({name='b-supply-gelend-factory-uh60a', mission='supply', targetzone='Factory'}),
		GroupCommander:new({name='b-supply-gelend-radiotower-uh60a', mission='supply', targetzone='Radio Tower'}),
		GroupCommander:new({name='b-supply-gelend-sochi-uh60a', mission='supply', targetzone='Sochi'}),
	},
	kelas = {
		GroupCommander:new({name='r-attack-kelas-four-su25t', mission='attack', targetzone='Four'}),
		GroupCommander:new({name='r-attack-kelas-foxtrot-ah64d', mission='attack', targetzone='Foxtrot'}),
		GroupCommander:new({name='r-attack-kelas-gelend-f18c', mission='attack', targetzone='Gelend'}),
		GroupCommander:new({name='r-attack-kelas-factory-su25t', mission='attack', targetzone='Factory'}),
		GroupCommander:new({name='r-attack-kelas-radiotower-su25t', mission='attack', targetzone='Radio Tower'}),
		GroupCommander:new({name='r-attack-kelas-krymsk-f18c', mission='attack', targetzone='Krymsk'}),
		GroupCommander:new({name='r-attack-kelas-delta-a10c2', mission='attack', targetzone='Delta'}),
		GroupCommander:new({name='r-attack-kelas-echo-su25t', mission='attack', targetzone='Echo'}),
		GroupCommander:new({name='r-attack-kelas-samsite-a10c2', mission='attack', targetzone='SAM Site'}),
		GroupCommander:new({name='r-attack-kelas-ever-su25t', mission='attack', targetzone='Ever'}),
		GroupCommander:new({name='r-attack-kelas-kras-ah64d', mission='attack', targetzone='Kras'}),
		GroupCommander:new({name='r-attack-kelas-banana-f16c', mission='attack', targetzone='Banana'}),
		GroupCommander:new({name='r-attack-kelas-apple-su25t', mission='attack', targetzone='Apple'}),

		GroupCommander:new({name='r-patrol-kelas-krymsk-f16c', mission='patrol', targetzone='Krymsk'}),
		GroupCommander:new({name='r-patrol-kelas-apple-f16c', mission='patrol', targetzone='Apple'}),
		GroupCommander:new({name='r-patrol-kelas-gelend-f14b', mission='patrol', targetzone='Gelend'}),
		GroupCommander:new({name='r-patrol-kelas-kelas-f14b', mission='patrol', targetzone='Kelas'}),
		
		GroupCommander:new({name='r-supply-kelas-kras-truck', mission='supply', targetzone='Kras', type='surface'}),

		GroupCommander:new({name='r-supply-kelas-four-mi8', mission='supply', targetzone='Four'}),
		GroupCommander:new({name='r-supply-kelas-foxtrot-uh60a', mission='supply', targetzone='Foxtrot'}),
		GroupCommander:new({name='r-supply-kelas-gelend-uh60a', mission='supply', targetzone='Gelend'}),
		GroupCommander:new({name='r-supply-kelas-factory-mi8', mission='supply', targetzone='Factory'}),
		GroupCommander:new({name='r-supply-kelas-radiotower-uh60a', mission='supply', targetzone='Radio Tower'}),
		GroupCommander:new({name='r-supply-kelas-krymsk-mi8', mission='supply', targetzone='Krymsk'}),
		GroupCommander:new({name='r-supply-kelas-delta-mi8', mission='supply', targetzone='Delta'}),
		GroupCommander:new({name='r-supply-kelas-echo-uh60a', mission='supply', targetzone='Echo'}),
		GroupCommander:new({name='r-supply-kelas-samsite-mi8', mission='supply', targetzone='SAM Site'}),
		GroupCommander:new({name='r-supply-kelas-ever-mi8', mission='supply', targetzone='Ever'}),
		GroupCommander:new({name='r-supply-kelas-kras-uh60a', mission='supply', targetzone='Kras'}),
		GroupCommander:new({name='r-supply-kelas-banana-mi8', mission='supply', targetzone='Banana'}),
		GroupCommander:new({name='r-supply-kelas-apple-mi8', mission='supply', targetzone='Apple'}),

		GroupCommander:new({name='b-supply-kelas-four-uh60a', mission='supply', targetzone='Four'}),
		GroupCommander:new({name='b-supply-kelas-foxtrot-uh60a', mission='supply', targetzone='Foxtrot'}),
		GroupCommander:new({name='b-supply-kelas-delta-uh60a', mission='supply', targetzone='Delta'}),
		GroupCommander:new({name='b-supply-kelas-echo-uh60a', mission='supply', targetzone='Echo'}),
		GroupCommander:new({name='b-supply-kelas-samsite-uh60a', mission='supply', targetzone='SAM Site'}),
		GroupCommander:new({name='b-supply-kelas-ever-uh60a', mission='supply', targetzone='Ever'}),
		GroupCommander:new({name='b-supply-kelas-kras-uh60a', mission='supply', targetzone='Kras'}),
		GroupCommander:new({name='b-supply-kelas-banana-uh60a', mission='supply', targetzone='Banana'}),
		GroupCommander:new({name='b-supply-kelas-apple-uh60a', mission='supply', targetzone='Apple'}),
	},
	-- Airfields enhanced
	kras={
		GroupCommander:new({name='r-attack-kras-four-su34', mission='attack', targetzone='Four'}),
		GroupCommander:new({name='r-attack-kras-sochi-su34', mission='attack', targetzone='Sochi'}),
		GroupCommander:new({name='r-attack-kras-kelas-su34', mission='attack', targetzone='Kelas'}),
		GroupCommander:new({name='r-attack-kras-krymsk-su34', mission='attack', targetzone='Krymsk'}),
		GroupCommander:new({name='r-attack-kras-samsite-su34', mission='attack', targetzone='SAM Site'}),

		GroupCommander:new({name='r-attack-kras-kelas-ka50', mission='attack', targetzone='Kelas'}),
		GroupCommander:new({name='r-attack-kras-foxtrot-ka50', mission='attack', targetzone='Foxtrot'}),

		GroupCommander:new({name='r-patrol-kras-kras-su33', mission='patrol', targetzone='Kras'}),
		GroupCommander:new({name='r-patrol-kras-gelend-su27', mission='patrol', targetzone='Gelend'}),
		GroupCommander:new({name='r-patrol-kras-samsite-mig29s', mission='patrol', targetzone='SAM Site'}),
		GroupCommander:new({name='r-patrol-kras-sochi-mig31', mission='patrol', targetzone='Sochi'}),

		GroupCommander:new({name='r-supply-kras-kelas-truck', mission='supply', targetzone='Kelas', type='surface'}),

		GroupCommander:new({name='r-supply-kras-echo-mi8', mission='supply', targetzone='Echo'}),
		GroupCommander:new({name='r-supply-kras-foxtrot-mi8', mission='supply', targetzone='Foxtrot'}),
		GroupCommander:new({name='r-supply-kras-apple-mi8', mission='supply', targetzone='Apple'}),
		GroupCommander:new({name='r-supply-kras-banana-mi8', mission='supply', targetzone='Banana'}),
		GroupCommander:new({name='r-supply-kras-four-mi8', mission='supply', targetzone='Four'}),
		GroupCommander:new({name='r-supply-kras-ever-mi8', mission='supply', targetzone='Ever'}),
		GroupCommander:new({name='r-supply-kras-kelas-mi8', mission='supply', targetzone='Kelas'}),
		GroupCommander:new({name='r-supply-kras-sochi-mi8', mission='supply', targetzone='Sochi'}),
	},
	-- Airfields final
	sochi={
		GroupCommander:new({name='r-attack-sochi-gelend-su34', mission='attack', targetzone='Gelend'}),

		GroupCommander:new({name='r-patrol-sochi-sochi-su33', mission='patrol', targetzone='Sochi'}),

		GroupCommander:new({name='r-supply-sochi-apple-mi8', mission='supply', targetzone='Apple'}),
		GroupCommander:new({name='r-supply-sochi-banana-mi8', mission='supply', targetzone='Banana'}),
		GroupCommander:new({name='r-supply-sochi-four-mi8', mission='supply', targetzone='Four'}),
		GroupCommander:new({name='r-supply-sochi-gelend-mi8', mission='supply', targetzone='Gelend'}),
	},
}

-- Friendly airfields
anapa:addGroups(dispatch.anapa)
novoro:addGroups(dispatch.novoro)
-- Friendly carriers
carrier:addGroups(dispatch.carrier)
-- FARPs
oilfields:addGroups(dispatch.oilfields)
samsite:addGroups(dispatch.samsite)
factory:addGroups(dispatch.factory)
-- Airfields
krymsk:addGroups(dispatch.krymsk)
gelend:addGroups(dispatch.gelend)
kelas:addGroups(dispatch.kelas)
-- Airfields enhanced
kras:addGroups(dispatch.kras)
-- Airfields final
sochi:addGroups(dispatch.sochi)

bc:addZone(anapa)
bc:addZone(carrier)
bc:addZone(alpha)
bc:addZone(bravo)
bc:addZone(charlie)
bc:addZone(convoy)
bc:addZone(krymsk)
bc:addZone(oilfields)
bc:addZone(radio)
bc:addZone(delta)
bc:addZone(factory)
bc:addZone(samsite)
bc:addZone(foxtrot)
bc:addZone(echo)
bc:addZone(kras)
bc:addZone(novoro)
bc:addZone(apple)
bc:addZone(banana)
bc:addZone(famer)
bc:addZone(four)
bc:addZone(ever)
bc:addZone(gelend)
bc:addZone(kelas)
bc:addZone(sochi)

-- Add lines between zones
bc:addConnection("Anapa","Alpha")
bc:addConnection("Anapa","Charlie")
bc:addConnection("Anapa","Famer")

bc:addConnection("Alpha","Bravo")
bc:addConnection("Alpha","Charlie")
bc:addConnection("Alpha","Famer")
bc:addConnection("Alpha","Novoro")
bc:addConnection("Alpha","Radio Tower")

bc:addConnection("Bravo","Charlie")
bc:addConnection("Bravo","Convoy")
bc:addConnection("Bravo","Krymsk")
bc:addConnection("Bravo","Radio Tower")

bc:addConnection("Charlie","Convoy")
bc:addConnection("Charlie","Oil Fields")

bc:addConnection("Novoro","Famer")
bc:addConnection("Novoro","Gelend")
bc:addConnection("Novoro","Radio Tower")

bc:addConnection("Gelend","Four")
bc:addConnection("Gelend","Factory")
bc:addConnection("Gelend","Radio Tower")
bc:addConnection("Gelend","Apple")

bc:addConnection("Krymsk","Delta")
bc:addConnection("Krymsk","Convoy")
bc:addConnection("Krymsk","Radio Tower")
bc:addConnection("Krymsk","Factory")
bc:addConnection("Krymsk","SAM Site")
bc:addConnection("Krymsk","Oil Fields")

bc:addConnection("Oil Fields","Convoy")
bc:addConnection("Oil Fields","SAM Site")

bc:addConnection("Factory","Four")
bc:addConnection("Factory","Radio Tower")

bc:addConnection("Delta","Echo")
bc:addConnection("Delta","SAM Site")
bc:addConnection("Delta","Factory")

bc:addConnection("Echo","Foxtrot")
bc:addConnection("Echo","Kelas")
bc:addConnection("Echo","SAM Site")
bc:addConnection("Echo","Factory")

bc:addConnection("Ever","Echo")
bc:addConnection("Ever","Oil Fields")
bc:addConnection("Ever","SAM Site")
bc:addConnection("Ever","Kelas")

bc:addConnection("Foxtrot","Kelas")
bc:addConnection("Foxtrot","Kras")
bc:addConnection("Foxtrot","Factory")
bc:addConnection("Foxtrot","Four")
bc:addConnection("Foxtrot","Apple")

bc:addConnection("Kras","Apple")
bc:addConnection("Kras","Banana")
bc:addConnection("Kras","Kelas")

bc:addConnection("Apple","Banana")
bc:addConnection("Apple","Four")

bc:addConnection("Sochi","Gelend")
bc:addConnection("Sochi","Apple")
bc:addConnection("Sochi","Banana")

convoy:registerTrigger('lost', function (event, sender)
	local convoyItems = {'convoy1','convoy2','convoy3', 'convoy4'}
	
	local message = "Convoy liberated"
	local totalLost = 0
	for i,v in ipairs(convoyItems) do
		if not StaticObject.getByName(v) then
			totalLost = totalLost+1
		end
	end
	
	if totalLost>0 then
		local percentLost = math.ceil((totalLost/#convoyItems)*100)
		percentLost = math.min(percentLost,100)
		percentLost = math.max(percentLost,1)
		message = message..' but we lost '..percentLost..'% of the trucks.'
	else
		message = message..'. We recovered all of the supplies.'
	end
	
	local creditsEarned = (#convoyItems - totalLost) * 250
	message = message..'\n\n+'..creditsEarned..' credits'
	
	bc:addFunds(2, creditsEarned)
	
	trigger.action.outTextForCoalition(2, message, 15)
end, 'convoyLost', 1)

local showCredIncrease = function(event, sender)
	trigger.action.outTextForCoalition(sender.side, '+'..math.floor(sender.income*360)..' Credits/Hour', 5)
end

oilfields:registerTrigger('captured', showCredIncrease, 'oilfieldcaptured')
factory:registerTrigger('captured', showCredIncrease, 'factorycaptured')

-- Mission Complete Check

local checkMissionComplete = function (event, sender)
	local done = true
	for i,v in ipairs(bc:getZones()) do
		if v.side == 1 then
			done = false
			break
		end
	end
	
	if done then
		trigger.action.outText("敌军已被彻底击败！任务完成！ \n\n服务器将于30秒后重启！", 120)
		trigger.action.setUserFlag("TriggerFlagMissionComplete", true)
		os.remove("D:\\DCS World OpenBeta Server\\Caucasus-NW-Saved-Data.lua")
	end
end

-- for i,v in ipairs(bc:getZones()) do
-- 	v:registerTrigger('lost', checkMissionComplete, 'missioncompleted')
-- end

mist.scheduleFunction(checkMissionComplete, {}, timer.getTime(), 60)

-- Mission Complete Check Done

-- Scheduled Restart
local triggerScheduledRestart = function (event, sender)
	trigger.action.setUserFlag("TriggerFlagScheduledRestart", true)
end

local saveScheduledRestart = function (event, sender)
	bc:update()
	bc:saveToDisk()
	mist.scheduleFunction(triggerScheduledRestart, {}, timer.getTime() + 1)
end

local hintScheduledRestart = function (event, sender)
	trigger.action.outText("服务器将于60秒后定时重启！", 120)
	mist.scheduleFunction(saveScheduledRestart, {}, timer.getTime() + 60)
end

mist.scheduleFunction(hintScheduledRestart, {}, timer.getTime() + 21540)

-- Scheduled Restart Done

-- Blue supports

Group.getByName('sead1'):destroy()
local seadTargetMenu = nil
bc:registerShopItem('sead', 'F/A-18C 防空压制任务', 2500, function(sender) 
	local gr = Group.getByName('sead1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
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
			
			trigger.action.outTextForCoalition(2, 'F/A-18C 正在进行防空压制：'..target, 15)
		else
			trigger.action.outTextForCoalition(2, '支援单位已离开战区或已被击毁', 15)
		end
		
		seadTargetMenu = nil
	end
	
	seadTargetMenu = bc:showTargetZoneMenu(2, '指派 F/A-18C 防空压制目标', launchAttack, 1)
	
	trigger.action.outTextForCoalition(2, 'F/A-18C 已就绪，请使用 F10 菜单指派攻击目标', 15)
end,
function (sender, params)
	if params.zone and params.zone.side == 1 then
		local gr = Group.getByName('sead1')
		if gr and gr:getSize()>0 and gr:getController():hasTask() then 
			return '防空压制任务仍在进行中'
		end
		
		mist.respawnGroup('sead1', true)
		mist.scheduleFunction(function(target)
			if Group.getByName('sead1') then
				local err = bc:engageZone(target, 'sead1')
				if err then
					return err
				end
				
				trigger.action.outTextForCoalition(2, 'F/A-18C 正在进行防空压制：'..target, 15)
			end
		end,{params.zone.zone},timer.getTime()+2)
	else
		return '仅允许攻击敌方占领区'
	end
end)

Group.getByName('sweep1'):destroy()
bc:registerShopItem('sweep', 'F-14B 战斗机扫荡任务', 2500, function(sender) 
	local gr = Group.getByName('sweep1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return '战斗机扫荡任务仍在进行中'
	end
	mist.respawnGroup('sweep1', true)
end,
function (sender, params)
	local gr = Group.getByName('sweep1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return '战斗机扫荡任务仍在进行中'
	end
	mist.respawnGroup('sweep1', true)
end)

Group.getByName('cas1'):destroy()
local casTargetMenu = nil
bc:registerShopItem('cas', 'F-4 对地攻击任务', 2500, function(sender) 
	local gr = Group.getByName('cas1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
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
				
				trigger.action.outTextForCoalition(2, 'F-4 正在进行对地攻击：'..target, 15)
			else
				trigger.action.outTextForCoalition(2, '支援单位已离开战区或已被击毁', 15)
			end
			
			casTargetMenu = nil
		end
	end
	
	casTargetMenu = bc:showTargetZoneMenu(2, '指派 F-4 对地攻击目标', launchAttack, 1)
	
	trigger.action.outTextForCoalition(2, 'F-4 已就绪，请使用 F10 菜单指派攻击目标', 15)
end,
function (sender, params)
	if params.zone and params.zone.side == 1 then
		local gr = Group.getByName('cas1')
		if gr and gr:getSize()>0 and gr:getController():hasTask() then 
			return '对地攻击任务仍在进行中'
		end
		
		mist.respawnGroup('cas1', true)
		mist.scheduleFunction(function(target)
			if Group.getByName('cas1') then
				local err = bc:engageZone(target, 'cas1')
				if err then
					return err
				end
				
				trigger.action.outTextForCoalition(2, 'F-4 正在进行对地攻击：'..target, 15)
			end
		end,{params.zone.zone},timer.getTime()+2)
	else
		return '仅允许攻击敌方占领区'
	end
end)

bc:addMonitoredROE('bCruise1')
local cruiseMissileTargetMenu = nil
bc:registerShopItem('cruisemsl', '巡航导弹打击', 5000, function(sender)
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
			trigger.action.outTextForCoalition(2, '正在进行巡航导弹打击：'..target, 15)
		end
	end
	
	cruiseMissileTargetMenu = bc:showTargetZoneMenu(2, '指派巡航导弹打击目标', launchAttack, 1)
	
	trigger.action.outTextForCoalition(2, '巡航导弹已就绪，请使用 F10 菜单指派攻击目标', 15)
end,
function (sender, params)
	if params.zone and params.zone.side == 1 then
		local err = bc:fireAtZone(params.zone.zone, 'bCruise1', true, 8)
		if err then
			return err
		end
		
		trigger.action.outTextForCoalition(2, '正在进行巡航导弹打击：'..params.zone.zone, 15)
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
			if zn and zn.side==2 then
				zn:upgrade()
			else
				return '所选区域不是友方占领区'
			end
			
			upgradeMenu = nil
		end
	end
	
	upgradeMenu = bc:showTargetZoneMenu(2, '指派补给区域', upgradeZone, 2)
	
	trigger.action.outTextForCoalition(2, '补给已就绪，请使用 F10 菜单指派补给区域', 15)
end,
function(sender, params)
	if params.zone and params.zone.side == 2 then
		params.zone:upgrade()
	else
		return '仅允许补给友方占领区'
	end
end)

Group.getByName('jtacDrone'):destroy()
local jtacTargetMenu = nil
drone = JTAC:new({name = 'jtacDrone'})
bc:registerShopItem('jtac', 'MQ-1A JTAC 侦查任务', 100, function(sender)
	
	if jtacTargetMenu then
		return '请使用 F10 菜单指派侦查目标'
	end
	
	local spawnAndOrbit = function(target)
		if jtacTargetMenu then
			local zn = bc:getZoneByName(target)
			drone:deployAtZone(zn)
			drone:showMenu()
			trigger.action.outTextForCoalition(2, 'MQ-1A 已部署于战区上空：'..target, 15)
			jtacTargetMenu = nil
		end
	end
	
	jtacTargetMenu = bc:showTargetZoneMenu(2, '部署 MQ-1A', spawnAndOrbit, 1)
	
	trigger.action.outTextForCoalition(2, 'MQ-1A 已就绪，请使用 F10 菜单指派侦查区域', 15)
end,
function(sender, params)
	if params.zone and params.zone.side == 1 then
		drone:deployAtZone(params.zone)
		drone:showMenu()
		trigger.action.outTextForCoalition(2, 'MQ-1A 已部署于战区上空：'..params.zone.zone, 15)
	else
		return '仅允许侦查敌方占领区'
	end
end)


local smoketargets = function(tz)
	local units = {}
	for i,v in pairs(tz.built) do
		local g = Group.getByName(v)
		for i2,v2 in ipairs(g:getUnits()) do
			table.insert(units, v2)
		end
	end
	
	local tgts = {}
	for i=1,3,1 do
		if #units > 0 then
			local selected = math.random(1,#units)
			table.insert(tgts, units[selected])
			table.remove(units, selected)
		end
	end
	
	for i,v in ipairs(tgts) do
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
			trigger.action.outTextForCoalition(2, '目标已由红色烟雾标出：'..target, 15)
		end
	end
	
	smokeTargetMenu = bc:showTargetZoneMenu(2, '指派烟雾标记目标', launchAttack, 1)
	
	trigger.action.outTextForCoalition(2, '烟雾标记已就绪，请使用 F10 菜单指派标记区域', 15)
end,
function(sender, params)
	if params.zone and params.zone.side == 1 then
		smoketargets(params.zone)
		trigger.action.outTextForCoalition(2, '目标已由红色烟雾标出：'..params.zone.zone, 15)
	else
		return '仅允许标记敌方占领区'
	end
end)

local spawnAwacs = function(sender) 
	local gr = Group.getByName('awacs1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return '空中预警机仍在执行任务\n呼号：Darkstar\n无线电频率：252.00 MHz AM'
	end
	mist.respawnGroup('awacs1', true)
	trigger.action.outTextForCoalition(2,'空中预警机已上线\n呼号：Darkstar\n无线电频率：252.00 MHz AM', 15)
end
Group.getByName('awacs1'):destroy()
bc:registerShopItem('awacs', 'AWACS 空中预警机', 100, spawnAwacs, spawnAwacs)

local spawnAirrefuel = function(sender) 
	local gr = Group.getByName('airrefuel1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return '空中加油机仍在执行任务'
	end
	mist.respawnGroup('airrefuel1', true)
	trigger.action.outTextForCoalition(2,'空中加油机已上线', 15)
end
Group.getByName('airrefuel1'):destroy()
bc:registerShopItem('airrefuel', 'KC-135 空中加油机', 100, spawnAirrefuel, spawnAirrefuel)

bc:addShopItem(2, 'sead', -1)
bc:addShopItem(2, 'sweep', -1)
bc:addShopItem(2, 'cas', -1)
bc:addShopItem(2, 'cruisemsl', 12)
bc:addShopItem(2, 'supplies', -1)
bc:addShopItem(2, 'jtac', -1)
bc:addShopItem(2, 'smoke', -1)
bc:addShopItem(2, 'awacs', -1)
bc:addShopItem(2, 'airrefuel', -1)

-- bc:addFunds(2,100000)

-- Blue support end

-- Red support

-- Group.getByName('r-cap-cclockwise-m2000c'):destroy()
-- bc:registerShopItem('r-cap-cclockwise-m2000c', 'Red Combat Air Patrol Counter-Clockwise M-2000C', 100, function(sender) 
-- 	local gr = Group.getByName('r-cap-cclockwise-m2000c')
-- 	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
-- 		return 'still alive'
-- 	end
-- 	mist.respawnGroup('r-cap-cclockwise-m2000c', true)
-- 	trigger.action.outTextForCoalition(2,'Enemy M-2000C is executing Combat Air Patrol missions.',15)
-- end)

-- bc:addShopItem(1, 'r-cap-cclockwise-m2000c', -1)

-- Frigate Patrol
Group.getByName('r-support-frigate-sochi-carrier-1'):destroy()
Group.getByName('r-support-frigate-sochi-carrier-2'):destroy()
bc:registerShopItem('r-support-frigate-sochi-carrier', 'Frigate Patrol', 5000, function(sender)
	if bc:getZoneByName('Carrier Group').side==2 and bc:getZoneByName('Sochi').side==1 then
		-- Group 1
		local gr1 = Group.getByName('r-support-frigate-sochi-carrier-1')
		local gr2 = Group.getByName('r-support-frigate-sochi-carrier-2')
		if (gr1 and gr1:getSize()>0 and gr1:getController():hasTask()) or
			(gr2 and gr2:getSize()>0 and gr2:getController():hasTask()) then 
			return 'still alive'
		end
		mist.respawnGroup('r-support-frigate-sochi-carrier-1', true)
		mist.respawnGroup('r-support-frigate-sochi-carrier-2', true)
		trigger.action.outTextForCoalition(2,'敌军正在派遣舰队攻击我方航母！\n起点：索契\n攻击目标：蓝方航母作战集群',15)
	else
		return 'zone no match'
	end
end)
bc:addShopItem(1, 'r-support-frigate-sochi-carrier', -1)

-- Bomber Attack Sochi to Novoro
Group.getByName('r-support-bomber-sochi-novoro-tu22m3'):destroy()
Group.getByName('r-support-bomber-sochi-novoro-f16c'):destroy()
bc:registerShopItem('r-support-bomber-sochi-novoro', 'Bomber Attack from Sochi to Novoro', 5000, function(sender)
	if bc:getZoneByName('Novoro').side==2 and bc:getZoneByName('Sochi').side==1 then
		local gr1 = Group.getByName('r-support-bomber-sochi-novoro-tu22m3')
		local gr2 = Group.getByName('r-support-bomber-sochi-novoro-f16c')
		if (gr1 and gr1:getSize()>0 and gr1:getController():hasTask()) or
			(gr2 and gr2:getSize()>0 and gr2:getController():hasTask()) then 
			return 'still alive'
		end
		mist.respawnGroup('r-support-bomber-sochi-novoro-tu22m3', true)
		mist.respawnGroup('r-support-bomber-sochi-novoro-f16c', true)
		trigger.action.outTextForCoalition(2,'敌军正在派遣轰炸机机队攻击我方机场！\n起点：索契\n攻击目标：新罗西斯克',15)
	else
		return 'zone no match'
	end
end)
bc:addShopItem(1, 'r-support-bomber-sochi-novoro', -1)

-- Bomber Attack Kelas to Anapa
Group.getByName('r-support-bomber-kelas-anapa-tu22m3'):destroy()
Group.getByName('r-support-bomber-kelas-anapa-f16c'):destroy()
bc:registerShopItem('r-support-bomber-kelas-anapa', 'Bomber Attack from Kelas to Anapa', 5000, function(sender)
	if bc:getZoneByName('Novoro').side==2 and bc:getZoneByName('Sochi').side==1 then
		local gr1 = Group.getByName('r-support-bomber-kelas-anapa-tu22m3')
		local gr2 = Group.getByName('r-support-bomber-kelas-anapa-f16c')
		if (gr1 and gr1:getSize()>0 and gr1:getController():hasTask()) or
			(gr2 and gr2:getSize()>0 and gr2:getController():hasTask()) then 
			return 'still alive'
		end
		mist.respawnGroup('r-support-bomber-kelas-anapa-tu22m3', true)
		mist.respawnGroup('r-support-bomber-kelas-anapa-f16c', true)
		trigger.action.outTextForCoalition(2,'敌军正在派遣轰炸机机队攻击我方机场！\n起点：克拉斯诺达尔-中心区\n攻击目标：阿纳帕-维迪泽瓦',15)
	else
		return 'zone no match'
	end
end)
bc:addShopItem(1, 'r-support-bomber-kelas-anapa', -1)

-- bc:addFunds(1,100000)
-- budgetAI = BudgetCommander:new({ battleCommander = bc, side=1, decissionFrequency=1, decissionVariance=1, skipChance = 0})

budgetAI = BudgetCommander:new({ battleCommander = bc, side=1, decissionFrequency=30*60, decissionVariance=30*60, skipChance = 25})
budgetAI:init()

-- Red support end

lc = LogisticCommander:new({battleCommander = bc, supplyZones = {
	'Anapa', 'Krymsk', 'Factory', 'Bravo', 'Echo', 'Carrier Group',
	'Novoro', 'Foxtrot', 'Famer', 'Oil Fields', 'Banana',
	'Gelend', 'Kelas', 'Kras', 'Sochi'
}}) 
lc:init()

bc:loadFromDisk() --will load and overwrite default zone levels, sides, funds and available shop items
bc:init()
bc:startRewardPlayerContribution(15,{infantry = 5, ground = 15, sam = 25, airplane = 25, ship = 100, helicopter=15, crate=150, rescue = 300})

HercCargoDropSupply.init(bc)

function respawnStatics()
	for i,v in pairs(cargoSpawns) do
		local farp = bc:getZoneByName(i)
		if farp then
			if farp.side==2 then
				for ix,vx in ipairs(v) do
					if not StaticObject.getByName(vx) then
						mist.respawnGroup(vx)
					end
				end
			else
				for ix,vx in ipairs(v) do
					local cr = StaticObject.getByName(vx)
					if cr then
						cr:destroy()
					end
				end
			end
		end
	end
end

mist.scheduleFunction(respawnStatics, {}, timer.getTime() + 1, 30)

GlobalSettings.setDifficultyScaling(1.0,1) --red
GlobalSettings.setDifficultyScaling(1.0,2) --blue
