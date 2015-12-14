local slam = require "lib.slam"
local source = slam.audio.newSource

local sound = {
    source("sfx/alarm.wav"),        --1 red alert?
    source("sfx/beep.wav"),         --2 beep (typing)
    --source("sfx/high_beep.wav"),  -- another typing beep? idk yet
    source("sfx/command_run.wav"),  --3 opcode ran
    --source("sfx/damage.wav"),     -- damaged ? how is this different from hits?
    source("sfx/equip_module.wav"), --4 new module equiped
    source("sfx/laser.wav"),        --5 laser fired
    source({"sfx/explode1.wav", "sfx/explode2.wav", "sfx/explode3.wav"}), --6 explosion!
    source({"sfx/hit1.wav", "sfx/hit2.wav", "sfx/hit3.wav"}),             --7 hit!
}

function sound.play(id, ...)
    slam.audio.play(sound[id], ...)
end

return sound
