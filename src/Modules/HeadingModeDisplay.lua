--HeadingModeDisplay: Another is a display of what opcodes lead to what directions of travel (as a reference moreso than these others than just show what you're doing in different ways).
local class = require "lib.middleclass"
local Module = require "Modules.Module"
local HeadingModeDisplay = class("Modules.HeadingModeDisplay", Module)
local lg = love.graphics

function HeadingModeDisplay:initialize()
    Module.initialize(self)
end

function HeadingModeDisplay:draw(player)
    --TODO actually design this shit (NOTE only appears when in heading mode)
    -- basically check last thing in ophistory, if we are in heading mode, display overlay in center to tell which way to go
    if player.mode == 2 then
        local hw = lg.getWidth()/2
        local hh = lg.getHeight()/2

        lg.setColor(20, 100, 60, 160)
        lg.rectangle("fill", hw - 125, hh - 60, 250, 120)
        lg.rectangle("fill", hw - 250, hh + 80, 500, 24)

        lg.setColor(80, 200, 50, 200)
        lg.printf("000:Up", hw - 125, hh - 60, 250, "center")
        lg.printf("011:Down", hw - 125, hh + 60 - 22, 250, "center")
        lg.printf("010:Left", hw - 125, hh - 12, 250, "left")
        lg.printf("001:Right", hw - 125, hh - 12, 250, "right")
        lg.printf("100:Stop . 110:Slower . 101:Faster . 111:Max", hw - 250, hh + 80, 500, "center")

        lg.setColor(80, 220, 160, 180)
        lg.printf("Direction:", hw - 125, hh - 60 - 22, 250, "left")
        lg.printf("Speed:", hw - 250, hh + 80 - 22, 500, "left")
    end
end

return HeadingModeDisplay
