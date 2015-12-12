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
    lg.setColor(255, 255, 255, 200)
    lg.line(-10, 0, 10, 0)
    lg.line(0, -10, 0, 10)
end

function love.keypressed(key)
    if key == "0" then
        --
    elseif key == "1" then
        --
    elseif key == "escape" then
        love.event.quit()
    end
end
