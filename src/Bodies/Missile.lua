local class = require "lib.middleclass"
local Body = require "Bodies.Body"
local Missile = class("Bodies.Missile", Body)

local random = math.random

function Missile:initialize(x, y, target)
    Body.initialize(self)
    self.type = "Missile"
    self.name = self.name .. " (Missile)"

    self.x = x
    self.y = y

    --self.color = {255, 255, 255, 255} --maybe missiles should have color too!
    self.image = 18
    self.sx = random(2, 3) --TODO SIZE SHOULD NOT BE RANDOM, BUT DETERMINED
    self.sy = self.sx

    self.target = target
    --set r to match aiming at target
end

--TODO write custom update that handles this freeform instead of locked to axis, goes straight for target

return Missile
