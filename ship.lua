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

function Ship.new(options)
  local self = setmetatable({}, Ship)
  self.speedmin, self.speedmax = 5, 12
  self.scalemin, self.scalemax = 0.4, 0.6
  
  local imgs = options.imgs
  self.image = grph.newImage(imgs.image)
  self:setSpeed(options.speed)
  self.scale = options.scale or ((self.scalemin + self.scalemax) / 2)
  self.window = {x=grph.getWidth(), y=grph.getHeight()}
  self.size = {
    w = self.image:getWidth(),
    h = self.image:getHeight()
  }
  self.boundaries = {
    x = (self.window.x - self.size.w / 2),
    y = (self.window.y - self.size.h / 2)
  }
  self.startPosition = options.position or {
    x = math.random(self.boundaries.x),
    y = self.boundaries.y
  }
  self.position = Position(self.startPosition, self.boundaries)
  return self
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
  if (self.speed < self.speedmax) then
    self.speed = self.speed + 0.07
  end
  if self.scale > self.scalemin then
    self.scale = self.scale - 0.01
  end
end

function Ship.slowdown(self)
  if (self.speed > self.speedmin) then
    self.speed = self.speed - 0.1
  end
  if (self.scale < self.scalemax) then
    self.scale = self.scale + 0.01
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
  grph.draw(self.image, self.position.x, self.position.y, 0, self.scale, self.scale)
end

return Ship