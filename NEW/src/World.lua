local class = require "lib.middleclass"
local World = class("World")

local Sector = require "Sector"

function World:initialize()
    --self.type = "World"
    self.sectors = {}
    self.current = self:getSector(0, 0)
end

function World:getSector(x, y)
    if not self.sectors[x] then
        self.sectors[x] = {}
    end
    if not self.sectors[x][y] then
        self.sectors[x][y] = Sector(self, x, y)
    end

    return self.sectors[x][y]
end

function World:changeSector(x, y)
    self.current = self:getSector(x, y)
end

function World:update(dt)
    self.current:update(dt)
end

function World:draw()
    self.current:draw()
end

return Player
