local class = require "lib.middleclass"
local Module = require "Modules.Module"
local SelectedTarget = class("Modules.SelectedTarget", Module)
local lg = love.graphics

function SelectedTarget:initialize()
    Module.initialize(self)
    self.priority = 200
end

function SelectedTarget:draw(player)
    local msg

    if player.target then
        if player.target.type == "Sector" then
            local x = player.sector.x - player.target.x
            local y = player.sector.y - player.target.y
            msg = "SECT:REL:" .. x .. "," .. y
        else
            msg = player.target.name
        end
    else
        msg = "NULL"
    end

    msg = "TAR:" .. msg
    local width = lg.getFont():getWidth(msg) + 2

    -- background box
    lg.setColor(40, 0, 0, 200)
    lg.rectangle("fill", lg.getWidth()/4, lg.getHeight() - 48, width, 48)
    -- text
    lg.setColor(0, 150, 200, 240)
    lg.print(msg, lg.getWidth()/4 + 1, lg.getHeight() - 48)
end

return SelectedTarget
