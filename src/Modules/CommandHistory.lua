local class = require "lib.middleclass"
local CommandHistory = class("Modules.CommandHistory")
local lg = love.graphics
local insert = table.insert

function CommandHistory:draw(player)
    local msg = {}

    --for i=1,#player.ophistory do
    local i = 1
    while i <= #player.ophistory do
        if player.ophistory[i] == "000" then
            if player.ophistory[i+1] then
                i = i + 1
                if player.ophistory[i] == "000" then
                    insert(msg, "SELECT>SET>TARGET>SECTOR>UP")
                elseif player.ophistory[i] == "001" then
                    insert(msg, "SELECT>SET>TARGET>SECTOR>RIGHT")
                elseif player.ophistory[i] == "010" then
                    insert(msg, "SELECT>SET>TARGET>SECTOR>LEFT")
                elseif player.ophistory[i] == "011" then
                    insert(msg, "SELECT>SET>TARGET>SECTOR>DOWN")
                elseif player.ophistory[i] == "100" then
                    insert(msg, "SELECT>SET>TARGET>LOCAL>0")
                elseif player.ophistory[i] == "101" then
                    insert(msg, "SELECT>SET>TARGET>LOCAL>1")
                elseif player.ophistory[i] == "110" then
                    insert(msg, "SELECT>SET>TARGET>LOCAL>2")
                elseif player.ophistory[i] == "111" then
                    insert(msg, "SELECT>SET>TARGET>LOCAL>3")
                end
            else
                --insert(msg, "SELECT>SET>TARGET>(A##)")
            end
        elseif player.ophistory[i] == "001" then
            if player.ophistory[i+1] then
                i = i + 1
                if player.ophistory[i] == "000" then
                    insert(msg, "SELECT>SET>HEADING>DIRECTION>UP")
                elseif player.ophistory[i] == "001" then
                    insert(msg, "SELECT>SET>HEADING>DIRECTION>RIGHT")
                elseif player.ophistory[i] == "010" then
                    insert(msg, "SELECT>SET>HEADING>DIRECTION>LEFT")
                elseif player.ophistory[i] == "011" then
                    insert(msg, "SELECT>SET>HEADING>DIRECTION>DOWN")
                elseif player.ophistory[i] == "100" then
                    insert(msg, "SELECT>SET>HEADING>SPEED>STOP")
                elseif player.ophistory[i] == "101" then
                    insert(msg, "SELECT>SET>HEADING>SPEED>UP")
                elseif player.ophistory[i] == "110" then
                    insert(msg, "SELECT>SET>HEADING>SPEED>DOWN")
                elseif player.ophistory[i] == "111" then
                    insert(msg, "SELECT>SET>HEADING>SPEED>MAX")
                end
            else
                --insert(msg, "SELECT>SET>HEADING>(B##)")
            end
        elseif player.ophistory[i] == "010" then
            insert(msg, "SELECT>WARP>START")
        elseif player.ophistory[i] == "011" then
            insert(msg, "SELECT>WARP>STOP")
        elseif player.ophistory[i] == "100" then
            insert(msg, "ACT>PASSIVE>COMMS")
        elseif player.ophistory[i] == "101" then
            insert(msg, "ACT>PASSIVE>SCAN")
        elseif player.ophistory[i] == "110" then
            insert(msg, "ACT>ATK>LASER")
        elseif player.ophistory[i] == "111" then
            insert(msg, "ACT>ATK>MISSILE")
        end
        i = i + 1
    end

    for i=1,#msg do
        lg.setColor(20, 30, 50, 255)
        lg.rectangle("fill", 0, (i-1) * 24, lg.getWidth()*2/5, 24)

        lg.setColor(90, 120, 180, 255)
        lg.printf(msg[i], 0, (i-1) * 24, lg.getWidth()*2/5, "left")
    end
end

return CommandHistory
