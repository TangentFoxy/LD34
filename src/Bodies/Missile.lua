local class = require "lib.middleclass"
local Body = require "Bodies.Body"
local Missile = class("Bodies.Missile", Body)

local random = math.random

--TODO NEW PARAMETERS: source, target
-- source is what fired it (it pulls the heading, r, x, y, speed, from this)
-- target is what its aiming at (and thus controls heading code)
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
    --set r to match aiming at target (NO, angle should be based on heading at the start)
    -- (missiles are launched straight but can curve)
    --TODO set heading to 2 for 'custom heading'?

    -- missiles are faster than the player
    self.throttle = 9.2
    self.speed = 0            -- TODO start with a speed boost (EDIT TO BE BASED ON WHAT LAUNCHED IT!!)
    self.acceleration = 0.052 -- (a little faster than) 1 pixel per second^2
    self.maxSpeed = 9.2       -- 100 pixels per second
end

--TODO write custom update that handles this freeform instead of locked to axis, goes straight for target
---[[
function Missile:update(dt)
    -- accelerate as needed
    if self.throttle > self.speed then
        self.speed = self.speed + self.acceleration
        if self.speed > self.throttle then
            self.speed = self.throttle
        end
    elseif self.throttle < self.speed then
        self.speed = self.speed - self.acceleration
        if self.speed < self.throttle then
            self.speed = self.throttle
        end
    end

    -- now move somewhere
    --TODO get angle to target, change our angle by max(angle between us an angle to target, 10 degrees)
    --TODO apply speed to x/y position based on angle we're moving at
    --TODO if colliding with target, detonate (Explosion())
end
--]]

return Missile
