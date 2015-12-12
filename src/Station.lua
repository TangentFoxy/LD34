local class = require "lib.middleclass"
local Station = class("Station")

local random = math.random
math.randomseed(os.time())

function Station:initialize(distance)
    local direction = random(0, math.pi*2)
    self.x = distance * math.cos(direction)
    self.y = distance * math.sin(direction)
    self.heading = 0
    self.color = {random(80, 240), random(80, 240), random(80, 240), 255}
    self.image = 2
end

function Station:update(dt)
    --
end

return Station
