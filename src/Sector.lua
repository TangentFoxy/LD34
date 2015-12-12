local class = require "lib.middleclass"
local Sector = class("Sector")
local lg = love.graphics

local images = require "images"
local Station = require "Station"

local random = math.random
math.randomseed(os.time())

function Sector:initialize(world, x, y)
    self.world = world
    self.x = x
    self.y = y
    self.player = false --ref to player if in sector

    --NOTE TEMPORARY, LATER WILL BE GENRATED
    self.targets = {}
    self.targets[1] = Station(50)
    self.radius = 100
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
    self.player = player
end

function Sector:update(dt)
    for i=1,#self.targets do
        self.targets[i]:update(dt)
    end
    self.player:update(dt)
end

--NOTE WE GONNA NEED WAYPOINT INDICATOR / THINGS WHEN STUFF IS OFF SCREEN
function Sector:draw()
    lg.translate(lg.getWidth()/2, lg.getHeight()/2) --TODO change to be based on actual position

    for i=1,#self.targets do
        lg.setColor(self.targets[i].color)
        if self.targets[i].heading == 10 then
            images.draw(self.targets[i].image, self.targets[i].x, self.targets[i].y, math.pi/2)
        elseif self.targets[i].heading == 1 then
            images.draw(self.targets[i].image, self.targets[i].x, self.targets[i].y, -math.pi/2)
        elseif self.targets[i].heading == 0 then
            images.draw(self.targets[i].image, self.targets[i].x, self.targets[i].y, math.pi)
        elseif self.targets[i].heading == 11 then
            images.draw(self.targets[i].image, self.targets[i].x, self.targets[i].y, 0)
        end
    end

    lg.setColor(self.player.color)
    if self.player.heading == 10 then
        images.draw(self.player.image, self.player.x, self.player.y, math.pi/2)
    elseif self.player.heading == 1 then
        images.draw(self.player.image, self.player.x, self.player.y, -math.pi/2)
    elseif self.player.heading == 0 then
        images.draw(self.player.image, self.player.x, self.player.y, math.pi)
    elseif self.player.heading == 11 then
        images.draw(self.player.image, self.player.x, self.player.y, 0)
    end

    lg.translate(-lg.getWidth()/2, -lg.getHeight()/2) --TODO match with top, undo top's translation
end

function Sector:getTarget(player, selection)
    local closest = {} --IDs and distances (squared)

    for i=1,#self.targets do
        local x = player.x - self.targets[i].x
        local y = player.y - self.targets[i].y
        table.insert(closest, {x*x+y*y, i}) -- {distance, id}
    end

    table.sort(closest, function(a,b) return (a[1] < b[1]) end)

    return self.targets[closest[selection+1][2]] -- return target at selection of closest's ID (convoluted!)
end

function Sector:getSector(x, y)
    return self.world:getSector(self.x + x, self.y + y)
end

return Sector
