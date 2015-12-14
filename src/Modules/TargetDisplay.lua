local class = require "lib.middleclass"
local Module = require "Modules.Module"
local TargetDisplay = class("Modules.TargetDisplay", Module)
local lg = love.graphics
local cos = math.cos
local sin = math.sin
local pi = math.pi
local sqrt = math.sqrt

function TargetDisplay:initialize()
    Module.initialize(self)
end

--TODO somehow option always draw target options ?

function TargetDisplay:draw(player)
    if player.mode == 1 then --if in TARGET mode
        local stuff = player.sector:getTargetList(player)
        local hw = lg.getWidth()/2
        local hh = lg.getHeight()/2

        for i=1,#stuff do
            stuff[i][1] = sqrt(stuff[i][1])

            if i < 5 then
                -- first four things get target codes!
                local msg
                if i == 1 then
                    msg = "100"
                elseif i == 2 then
                    msg = "101"
                elseif i == 3 then
                    msg = "110"
                elseif i == 4 then
                    msg = "111"
                end

                lg.setColor(60, 30, 0, 200)
                lg.rectangle("fill", hw + stuff[i][1]*cos(stuff[i][3] + pi), hh + stuff[i][1]*sin(stuff[i][3] + pi), 35, 22)

                lg.setColor(255, 150, 100, 255)
                lg.print(msg, hw + stuff[i][1]*cos(stuff[i][3] + pi), hh + stuff[i][1]*sin(stuff[i][3] + pi))
            else
                break --since we started the loop going through all of them but only care about the first 4
            end
        end

        lg.setColor(60, 30, 0, 200)
        lg.rectangle("fill", hw - 50, 0, 100, 22)
        lg.rectangle("fill", 0, hh - 22, 100, 22)
        lg.rectangle("fill", lg.getWidth() - 100, hh - 22, 100, 22)
        lg.rectangle("fill", hw - 50, lg.getHeight() - (24+22), 100, 22)

        lg.setColor(255, 150, 100, 255)
        lg.printf("000:Up", hw - 50, 0, 100, "center")
        lg.printf("011:Down", hw - 50, lg.getHeight() - (24+22), 100, "center")
        lg.printf("010:Left", 0, hh - 22, 100, "center")
        lg.printf("001:Right", lg.getWidth() - 100, hh - 22, 100, "center")
    end
end

return TargetDisplay
