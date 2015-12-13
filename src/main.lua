math.randomseed(os.time())
local World = require "World"
local Player = require "Bodies.Player"

local player = Player()
local world = World()

local start = world:getSector(0, 0)
start:enter(player, true)

local time, rate = 0, 0.016
function love.update(dt)
    time = time + dt
    while time >= rate do
        time = time - rate
        world:update(dt)
    end
end

function love.draw()
    world:draw()
end

function love.keypressed(key)
    if (key == "0") or (key == "kp0") then
        player:opcode("0")
    elseif (key == "1") or (key == "kp1") then
        player:opcode("1")
    elseif key == "escape" then
        love.event.quit()
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
