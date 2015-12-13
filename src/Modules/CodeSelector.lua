local class = require "lib.middleclass"
local CodeSelector = class("Modules.CodeSelector")
local lg = love.graphics

lg.setFont(lg.newFont("Audimat Mono Regular.ttf", 20))

function CodeSelector:draw(player)
    lg.setColor(10, 30, 55, 255)
    lg.rectangle("fill", lg.getWidth()/4, lg.getHeight() - 24, lg.getWidth()/2, 24)

    local msg = ""
    if player.op == "" then
        msg = "0:Targeting/Movement 1:Action"
    end

    lg.setColor(80, 130, 200, 255)
    lg.printf(msg, 0, lg.getHeight() - 24, lg.getWidth(), "center")
end

return CodeSelector
