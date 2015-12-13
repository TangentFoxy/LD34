local class = require "lib.middleclass"
local CodeSelector = class("Modules.CodeSelector")
local lg = love.graphics

lg.setFont(lg.newFont("Audimat Mono Regular.ttf", 20))

function CodeSelector:draw(player)
    local msg0 = ""
    local msg1 = ""
    if player.mode == 0 then
        -- MAIN
        if player.op == "" then
            msg0 = "0:Targeting/Movement"
            msg1 = "1:Action"
        elseif player.op == "0" then
            msg0 = "0:Selection"
            msg1 = "1:Warp"
        elseif player.op == "1" then
            msg0 = "0:Peaceful"
            msg1 = "1:Attack"
        elseif player.op == "00" then
            msg0 = "0:Set Target"
            msg1 = "1:Set Heading"
        elseif player.op == "01" then
            msg0 = "0:Begin Warp"
            msg1 = "1:Abort Warp"
        elseif player.op == "10" then
            msg0 = "0:Comms"
            msg1 = "1:Scan"
        elseif player.op == "11" then
            msg0 = "0:Laser"
            msg1 = "1:Missile"
        end
    elseif player.mode == 1 then
        -- TARGET
        if player.op == "" then
            msg0 = "0:Sector"
            msg1 = "1:Local"
        elseif player.op == "0" then
            msg0 = "0:Up/Right"
            msg1 = "1:Left/Down"
        elseif player.op == "1" then
            msg0 = "0:Close(00/01)"
            msg1 = "1:Far(10/11)"
        elseif player.op == "00" then
            msg0 = "0:Up"
            msg1 = "1:Right"
        elseif player.op == "01" then
            msg0 = "0:Left"
            msg1 = "1:Down"
        elseif player.op == "10" then
            msg0 = "0:Closest(00)"
            msg1 = "1:2nd(01)"
        elseif player.op == "11" then
            msg0 = "0:3rd(10)"
            msg1 = "1:Farthest(11)"
        end
    elseif player.mode == 2 then
        -- HEADING
        if player.op == "" then
            msg0 = "0:Direction"
            msg1 = "1:Speed"
        elseif player.op == "0" then
            msg0 = "0:Up/Right"
            msg1 = "1:Left/Down"
        elseif player.op == "1" then
            msg0 = "0:Stop/Faster"
            msg1 = "1:Slower/Max"
        elseif player.op == "00" then
            msg0 = "0:Up"
            msg1 = "1:Right"
        elseif player.op == "01" then
            msg0 = "0:Left"
            msg1 = "1:Down"
        elseif player.op == "10" then
            msg0 = "0:Stop"
            msg1 = "1:Faster"
        elseif player.op == "11" then
            msg0 = "0:Slower"
            msg1 = "1:Max Speed"
        end
    end

    lg.setColor(10, 30, 55, 255)
    lg.rectangle("fill", lg.getWidth()/4, lg.getHeight() - 24, lg.getWidth()/2, 24)

    lg.setColor(80, 130, 200, 255)
    lg.printf(msg0, lg.getWidth()/4, lg.getHeight() - 24, lg.getWidth()/2, "left")
    lg.printf(msg1, lg.getWidth()/2, lg.getHeight() - 24, lg.getWidth()*3/4, "left")
end

return CodeSelector
