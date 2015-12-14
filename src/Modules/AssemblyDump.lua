--AssemblyDump: Another is like an assembly code dump: TARGET SECTOR 0 for 000 000, LASER for firing lasers. HEADING 2 for left (001 010). SPEED UP, or STOP. Or WARP_START.
local class = require "lib.middleclass"
local Module = require "Modules.Module"
local AssemblyDump = class("Modules.AssemblyDump", Module)
local lg = love.graphics

function AssemblyDump:initialize()
    Module.initialize(self)
end

function AssemblyDump:draw(player)
    --first check 2nd to last ophistory, if it sets target or heading mode, use last 2 ophistory in this manner,
    -- ELSE use last ophistory only

    --[[
    0 movement / targeting (preparation)
      0 selection
        0 target
          (enter code to select a target)
           (ABC, A is sector/local, B/C is ID)
        1 heading
          (enter code to select a heading)
           (see Heading codes v3)
      1 warp
        0 start
          (in current direction or towards target??)
        1 stop
          (cancel warp in progress)
    1 action (NEED BETTER NAME)
      0 peaceful
        0 communicate
        1 scan
      1 attack
        0 laser
        1 missile
    ]]
end

return AssemblyDump
