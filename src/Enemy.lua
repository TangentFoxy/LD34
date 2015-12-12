local class = require "lib.middleclass"
local Enemy = class("Enemy")
local lg = love.graphics

local img = lg.newImage("img/lil.png")

function Enemy:initialize()
    self.x = lg.getWidth()*4/5
    self.y = lg.getHeight()/2
    self.r = 0
end

function Enemy:draw()
    lg.setColor(255, 55, 25, 255)
    lg.draw(img, self.x, self.y, self.r, 1, 1, 8, 8)
end

return Enemy
