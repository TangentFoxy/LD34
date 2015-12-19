local class = require "lib.middleclass"
local Module = require "Modules.Module"
local Communication = class("Modules.Communication", Module)
local lg = love.graphics
local max = math.max

function Communication:initialize()
    Module.initialize(self)
    self.priority = 100
end

function Communication:draw(player)
    --actual code

    -- I know it is called drawModules, but we also draw dialog screens for communications
    -- Communication should be turned into a module I think?

    --[[ (works as intended! (well, displaying something works as intended))
    self.communication = { --NOTE TEMPORARY DATA SET TO TEST
        "Test display.",
        --TODO "0: / 1:" should be added here? It will always be those, so I shouldn't have to always type them!
        "0: Option 1 (err, zero)",
        "1: Option 2 (well, one)",
        isOpen = true
    }
    --]]

    -- NOTE why do we have "isOpen" ? It's not needed.
    --  NOTE Either there is data or it is false!
    -- rather than checking for communication, check for mode, make comms a mode!
    if self.communication and self.communication.isOpen then
        local font = lg.getFont()
        local width
        if #self.communication == 3 then
            width = max(font:getWidth(self.communication[1]), font:getWidth(self.communication[2]), font:getWidth(self.communication[3])) + 2
        else
            width = max(font:getWidth(self.communication[1]), font:getWidth("0: Exit communications mode.")) + 2
        end

        lg.setColor(0, 105, 0, 250)
        lg.rectangle("fill", lg.getWidth()/2 - width/2, lg.getHeight()/2 - 36, width, 72)

        lg.setColor(255, 250, 250, 255)
        lg.printf(self.communication[1], lg.getWidth()/2 - width/2 + 1, lg.getHeight()/2 - 36, width - 1, "left")
        if #self.communication == 3 then
            lg.printf(self.communication[2], lg.getWidth()/2 - width/2 + 1, lg.getHeight()/2 - 12, width - 1, "left")
            lg.printf(self.communication[3], lg.getWidth()/2 - width/2 + 1, lg.getHeight()/2 + 12, width - 1, "left")
        else
            lg.printf("0: Exit communications mode.", lg.getWidth()/2 - width/2 + 1, lg.getHeight()/2 - 12, width, "left")
            lg.printf("1: Hail them again.", lg.getWidth()/2 - width/2 + 1, lg.getHeight()/2 + 12, width - 1, "left")
        end
    end
end

return Communication
