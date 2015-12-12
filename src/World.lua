local class = require "lib.middleclass"
local World = class("World")
local Sector = require "Sector"

function World:initialize()
    self.sectors = {}
    self.current = false
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

function World:changeSector(player, direction, x, y)
    if not self.sectors[x] then
        self.sectors[x] = {}
    end
    if not self.sectors[x][y] then
        self.sectors[x][y] = Sector(self, x, y)
    end

    self.current = self.sectors[x][y]
    self.current:enter(player, direction)
end

return World
