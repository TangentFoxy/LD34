--AssemblyDump: Another is like an assembly code dump: TARGET SECTOR 0 for 000 000, LASER for firing lasers. HEADING 2 for left (001 010). SPEED UP, or STOP. Or WARP_START.
local class = require "lib.middleclass"
local AssemblyDump = class("Modules.AssemblyDump")
local lg = love.graphics

function AssemblyDump:draw(player)
    --first check 2nd to last ophistory, if it sets target or heading mode, use last 2 ophistory in this manner,
    -- ELSE use last ophistory only
end

return AssemblyDump
