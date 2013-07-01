-- imported names
local grph = love.graphics
local Position = require "position"

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
  self.color = color or {255, 246, 117}
  self.speed = speed or 3
  self.window = {x=grph.getWidth(), y=grph.getHeight()}
  self.position = Position({x=0, y=0}, self.window)
  self.image = grph.newImage('img/fighter4.png')
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

function Ship.moveOnArrowKeyDown(self)
  local keydown = love.keyboard.isDown
  if keydown("up") then self:moveUp() end
  if keydown("down") then self:moveDown() end
  if keydown("left") then self:moveLeft() end
  if keydown("right") then self:moveRight() end
end

function Ship.listenToKeys(self)
  self:moveOnArrowKeyDown()
end

function Ship.listenToPressedKeys(self, key)
  if key == 'x' then self:accelerate() end
  if key == 's' then self:slowdown() end
end

function Ship.draw(self)
  local oldColor = {grph.getColor()}
  grph.setColor(self.color)
  grph.draw(self.image, self.position.x, self.position.y, 0, 0.5, 0.5)
  grph.setColor(oldColor)
end

return Ship