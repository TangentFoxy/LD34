local class = require "lib.middleclass"
local Body = require "Bodies.Body"
local Player = class("Bodies.Player", Body)

local lg = love.graphics
local random = math.random
local insert = table.insert
local remove = table.remove

local images = require "images"
local StickyNotes = require "Modules.StickyNotes"

function Player:initialize()
    Body.initialize(self)
    self.type = "Player"

    self.image = 1 --the shuttle
    self.sx = 3
    self.sy = 3

    self.target = false --unique
    self.targetDirection = false --this is direction we would be moving towards the target (sector only)

    --unique stuff
    self.mode = 0                  -- opcode mode (main=0, target=1, heading=2)
    self.op = ""                   -- current opcode
    self.ophistory = {}            -- last 5 3bit sequences are saved
    self.modules = {StickyNotes()} -- display modules
    self.warping = false          --prevent abusing warp by rapidly selecting it

    --NOTE TEMP THINGS FOR TESTING, YOU SHOULD NOT HAVE THESE
    self.modules[2] = require("Modules.CodeSelector")()
    self.modules[3] = require("Modules.CommandHistory")()
    self.modules[4] = require("Modules.RawCodeDump")()
    self.modules[5] = require("Modules.AssemblyDump")()
    self.modules[6] = require("Modules.HeadingModeDisplay")()
end

function Player:drawModules()
    for i=1,#self.modules do
        self.modules[i]:draw(self)
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
                self.target = self.sector:getRelativeSector(0, -1) --SECTOR>UP
                self.targetDirection = "up"
            elseif self.op == "001" then
                self.target = self.sector:getRelativeSector(1, 0)  --SECTOR>RIGHT
                self.targetDirection = "right"
            elseif self.op == "010" then
                self.target = self.sector:getRelativeSector(-1, 0) --SECTOR>LEFT
                self.targetDirection = "left"
            elseif self.op == "011" then
                self.target = self.sector:getRelativeSector(0, 1)  --SECTOR>DOWN
                self.targetDirection = "down"
            elseif self.op == "100" then
                self.target = self.sector:getLocalTarget(self, 0) --LOCAL>0
            elseif self.op == "101" then
                self.target = self.sector:getLocalTarget(self, 1) --LOCAL>1
            elseif self.op == "110" then
                self.target = self.sector:getLocalTarget(self, 2) --LOCAL>2
            elseif self.op == "111" then
                self.target = self.sector:getLocalTarget(self, 3) --LOCAL>3
            end
            self.mode = 0
        elseif self.mode == 2 then
            -- HEADING MODE
            if self.op == "000" then
                self:setHeading("up") --HEADING>UP
            elseif self.op == "001" then
                self:setHeading("right") --HEADING>RIGHT
            elseif self.op == "010" then
                self:setHeading("left") --HEADING>LEFT
            elseif self.op == "011" then
                self:setHeading("down") --HEADING>DOWN
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

        --no matter what, save history, clear op
        insert(self.ophistory, self.op)
        if #self.ophistory > 5 then
            remove(self.ophistory, 1)
        end
        self.op = ""
    end
end

--TODO when entering target-requiring commands with no target, display error

function Player:warp()
    if not self.warping then
        if self.target and (self.target.type == "Sector") then
            self.warping = self.sector:after(3, function()
                self.sector:leave(self, true)
                self.target:enter(self, true)
                self.warping = false
            end)
        else
            self.throttle = 0
            if self.heading == 0 then      --up
                self.warping = self.sector:after(2.5, function()
                    self.y = self.y - 1000
                    self.warping = false
                end)
            elseif self.heading == 10 then --left
                self.warping = self.sector:after(2.5, function()
                    self.x = self.x - 1000
                    self.warping = false
                end)
            elseif self.heading == 1 then  --right
                self.warping = self.sector:after(2.5, function()
                    self.x = self.x + 1000
                    self.warping = false
                end)
            elseif self.heading == 11 then --down
                self.warping = self.sector:after(2.5, function()
                    self.y = self.y + 1000
                    self.warping = false
                end)
            end
        end
    end
end

function Player:abortWarp()
    if self.warping then
        self.sector:cancel(self.warping)
        self.warping = false
    else
        --ERROR (actually..expansion! this is where expansion will go)
    end
end

--TODO if not target, broadcast static?
function Player:openComms()
    if self.target and not (self.target.type == "Sector") then
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
    if self.target and not (self.target.type == "Sector") then
        --TODO stuff
    end
end

--TODO if not target, fire blind straight ahead
function Player:missile()
    if self.target and not (self.target.type == "Sector") then
        --TODO stuff
    end
end

return Player
