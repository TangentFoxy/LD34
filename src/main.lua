local lg = love.graphics
local Player = require "Player"

local players = {}
local shots = {}

table.insert(players, Player())
table.insert(players, Player())

local time, rate = 0, 0.1
function love.update(dt)
    time = time + dt
    while time >= rate do
        time = time - rate
        update()
    end
end

function love.draw()
    for i=1,#players do
        players[i]:draw()
    end
    for i=1,#shots do
        shots[i]:draw()
    end
end

function love.keypressed(key)
    if key == "w" then
        --player 1 fired
    elseif key == "s" then
        --player 1 moved
    elseif key == "up" then
        --player 2 fired
    elseif key == "down" then
        --player 2 moved
    elseif key == "escape" then
        love.event.quit()
    end
end

--[[
    1 1 0
     0 1 0
     0 1 0

    A B C (A is left/right) (B is up/down) (C is fuck off)
]]
