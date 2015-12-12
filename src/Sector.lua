local class = require "lib.middleclass"
local Sector = class("Sector")
local lg = love.graphics

local random = math.random
math.randomseed(os.time())

function Sector:initialize(world, x, y)
    self.world = world
    self.x = x
    self.y = y
    self.targets = {} --NOTE none for now
    self.radius = 100 --NOTE also temporary static
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

    player.sector = self

    table.insert(self.targets, player)
end

function Sector:update(dt)
    for i=1,#self.targets do
        self.targets[i]:update(dt)
    end
end

lg.setDefaultFilter("nearest", "nearest", 1)
local shuttle = lg.newImage("img/shuttle-alpha.png")
local station = lg.newImage("img/station-alpha.png")
--NOTE EVERYTHING IS A SHUTTLE, FIX THIS SHIT
--NOTE WE GONNA NEED WAYPOINT INDICATOR / THINGS WHEN STUFF IS OFF SCREEN
function Sector:draw()
    for i=1,#self.targets do
        --lg.setColor(self.targets[i].color) --bring this back!
        if self.targets[i].heading == 10 then
            lg.draw(shuttle, self.targets[i].x, self.targets[i].y, math.pi/2, 3, 3, 7, 7)
        elseif self.targets[i].heading == 1 then
            lg.draw(shuttle, self.targets[i].x, self.targets[i].y, -math.pi/2, 3, 3, 7, 7)
        elseif self.targets[i].heading == 0 then
            lg.draw(shuttle, self.targets[i].x, self.targets[i].y, math.pi, 3, 3, 7, 7)
        elseif self.targets[i].heading == 11 then
            lg.draw(shuttle, self.targets[i].x, self.targets[i].y, 0, 3, 3, 7, 7)
        end
        lg.circle("fill", self.targets[i].x, self.targets[i].y, 5)
    end
end

function Sector:getTarget(player, selection)
    --TODO needs to parse targets to find closest "selection" # of targets, and return # "selection"
end

function Sector:getSector(x, y)
    return self.world:getSector(self.x + x, self.y + y)
end

return Sector
