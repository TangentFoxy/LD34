local class = require "lib.middleclass"
local Sector = class("Sector")

local insert = table.insert
local remove = table.remove

local cron = require "lib.cron"

function Sector:initialize(world, x, y)
    self.type = "Sector"
    self.world = world
    self.x = x
    self.y = y

    self.bodies = {}
    self.player = false --player body when player is in sector

    self.jobs = {} --timed things to do

    --TODO GENERATE STUFF
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
end

function Sector:draw()
    --
end

function Sector:getRelativeSector(x, y)
    return self.world:getSector(self.x + x, self.y + y)
end

function Sector:enter(body, isPlayer)
    body.sector = self

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

function Sector:after(time, fn)
    local job = cron.after(time, fn)
    self.jobs[job] = job
end

function Sector:cancel(job)
    self.jobs[job] = nil
end

return Sector
