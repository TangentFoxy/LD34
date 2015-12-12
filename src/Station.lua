local class = require "lib.middleclass"
local Body = require "Body"
local Station = class("Station", Body)

local random = math.random
math.randomseed(os.time())

function Station:initialize(distance)
    Body.initialize(self)

    local direction = random(0, math.pi*2)
    self.x = distance * math.cos(direction)
    self.y = distance * math.sin(direction)
    self.image = 2
end

return Station
