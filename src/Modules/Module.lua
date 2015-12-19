local class = require "lib.middleclass"
local Module = class("Modules.Module")

function Module:initialize()
    self.priority = 50000 --really high so it's probably first (thus, under everything else)
end

function Module:update(dt)
    --
end

function Module:draw(player)
    --
end

return Module
