local class = require "lib.middleclass"
local Body = class("Bodies.Body")
local random = math.random

local lume = require "lib.lume"

function Body:initialize()
    -- Basics
    self.type = "Body"
    self.name = random() --TODO make subclasses modify instead of replace this? use uuid in naming? idk
    self.uuid = lume.uuid()
    -- Position
    --TODO make this (sector) actually set for everything!
    self.sector = false --sector this body is in
    self.x = 0
    self.y = 0
    self:setHeading("right") --self.r / self.heading
    -- Movement
    self.throttle = 0
    self.speed = 0
    self.acceleration = 0.032 -- 1 pixel per second^2
    self.maxSpeed = 8         -- 100 pixels per second
    -- Display
    self.color = {random(80, 240), random(80, 240), random(80, 240), 255}
    self.image = 0 --there is no 0 image
    self.sx = 1
    self.sy = 1
    -- References/Contains
    self.target = false --would be reference to targeted body
        --NOTE POTENTIAL BUG:
        -- if something is targeting something and it leaves the sector, it is still targeted!
    self.communication = false
    self.commsHistory = {}
    --[[
    self.modules = {} --these modify capabilities
    self.storage = {
        items = {},
        volume = 0,
        maxVolume = 100
    }
    --]]
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
    --NOTE this part is lazy for randomization, used with debris
    --[[ NOTE NOT USED ACTUALLY
    if direction == 0 then
        self.r = math.pi/2
        self.heading = 10
    elseif direction == 1 then
        self.r = -math.pi/2
        self.heading = 1
    elseif direction == 2 then
        self.r = math.pi
        self.heading = 0
    elseif direction == 3 then
        self.r = 0
        self.heading = 11
    end
    --]]
end

return Body
