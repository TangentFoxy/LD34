local class = require "lib.middleclass"
local Body = require "Bodies.Body"
local Debris = class("Bodies.Debris", Body)

local random = math.random

--TODO Debris is made FROM something, and has to know how much debris is being
--     generated so it doesn't duplicate any physical thing stored onboard
-- (there is a note on an issue about how to do this, using explosion bodies as
--  a surrogate)
function Debris:initialize(range)
    Body.initialize(self)
    self.type = "Debris"
    self.name = self.name .. " (Debris)"

    local direction = random()*math.pi*2
    local distance = random(0, range)
    self.x = distance * math.cos(direction)
    self.y = distance * math.sin(direction)

    self.image = random(19, 20)
    self.sx = random(2, 7)
    self.sy = random(2, 7)

    self.r = random()*math.pi*2
end

return Debris
