local class = require "lib.middleclass"
local Player = class("Player")
local lg = love.graphics

local random = math.random
math.randomseed(os.time())

function Player:initialize()
    self.x = 0
    self.y = 0
    self.sector = false --set when player enters a sector

    self.color = {random(80, 240), random(80, 240), random(80, 240), 255}

    self.mode = 0       --main=0, target=1, heading=2
    self.target = false --object, either a sector or local target
    self.op = {}        --opcodes

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

function Player:keypressed(key)
    print("KEY", key)
    table.insert(self.op, key)
    for i=1,#self.op do
        print(i,self.op[i])
    end

    if #self.op >= 3 then
        if self.mode == 0 then --main mode
            if self.op[1] == 0 then
                if self.op[2] == 0 then
                    if self.op[3] == 0 then
                        --000 TARGET (###)
                        self.mode = 1
                    else
                        --001 HEADING (###)
                        self.mode = 2
                    end
                else
                    if self.op[3] == 0 then
                        --010 WARP_START (@TARGET / @HEADING)
                        self:warp()
                    else
                        --011 WARP_STOP (@TARGET)
                        self:abortWarp()
                    end
                end
            else
                if self.op[2] == 0 then
                    if self.op[3] == 0 then
                        --100 COMMUNICATE (@TARGET)
                        self:openComms()
                    else
                        --101 SCAN (@TARGET)
                        self:scan()
                    end
                else
                    if self.op[3] == 0 then
                        --110 LASER (@TARGET)
                        self:laser()
                    else
                        --111 MISSILE (@TARGET)
                        self:missile()
                    end
                end
            end
        elseif self.mode == 1 then
            self:targetMode()
        elseif self.mode == 2 then
            self:headingMode()
        end

        --no matter what, clear op
        self.op = {}
    end
end

function Player:targetMode()
    if self.op[1] == 0 then
        if self.op[2] == 0 then
            if self.op[3] == 0 then
                --000 SECTOR>UP
                self.target = self.sector:getSector(0, -1)
            else
                --001 SECTOR>RIGHT
                self.target = self.sector:getSector(1, 0)
            end
        else
            if self.op[3] == 0 then
                --010 SECTOR>LEFT
                self.target = self.sector:getSector(-1, 0)
            else
                --011 SECTOR>DOWN
                self.target = self.sector:getSector(0, 1)
            end
        end
    else
        if self.op[2] == 0 then
            if self.op[3] == 0 then
                --100 LOCAL>0
                self.target = self.sector:getTarget(player, 0)
            else
                --101 LOCAL>1
                self.target = self.sector:getTarget(player, 1)
            end
        else
            if self.op[3] == 0 then
                --110 LOCAL>2
                self.target = self.sector:getTarget(player, 2)
            else
                --111 LOCAL>3
                self.target = self.sector:getTarget(player, 3)
            end
        end
    end

    --no matter what, reset op! (and mode!)
    self.mode = 0
    self.op = {}
end

function Player:headingMode()
    if self.op[1] == 0 then
        if self.op[2] == 0 then
            if self.op[3] == 0 then
                --000 HEADING>UP
                self.heading = 0
            else
                --001 HEADING>RIGHT
                self.heading = 1
            end
        else
            if self.op[3] == 0 then
                --010 HEADING>LEFT
                self.heading = 10
            else
                --011 HEADING>DOWN
                self.heading = 11
            end
        end
    else
        if self.op[2] == 0 then
            if self.op[3] == 0 then
                --100 SPEED>STOP
                self.throttle = 0
            else
                --101 SPEED>UP
                self.throttle = self.throttle + 1
                if self.throttle > self.maxSpeed then
                    self.throttle = self.maxSpeed
                end
            end
        else
            if self.op[3] == 0 then
                --110 SPEED>DOWN
                self.throttle = self.throttle - 1
                if self.throttle < 0 then
                    self.throttle = 0
                end
            else
                --111 SPEED>MAX
                self.throttle = self.maxSpeed
            end
        end
    end

    --no matter what, reset op! (and mode!)
    self.mode = 0
    self.op = {}
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
