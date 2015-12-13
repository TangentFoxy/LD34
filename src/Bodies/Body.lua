local class = require "lib.middleclass"
local Body = class("Body")

local random = math.random

function Body:initialize()
    self.type = "Body"

    self.x = 0
    self.y = 0
    self.sector = false --only used in Player (NOTE then why is it here instead of in player? in case I need it, duh)
    self.image = 0      --TODO add error image (so it won't just crash)

    self.color = {random(80, 240), random(80, 240), random(80, 240), 255}

    self.target = false --object, either a sector or local target

    self.heading = 1    --right is 1 (see heading codes)
    self.throttle = 0

    self.speed = 0
    self.acceleration = 0.032 -- 1 pixel per second^2
    self.maxSpeed = 8        -- 100 pixels per second
end

function Body:update(dt)
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
    if self.heading == 10 then
        self.x = self.x - self.speed
    elseif self.heading == 1 then
        self.x = self.x + self.speed
    elseif self.heading == 0 then
        self.y = self.y - self.speed
    elseif self.heading == 11 then
        self.y = self.y + self.speed
    end
end

return Body
