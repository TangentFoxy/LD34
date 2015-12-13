--RawCodeDump: Another is a raw dump (so it literally will say 000 000 for example for targeting sector up).
local class = require "lib.middleclass"
local RawCodeDump = class("Modules.RawCodeDump")
local lg = love.graphics

function RawCodeDump:draw(player)
    --first check 2nd to last ophistory, if it sets target or heading mode, use last 2 ophistory in this manner,
    -- ELSE use last ophistory only
end

return RawCodeDump
