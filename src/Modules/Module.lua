local class = require "lib.middleclass"
local Module = class("Modules.Module")

--TODO make something check if a Module has a 50000 priority and error if it does ?
function Module:initialize()
    self.priority = 50000 --this value is an error, it means a Module didn't set its priority
end

function Module:update(dt)
    --
end

function Module:draw(player)
    --
end

return Module
