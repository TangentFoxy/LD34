math.randomseed(os.time())
love.graphics.setFont(love.graphics.newFont("Audimat Mono Regular.ttf", 20))
--loading here to force it to load (later will having "loading" graphic/prompt while loading)
require "images"
require "sound" --TODO rename to audio

-- make lady able to save everything
local class = require "lib.middleclass"
local lady = require "lib.lady"
function class.Object.static:subclassed(other)
    lady.register_class(other)
end

local Gamestate = require "lib.gamestate"
local Main = require "Gamestates.Main"

Gamestate.switch(Main)
Gamestate.registerEvents()
