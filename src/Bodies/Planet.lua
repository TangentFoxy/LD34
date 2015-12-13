local class = require "lib.middleclass"
local Body = require "Bodies.Body"
local Planet = class("Bodies.Planet", Body)

local random = math.random

function Planet:initialize(distance)
    Body.initialize(self)
    self.type = "Planet"

    local direction = random(0, math.pi*2)
    self.x = distance * math.cos(direction)
    self.y = distance * math.sin(direction)
    self.image = random(4, 6)
    self.heading = 11
end

return Planet
