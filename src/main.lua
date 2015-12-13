local World = require "World"
local Player = require "Bodies.Player"
local lg = love.graphics

math.randomseed(os.time())

local world = World()
local sector = world:getSector(0, 0)
local player = Player()

world:changeSector(player, 10, 0, 0) --heading code for left is 10 (we "came" from the left)

local time, rate = 0, 0.016
function love.update(dt)
    time = time + dt
    while time >= rate do
        time = time - rate
        world.current:update(rate)
    end
end

function love.draw()
    world.current:draw()
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
