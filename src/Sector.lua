local class = require "lib.middleclass"
local Sector = class("Sector")
local lg = love.graphics
local insert = table.insert
local remove = table.remove
local sort = table.sort

local images = require "images"
local cron = require "lib.cron"

local Station = require "Bodies.Station"
local Star = require "Bodies.Star"
local Planet = require "Bodies.Planet"

function Sector:initialize(world, x, y)
    self.type = "Sector"
    self.world = world
    self.x = x
    self.y = y

    self.background = {}
    self.bodies = {}
    self.player = false --player body when player is in sector

    self.jobs = {} --timed things to do

    --TODO GENERATE STUFF
    self.background[1] = Star(500)
    self.bodies[1] = Station(100)
    self.bodies[2] = Planet(2000)
    self.radius = 200
end

function Sector:update(dt)
    local remove = {} --jobs to be removed

    -- execute jobs
    for key,job in pairs(self.jobs) do
        if job:update(dt) then
            remove[key] = true
        end
    end

    -- now actually remove the expired ones
    for key,_ in pairs(remove) do
        self.jobs[key] = nil
    end

    -- update all bodies (and player)
    for i=1,#self.bodies do
        self.bodies[i]:update(dt)
    end
    self.player:update(dt)
end

function Sector:draw()
    lg.translate(lg.getWidth()/2, lg.getHeight()/2)

    for i=1,#self.background do
        lg.setColor(self.background[i].color)
        images.draw(self.background[i].image, self.background[i].x - (self.player.x/12), self.background[i].y - (self.player.y/12), self.background[i].r, self.background[i].sx, self.background[i].sy)
    end

    lg.translate(-self.player.x, -self.player.y)

    for i=1,#self.bodies do
        if self.bodies[i].type == "Planet" then
            lg.setColor(self.bodies[i].color)
            images.draw(self.bodies[i].image, self.bodies[i].x, self.bodies[i].y, self.bodies[i].r, self.bodies[i].sx, self.bodies[i].sy)
        end
    end

    for i=1,#self.bodies do
        if not (self.bodies[i].type == "Planet") then
            lg.setColor(self.bodies[i].color)
            images.draw(self.bodies[i].image, self.bodies[i].x, self.bodies[i].y, self.bodies[i].r, self.bodies[i].sx, self.bodies[i].sy)
        end
    end

    lg.setColor(self.player.color)
    images.draw(self.player.image, self.player.x, self.player.y, self.player.r, self.player.sx, self.player.sy)

    lg.translate(self.player.x, self.player.y)
    lg.translate(-lg.getWidth()/2, -lg.getHeight()/2)

    self.player:drawModules()
end

function Sector:getRelativeSector(x, y)
    return self.world:getSector(self.x + x, self.y + y)
end

function Sector:enter(body, isPlayer)
    body.sector = self
    if body.targetDirection == "up" then
        body:setHeading("up")
        body.x = 0
        body.y = self.radius
    elseif body.targetDirection == "left" then
        body:setHeading("left")
        body.x = self.radius
        body.y = 0
    elseif body.targetDirection == "right" then
        body:setHeading("right")
        body.x = -self.radius
        body.y = 0
    elseif body.targetDirection == "down" then
        body:setHeading("down")
        body.x = 0
        body.y = -self.radius
    else
        body:setHeading("right")
        body.x = -self.radius
        body.y = 0
    end

    if isPlayer then
        self.player = body
        self.world:changeSector(self.x, self.y)
    else
        insert(self.bodies, body)
    end
end

function Sector:leave(body, isPlayer)
    body.sector = false

    if isPlayer then
        self.player = false
    else
        for i=1,#self.bodies do
            if self.bodies[i] == body then
                remove(self.bodies, i)
                break
            end
        end
    end
end

--NOTE will break if less than 5 bodies in a sector (if you try to grab 3rd for example, when you are the "5th" item, will grab a nil, or crash)
function Sector:getLocalTarget(body, selection)
    local closest = {} --IDs and distances (squared)

    for i=1,#self.bodies do
        local x = body.x - self.bodies[i].x
        local y = body.y - self.bodies[i].y
        insert(closest, {x*x+y*y, i})
    end

    sort(closest, function(a,b) return (a[1] < b[1]) end)

    if body == self.player then
        return self.bodies[closest[selection+1][2]]
    else
        return self.bodies[closest[selection+2][2]] --plus 2 so we exclude ourselves at distance zero
    end
end

function Sector:after(time, fn)
    local job = cron.after(time, fn)
    self.jobs[job] = job
end

function Sector:cancel(job)
    self.jobs[job] = nil
end

return Sector
