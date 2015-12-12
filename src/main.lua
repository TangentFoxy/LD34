local World = require "World"
local Player = require "Player"
local lg = love.graphics

local world = World()
local sector = world:getSector(0, 0)
local player = Player()

sector:enter(player, 10) --heading code for left is 10

local time, rate = 0, 0.1
function love.update(dt)
    time = time + dt
    while time >= rate do
        time = time - rate
        sector:update(rate)
    end
end

function love.draw()
    lg.translate(lg.getWidth()/2, lg.getHeight()/2)
    sector:draw()
end

function love.keypressed(key)
    if (key == "0") or (key == "kp0") then
        player:keypressed(0)
    elseif (key == "1") or (key == "kp1") then
        player:keypressed(1)
    elseif key == "escape" then
        love.event.quit()
    end
end

--[[
function love.mousepressed(x, y, button)
    if button == "l" then
        player:keypressed(0)
    elseif button == "r" then
        player:keypressed(1)
    end
end
--]]
