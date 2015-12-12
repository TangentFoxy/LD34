local class = require "lib.middleclass"
local Player = class("Player")
local lg = love.graphics

local random = math.random
math.randomseed(os.time())

local img = lg.newImage("img/lil.png")

function Player:initialize(warpSpeed)
    self.x = lg.getWidth()*1/5
    self.y = lg.getHeight()/2
    self.r = 0
    self.color = {random(80, 240), random(80, 240), random(80, 240)}
    self.cooldown = 0
    self.warpRandomizer = love.math.newRandomGenerator(warpSpeed)
end

function Player:update(dt)
    self.cooldown = self.cooldown - dt
end

function Player:draw()
    lg.setColor(unpack(self.color), 255)
    lg.draw(img, self.x, self.y, self.r, 1, 1, 8, 8)
end

function Player:warp(ex, ey)
    if self.cooldown <= 0 then
        local x, y = self.warpRandomizer(lg.getWidth()), self.warpRandomizer(lg.getHeight())
        self.x = x
        self.y = y
        self.cooldown = 4

        -- ex/ey are an enemy to turn and face!
    end
end

return Player
