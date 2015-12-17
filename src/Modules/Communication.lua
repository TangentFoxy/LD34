local class = require "lib.middleclass"
local Module = require "Modules.Module"
local Communication = class("Modules.Communication", Module)
local lg = love.graphics

function Communication:initialize()
    Module.initialize(self)
end

function Communication:draw(player)
    --actual code
end

return Communication
