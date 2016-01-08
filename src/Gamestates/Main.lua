local World = require "World"
local Player = require "Bodies.Player"

local world, player

local Main = {}

function Main:init()
    player = Player()
    world = World()

    world:getSector(0, 0):enter(player, true)
end

local time, rate = 0, 1/60
function Main:update(dt)
    time = time + dt
    while time >= rate do
        time = time - rate
        world:update(dt)
    end
end

function Main:draw()
    world:draw()
end

function Main:keypressed(key)
    ---[[
    if (key == "0") or (key == "kp0") then
        player:input("0")
    elseif (key == "1") or (key == "kp1") then
        player:input("1")
    elseif key == "escape" then
        love.event.quit()
    end
    --]]
    --[[ TODO switch to this for input
    if key == "escape" then
        love.event.quit()
    else
        player:key(key)
    end
    ]]
end

--[[
function Main:mousepressed(x, y, button)
    if button == "l" then
        player:opcode("0")
    elseif button == "r" then
        player:opcode("1")
    end
end
--]]

return Main
