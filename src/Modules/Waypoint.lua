local class = require "lib.middleclass"
local Waypoint = class("Modules.Waypoint")
local lg = love.graphics
local cos = math.cos
local sin = math.sin
local pi = math.pi
local sqrt = math.sqrt
local min = math.min

local images = require "images"

function Waypoint:draw(player)
    local stuff = player.sector:getTargetList(player)

    for i=1,#stuff do

        stuff[i][1] = sqrt(stuff[i][1])

        -- if within 540, we draw it where it is, else we gradually draw it farther and farther away
        if stuff[i][1] < 540 then
            --NOTE I don't think we should mark things that should "be seen" already
            --lg.setColor(60, 100, 255, 200)
            --lg.circle("fill", lg.getWidth()/2 + stuff[i][1]*cos(stuff[i][3] + pi), lg.getHeight()/2 + stuff[i][1]*sin(stuff[i][3] + pi), 5) --TODO replace with target reticule
        else
            -- 0 to infinite, need to inverse
            -- 1 / (stuff[i][1] - 540) * 2550 (at 0, is infinity, at 1, is 2550, at 100 is 1/10th of 255)
            -- was changed to 12800 to make the scaling able to see the first planet on long range
            lg.setColor(200, 100, 80, min(1 / (stuff[i][1] - 540) * 128000, 180)) --NOTE HAVE NO IDEA IF DOING THIS IS RIGHT/WHAT I WANT
            --lg.circle("fill", lg.getWidth()/2 + 240*cos(stuff[i][3] + pi), lg.getHeight()/2 + 240*sin(stuff[i][3] + pi), 3) --TODO replace with target arrow
            images.draw(25, lg.getWidth()/2 + 240*cos(stuff[i][3] + pi), lg.getHeight()/2 + 240*sin(stuff[i][3] + pi), stuff[i][3] - pi/2, 2, 4) --x,y,r,sx,sy (3,3 sx/sy)

            --NOTE DEBUG CIRCLE
            --lg.setColor(255, 200, 100, 255)
            --lg.circle("line", lg.getWidth()/2 + 240*cos(stuff[i][3] + pi), lg.getHeight()/2 + 240*sin(stuff[i][3] + pi), 5)
        end
    end

    -- draw reticule around targeted thing!
    if player.target then
        lg.setColor(10, 200, 220, 230)
        lg.circle("line", player.target.x, player.target.y, 5)
    end
end

return Waypoint
