local class = require "lib.middleclass"
local Body = require "Bodies.Body"
local Debris = class("Bodies.Debris", Body)

local random = math.random

function Debris:initialize(range)
    Body.initialize(self)
    self.type = "Debris"

    local direction = random(0, math.pi*2)
    local distance = random(0, range)
    self.x = distance * math.cos(direction)
    self.y = distance * math.sin(direction)

    self.image = random(19, 20)
    self.sx = random(2, 7)
    self.sy = self.sx

    self.r = random(0, math.pi*2)
end

return Debris
