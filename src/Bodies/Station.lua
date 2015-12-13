local class = require "lib.middleclass"
local Body = require "Bodies.Body"
local Station = class("Bodies.Station", Body)

local random = math.random

function Station:initialize(distance)
    Body.initialize(self)
    self.type = "Station"

    local direction = random(0, math.pi*2)
    self.x = distance * math.cos(direction)
    self.y = distance * math.sin(direction)

    self.image = 2
    self.sx = random(3, 5)
    self.sy = self.sx
end

return Station
