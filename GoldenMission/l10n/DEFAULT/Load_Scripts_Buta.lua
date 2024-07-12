local script_path = "C:\\Users\\10462\\Saved Games\\DCS.openbeta\\Missions\\Scripts\\zoneCommander\\GoldenScripts\\"

local script_list =
{
    -- Load order must be correct
    -- "file_lib.lua",
    "mist.lua",
    "GroupFunctions.lua",
    "GroundUnitAutoAttack.lua",
    "WeaponCooldown.lua",
    "zoneCommander.lua",
    "zoneSetup.lua",
    "unlock_slots_in_zones.lua",
    "restart_timer.lua",
    "PretenseGCI.lua",
    "Hercules_Cargo.lua",
    "CTLD.lua",
    -- "Splash_Damage_2_0.lua",
}

local function load_scripts(path, list)
    for index, value in ipairs(list) do
        dofile(path .. value)
        -- local status, result = pcall(dofile, path .. value)
        -- if not status then
        --     dofile(lfs.writedir() .. "Missions\\Buta\\Röntgen_ButaVer\\Scripts\\" .. value)
        -- end
    end
end

if lfs then
    script_path = lfs.writedir() .. "Missions\\Scripts\\zoneCommander\\GoldenScripts\\"

    env.info("Script Loader: LFS available, using relative script load path: " .. script_path)
else
    env.info("Script Loader: LFS not available, using default script load path: " .. script_path)
end
load_scripts(script_path, script_list)