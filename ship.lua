-- imported names
local grph = love.graphics
local Position = require "position"
local color = require "color"

--
-- A class represents a Ship
local Ship = {}
Ship.__index = Ship

-- so that an instance can be created
-- by Ship()
setmetatable(Ship, {
  __call = function (cls, ...)
    return cls.new(...)
  end
})

function Ship.new(color, position, speed)
  local self = setmetatable({}, Ship)
  self.min, self.max = 3, 10
  self.scalemin, self.scalemax = 0.4, 0.9
  self.imageS = grph.newImage('img/fighter3.png')
  self.imageX = grph.newImage('img/fighter1.png')
  self.image = self.imageS
  self.color = color or {255, 246, 117}
  self.speed = speed or 3
  self.scale = self.scalemin
  self.window = {x=grph.getWidth(), y=grph.getHeight()}
  self.size = {
    w = self.image:getWidth(),
    h = self.image:getHeight()
  }
  self.boundaries = {
    x = (self.window.x - self.size.w / 2),
    y = (self.window.y - self.size.h / 2)
  }
  self.startPosition = {
    x = math.random(self.boundaries.x),
    y = self.boundaries.y
  }
  self.position = Position(self.startPosition, self.boundaries)
  return self
end

function Ship.moveDown(self)
  -- returns a new position
  self:slowdown()
  self.position:moveY(self.speed)
end

function Ship.moveUp(self)
  self:accelerate()
  self.position:moveY(-(self.speed))
end

function Ship.moveRight(self)
  self.position:moveX(self.speed)
end

function Ship.moveLeft(self)
  self.position:moveX(-(self.speed))
end

function Ship.accelerate(self)
  if (self.speed < self.max) then
    self.speed = self.speed + 0.05
  end
  if self.scale > self.scalemin then
    print(self.scale, self.scalemax)
    self.scale = self.scale - 0.01
  end
  if self.speed > ( (self.min + self.max) / 2 ) then
    self.image = self.imageX
  end
end

function Ship.slowdown(self)
  if (self.speed > self.min) then
    self.speed = self.speed - 0.1
  end
  if self.scale < self.scalemax then
    self.scale = self.scale + 0.01
  end
  if self.speed < ( (self.min + self.max) / 2 ) then
    self.image = self.imageS
  end
end

function Ship.moveByKeys(self)
  local keydown = love.keyboard.isDown
  if keydown("up") then self:moveUp() end
  if keydown("down") then self:moveDown() end
  if keydown("left") then self:moveLeft() end
  if keydown("right") then self:moveRight() end
end

function Ship.listenToKeys(self)
end

function Ship.listenToPressedKeys(self, key)
end

function Ship.draw(self)
  local oldColor = {grph.getColor()}
  grph.setColor(color.white)
  grph.draw(self.image, self.position.x, self.position.y, 0, self.scale, self.scale)
  grph.setColor(oldColor)
end

return Ship