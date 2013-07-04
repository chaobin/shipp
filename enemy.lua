-- Imported names
local Ship = require "ship"

--
-- Enemy class

local Enemy = {}
Enemy.__index = Enemy

setmetatable(Enemy, {
  __index = Ship,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self._base = Ship
    self:_init(...)
    return self
  end
})

function Enemy._init(self, options)
  self._base._init(self, options)
end

function Enemy.setSpeed(self, speed)
  self.speed = 1
end

function Enemy.move(self)
  self.position:moveX(self.speed)
  self.position:moveY(self.speed)
end

function Enemy.update(self, dt)
  -- override Ship.update
  self:move()
end

return Enemy