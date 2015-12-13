math.randomseed(os.time())
love.graphics.setFont(love.graphics.newFont("Audimat Mono Regular.ttf", 20))

local Gamestate = require "lib.gamestate"
local Main = require "Gamestates.Main"

Gamestate.switch(Main)
Gamestate.registerEvents()
