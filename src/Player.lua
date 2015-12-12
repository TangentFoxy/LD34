local class = require "lib.middleclass"
local Player = class("Player")
local lg = love.graphics

local img = lg.newImage("img/lil.png")

function Player:initialize()
    self.x = lg.getWidth()*1/5
    self.y = lg.getHeight()/2
    self.r = 0
end

function Player:draw()
    lg.setColor(200, 140, 105, 255)
    lg.draw(img, self.x, self.y, self.r, 1, 1, 8, 8)
end

return Player
