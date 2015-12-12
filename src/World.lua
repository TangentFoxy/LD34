local class = require "lib.middleclass"
local World = class("World")
local Sector = require "Sector"

function World:initialize()
    self.sectors = {}
end

function World:getSector(x, y)
    if not self.sectors[x] then
        self.sectors[x] = {}
    end
    if not self.sectors[x][y] then
        self.sectors[x][y] = Sector()
    end

    return self.sectors[x][y]
end

return World
