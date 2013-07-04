-- Imported names
local Ship = require "ship"
local Position = require "position"

--
-- Enemy base class

local Enemy = {}
Enemy.__index = Enemy

setmetatable(Enemy, {
  __index = Ship,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function Enemy._init(self, options)
  Ship._init(self, options)
  self:calcStartPosition(options.position)
  self:calcTurning(options.turning)
end

function Enemy.setSpeed(self, speed)
  self.speed = 1
end

function Enemy.calcStartPosition(self, position)
  self.startPosition = position or {
    x = math.random(self.boundaries.x),
    y = 0
  }
  self.position = Position(self.startPosition, self.boundaries)
end

function Enemy.move(self)
  self.position:moveX(self.speed * self.turning)
  self.position:moveY(self.speed)
end

function Enemy.calcTurning(self, turning)
  if turning then
    self.turning = turning
  else
    self.turning = ({-1, 0, 1})[math.random(3)]
  end
end

function Enemy.update(self, dt)
  -- override Ship.update
  self:move()
end

return Enemy
