local class = require "lib.middleclass"
local Player = class("Player")
local lg = love.graphics

local random = math.random
math.randomseed(os.time())

function Player:initialize()
    self.x = 0
    self.y = 0
    self.r = 0
    self.color = {random(80, 240), random(80, 240), random(80, 240), 255}
end

return Player
