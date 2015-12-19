local class = require "lib.middleclass"
Module = require "Modules.Module"
local CommandDisplay = class("Modules.CommandDisplay", Module)
local lg = love.graphics

--NOTE if you get this module, StickyNotes should be destroyed!

function CommandDisplay:initialize()
    Module.initialize(self)
    self.priority = 101
end

function CommandDisplay:draw(player)
    lg.setColor(250, 240, 120, 150)
    lg.rectangle("fill", 0, lg.getHeight() - (24*8), 188, 24*8)

    lg.setColor(30, 50, 150, 250)
    if player.mode == 0 then
        -- MAIN
        lg.print("TARGET (A##)  000", 0, lg.getHeight() - (24*8))
        lg.print("HEADING (B##) 001", 0, lg.getHeight() - (24*7))
        lg.print("WARP_START    010", 0, lg.getHeight() - (24*6))
        lg.print("WARP_STOP     011", 0, lg.getHeight() - (24*5))
        lg.print("OPEN_COMMS    100", 0, lg.getHeight() - (24*4))
        lg.print("SCAN_TARGET   101", 0, lg.getHeight() - (24*3))
        lg.print("FIRE_LASER    110", 0, lg.getHeight() - (24*2))
        lg.print("FIRE_MISSILE  111", 0, lg.getHeight() - 24)
    elseif player.mode == 1 then
        -- TARGET
        lg.print("SECTOR (Up)   000", 0, lg.getHeight() - (24*8))
        lg.print("SECTOR (Right)001", 0, lg.getHeight() - (24*7))
        lg.print("SECTOR (Left) 010", 0, lg.getHeight() - (24*6))
        lg.print("SECTOR (Down) 011", 0, lg.getHeight() - (24*5))
        lg.print("LOCAL 0       100", 0, lg.getHeight() - (24*4))
        lg.print("LOCAL 1       101", 0, lg.getHeight() - (24*3))
        lg.print("LOCAL 2       110", 0, lg.getHeight() - (24*2))
        lg.print("LOCAL 3       111", 0, lg.getHeight() - 24)
    elseif player.mode == 2 then
        -- HEADING
        lg.print("HEADING(Up)   000", 0, lg.getHeight() - (24*8))
        lg.print("HEADING(Right)001", 0, lg.getHeight() - (24*7))
        lg.print("HEADING(Left) 010", 0, lg.getHeight() - (24*6))
        lg.print("HEADING(Down) 011", 0, lg.getHeight() - (24*5))
        lg.print("STOP          100", 0, lg.getHeight() - (24*4))
        lg.print("SPEED UP      101", 0, lg.getHeight() - (24*3))
        lg.print("SPEED DOWN    110", 0, lg.getHeight() - (24*2))
        lg.print("MAX SPEED     111", 0, lg.getHeight() - 24)
    end
end

return CommandDisplay
