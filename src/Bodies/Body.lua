local class = require "lib.middleclass"
local Body = class("Bodies.Body")
local random = math.random

function Body:initialize()
    self.type = "Body"
    self.name = random()

    self.x = 0
    self.y = 0

    self.sector = false --sector this body is in
    --self.target

    self.color = {random(80, 240), random(80, 240), random(80, 240), 255}
    self.image = 0 --there is no 0 image
    self.sx = 1
    self.sy = 1

    self:setHeading("right") --self.r / self.heading

    self.throttle = 0
    self.speed = 0
    self.acceleration = 0.032 -- 1 pixel per second^2
    self.maxSpeed = 8         -- 100 pixels per second
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

function Body:setHeading(direction)
    if direction == "left" then
        self.r = math.pi/2
        self.heading = 10
    elseif direction == "right" then
        self.r = -math.pi/2
        self.heading = 1
    elseif direction == "up" then
        self.r = math.pi
        self.heading = 0
    elseif direction == "down" then
        self.r = 0
        self.heading = 11
    end
end

--IDEA setRandomHeading() will randomly choose an r value and set heading to 2
-- (2 being a special value meaning "no heading") ?
--  I don't think I need to worry about heading being 2, but check anyhow.
--   (Heading being 2 will just make it impossible to move, because the update
--    code is based on heading.)

return Body
