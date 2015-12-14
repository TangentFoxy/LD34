--RawCodeDump: Another is a raw dump (so it literally will say 000 000 for example for targeting sector up).
local class = require "lib.middleclass"
local Module = require "Modules.Module"
local RawCodeDump = class("Modules.RawCodeDump", Module)
local lg = love.graphics

function RawCodeDump:initialize()
    Module.initialize(self)
end

function RawCodeDump:draw(player)
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

return RawCodeDump
