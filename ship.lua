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
  self.image = grph.newImage('img/fighter3.png')
  self.color = color or {255, 246, 117}
  self.speed = speed or 3
  self.window = {x=grph.getWidth(), y=grph.getHeight()}
  self.size = {
    w = self.image:getWidth(),
    h = self.image:getHeight()
  }
  self.boundaries = {
    x = (self.window.x - self.size.w / 2),
    y = (self.window.y - self.size.h / 2)
  }
  self.position = Position({x=0, y=0}, self.boundaries)
  return self
end

function Ship.moveDown(self)
  -- returns a new position
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
  -- 4 is the maximum speed
  if (self.speed < 5) then
    self.speed = self.speed + 1
  end
end

function Ship.slowdown(self)
  -- 1 is the lowest speed
  if (self.speed > 1) then
    self.speed = self.speed - 1
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
  if key == 'x' then self:accelerate() end
  if key == 's' then self:slowdown() end
end

function Ship.moveByMouse(self)
  local mouse = love.mouse
  mouse.setVisible(false)
  self.position:setX(mouse.getX())
  self.position:setY(mouse.getY())
end

function Ship.draw(self)
  local oldColor = {grph.getColor()}
  grph.setColor(color.white)
  grph.draw(self.image, self.position.x, self.position.y, 0, 0.5, 0.5)
  grph.setColor(oldColor)
end

return Ship