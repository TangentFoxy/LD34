local class = require "lib.middleclass"
local Body = require "Bodies.Body"
local Station = class("Bodies.Station", Body)

local random = math.random
local name = require "lib.name"

function Station:initialize(distance, special)
    Body.initialize(self)
    self.type = "Station"
    self.name = "Station " .. name.generate(3, 9):gsub("^%l", string.upper)

    local direction = random(0, math.pi*2)
    self.x = distance * math.cos(direction)
    self.y = distance * math.sin(direction)

    self.image = 2
    self.sx = random(3, 5)
    self.sy = self.sx

    self.special = special --used for specific stations that are special for one reason or another

    self.commsTrack = 0 --nothing special is happening communications-wise
end

function Station:communicate(incoming, response)
    if self.special == "start" then
        if self.commsTrack == 0 then
            self.commsTrack = 1
            return {
                "Welcome to " .. self.name .. "! Would you like to buy a module?",
                "0: What do you have?",
                "1: What's a module?",
                isOpen = true
            }
        end
    else
        return {
            "Go away! We don't want to talk to you.",
            isOpen = true
        }
    end
end

return Station
