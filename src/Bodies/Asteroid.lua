local class = require "lib.middleclass"
local Body = require "Bodies.Body"
local Asteroid = class("Bodies.Asteroid", Body)

local random = math.random
local name = require "lib.name"

function Asteroid:initialize(range)
    Body.initialize(self)
    self.type = "Asteroid"
    self.name = "Asteroid " .. name.generate(1, 2):upper() .. "-" .. random(11, 99)

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
