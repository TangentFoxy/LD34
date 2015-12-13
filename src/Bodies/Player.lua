local class = require "lib.middleclass"
local Body = require "Bodies.Body"
local Player = class("Bodies.Player", Body)
local lg = love.graphics

local StickyNotes = require "Modules.StickyNotes"

local random = math.random

function Player:initialize()
    Body.initialize(self)
    self.type = "Player"
    self.image = 1      --1 is the shuttle
    self.mode = 0       --main=0, target=1, heading=2
    self.op = ""        --opcodes
    self.modules = {StickyNotes()}
    self.warping = false --prevent abusing warp too quickly
end

function Player:drawModules()
    for i=1,#self.modules do
        self.modules[i]:draw()
    end
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
                self.target =  {0, -1, type = "SectorCoords"}  --SECTOR>UP
            elseif self.op == "001" then
                self.target =  {1, 0, type = "SectorCoords"}   --SECTOR>RIGHT
            elseif self.op == "010" then
                self.target =  {-1, 0, type = "SectorCoords"}  --SECTOR>LEFT
            elseif self.op == "011" then
                self.target = {0, 1, type = "SectorCoords"}    --SECTOR>DOWN
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
    if not self.warping then
        if self.target and (self.target.type == "SectorCoords") then
            self.sector:after(3, function()
                self.sector:changeSector(unpack(self.target))
                self.warping = false
            end)
        else
            self.throttle = 0
            if self.heading == 0 then      --up
                self.sector:after(2.5, function()
                    self.y = self.y - 1000
                    self.warping = false
                end)
            elseif self.heading == 10 then --left
                self.sector:after(2.5, function()
                    self.x = self.x - 1000
                    self.warping = false
                end)
            elseif self.heading == 1 then  --right
                self.sector:after(2.5, function()
                    self.x = self.x + 1000
                    self.warping = false
                end)
            elseif self.heading == 11 then --down
                self.sector:after(2.5, function()
                    self.y = self.y + 1000
                    self.warping = false
                end)
            end
        end

        self.warping = true
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
