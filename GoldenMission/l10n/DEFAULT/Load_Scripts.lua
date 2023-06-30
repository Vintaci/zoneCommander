local script_path = "D:/GitRepos/zoneCommander/GoldenScripts/"

local script_list =
{
    -- Load order must be correct
    "file_lib.lua",
    "mist_4_5_113.lua",
    "GroupFunctions.lua",
    "GroundUnitAutoAttack.lua",
    "WeaponCooldown.lua",
    "zoneCommander.lua",
    "zoneSetup.lua",
    "Hercules_Cargo.lua",
    -- "Splash_Damage_2_0.lua",
}

local function load_scripts(path, list)
    for index, value in ipairs(list) do
        dofile(path .. value)
    end
end

if lfs then
    script_path = lfs.writedir() .. "Missions/Scripts/Foothold/"

    env.info("Foothold - LFS available, using relative script load path: " .. script_path)
else
    env.info("Foothold - LFS not available, using default script load path: " .. script_path)
end

load_scripts(script_path, script_list)
