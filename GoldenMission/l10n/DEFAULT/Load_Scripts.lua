-- Debug Trace

-- debug.sethook(function()
--     local info = debug.getinfo(2)
--     env.warning(info.short_src .. info.currentline, false)
-- end, "c") -- c: when function is called, r: when function is returned, l: every line

-- Debug Trace Done

local script_path = "D:/GitRepos/zoneCommander/GoldenScripts/"

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
    "BlockRedSpawn.lua",
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
