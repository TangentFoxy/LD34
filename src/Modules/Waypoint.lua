local class = require "lib.middleclass"
local Waypoint = class("Modules.Waypoint")
local lg = love.graphics
local cos = math.cos
local sin = math.sin
local pi = math.pi
local sqrt = math.sqrt
local min = math.min

function Waypoint:draw(player)
    --first check 2nd to last ophistory, if it sets target or heading mode, use last 2 ophistory in this manner,
    -- ELSE use last ophistory only
    local stuff = player.sector:getTargetList(player)

    lg.setColor(160, 30, 0, 180)

    for i=1,#stuff do
        --lg.circle("fill", lg.getWidth()/2 + 100*math.cos(stuff[i][3] + math.pi), lg.getHeight()/2 + 100*math.sin(stuff[i][3] + math.pi), 5)

        stuff[i][1] = sqrt(stuff[i][1])
        -- if within 540, we draw it where it is, else we gradually draw it farther and farther away
        if stuff[i][1] < 540 then
            --lg.setColor(60, 100, 255, 200)
            --lg.circle("fill", lg.getWidth()/2 + stuff[i][1]*cos(stuff[i][3] + pi), lg.getHeight()/2 + stuff[i][1]*sin(stuff[i][3] + pi), 5) --TODO replace with target reticule
        else
            -- 0 to infinite, need to inverse
            -- 1 / (stuff[i][1] - 540) * 2550 (at 0, is infinity, at 1, is 2550, at 100 is 1/10th of 255)
            -- was changed to 12800 to make the scaling able to see the first planet on long range
            lg.setColor(200, 100, 80, min(1 / (stuff[i][1] - 540) * 128000, 180)) --NOTE HAVE NO IDEA IF DOING THIS IS RIGHT/WHAT I WANT
            lg.circle("fill", lg.getWidth()/2 + 240*cos(stuff[i][3] + pi), lg.getHeight()/2 + 240*sin(stuff[i][3] + pi), 3) --TODO replace with target arrow

            --NOTE DEBUG CIRCLE
            --lg.setColor(255, 200, 100, 255)
            --lg.circle("line", lg.getWidth()/2 + 240*cos(stuff[i][3] + pi), lg.getHeight()/2 + 240*sin(stuff[i][3] + pi), 5)
        end
    end
end

return Waypoint
