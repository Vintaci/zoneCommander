local slotblock = {}

function slotblock.onPlayerTryChangeSlot(playerId, side, slotId)
	-- Detect if server has been initialized
	local init_status, _error  = net.dostring_in('server', " return trigger.misc.getUserFlag(\"TriggerFlagInitDone\"); ")

	if init_status then
		if tonumber(init_status) == 0 then
			net.send_chat_to("服务器仍在初始化中，请稍后。", playerId)
			net.force_player_slot(playerId, 0, '')
			return false
		end
	end

	-- Detect if slot is blocked
	local gname = DCS.getUnitProperty(slotId, DCS.UNIT_GROUPNAME)
	local _status,_error  = net.dostring_in('server', " return trigger.misc.getUserFlag(\""..gname.."\"); ")
	
	if _status then
		local isblocked = tonumber(_status)
		if isblocked==1 then
			net.send_chat_to("该机位(" .. gname .. ")所在机场尚未被所属阵营占领。", playerId)
			net.force_player_slot(playerId, 0, '')
			return false
		end
	end
end

DCS.setUserCallbacks(slotblock)
