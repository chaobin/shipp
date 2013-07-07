-- imported names
local Ship = require "ship"
local Position = require "position"

--
-- Base class for all battle ship variants
-- that can be controlled by player
local PlayerShip = {}
PlayerShip.__index = PlayerShip

setmetatable(PlayerShip, {
  __index = Ship,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function PlayerShip._init(self, options)
  self._base = Ship
  self._base._init(self, options)
  self.diversion = options.diversion or math.rad(8)
  self:calcStartPosition(options.position)
end

function PlayerShip.update(self, dt)
  self._base.update(self, dt)
  self:moveByKeys()
end

function PlayerShip.keyreleased(self, key)
  if key == 'left' or key == 'right' then
    self.direction = 0
  end
end

function PlayerShip.keypressed(self, key)
  if key == " " then
    self:fire()
  end
end

-- moving controls

function PlayerShip.moveDown(self)
  -- returns a new position
  self:slowdown()
  self._base.moveDown(self)
end

function PlayerShip.moveUp(self)
  self:accelerate()
  self._base.moveUp(self)
end

function PlayerShip.moveRight(self)
  self.direction = self.diversion
  self._base.moveRight(self)
end

function PlayerShip.moveLeft(self)
  self.direction = math.rad(350)
  self._base.moveLeft(self)
end

function PlayerShip.calcStartPosition(self, position)
  self.startPosition = position or {
    x = self.boundaries.x / 2, -- always comes out in the middle
    y = self.boundaries.y
  }
  self.position = Position(self.startPosition, self.boundaries)
end

function PlayerShip.moveByKeys(self)
  local keydown = love.keyboard.isDown
  if keydown("up") then self:moveUp() end
  if keydown("down") then self:moveDown() end
  if keydown("left") then self:moveLeft() end
  if keydown("right") then self:moveRight() end
end

-- Weapons

return PlayerShip