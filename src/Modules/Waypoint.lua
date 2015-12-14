local class = require "lib.middleclass"
local Module = require "Modules.Module"
local Waypoint = class("Modules.Waypoint", Module)
local lg = love.graphics
local cos = math.cos
local sin = math.sin
local pi = math.pi
local sqrt = math.sqrt
local min = math.min

local images = require "images"

function Waypoint:initialize()
    Module.initialize(self)

    self.time = 0
    self.angle = 0
end

local rate = 1
function Waypoint:update(dt)
    self.time = self.time + dt
    while self.time >= rate do
        self.time = self.time - rate

        self.angle = self.angle + pi/4
        if self.angle > pi then
            self.angle = pi/4
        end
    end
end

function Waypoint:draw(player)
    local stuff = player.sector:getTargetList(player)

    for i=1,#stuff do

        stuff[i][1] = sqrt(stuff[i][1])

        if stuff[i][1] > 540 then
            -- 1 / (stuff[i][1] - 540) * 2550 (at 0, is infinity, at 1, is 2550, at 100 is 1/10th of 255)
            -- was changed to 12800 to make the scaling able to see the first planet on long range
            lg.setColor(200, 100, 80, min(1 / (stuff[i][1] - 540) * 128000, 180)) --NOTE HAVE NO IDEA IF DOING THIS IS RIGHT/WHAT I WANT
            images.draw(25, lg.getWidth()/2 + 240*cos(stuff[i][3] + pi), lg.getHeight()/2 + 240*sin(stuff[i][3] + pi), stuff[i][3] - pi/2, 2, 4) -- scale is 2x4y on purpose
        end
    end

    -- draw reticule around targeted thing!
    if player.target and not (player.target.type == "Sector") then
        lg.setColor(220, 200, 0, 230)
        local scale = (player.target.sx + player.target.sy) / 2
        images.draw(26, player.target.x - player.x + lg.getWidth()/2, player.target.y - player.y + lg.getHeight()/2, self.angle, scale, scale)
    end
end

return Waypoint
