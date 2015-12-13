local class = require "lib.middleclass"
local Sector = class("Sector")
local lg = love.graphics
local random = math.random

local images = require "images"
local cron = require "lib.cron"

local Station = require "Bodies.Station"
local Star = require "Bodies.Star"
local Planet = require "Bodies.Planet"

function Sector:initialize(world, x, y)
    self.world = world
    self.x = x
    self.y = y
    self.player = false --ref to player if in sector

    self.type = "Sector" --for targeting purposes

    --NOTE TEMPORARY, LATER WILL BE GENRATED
    self.background = {}
    self.background[1] = Star(500)
    self.targets = {}
    self.targets[1] = Station(100)
    self.targets[2] = Planet(2000)
    self.radius = 200

    self.jobs = {}
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

function Sector:changeSector(x, y)
    local direction

    if x == -1 then --GOING left
        direction = 1
    elseif x == 1 then --GOING right
        direction = 10
    elseif y == -1 then --GOING up
        direction = 11
    elseif y == 1 then --GOING down
        direction = 0
    end

    self.world:changeSector(self.player, direction, self.x + x, self.y + y)
    --self.player = false
end

function Sector:update(dt)
    for i=#self.jobs,1,-1 do
        if self.jobs[i]:update(dt) then
            table.remove(self.jobs, i)
        end
    end

    for i=1,#self.targets do
        self.targets[i]:update(dt)
    end
    self.player:update(dt)
end

function Sector:draw()
    lg.translate(lg.getWidth()/2, lg.getHeight()/2)

    for i=1,#self.background do
        lg.setColor(self.background[i].color)
        images.draw(self.background[i].image, self.background[i].x - (self.player.x/20), self.background[i].y - (self.player.y/20), self.background[i].r)
    end

    lg.translate(-self.player.x, -self.player.y)

    for i=1,#self.targets do
        if self.targets[i].type == "Planet" then
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
    end

    for i=1,#self.targets do
        if not (self.targets[i].type == "Planet") then
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

    lg.translate(self.player.x, self.player.y)
    lg.translate(-lg.getWidth()/2, -lg.getHeight()/2)
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

--[[
function Sector:getSector(x, y)
    --return self.world:getSector(self.x + x, self.y + y)
    return {self.x + x, self.y + y, type = "SectorCoords"}
end
--]]

return Sector
