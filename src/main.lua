local lg = love.graphics
local Player = require "Player"
local Enemy = require "Enemy"

local player = Player()
local enemy = Enemy()

function love.update(dt)
    --
end

function love.draw()
    enemy:draw()
    player:draw()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

--[[
    0 and 1
    AND / OR / XOR / NOT

    0 0 0
    0 0 1

    0 1 0
    0 1 1

    1 0 0
    1 0 1

    1 1 0
    1 1 1 

    + next, - next, jump if equal, set next, get next
]]
