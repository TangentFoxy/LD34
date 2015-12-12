local class = require "lib.middleclass"
local Body = require "Body"
local Player = class("Player", Body)
local lg = love.graphics

local random = math.random
math.randomseed(os.time())

function Player:initialize()
    Body.initialize(self)
    self.image = 1      --1 is the shuttle
    self.mode = 0       --main=0, target=1, heading=2
    self.op = ""        --opcodes
end

local note1 = lg.newImage("img/note1.png")
local note2 = lg.newImage("img/note2.png")
function Player:drawModules()
    lg.setColor(255, 255, 100, 255)
    lg.draw(note1, 0, lg.getHeight() - 237)
    lg.draw(note2, lg.getWidth() - 153, lg.getHeight() - 237)
end

function Player:opcode(code)
    self.op = self.op .. code

    if #self.op >= 3 then
        if self.mode == 0 then
            -- MAIN MODE
            if self.op == "000" then
                self.mode = 1 --TARGET (A##)
            elseif self.op == "001" then
                self.mode = 2 --HEADING (B##)
            elseif self.op == "010" then
                self:warp()   --WARP_START (@TARGET / @HEADING)
            elseif self.op == "011" then
                self:abortWarp() --WARP_STOP
            elseif self.op == "100" then
                self:openComms() --COMMUNICATE (@TARGET)
            elseif self.op == "101" then
                self:scan()    --SCAN (@TARGET)
            elseif self.op == "110" then
                self:laser()   --LASER (@TARGET)
            elseif self.op == "111" then
                self:missile() --MISSILE (@TARGET)
            end
        elseif self.mode == 1 then
            -- TARGET MODE
            if self.op == "000" then
                self.target = self.sector:getSector(0, -1)     --SECTOR>UP
            elseif self.op == "001" then
                self.target = self.sector:getSector(1, 0)      --SECTOR>RIGHT
            elseif self.op == "010" then
                self.target = self.sector:getSector(-1, 0)     --SECTOR>LEFT
            elseif self.op == "011" then
                self.target = self.sector:getSector(0, 1)      --SECTOR>DOWN
            elseif self.op == "100" then
                self.target = self.sector:getTarget(player, 0) --LOCAL>0
            elseif self.op == "101" then
                self.target = self.sector:getTarget(player, 1) --LOCAL>1
            elseif self.op == "110" then
                self.target = self.sector:getTarget(player, 2) --LOCAL>2
            elseif self.op == "111" then
                self.target = self.sector:getTarget(player, 3) --LOCAL>3
            end
            self.mode = 0
        elseif self.mode == 2 then
            -- HEADING MODE
            if self.op == "000" then
                self.heading = 0 --HEADING>UP
            elseif self.op == "001" then
                self.heading = 1 --HEADING>RIGHT
            elseif self.op == "010" then
                self.heading = 10 --HEADING>LEFT
            elseif self.op == "011" then
                self.heading = 11 --HEADING>DOWN
            elseif self.op == "100" then
                self.throttle = 0 --SPEED>STOP
            elseif self.op == "101" then
                --SPEED>UP
                self.throttle = self.throttle + 0.7
                if self.throttle > self.maxSpeed then
                    self.throttle = self.maxSpeed
                end
            elseif self.op == "110" then
                --SPEED>DOWN
                self.throttle = self.throttle - 0.7
                if self.throttle < 0 then
                    self.throttle = 0
                end
            elseif self.op == "111" then
                self.throttle = self.maxSpeed --SPEED>MAX
            end
            self.mode = 0
        end

        --no matter what, clear op
        self.op = ""
    end
end

--TODO when entering target-requiring commands with no target, display error

function Player:warp()
    if self.target then
        --TODO stuff
    elseif self.heading then
        --TODO stuff
    end
end

function Player:abortWarp()
    --TODO STOP
end

--TODO if not target, broadcast static?
function Player:openComms()
    if self.target then
        --TODO stuff
    end
end

--TODO if not target, possibility of generating new object at long range!
function Player:scan()
    if self.target then
        --TODO stuff
    end
end

--TODO if not target, fire blind straight ahead
function Player:laser()
    if self.target then
        --TODO stuff
    end
end

--TODO if not target, fire blind straight ahead
function Player:missile()
    if self.target then
        --TODO stuff
    end
end

return Player
