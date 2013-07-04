-- imported names
local grph = love.graphics

local O = require "O"
local Position = require "position"
local V = require "values"

--
-- A class represents a Ship
local Ship = {}
Ship.__index = Ship

-- so that an instance can be created
-- by Ship()
setmetatable(Ship, {
  __index = O,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function Ship._init(self, options)
  O._init(self, options)
  self.speedmin, self.speedmax = 5, 12
  self.image = grph.newImage(options.imgs.image)
  self:setSpeed(options.speed)
  self.direction = options.direction or V.up
  self.window = {x=grph.getWidth(), y=grph.getHeight()}
  self.size = {
    w = self.image:getWidth(),
    h = self.image:getHeight()
  }
  self.boundaries = {
    x = (self.window.x - self.size.w / 2),
    y = (self.window.y - self.size.h / 2)
  }
  self:calcRadius()
end

function Ship.calcRadius(self)
  -- rectangle shaped only
  self.rad = math.max(self.size.w, self.size.h) / 2
end

function Ship.setSpeed(self, speed)
  if (speed == 'fast') then
    self.speed = self.speedmax
  elseif (speed == 'slow') then
    self.speed = self.speedmin
  else
    self.speed = (self.speedmin + self.speedmax) / 2
  end
end

function Ship.moveDown(self)
  self.position:moveY(self.speed)
end

function Ship.moveUp(self)
  self.position:moveY(-(self.speed))
end

function Ship.moveRight(self)
  self.position:moveX(self.speed)
end

function Ship.moveLeft(self)
  self.position:moveX(-(self.speed))
end

function Ship.accelerate(self)
  if (self.speed < self.speedmax) then
    self.speed = self.speed + 0.07
  end
end

function Ship.slowdown(self)
  if (self.speed > self.speedmin) then
    self.speed = self.speed - 0.1
  end
end

function Ship.draw(self)
  grph.draw(self.image, self.position.x, self.position.y, self.direction)
end

function Ship.update(self, dt)
end

return Ship