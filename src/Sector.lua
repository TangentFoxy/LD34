local class = require "lib.middleclass"
local Sector = class("Sector")
local lg = love.graphics

local random = math.random
math.randomseed(os.time())

function Sector:initialize()
    self.targets = {} --none for now
    self.radius = 100 --also temporary static
end

function Sector:enter(player, direction)
    if direction == 10 then     --left
        player.x = -self.radius
        player.y = 0
    elseif direction == 1 then  --right
        player.x = self.radius
        player.y = 0
    elseif direction == 0 then  --up
        player.x = 0
        player.y = -self.radius
    elseif direction == 11 then --down
        player.x = 0
        player.y = self.radius
    end

    table.insert(self.targets, player)
end

function Sector:update(dt)
    --TODO
end

function Sector:draw()
    for i=1,#self.targets do
        lg.setColor(self.targets[i].color)
        --lg.draw(img, self.x, self.y, self.r, 1, 1, 8, 8)
        lg.circle("fill", self.targets[i].x, self.targets[i].y, 5)
    end
end

return Sector
