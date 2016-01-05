local class = require "lib.middleclass"
local Sector = class("Sector")
local lg = love.graphics
local insert = table.insert
local remove = table.remove
local sort = table.sort
local random = math.random

local images = require "images"
local cron = require "lib.cron"

local Station = require "Bodies.Station"
local Star = require "Bodies.Star"
local Planet = require "Bodies.Planet"
local Anomaly = require "Bodies.Anomaly"
local Asteroid = require "Bodies.Asteroid"
local Debris = require "Bodies.Debris"
local Missile = require "Bodies.Missile" --NOTE probably not going to generate missiles in sectors!!

local Special = {
    [0] = {
        [0] = {
            background = function()
                return {
                    Star(500)
                }
            end,
            bodies = function()
                return {
                    Station(100, "start"),
                    Planet(2000)
                }
            end,
            radius = 200
        }
    }
}

--TODO use lume.weightedchoice to give these percentages of chance
local Templates = {
    {   -- nothingness
        background = function() return {} end,
        bodies = function() return {} end,
        radius = 0
    },
    {   -- two stars & a planet
        background = function()
            return {
                Star(10),
                Star(1000)
            }
        end,
        bodies = function() return {Planet(1000)} end,
        radius = 400
    },
    {
        --debris field
        background = function() return {} end,
        bodies = function()
            local result = {}

            for i=1,100 do
                insert(result, Debris(1000))
            end

            return result
        end,
        radius = 700
    }
}

function Sector:initialize(world, x, y)
    self.type = "Sector"
    self.world = world
    self.x = x
    self.y = y

    self.background = {}
    self.bodies = {}
    self.player = false --player body when player is in sector

    self.jobs = {} --timed things to do

    if Special[x] and Special[x][y] then
        self.background = Special[x][y].background()
        self.bodies = Special[x][y].bodies()
        self.radius = Special[x][y].radius
    else
        local template = random(1, #Templates)
        self.background = Templates[template].background()
        self.bodies = Templates[template].bodies()
        self.radius = Templates[template].radius
    end

    --[[
    --TODO GENERATE STUFF
    self.background[1] = Star(500)
    self.bodies[1] = Station(100)
    self.bodies[2] = Planet(2000)
    self.radius = 200

    --NOTE throwing random shit in to test things!
    for i=1,30 do
        --insert(self.bodies, Anomaly(500))
        insert(self.bodies, Asteroid(1500))
        --insert(self.bodies, Debris(500))
        --insert(self.bodies, Missile(random(-500, 500), random(-250, 250)))
    end
    --insert(self.bodies, Planet(300))
    --]]
end

function Sector:update(dt)
    local remove = {} --jobs to be removed

    -- execute jobs
    for key,job in pairs(self.jobs) do
        if job:update(dt) then
            remove[key] = true
        end
    end

    -- remove expired jobs
    for key,_ in pairs(remove) do
        self.jobs[key] = nil
    end

    -- update all bodies (and player)
    for i=1,#self.bodies do
        self.bodies[i]:update(dt)
    end

    if self.player then
        self.player:update(dt)
    end
end

function Sector:draw()
    lg.translate(lg.getWidth()/2, lg.getHeight()/2)

    for i=1,#self.background do
        lg.setColor(self.background[i].color)
        images.draw(self.background[i].image, self.background[i].x - (self.player.x/12), self.background[i].y - (self.player.y/12), self.background[i].r, self.background[i].sx, self.background[i].sy)
    end

    lg.translate(-self.player.x, -self.player.y)

    local layers = {"Anomaly", "Planet", "Asteroid", "Station", "Debris", "Missile"}

    for j=1,#layers do
        for i=1,#self.bodies do
            if self.bodies[i].type == layers[j] then
                lg.setColor(self.bodies[i].color)
                images.draw(self.bodies[i].image, self.bodies[i].x, self.bodies[i].y, self.bodies[i].r, self.bodies[i].sx, self.bodies[i].sy)
            end
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

--NOTE non-player bodies should get targetDirection in the future
function Sector:enter(body, isPlayer)
    body.sector = self
    body.target = false -- don't target a sector you're in (or a body in another sector)

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

function Sector:getTargetList(body)
    local closest = {} --IDs and distances (squared)

    for i=1,#self.bodies do
        local x = body.x - self.bodies[i].x
        local y = body.y - self.bodies[i].y
        insert(closest, {x*x+y*y, i, math.atan2(y, x)})
    end

    sort(closest, function(a,b) return (a[1] < b[1]) end)

    return closest
end

--NOTE can return false
function Sector:getLocalTarget(body, selection)
    local closest = self:getTargetList(body)

    if body == self.player then
        if closest[selection+1] then
            return self.bodies[closest[selection+1][2]]
        end
    else
        if closest[selection+2] then
            return self.bodies[closest[selection+2][2]] --plus 2 so we exclude ourselves at distance zero
        end
    end

    return false
end

function Sector:after(time, fn)
    local job = cron.after(time, fn)
    self.jobs[job] = job
    return job
end

function Sector:cancel(job)
    self.jobs[job] = nil
end

return Sector
