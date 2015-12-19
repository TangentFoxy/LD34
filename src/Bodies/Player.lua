local class = require "lib.middleclass"
local Body = require "Bodies.Body"
local Player = class("Bodies.Player", Body)

local lg = love.graphics
local random = math.random
local insert = table.insert
local remove = table.remove
local max = math.max

local images = require "images"
local sound = require "sound"
local StickyNotes = require "Modules.StickyNotes"
local SelectedTarget = require "Modules.SelectedTarget"

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
    self.warping = false           --prevent abusing warp by rapidly selecting it

    self.communication = false    --used to display and respond to communications

    self.modules = {}
    --self.modules = {StickyNotes()}
    self:addModule(StickyNotes())
    self:addModule(SelectedTarget())

    ---[[
    --NOTE TEMP THINGS FOR TESTING, YOU SHOULD NOT HAVE THESE
    self:addModule(require("Modules.CodeSelector")())
    self:addModule(require("Modules.CommandHistory")())
    --self:addModule(require("Modules.RawCodeDump")())
    --self:addModule(require("Modules.AssemblyDump")())
    self:addModule(require("Modules.HeadingModeDisplay")())
    self:addModule(require("Modules.Waypoint")())
    self:addModule(require("Modules.TargetDisplay")())
    self:addModule(require("Modules.CommandDisplay")())
    self:addModule(require("Modules.Communication")())

    --NOTE debug print
    --print(require("lib.inspect")(self.modules))
    for i=1,#self.modules do
        print(self.modules[i])
    end
    --]]
end

function Player:update(dt)
    Body.update(self, dt)

    for i=1,#self.modules do
        self.modules[i]:update(dt)
    end
end

function Player:drawModules()
    for i=1,#self.modules do
        self.modules[i]:draw(self)
    end
end

function Player:input(button)
    self:opcode(button)

    --TODO comms should be a mode? yes
    if self.communication and self.communication.isOpen then
        if (#self.communication == 3) or (button == "1") then
            self:openComms(button) -- respond with whatever we said
        else
            self.communication = false
        end
    end
end

function Player:opcode(code)
    self.op = self.op .. code

    if #self.op >= 3 then
        sound.play(3) --a command was run!

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

        -- save history
        insert(self.ophistory, self.op)

        -- clear old history
        if #self.ophistory > 5 then
            -- remove it, and if it contained mode change, remove next code
            local old = remove(self.ophistory, 1)
            if (old == "000") or (old == "001") then
                remove(self.ophistory, 1)
            end
        end

        -- clear op
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
function Player:openComms(response, target)
    if self.target and self.target.communicate then
        self.communication = self.target:communicate(self, response) --response is uneeded here, it is always a nil
    else
        if target then
            self.communication = target:communicate(self, response)
        else
            print("I FUCKED SOMETHING UP THIS ERROR SHOULDN'T HAPPEN\nI BLAME LOMELI EVEN THOUGH HE HAD NOTHING TO DO WITH IT.")
        end
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

function Player:addModule(module)
    if #self.modules == 0 then
        self.modules[1] = module
    else
        for i=1,#self.modules do
            --print(self.modules[i].priority ,"> ?", module.priority, (self.modules[i].priority > module.priority) )
            if self.modules[i].priority < module.priority then
                insert(self.modules, i, module)
                return
            end
        end

        insert(self.modules, module)
    end
end

return Player
