local ev = {}
function ev:onEvent(event)
    if event.id==world.event.S_EVENT_BIRTH and event.initiator and Object.getCategory(event.initiator) == Object.Category.UNIT and (Unit.getCategoryEx(event.initiator) == Unit.Category.AIRPLANE or Unit.getCategoryEx(event.initiator) == Unit.Category.HELICOPTER)  then
        if event.initiator:getCoalition() ~= 2 then
            local unit = event.initiator

            timer.scheduleFunction(function (unit)
                local pname = unit:getPlayerName()
    
                for i,v in pairs(net.get_player_list()) do
                    if net.get_name(v) == pname then
                        net.send_chat_to('当前不支持作为红方出生, 请选择蓝方进行游玩' , v)
                        net.force_player_slot(v, coalition.side.BLUE, '')
                        break
                    end
                end

            end,unit,timer.getTime()+20)
        end
    end
end

world.addEventHandler(ev)