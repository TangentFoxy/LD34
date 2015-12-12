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
    sector:draw()
    player:drawModules()
end

function love.keypressed(key)
    if (key == "0") or (key == "kp0") then
        player:opcode("0")
    elseif (key == "1") or (key == "kp1") then
        player:opcode("1")
    elseif key == "escape" then
        love.event.quit() --TODO pause menu instead of quit
    end
end

--[[
function love.mousepressed(x, y, button)
    if button == "l" then
        player:opcode("0")
    elseif button == "r" then
        player:opcode("1")
    end
end
--]]
