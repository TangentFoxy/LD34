local class = require "lib.middleclass"
local Module = require "Modules.Module"
local StickyNotes = class("Modules.StickyNotes", Module)
local lg = love.graphics

local note1 = lg.newImage("img/note1.png")
local note2 = lg.newImage("img/note2.png")

function StickyNotes:initialize()
    Module.initialize(self)
end

function StickyNotes:draw()
    lg.setColor(255, 255, 100, 255)
    lg.draw(note1, 0, lg.getHeight() - 237)
    lg.draw(note2, lg.getWidth() - 153, lg.getHeight() - 237)
end

return StickyNotes
