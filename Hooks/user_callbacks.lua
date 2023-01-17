local vip_list = {
    -- 晚风
    ["78145d0ad9f139506511577d290fcb88"] = {
        welcome_text = "欢迎下崽下一窝的大佬晚风加入服务器！",
        welcome_audio = "WanFeng_Welcome.ogg",
        goodbye_text = "老金恭送大佬晚风离开服务器~",
        online = false,
    },
    -- 老金
    ["197bd981b5ebe0f48479499ab7606856"] = {
        welcome_text = "欢迎写不出来代码的秃头老金加入服务器！",
        welcome_audio = "LaoJin_Welcome.ogg",
        goodbye_text = "啊~看来老金又去修他的BUG喽~",
        online = false,
    },
}

local welcome_text_prefix = "====== VIP 欢迎消息 ======\n\n"
local goodbye_text_prefix = "====== VIP 下线消息 ======\n\n"
local audio_path_prefix = "l10n/DEFAULT/Sounds/"

local function vip_welcome(_player_id)
    local _player_ucid = net.get_player_info(_player_id, 'ucid')
    local _vip = vip_list[_player_ucid]

    if _vip ~= nil and _vip.online == false then
        _vip.online = true

        net.log("[GAC] trigger.action.outText(\"" .. welcome_text_prefix .. _vip.welcome_text .. "\", 45);")
        net.dostring_in('server', "trigger.action.outText(\"" .. welcome_text_prefix .. _vip.welcome_text .. "\", 45);")

        if _vip.welcome_audio ~= nil then
            net.dostring_in('server', "trigger.action.outSound(\"" .. audio_path_prefix .. _vip.welcome_audio .. "\")")
        end
    end
end

local function vip_goodbye(_player_id)
    local _player_ucid = net.get_player_info(_player_id, 'ucid')
    local _vip = vip_list[_player_ucid]
    
    if _vip ~= nil and _vip.online == true then
        _vip.online = false

        net.dostring_in('server', "trigger.action.outText(\"" .. goodbye_text_prefix .. _vip.goodbye_text .. "\", 45)")
    end
end

local function vip_reset(_player_id)
    local _player_ucid = net.get_player_info(_player_id, 'ucid')
    local _vip = vip_list[_player_ucid]

    if _vip ~= nil then
        _vip.online = false
    end
end

local function server_init_check()
    local _status, _error = net.dostring_in('server', "return trigger.misc.getUserFlag(\"TriggerFlagInitDone\")")

    if _status and tonumber(_status) == 0 then
        return "服务器仍在初始化中，请稍后……"
    end
end

local function slot_block_check(_slot_id)
    local _group_name = DCS.getUnitProperty(_slot_id, DCS.UNIT_GROUPNAME)
    local _status, _error = net.dostring_in('server', "return trigger.misc.getUserFlag(\"" .. _group_name .. "\")")

    if _status and tonumber(_status) == 1 then
        return "该机位(" .. _group_name .. ")所在机场尚未被所属阵营占领。"
    end
end

local function kick_user_to_spectator(_player_id, _resaon)
    net.send_chat_to(_resaon, _player_id)
    net.force_player_slot(_player_id, 0, '')

    return false
end

local user_callbacks = {}

-- This will tirgger once a player selects a slot
function user_callbacks.onPlayerTryChangeSlot(_player_id, _side, _slot_id)
    local _reason = server_init_check()

    if _reason ~= nil then
        return kick_user_to_spectator(_player_id, _reason)
    end

    _reason = slot_block_check(_slot_id)

    if _reason ~= nil then
        return kick_user_to_spectator(_player_id, _reason)
    end
end

-- This will tirgger once a player gets into a slot successfully (player is assigned to the slot)
function user_callbacks.onPlayerChangeSlot(_player_id)
    vip_welcome(_player_id)
end

function user_callbacks.onPlayerDisconnect(_player_id)
    vip_goodbye(_player_id)
end

function user_callbacks.onPlayerConnect(_player_id)
    vip_reset(_player_id)
end

DCS.setUserCallbacks(user_callbacks)
