local class = require "lib.middleclass"
local Player = class("Player")
local lg = love.graphics

local random = math.random
math.randomseed(os.time())

function Player:initialize()
    self.x = 0
    self.y = 0
    self.sector = false --set when player enters a sector
    self.image = 1      --1 is the shuttle

    self.color = {random(80, 240), random(80, 240), random(80, 240), 255}

    self.mode = 0       --main=0, target=1, heading=2
    self.target = false --object, either a sector or local target
    self.op = ""        --opcodes

    self.heading = 1    --right is 1 (see heading codes)
    self.throttle = 0

    self.speed = 0
    self.acceleration = 0.1 -- 1 pixel per second^2
    self.maxSpeed = 10      -- 100 pixels per second
end

function Player:update(dt)
    -- accelerate as needed
    if self.throttle > self.speed then
        self.speed = self.speed + self.acceleration
        if self.speed > self.throttle then
            self.speed = self.throttle
        end
    elseif self.throttle < self.speed then
        self.speed = self.speed - self.acceleration
        if self.speed < self.throttle then
            self.speed = self.throttle
        end
    end

    -- now move somewhere
    if self.heading == 10 then
        self.x = self.x - self.speed
    elseif self.heading == 1 then
        self.x = self.x + self.speed
    elseif self.heading == 0 then
        self.y = self.y - self.speed
    elseif self.heading == 11 then
        self.y = self.y + self.speed
    end
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
                self.throttle = self.throttle + 1
                if self.throttle > self.maxSpeed then
                    self.throttle = self.maxSpeed
                end
            elseif self.op == "110" then
                --SPEED>DOWN
                self.throttle = self.throttle - 1
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
