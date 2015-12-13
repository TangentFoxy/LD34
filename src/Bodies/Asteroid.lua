local class = require "lib.middleclass"
local Body = require "Bodies.Body"
local Asteroid = class("Bodies.Asteroid", Body)

local random = math.random

function Asteroid:initialize(range)
    Body.initialize(self)
    self.type = "Asteroid"

    local direction = random(0, math.pi*2)
    local distance = random(0, range)
    self.x = distance * math.cos(direction)
    self.y = distance * math.sin(direction)

    self.image = random(10, 17)
    self.sx = random(2, 11)
    --self.sy = self.sx
    self.sy = random(2, 11)

    self.r = random(0, math.pi*2)
end

return Asteroid
