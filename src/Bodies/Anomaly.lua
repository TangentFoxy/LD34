local class = require "lib.middleclass"
local Body = require "Bodies.Body"
local Anomaly = class("Bodies.Anomaly", Body)

local random = math.random

function Anomaly:initialize(range)
    Body.initialize(self)
    self.type = "Anomaly"

    local direction = random(0, math.pi*2)
    local distance = random(0, range)
    self.x = distance * math.cos(direction)
    self.y = distance * math.sin(direction)

    self.image = random(7, 9)
    self.sx = random(2, 21)
    self.sy = self.sx

    self.r = random(0, math.pi*2)
end

return Anomaly
