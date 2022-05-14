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

-- Edited: Spawn more units on zones & add new spawn types
carrier = {
	blue = { "bShip", "bShip", "bShip", "bShip", "bShip", "bShip" },
	red = {}
}

airfield = {
	blue = { "bInfantry", "bInfantry", "bArmor", "bArmor", "bSamIR", "bSam", "bSam2", "bSam3", "bSamBig", "bSamFinal" },
	red = { "rInfantry", "rInfantry", "rArmor", "rArmor", "rSamIR", "rSam", "rSam2", "rSam3", "bSamBig", "bSamFinal" }
}

airfieldEnhanced = {
	blue = { "bInfantry", "bArmor", "bArmor", "bSamIR", "bSam2", "bSam3", "bSamBig", "bSamBig", "bSamFinal", "bSamFinal" },
	red = { "rInfantry", "rArmor", "rArmor", "rSamIR", "rSam2", "rSam3", "rSamBig", "rSamBig", "rSamFinal", "rSamFinal" }
}

airfieldFinal = {
	blue = { "bInfantry", "bInfantry", "bArmor", "bArmor", "bSamIR", "bSam", "bSam2", "bSam3", "bSamBig", "bSamFinal" },
	red = { "rInfantry", "rArmor", "rSamIR", "rSam2", "rSam3", "rSamBig", "rSamBig", "rSamFinal", "rSamFinal", "Suhumi001", "Suhumi001-1", "Suhumi001-2", "Suhumi001-3" }
}

regularzone = {
	blue = { "bInfantry", "bInfantry", "bArmor", "bArmor", "bSamIR", "bSam", "bSam", "bSam2" },
	red = { "rInfantry", "rInfantry", "rArmor", "rArmor", "rSamIR", "rSam", "rSam", "rSam2" }
}

farp = {
	blue = { "bInfantry", "bInfantry", "bArmor", "bArmor", "bSamIR", "bSamIR", "bSam" },
	red = { "rInfantry", "rInfantry", "rArmor", "rArmor", "rSamIR", "rSamIR", "rSam" }
}

specialSAM = {
	blue = { "bInfantry", "bArmor", "bSamIR", "bSam", "bSam2", "bSam3", "bSamBig" },
	red = { "rInfantry", "rArmor", "rSamIR", "rSam", "rSam2", "rSam3", "rSamBig" }
}

convoy = {
	blue = { "bInfantry", "bArmor", "bArmor", "bArmor", "bSamIR", "bSamIR" },
	red = { "rInfantry", "rArmor", "rArmor", "rArmor", "rSamIR", "rSamIR" }
}
-- Edited: Done

cargoSpawns = {
	["Anapa"] = {"c1","c2","c3"},
	["Bravo"] = {"c6","c7"},
	["Krymsk"] = {"c8","c9","c10"},
	["Factory"] = {"c4","c5","c11"},
	["Echo"] = {"c12","c13"},
	["Novoro"] = {"c14","c15","c16"}
}

farpSupply = {
	["Bravo"] = {"bravoFuelAndAmmo"},
	["Echo"] = {"echoFuelAndAmmo"}
}

cargoAccepts = {
	anapa = allExcept(cargoSpawns, 'Anapa'),
	bravo =  allExcept(cargoSpawns, 'Bravo'),
	krymsk =  allExcept(cargoSpawns, 'Krymsk'),
	factory =  allExcept(cargoSpawns, 'Factory'),
	echo =  allExcept(cargoSpawns, 'Echo'),
	novoro = allExcept(cargoSpawns, 'Novoro'),
	all = allExcept(cargoSpawns)
}

flavor = {
	anapa = 'WPT 1\nHome base',
	carrier = 'Carrier group',
	alpha='WPT 2\nDefensive position next to the town of Natuhaevskaya',
	bravo='WPT 3\nFARP next to the town of Damanka.\nWill let us launch helicopter attacks from a bit closer to the action.',
	charlie='WPT 4\nDefensive position next to an old TV tower.\nWill provide allied air patrol to help capture Bravo',
	convoy='WPT 5\nSupply convoy detained north of Bravo.\nKeep damage to the trucks to a minimum while liberating this area.\nWe could really use the supplies.',
	krymsk='WPT 7\nAirbase next to the city of Krymsk.\nCapturing it will provide us with valuable aircraft to use for our cause.',
	radio='WPT 8\nRadio atenna on the outskirts of Krymsk.\nIf we capture it, we can launch AWACS from the nearby airport\nto get some much needed intel on the enemy.',
	oilfields='WPT 6\nOil extraction and Refinery north of Krymsk.\nCapture it to get a steady stream of income, or just destroy it to put a hole in the enemy wallet.',
	delta='WPT 10\nDefensive position out in the middle of nowhere',
	factory='WPT 9\nWeapon factory next to the town of Homskiy.\nWe can use it to resupply nearby bases.\nIt will also provide a steady stream of income.',
	samsite='WPT 11\nHome to an old SA-2 site.\nIf we capture it, we might be able to get some use out of it.',
	foxtrot='WPT 13\nDefensive position with a nice view of a lake',
	echo='WPT 12\nFARP next to the city of Krasnodar.\nCapturing it will let us operate our helicopters in the area.',
	krasnodar='WPT 14\nAirbase next to the city of Krasnodar.\nThe home base of our enemy. Capture it to deprive them of their most valuable asset.'
}

bc = BattleCommander:new('foothold_1.3.3.lua')
-- Edited: Change zone settings
-- Friendly airfields
anapa = ZoneCommander:new({zone='Anapa', side=2, level=5, upgrades=airfield, crates=cargoAccepts.anapa, flavorText=flavor.anapa})
novoro = ZoneCommander:new({zone='Novoro', side=2, level=5, upgrades=airfield, crates=cargoAccepts.novoro, flavorText=flavor.anapa})
-- Friendly carriers
carrier = ZoneCommander:new({zone='Carrier Group', side=2, level=5, upgrades=carrier, crates={}, flavorText=flavor.carrier})
-- Regular zones
alpha = ZoneCommander:new({zone='Alpha', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=flavor.alpha})
charlie = ZoneCommander:new({zone='Charlie', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=flavor.charlie})
radio = ZoneCommander:new({zone='Radio Tower', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=flavor.radio})
delta = ZoneCommander:new({zone='Delta', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=flavor.delta})
foxtrot = ZoneCommander:new({zone='Foxtrot', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=flavor.foxtrot})
famer = ZoneCommander:new({zone='Famer', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=flavor.alpha})
four = ZoneCommander:new({zone='Four', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=flavor.alpha})
finish = ZoneCommander:new({zone='Finish', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=flavor.alpha, income=1})
ever = ZoneCommander:new({zone='Ever', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.all, flavorText=flavor.alpha})
-- FARPs
bravo = ZoneCommander:new({zone='Bravo', side=1, level=3, upgrades=farp, crates=cargoAccepts.bravo, flavorText=flavor.bravo, income=1})
echo = ZoneCommander:new({zone='Echo', side=1, level=3, upgrades=farp, crates=cargoAccepts.echo, flavorText=flavor.echo, income=1})
factory = ZoneCommander:new({zone='Factory', side=1, level=3, upgrades=farp, crates=cargoAccepts.factory, flavorText=flavor.factory, income=1})
oilfields = ZoneCommander:new({zone='Oil Fields', side=1, level=3, upgrades=farp, crates=cargoAccepts.all, flavorText=flavor.oilfields, income=1})
-- Convoys
convoy = ZoneCommander:new({zone='Convoy', side=1, level=3, upgrades=convoy, crates=cargoAccepts.all, flavorText=flavor.convoy, income=1})
-- SAM sites: specialSAM
samsite = ZoneCommander:new({zone='SAM Site', side=1, level=3, upgrades=specialSAM, crates=cargoAccepts.all, flavorText=flavor.samsite, income=1})
apple = ZoneCommander:new({zone='Apple', side=1, level=3, upgrades=specialSAM, crates=cargoAccepts.all, flavorText=flavor.alpha})
banana = ZoneCommander:new({zone='Banana', side=1, level=3, upgrades=specialSAM, crates=cargoAccepts.all, flavorText=flavor.alpha})
fine = ZoneCommander:new({zone='Fine', side=1, level=3, upgrades=specialSAM, crates=cargoAccepts.all, flavorText=flavor.alpha})
fish = ZoneCommander:new({zone='Fish', side=1, level=3, upgrades=specialSAM, crates=cargoAccepts.all, flavorText=flavor.alpha})
cool = ZoneCommander:new({zone='Cool', side=1, level=3, upgrades=specialSAM, crates=cargoAccepts.all, flavorText=flavor.alpha, income=1})
-- Airfields
krymsk = ZoneCommander:new({zone='Krymsk', side=1, level=6, upgrades=airfield, crates=cargoAccepts.krymsk, flavorText=flavor.krymsk, income=2})
suoqi = ZoneCommander:new({zone='Suoqi', side=1, level=5, upgrades=airfield, crates=cargoAccepts.all, flavorText=flavor.krymsk, income=2})
gelend = ZoneCommander:new({zone='Gelend', side=1, level=5, upgrades=airfield, crates=cargoAccepts.all, flavorText=flavor.krasnodar, income=2})
kelasinuodaer = ZoneCommander:new({zone='Kelasinuodaer', side=1, level=5, upgrades=airfield, crates=cargoAccepts.all, flavorText=flavor.krasnodar, income=2})
-- Airfields enhanced
krasnodar = ZoneCommander:new({zone='Krasnodar', side=1, level=8, upgrades=airfieldEnhanced, crates=cargoAccepts.all, flavorText=flavor.krasnodar, income=3})
mikehans = ZoneCommander:new({zone='Mikehans', side=1, level=8, upgrades=airfieldEnhanced, crates=cargoAccepts.all, flavorText=flavor.krasnodar, income=3})
-- Airfields final
suhumi = ZoneCommander:new({zone='Suhumi', side=1, level=10, upgrades=airfieldFinal, crates=cargoAccepts.all, flavorText=flavor.krymsk, income=5})
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
		GroupCommander:new({name='anapa1', mission='supply', targetzone='Alpha'}),
		GroupCommander:new({name='anapa3', mission='supply', targetzone='Bravo'}),
		GroupCommander:new({name='anapa2', mission='supply', targetzone='Charlie'}),
		GroupCommander:new({name='anapa5', mission='patrol', targetzone='Bravo'}),
		GroupCommander:new({name='b-supply-anapa-famer-uh60a', mission='supply', targetzone='Famer'}),
		GroupCommander:new({name='b-supply-anapa-convoy-uh60a', mission='supply', targetzone='Convoy'}),
		GroupCommander:new({name='b-supply-anapa-oilfields-uh60a', mission='supply', targetzone='Oil Fields'}),
		GroupCommander:new({name='b-attack-anapa-krymsk-asj37', mission='attack', targetzone='Krymsk'}),
		GroupCommander:new({name='b-patrol-anapa-gelend-f15c', mission='supply', targetzone='Gelend'}),
		GroupCommander:new({name='b-patrol-anapa-bravo-f15c', mission='supply', targetzone='bravo'}),
		GroupCommander:new({name='b-patrol-anapa-oilfileds-f15c', mission='supply', targetzone='Oil Fields'}),
	},
	novoro = {
		GroupCommander:new({name='b-supply-novoro-gelend-uh60a', mission='supply', targetzone='Gelend'}),
		GroupCommander:new({name='b-supply-novoro-four-uh60a', mission='supply', targetzone='Four'}),
		GroupCommander:new({name='b-supply-novoro-apple-uh60a', mission='supply', targetzone='Apple'}),
		GroupCommander:new({name='b-supply-novoro-radiotower-uh60a', mission='supply', targetzone='Radio Tower'}),
		GroupCommander:new({name='b-supply-novoro-krymsk-uh60a', mission='supply', targetzone='Krymsk'}),
		GroupCommander:new({name='b-supply-novoro-anapa-uh60a', mission='supply', targetzone='Anapa'}),
		GroupCommander:new({name='b-supply-novoro-factory-uh60a', mission='supply', targetzone='Factory'}),
		GroupCommander:new({name='b-supply-novoro-gelend-uh60a', mission='supply', targetzone='Gelend'}),
		GroupCommander:new({name='b-patrol-novoro-famer-jf17', mission='patrol', targetzone='Famer'}),
		GroupCommander:new({name='b-patrol-novoro-four-f15c', mission='patrol', targetzone='Four'}),
		GroupCommander:new({name='b-patrol-novoro-gelend-f15c', mission='patrol', targetzone='Gelend'}),
		GroupCommander:new({name='b-patrol-novoro-apple-f14b', mission='patrol', targetzone='Novoro'}),
		GroupCommander:new({name='b-attack-novoro-krasnodar-a10c', mission='attack', targetzone='Krasnodar'}),
	},
	-- Friendly carriers
	carrier = {
		GroupCommander:new({name='CVN-73-3', mission='patrol', targetzone='Anapa'}),
		GroupCommander:new({name='CVN-74-3', mission='patrol', targetzone='Bravo'}),
		GroupCommander:new({name='CVN-61-2', mission='patrol', targetzone='Gelend'}),
	},
	-- Regular zones
	charlie={
		GroupCommander:new({name='anapa6', mission='attack', targetzone='Bravo'})
	},
	foxtrot={
		GroupCommander:new({name='foxtrot-krymsk-attack', mission='attack', targetzone='Krymsk', type='surface'}),
		GroupCommander:new({name='foxtrot-echo-attack', mission='attack', targetzone='Echo', type='surface'}),
		GroupCommander:new({name='b-supply-foxtrot-four-uh60a', mission='supply', targetzone='Four'}),
		GroupCommander:new({name='b-supply-foxtrot-apple-uh60a', mission='supply', targetzone='Apple'}),
	},
	famer = {
		GroupCommander:new({name='Famer1', mission='supply', targetzone='Alpha', type='surface'}),
	},
	-- FARPs
	bravo = {
		GroupCommander:new({name='bravo1', mission='supply', targetzone='Alpha'}),
		GroupCommander:new({name='bravo2', mission='attack', targetzone='Alpha'}),
		GroupCommander:new({name='bravo6', mission='supply', targetzone='Charlie'}),
		GroupCommander:new({name='bravo7', mission='attack', targetzone='Charlie'}),
		GroupCommander:new({name='bravo4', mission='supply', targetzone='Krymsk'}),
		GroupCommander:new({name='bravo5', mission='attack', targetzone='Krymsk'}),
		GroupCommander:new({name='bravo8', mission='supply', targetzone='Krymsk'}),
		GroupCommander:new({name='bravo10', mission='supply', targetzone='Charlie'}),
		GroupCommander:new({name='bravo9', mission='supply', targetzone='Alpha'}),
		GroupCommander:new({name='bravo11', mission='supply', targetzone='Oil Fields'}),
		GroupCommander:new({name='bravo12', mission='supply', targetzone='Oil Fields'}),
		GroupCommander:new({name='bravo13', mission='attack', targetzone='Oil Fields'}),
	},
	echo={
		GroupCommander:new({name='echo1', mission='supply', targetzone='SAM Site'}),
		GroupCommander:new({name='echo2', mission='supply', targetzone='SAM Site'}),
		GroupCommander:new({name='echo3', mission='attack', targetzone='Delta'}),
		GroupCommander:new({name='echo4', mission='supply', targetzone='Delta'}),
		GroupCommander:new({name='echo5', mission='supply', targetzone='Delta'}),
		GroupCommander:new({name='echo6', mission='supply', targetzone='Factory'}),
		GroupCommander:new({name='echo7', mission='supply', targetzone='Factory'}),
		GroupCommander:new({name='echo8', mission='attack', targetzone='Factory'}),
		GroupCommander:new({name='echo9', mission='supply', targetzone='Foxtrot'}),
		GroupCommander:new({name='echo10', mission='supply', targetzone='Foxtrot'}),
		GroupCommander:new({name='echo11', mission='attack', targetzone='Foxtrot'}),
		GroupCommander:new({name='echo12', mission='supply', targetzone='Krasnodar'}),
		GroupCommander:new({name='echo13', mission='supply', targetzone='Krasnodar'}),
		GroupCommander:new({name='echo14', mission='supply', targetzone='Krasnodar'}),
		GroupCommander:new({name='Echo0', mission='supply', targetzone='Ever'}),
	},
	factory={
		GroupCommander:new({name='factory1', mission='supply', targetzone='Krymsk'}),
		GroupCommander:new({name='factory2', mission='supply', targetzone='Krymsk'}),
		GroupCommander:new({name='factory3', mission='supply', targetzone='Delta'}),
		GroupCommander:new({name='factory4', mission='supply', targetzone='Delta'}),
		GroupCommander:new({name='factory5', mission='supply', targetzone='Foxtrot'}),
		GroupCommander:new({name='factory6', mission='supply', targetzone='Foxtrot'}),
		GroupCommander:new({name='factory7', mission='supply', targetzone='Echo'}),
		GroupCommander:new({name='factory8', mission='supply', targetzone='Echo'}),
		GroupCommander:new({name='factory-krymsk-supply', mission='supply', targetzone='Krymsk', type='surface'}),
		GroupCommander:new({name='factory-delta-supply', mission='supply', targetzone='Delta', type='surface'}),
		GroupCommander:new({name='factory-echo-supply', mission='supply', targetzone='Echo', type='surface'}),
		GroupCommander:new({name='factory-foxtrot-supply', mission='supply', targetzone='Foxtrot', type='surface'})
	},
	oilfields={
		GroupCommander:new({name='oil-krymsk-supply', mission='supply', targetzone='Krymsk', type='surface'})
	},
	-- Convoys
	-- SAM sites
	banana = {
		GroupCommander:new({name='Mikehans60A-11', mission='supply', targetzone='Mikehans'}),
	},
	fine = {
		GroupCommander:new({name='Fine1', mission='supply', targetzone='Suoqi'}),
	},
	-- Airfields
	krymsk = {
		GroupCommander:new({name='krym1', mission='supply', targetzone='Bravo'}),
		GroupCommander:new({name='krym2', mission='attack', targetzone='Bravo'}),
		GroupCommander:new({name='krym3', mission='patrol', targetzone='Bravo'}),
		GroupCommander:new({name='krym4', mission='patrol', targetzone='Krymsk'}),
		GroupCommander:new({name='krym5', mission='supply', targetzone='Radio Tower'}),
		GroupCommander:new({name='krym6', mission='attack', targetzone='Radio Tower'}),
		GroupCommander:new({name='krym7', mission='patrol', targetzone='Radio Tower'}),
		GroupCommander:new({name='krym8', mission='patrol', targetzone='Bravo'}),
		GroupCommander:new({name='krym9', mission='patrol', targetzone='Krymsk'}),
		GroupCommander:new({name='krym10', mission='supply', targetzone='Bravo'}),
		GroupCommander:new({name='krym11', mission='supply', targetzone='Radio Tower'}),
		GroupCommander:new({name='krym12', mission='supply', targetzone='Delta'}),
		GroupCommander:new({name='krym13', mission='attack', targetzone='Delta'}),
		GroupCommander:new({name='krym14', mission='supply', targetzone='Factory'}),
		GroupCommander:new({name='krym15', mission='attack', targetzone='Factory'}),
		GroupCommander:new({name='krym16', mission='supply', targetzone='Delta'}),
		GroupCommander:new({name='krym17', mission='supply', targetzone='Factory'}),
		GroupCommander:new({name='krym18', mission='supply', targetzone='SAM Site'}),
		GroupCommander:new({name='krym19', mission='supply', targetzone='SAM Site'}),
		GroupCommander:new({name='krym20', mission='attack', targetzone='SAM Site'}),
		GroupCommander:new({name='krym21', mission='patrol', targetzone='Delta'}),
		GroupCommander:new({name='krym22', mission='supply', targetzone='Oil Fields'}),
		GroupCommander:new({name='krym23', mission='supply', targetzone='Oil Fields'}),
		GroupCommander:new({name='krym24', mission='attack', targetzone='Oil Fields'}),
		GroupCommander:new({name='krym25', mission='attack', targetzone='Bravo', type='surface'}),
		GroupCommander:new({name='b-supply-krymsk-samsite-uh60a', mission='supply', targetzone='SAM Site'}),
		GroupCommander:new({name='b-supply-krymsk-delta-uh60a', mission='supply', targetzone='Delta'}),
		GroupCommander:new({name='b-supply-krymsk-ever-uh60a', mission='supply', targetzone='Ever'}),
		GroupCommander:new({name='b-supply-krymsk-echo-uh60a', mission='supply', targetzone='Echo'}),
		GroupCommander:new({name='b-supply-krymsk-kelasinuodaer-uh60a', mission='supply', targetzone='Kelasinuodaer'}),
	},
	suoqi = {
		GroupCommander:new({name='Suoqi60A-3', mission='supply', targetzone='Fine'}),
		GroupCommander:new({name='Suoqi60A-2', mission='supply', targetzone='Fish'}),
		GroupCommander:new({name='Mikehans15-7', mission='supply', targetzone='Krymsk'}),
		GroupCommander:new({name='Mikehans60A-8', mission='supply', targetzone='Fish'}),
		GroupCommander:new({name='Suoqi60A-4', mission='supply', targetzone='Suhumi'}),
		GroupCommander:new({name='Suoqi60A', mission='supply', targetzone='Fish'}),
		GroupCommander:new({name='Suoqi60A-1', mission='supply', targetzone='Cool'}),
		GroupCommander:new({name='Suoqi111', mission='patrol', targetzone='Fine'}),
		GroupCommander:new({name='Suoqi111-1', mission='patrol', targetzone='Cool'}),
		GroupCommander:new({name='Suoqi111-2', mission='patrol', targetzone='Fish'}),
		GroupCommander:new({name='b-patrol-suoqi-fish-f14b', mission='patrol', targetzone='Fish'}),
	},
	gelend = {
		GroupCommander:new({name='r-supply-gelend-famer-uh60a', mission='supply', targetzone='Famer'}),
		GroupCommander:new({name='r-supply-gelend-four-uh60a', mission='supply', targetzone='Four'}),
		GroupCommander:new({name='r-supply-gelend-apple-uh60a', mission='supply', targetzone='Apple'}),
		GroupCommander:new({name='b-supply-gelend-four-uh60a', mission='supply', targetzone='Four'}),
		GroupCommander:new({name='b-supply-gelend-apple-uh60a', mission='supply', targetzone='Apple'}),
		GroupCommander:new({name='b-supply-gelend-banana-uh60a', mission='supply', targetzone='Banana'}),
		GroupCommander:new({name='b-supply-gelend-novoro-uh60a', mission='supply', targetzone='Novoro'}),
		GroupCommander:new({name='r-patrol-gelend-four-f15c', mission='patrol', targetzone='Four'}),
		GroupCommander:new({name='r-patrol-gelend-apple-f16c', mission='patrol', targetzone='Apple'}),
		GroupCommander:new({name='r-attack-gelend-anapa-a10c', mission='attack', targetzone='Anapa'}),
		GroupCommander:new({name='r-patrol-gelend-radiotower-su33', mission='patrol', targetzone='Radio Tower'}),
		GroupCommander:new({name='r-attack-gelend-bravo-asj37', mission='attack', targetzone='Bravo'}),
	},
	kelasinuodaer = {
		GroupCommander:new({name='Kelasinuodaer1', mission='supply', targetzone='Ever'}),
		GroupCommander:new({name='Kelasinuodaer15C', mission='patrol', targetzone='Anapa'}),
		GroupCommander:new({name='Kelasinuodaer16', mission='patrol', targetzone='Krymsk'}),
		GroupCommander:new({name='Kelasinuodaer14', mission='patrol', targetzone='Four'}),
		GroupCommander:new({name='Kelasinuodaer15C-1', mission='patrol', targetzone='Ever'}),
		GroupCommander:new({name='Kelasinuodaer1-1', mission='patrol', targetzone='Delta'}),
		GroupCommander:new({name='Kelasinuodaer2-4', mission='supply', targetzone='Krasnodar'}),
	},
	-- Airfields enhanced
	krasnodar={
		GroupCommander:new({name='kras1', mission='supply', targetzone='Echo'}),
		GroupCommander:new({name='kras2', mission='supply', targetzone='Echo'}),
		GroupCommander:new({name='kras3', mission='supply', targetzone='Foxtrot'}),
		GroupCommander:new({name='kras4', mission='supply', targetzone='Foxtrot'}),
		GroupCommander:new({name='kras5', mission='attack', targetzone='SAM Site'}),
		GroupCommander:new({name='kras6', mission='attack', targetzone='Krymsk'}),
		GroupCommander:new({name='kras7', mission='attack', targetzone='Radio Tower'}),
		GroupCommander:new({name='kras8', mission='attack', targetzone='Factory'}),
		GroupCommander:new({name='kras9', mission='attack', targetzone='Echo'}),
		GroupCommander:new({name='kras10', mission='attack', targetzone='Foxtrot'}),
		GroupCommander:new({name='kras11', mission='patrol', targetzone='Echo'}),
		GroupCommander:new({name='kras12', mission='patrol', targetzone='Delta'}),
		GroupCommander:new({name='kras13', mission='patrol', targetzone='Factory'}),
		GroupCommander:new({name='kras332', mission='supply', targetzone='Banana'}),
		GroupCommander:new({name='kras332-1', mission='supply', targetzone='Apple'}),
		GroupCommander:new({name='b-supply-krasnodar-banana-uh60a', mission='supply', targetzone='Banana'}),
		GroupCommander:new({name='b-supply-krasnodar-mikehans-uh60a', mission='supply', targetzone='Mikehans'}),
	},
	mikehans = {
		GroupCommander:new({name='Mikehans15', mission='supply', targetzone='Banana'}),
		GroupCommander:new({name='Mikehans15-1', mission='patrol', targetzone='Finish'}),
		GroupCommander:new({name='Mikehans15-2', mission='patrol', targetzone='Fine'}),
		GroupCommander:new({name='Mikehans15-3', mission='patrol', targetzone='Cool'}),
		GroupCommander:new({name='Mikehans15-4', mission='patrol', targetzone='Suoqi'}),
		GroupCommander:new({name='Mikehans15-5', mission='patrol', targetzone='Fine'}),
		GroupCommander:new({name='Mikehans15-6', mission='patrol', targetzone='Fish'}),
		GroupCommander:new({name='b-patrol-mikehans-fine-f18c', mission='patrol', targetzone='Fine'}),
		GroupCommander:new({name='b-patrol-mikehans-cool-f16c', mission='patrol', targetzone='Cool'}),
		GroupCommander:new({name='Mikehans60A', mission='supply', targetzone='Banana'}),
		GroupCommander:new({name='Mikehans60A-1', mission='supply', targetzone='Fine'}),
		GroupCommander:new({name='Mikehans60A-2', mission='supply', targetzone='Fine'}),
		GroupCommander:new({name='Mikehans60A-3', mission='supply', targetzone='Cool'}),
		GroupCommander:new({name='Mikehans60A-4', mission='supply', targetzone='Cool'}),
		GroupCommander:new({name='Mikehans60A-5', mission='supply', targetzone='Finish'}),
		GroupCommander:new({name='Mikehans60A-6', mission='supply', targetzone='Apple'}),
		GroupCommander:new({name='Mikehans60A-7', mission='supply', targetzone='Finish'}),
	},
	
	suhumi = {
		GroupCommander:new({name='Suhumi60A', mission='supply', targetzone='Suoqi'}),
		GroupCommander:new({name='Suhumi60A-1', mission='supply', targetzone='Fish'}),
		GroupCommander:new({name='Suhumi0', mission='patrol', targetzone='Suoqi'}),
		GroupCommander:new({name='Suhumi0-1', mission='patrol', targetzone='Fish'}),
		GroupCommander:new({name='Suhumi0-2', mission='patrol', targetzone='Apple'}),
		GroupCommander:new({name='Suhumi111', mission='attack', targetzone='Mikehans'}),
		GroupCommander:new({name='Suhumi11', mission='attack', targetzone='Mikehans'}),
		GroupCommander:new({name='Suhumi11-1', mission='attack', targetzone='Suoqi'}),
	},
}

-- Friendly airfields
anapa:addGroups(dispatch.anapa)
novoro:addGroups(dispatch.novoro)
-- Friendly carriers
carrier:addGroups(dispatch.carrier)
-- Regular zones
charlie:addGroups(dispatch.charlie)
foxtrot:addGroups(dispatch.foxtrot)
famer:addGroups(dispatch.famer)
-- FARPs
bravo:addGroups(dispatch.bravo)
echo:addGroups(dispatch.echo)
factory:addGroups(dispatch.factory)
oilfields:addGroups(dispatch.oilfields)
-- Convoys
-- SAM sites
banana:addGroups(dispatch.banana)
fine:addGroups(dispatch.fine)
-- Airfields
krymsk:addGroups(dispatch.krymsk)
suoqi:addGroups(dispatch.suoqi)
gelend:addGroups(dispatch.gelend)
kelasinuodaer:addGroups(dispatch.kelasinuodaer)
-- Airfields enhanced
krasnodar:addGroups(dispatch.krasnodar)
mikehans:addGroups(dispatch.mikehans)
-- Airfields final
suhumi:addGroups(dispatch.suhumi)

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
bc:addZone(krasnodar)
-- Edited: Add new zones
bc:addZone(novoro)
bc:addZone(apple)
bc:addZone(banana)
bc:addZone(famer)
bc:addZone(four)
bc:addZone(fine)
bc:addZone(fish)
bc:addZone(ever)
bc:addZone(finish)
bc:addZone(cool)
bc:addZone(suoqi)
bc:addZone(gelend)
bc:addZone(kelasinuodaer)
bc:addZone(mikehans)
bc:addZone(suhumi)
-- Edited: Done

bc:addConnection("Anapa","Alpha")
bc:addConnection("Alpha","Bravo")
bc:addConnection("Bravo","Krymsk")
bc:addConnection("Bravo","Charlie")
bc:addConnection("Bravo","Convoy")
bc:addConnection("Anapa","Charlie")
bc:addConnection("Bravo","Oil Fields")
bc:addConnection("Krymsk","Oil Fields")
bc:addConnection("Krymsk","Radio Tower")
bc:addConnection("Krymsk","Factory")
bc:addConnection("Krymsk","Delta")
bc:addConnection("Factory","Delta")
bc:addConnection("Factory","Foxtrot")
bc:addConnection("Factory","Echo")
bc:addConnection("Delta","Echo")
bc:addConnection("Foxtrot","Krasnodar")
bc:addConnection("Echo","Krasnodar")
bc:addConnection("Echo","SAM Site")
bc:addConnection("Krymsk","SAM Site")
-- Edited: Add new zones
bc:addConnection("Anapa","Famer")
bc:addConnection("Alpha","Famer")
bc:addConnection("Famer","Novoro")
bc:addConnection("Famer","Bravo")
bc:addConnection("Famer","Krymsk")
bc:addConnection("Famer","Radio Tower")
bc:addConnection("Novoro","Alpha")
bc:addConnection("Novoro","Bravo")
bc:addConnection("Novoro","Krymsk")
bc:addConnection("Novoro","Radio Tower")
bc:addConnection("Novoro","Gelend")
bc:addConnection("Novoro","Factory")
bc:addConnection("Novoro","Four")
bc:addConnection("Gelend","Radio Tower")
bc:addConnection("Gelend","Factory")
bc:addConnection("Gelend","Four")
bc:addConnection("Gelend","Bravo")
bc:addConnection("Gelend","Alpha")
bc:addConnection("Gelend","Krymsk")
bc:addConnection("Gelend","Fine")
bc:addConnection("Ever","Oil Fields")
bc:addConnection("Ever","SAM Site")
bc:addConnection("Ever","Echo")
bc:addConnection("Ever","Foxtrot")
bc:addConnection("Ever","Kelasinuodaer")
bc:addConnection("Ever","Krasnodar")
bc:addConnection("Ever","Banana")
bc:addConnection("Four","Famer")
bc:addConnection("Four","Alpha")
bc:addConnection("Four","Bravo")
bc:addConnection("Four","Radio Tower")
bc:addConnection("Four","Factory")
bc:addConnection("Four","Echo")
bc:addConnection("Four","Foxtrot")
bc:addConnection("Four","Apple")
bc:addConnection("Four","Fine")
bc:addConnection("Four","Suoqi")
bc:addConnection("Apple","Suoqi")
bc:addConnection("Apple","Foxtrot")
bc:addConnection("Apple","Factory")
bc:addConnection("Apple","Banana")
bc:addConnection("Apple","Krasnodar")
bc:addConnection("Apple","Mikehans")
bc:addConnection("Apple","Fine")
bc:addConnection("Krasnodar","Banana")
bc:addConnection("Krasnodar","Four")
bc:addConnection("Krasnodar","Mikehans")
bc:addConnection("Banana","Mikehans")
bc:addConnection("Banana","Foxtrot")
bc:addConnection("Mikehans","Finish")
bc:addConnection("Mikehans","Cool")
bc:addConnection("Mikehans","Fine")
bc:addConnection("Fine","Suoqi")
bc:addConnection("Fine","Finish")
bc:addConnection("Fine","Cool")
bc:addConnection("Fine","Fish")
bc:addConnection("Finish","Cool")
bc:addConnection("Finish","Fish")
bc:addConnection("Finish","Suoqi")
bc:addConnection("Cool","Fish")
bc:addConnection("Cool","Suoqi")
bc:addConnection("Cool","Suhumi")
bc:addConnection("Suoqi","Suhumi")
bc:addConnection("Suoqi","Gelend")
bc:addConnection("Suoqi","Fish")
bc:addConnection("Fish","Suhumi")
-- Edited: Done

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

krymsk:registerTrigger('captured', function(event,sender)
	local kr = bc:getZoneByName('Krymsk')
	if kr.side == 1 then
		local krforces = { 'krymsk-gforce-1','krymsk-gforce-2','krymsk-gforce-3','krymsk-tforce-1' }
		for _,v in ipairs(krforces) do
			local g = Group.getByName(v)
			if g then
				g:destroy()
			end
		end
	end
end, 'krymskcaptured')

local checkMissionComplete = function (event, sender)
	local done = true
	for i,v in ipairs(bc:getZones()) do
		if v.side == 1 then
			done = false
			break
		end
	end
	
	if done then
		trigger.action.outText("Enemy has been defeated. \n\nMission Complete.", 120)
		trigger.action.setUserFlag("TriggerFlagMissionComplete", true) -- Edited: Set flag to make mission restart
	end
end

for i,v in ipairs(bc:getZones()) do
	v:registerTrigger('lost', checkMissionComplete, 'missioncompleted')
end

--bc:addFunds(1,0)
--bc:addFunds(2,0)

Group.getByName('sead1'):destroy()
local seadTargetMenu = nil
bc:registerShopItem('sead', 'F/A-18C SEAD mission', 250, function(sender) 
	local gr = Group.getByName('sead1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return 'SEAD mission still in progress'
	end
	mist.respawnGroup('sead1', true)
	
	if seadTargetMenu then
		return 'Choose target zone from F10 menu'
	end
	
	local launchAttack = function(target)
		if Group.getByName('sead1') then
			local err = bc:engageZone(target, 'sead1')
			if err then
				return err
			end
			
			trigger.action.outTextForCoalition(2, 'F/A-18C Hornets engaging SAMs at '..target, 15)
		else
			trigger.action.outTextForCoalition(2, 'Group has left the area or has been destroyed', 15)
		end
		
		seadTargetMenu = nil
	end
	
	seadTargetMenu = bc:showTargetZoneMenu(2, 'SEAD Target', launchAttack, 1)
	
	trigger.action.outTextForCoalition(2, 'F/A-18C Hornets on route. Choose target zone from F10 menu', 15)
end,
function (sender, params)
	if params.zone and params.zone.side == 1 then
		local gr = Group.getByName('sead1')
		if gr and gr:getSize()>0 and gr:getController():hasTask() then 
			return 'SEAD mission still in progress'
		end
		
		mist.respawnGroup('sead1', true)
		mist.scheduleFunction(function(target)
			if Group.getByName('sead1') then
				local err = bc:engageZone(target, 'sead1')
				if err then
					return err
				end
				
				trigger.action.outTextForCoalition(2, 'F/A-18C Hornets engaging SAMs at '..target, 15)
			end
		end,{params.zone.zone},timer.getTime()+2)
	else
		return 'Can only target enemy zone'
	end
end)

Group.getByName('sweep1'):destroy()
bc:registerShopItem('sweep', 'F-14B Fighter Sweep', 150, function(sender) 
	local gr = Group.getByName('sweep1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return 'Fighter sweep mission still in progress'
	end
	mist.respawnGroup('sweep1', true)
end,
function (sender, params)
	local gr = Group.getByName('sweep1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return 'Fighter sweep mission still in progress'
	end
	mist.respawnGroup('sweep1', true)
end)

Group.getByName('cas1'):destroy()
local casTargetMenu = nil
bc:registerShopItem('cas', 'F-4 Ground Attack', 400, function(sender) 
	local gr = Group.getByName('cas1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return 'Ground attack mission still in progress'
	end
	
	mist.respawnGroup('cas1', true)
	
	if casTargetMenu then
		return 'Choose target zone from F10 menu'
	end
	
	local launchAttack = function(target)
		if casTargetMenu then
			if Group.getByName('cas1') then
				local err = bc:engageZone(target, 'cas1')
				if err then
					return err
				end
				
				trigger.action.outTextForCoalition(2, 'F-4 Phantoms engaging groups at '..target, 15)
			else
				trigger.action.outTextForCoalition(2, 'Group has left the area or has been destroyed', 15)
			end
			
			casTargetMenu = nil
		end
	end
	
	casTargetMenu = bc:showTargetZoneMenu(2, 'F-4 Target', launchAttack, 1)
	
	trigger.action.outTextForCoalition(2, 'F-4 Phantoms on route. Choose target zone from F10 menu', 15)
end,
function (sender, params)
	if params.zone and params.zone.side == 1 then
		local gr = Group.getByName('cas1')
		if gr and gr:getSize()>0 and gr:getController():hasTask() then 
			return 'Ground attack mission still in progress'
		end
		
		mist.respawnGroup('cas1', true)
		mist.scheduleFunction(function(target)
			if Group.getByName('cas1') then
				local err = bc:engageZone(target, 'cas1')
				if err then
					return err
				end
				
				trigger.action.outTextForCoalition(2, 'F-4 Phantoms engaging groups at '..target, 15)
			end
		end,{params.zone.zone},timer.getTime()+2)
	else
		return 'Can only target enemy zone'
	end
end)

bc:addMonitoredROE('cruise1')
local cruiseMissileTargetMenu = nil
bc:registerShopItem('cruisemsl', 'Cruise Missile Strike', 800, function(sender)
	if cruiseMissileTargetMenu then
		return 'Choose target zone from F10 menu'
	end
	
	local launchAttack = function(target)
		if cruiseMissileTargetMenu then
			local err = bc:fireAtZone(target, 'cruise1', true, 8)
			if err then
				return err
			end
			
			cruiseMissileTargetMenu = nil
			trigger.action.outTextForCoalition(2, 'Launching cruise missiles at '..target, 15)
		end
	end
	
	cruiseMissileTargetMenu = bc:showTargetZoneMenu(2, 'Cruise Missile Target', launchAttack, 1)
	
	trigger.action.outTextForCoalition(2, 'Cruise missiles ready. Choose target zone from F10 menu', 15)
end,
function (sender, params)
	if params.zone and params.zone.side == 1 then
		local err = bc:fireAtZone(params.zone.zone, 'cruise1', true, 8)
		if err then
			return err
		end
		
		trigger.action.outTextForCoalition(2, 'Launching cruise missiles at '..params.zone.zone, 15)
	else
		return 'Can only target enemy zone'
	end
end)

local upgradeMenu = nil
bc:registerShopItem('supplies', 'Resupply friendly Zone', 200, function(sender)
	if upgradeMenu then
		return 'Choose zone from F10 menu'
	end
	
	local upgradeZone = function(target)
		if upgradeMenu then
			local zn = bc:getZoneByName(target)
			if zn and zn.side==2 then
				zn:upgrade()
			else
				return 'Zone not friendly'
			end
			
			upgradeMenu = nil
		end
	end
	
	upgradeMenu = bc:showTargetZoneMenu(2, 'Select Zone to resupply', upgradeZone, 2)
	
	trigger.action.outTextForCoalition(2, 'Supplies prepared. Choose zone from F10 menu', 15)
end,
function(sender, params)
	if params.zone and params.zone.side == 2 then
		params.zone:upgrade()
	else
		return 'Can only target friendly zone'
	end
end)

Group.getByName('jtacDrone'):destroy()
local jtacTargetMenu = nil
drone = JTAC:new({name = 'jtacDrone'})
bc:registerShopItem('jtac', 'MQ-1A Predator JTAC mission', 100, function(sender)
	
	if jtacTargetMenu then
		return 'Choose target zone from F10 menu'
	end
	
	local spawnAndOrbit = function(target)
		if jtacTargetMenu then
			local zn = bc:getZoneByName(target)
			drone:deployAtZone(zn)
			drone:showMenu()
			trigger.action.outTextForCoalition(2, 'Predator drone deployed over '..target, 15)
			jtacTargetMenu = nil
		end
	end
	
	jtacTargetMenu = bc:showTargetZoneMenu(2, 'Deploy JTAC', spawnAndOrbit, 1)
	
	trigger.action.outTextForCoalition(2, 'Choose which zone to deploy JTAC at from F10 menu', 15)
end,
function(sender, params)
	if params.zone and params.zone.side == 1 then
		drone:deployAtZone(params.zone)
		drone:showMenu()
		trigger.action.outTextForCoalition(2, 'Predator drone deployed over '..params.zone.zone, 15)
	else
		return 'Can only target enemy zone'
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
bc:registerShopItem('smoke', 'Smoke markers', 20, function(sender)
	if smokeTargetMenu then
		return 'Choose target zone from F10 menu'
	end
	
	local launchAttack = function(target)
		if smokeTargetMenu then
			local tz = bc:getZoneByName(target)
			smoketargets(tz)
			smokeTargetMenu = nil
			trigger.action.outTextForCoalition(2, 'Targets marked with RED smoke at '..target, 15)
		end
	end
	
	smokeTargetMenu = bc:showTargetZoneMenu(2, 'Smoke marker target', launchAttack, 1)
	
	trigger.action.outTextForCoalition(2, 'Choose target zone from F10 menu', 15)
end,
function(sender, params)
	if params.zone and params.zone.side == 1 then
		smoketargets(params.zone)
		trigger.action.outTextForCoalition(2, 'Targets marked with RED smoke at '..params.zone.zone, 15)
	else
		return 'Can only target enemy zone'
	end
end)

local spawnAwacs = function(sender) 
	local gr = Group.getByName('awacs1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return 'Darkstar still active on 252.00 MHz AM'
	end
	mist.respawnGroup('awacs1', true)
	trigger.action.outTextForCoalition(2,'Darkstar active on 252.00 MHz AM',15)
end
Group.getByName('awacs1'):destroy()
bc:registerShopItem('awacs', 'AWACS', 100, spawnAwacs, spawnAwacs)


bc:addShopItem(2, 'sead', -1)
bc:addShopItem(2, 'sweep', -1)
bc:addShopItem(2, 'cas', -1)
bc:addShopItem(2, 'cruisemsl', 12)
bc:addShopItem(2, 'supplies', -1)
bc:addShopItem(2, 'jtac', -1)
bc:addShopItem(2, 'smoke', -1)
bc:addShopItem(2, 'awacs', -1)

--red support
Group.getByName('redcas1'):destroy()
bc:registerShopItem('redcas1', 'Red Cas', 1000, function(sender) 
	local gr = Group.getByName('redcas1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return 'still alive'
	end
	mist.respawnGroup('redcas1', true)
	trigger.action.outTextForCoalition(2,'The enemy has deployed a couple of Su-34 against our ground forces',15)
end)

Group.getByName('redcap1'):destroy()
bc:registerShopItem('redcap1', 'Red Cap', 1000, function(sender) 
	local gr = Group.getByName('redcap1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return 'still alive'
	end
	mist.respawnGroup('redcap1', true)
	trigger.action.outTextForCoalition(2,'Enemy MiG-31 interceptors, coming in from the South-East',15)
end)

Group.getByName('redsead1'):destroy()
bc:registerShopItem('redsead1', 'Red Sead', 1000, function(sender) 
	local gr = Group.getByName('redsead1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return 'still alive'
	end
	mist.respawnGroup('redsead1', true)
	trigger.action.outTextForCoalition(2,'The enemy has launched an attack from the North-East on our air defenses',15)
end)

Group.getByName('redmlrs1'):destroy()
bc:registerShopItem('redmlrs1', 'spawn Red mlrs', 1000, function(sender) 
	local zn = bc:getZoneByName('Foxtrot')
	if zn.side == 1 and zn.active then
		local gr = Group.getByName('redmlrs1')
		if gr then
			local full = true
			for i,v in ipairs(gr:getUnits()) do
				for i2,v2 in ipairs(v:getAmmo()) do
					if v2.count < 3 then
						full = false
						break
					end
				end
				
				if not full then 
					break
				end
			end
			
			if full and gr:getSize()==gr:getInitialSize() then
				return 'ammo full'
			end
			
			trigger.action.outTextForCoalition(2,'The enemy has resupplied its artillery near Foxtrot',15)
		else
			trigger.action.outTextForCoalition(2,'The enemy has deployed artillery near Foxtrot',15)
		end
		
		mist.respawnGroup('redmlrs1')
		bc:removeShopItem(1,'redmlrs1fire')
		bc:addShopItem(1, 'redmlrs1fire', 3)
	else
		return 'zone not red'
	end
end)

bc:registerShopItem('redmlrs1fire', 'fire red mlrs', 200, function(sender) 
	local gr = Group.getByName('redmlrs1')
	if gr then
		local targetzones = {'Echo', 'Delta', 'SAM Site', 'Factory', 'Radio Tower', 'Krymsk'}
		local viabletargets = {}
		for i,v in ipairs(targetzones) do
			local z = bc:getZoneByName(v)
			
			if z and z.side == 2 then
				table.insert(viabletargets, v)
			end
		end

		if #viabletargets==0 then
			return 'no targets'
		end
		
		local targetzn = viabletargets[math.random(1,#viabletargets)]
		
		local err = bc:fireAtZone(targetzn, 'redmlrs1', true, 3, 6)
		
		if not err then
			trigger.action.outTextForCoalition(2,'Enemy artillery near Foxtrot has begun preparations to fire on '..targetzn,15)
		else
			return err
		end
	else
		return 'buy first'
	end
end)


Group.getByName('intercept1'):destroy()
Group.getByName('intercept2'):destroy()
local cargoDieEvent = nil
bc:registerShopItem('intercept1', 'Red intercept', 1000, function(sender) 
	local grt = Group.getByName('intercept1')
	local gre = Group.getByName('intercept2')
	if gre and gre:getSize()>0 and gre:getController():hasTask() then 
		return 'still alive'
	end
	
	if grt and grt:getSize()>0 and grt:getController():hasTask() then 
		return 'still alive'
	end
	
	mist.respawnGroup('intercept1', true)
	mist.respawnGroup('intercept2', true)
	
	if not cargoDieEvent then
		local cargoPlaneDied = function(event)
			if event.id==28 then
				if event.initiator and event.initiator:getCoalition()==2 and event.target and event.target.getName then
					if event.target:getName()=='intercept1' then
						trigger.action.outTextForCoalition(2,'Enemy cargo transport destroyed.\n+500 credits',15)
						bc:addFunds(2,500)
						mist.removeEventHandler(cargoDieEvent)
						cargoDieEvent = nil
					elseif not Unit.getByName('intercept1') then
						mist.removeEventHandler(cargoDieEvent)
						cargoDieEvent = nil
					end
				end
			end
		end
		
		cargoDieEvent = mist.addEventHandler(cargoPlaneDied)
	end
	
	trigger.action.outTextForCoalition(2,'Enemy cargo transport has entered the airspace from the south.',15)
end)

Group.getByName('escort1'):destroy()
Group.getByName('antiescort1'):destroy()
Group.getByName('antiescort2'):destroy()
bc:registerShopItem('escort1', 'Red antiescort', 1000, function(sender) 
	local gr = Group.getByName('escort1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return 'still alive'
	end
	
	mist.respawnGroup('escort1', true)
	
	local spawnIntercept = function(groupname)
		if Group.getByName('escort1') then
			local g = Group.getByName(groupname)
			if not g then
				if math.random(1,100) > 30 then
					if math.random(1,100) > 50 then
						trigger.action.outTextForCoalition(2,'Enemy interceptor spotted heading for our cargo transport.',15)
					else
						trigger.action.outTextForCoalition(2,'The enemy has launched an intercept mission against our cargo transport',15)
					end
					mist.respawnGroup(groupname, true)
				end
			end
		end
	end
	
	local timers = {math.random(3*60,15*60), math.random(8*60,15*60)}
	mist.scheduleFunction(spawnIntercept, {'antiescort1'}, timer.getTime()+timers[1])
	mist.scheduleFunction(spawnIntercept, {'antiescort2'}, timer.getTime()+timers[2])
	
	
	trigger.action.outTextForCoalition(2,'Friendly cargo transport has entered the airspace from the south.',15)
end)

krymskForce = {
	'krymsk-force-1',
	'krymsk-force-2',
	'krymsk-force-3',
	'krymsk-gforce-1',
	'krymsk-gforce-2',
	'krymsk-gforce-3',
	'krymsk-tforce-1',
	'krymsk-aforce-1',
	'krymsk-aforce-2',
	'krymsk-aforce-3',
}

for _,v in ipairs(krymskForce) do Group.getByName(v):destroy() end

bc:registerShopItem('krymskForce', 'Krymsk Assault', 1000, function(sender) 
	for _,v in ipairs(krymskForce) do
		local gr = Group.getByName(v)
		if gr and gr:getSize()>0 and gr:getController():hasTask() then 
			return 'still alive'
		end
	end
	
	if bc:getZoneByName('Echo').side==1 and bc:getZoneByName('Krymsk').side==2 then
		for _,v in ipairs(krymskForce) do
			mist.respawnGroup('krymsk-force-1', true)
			mist.respawnGroup('krymsk-force-2', true)
			mist.respawnGroup('krymsk-force-3', true)
			
			if bc:getZoneByName('Delta').side==1 then
				mist.respawnGroup('krymsk-tforce-1', true)
			end
			
			mist.respawnGroup('krymsk-aforce-1', true)
			mist.respawnGroup('krymsk-aforce-2', true)
			mist.respawnGroup('krymsk-aforce-3', true)
		end
	
		trigger.action.outTextForCoalition(2,'Enemy is starting an assault on Krymsk',15)
	else
		return 'zone no match'
	end
end)

bc:addShopItem(1, 'redcas1', -1)
bc:addShopItem(1, 'redcap1', -1)
bc:addShopItem(1, 'redsead1', -1)
bc:addShopItem(1, 'redmlrs1', -1)
bc:addShopItem(1, 'intercept1', -1)
bc:addShopItem(1, 'escort1', -1)
bc:addShopItem(1, 'krymskForce', -1)

budgetAI = BudgetCommander:new({ battleCommander = bc, side=1, decissionFrequency=20*60, decissionVariance=10*60, skipChance = 10})
budgetAI:init()
--end red support

lc = LogisticCommander:new({battleCommander = bc, supplyZones = {
	'Anapa', 'Krymsk', 'Factory', 'Bravo', 'Echo', 'Carrier Group',
	'Novoro', 'Foxtrot', 'Famer', 'Oil Fields', 'Banana', 'Fine', -- Edited: Add more zones
	'Suoqi', 'Gelend', 'Kelasinuodaer', 'Krasnodar', 'Mikehans', 'Suhumi'
}}) 
lc:init()


bc:loadFromDisk() --will load and overwrite default zone levels, sides, funds and available shop items
bc:init()
bc:startRewardPlayerContribution(15,{infantry = 5, ground = 15, sam = 30, airplane = 30, ship = 200, helicopter=40, crate=100, rescue = 50})

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
	
	for i,v in pairs(farpSupply) do
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