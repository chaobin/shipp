-- imported names
local grph = love.graphics

--
-- the position class
local Position = {}
Position.__index = Position

-- so that an instance can be created
-- by Position(x, y)
setmetatable(Position, {
  __call = function (cls, ...)
    return cls.new(...)
  end
})

local window = {x=grph.getWidth(), y=grph.getHeight()}

function Position.new(xy, XY)
  -- params xy: table initial x and y
  -- params XY: table 0 <= x <= X
  --                  0 <= y <= Y
  local self = setmetatable({}, Position)
  -- the object boundary defaults to window
  local XY = XY or window
  self.x = xy.x
  self.y = xy.y
  self.X = XY.x
  self.Y = XY.y
  return self
end

function Position.moveX(self, distance)
  self:setX(self.x + distance)
end

function Position.moveY(self, distance)
  self:setY(self.y + distance)
end

function Position.setX(self, x)
  -- param x: the new position on x axis
  if x <= 0 then
    x = 0
  elseif x >= self.X then
    x = self.X
  end
  self.x = x
end

function Position.setY(self, y)
  -- param y: the new position on y axis
  if y <= 0 then
    y = 0
  elseif y >= self.Y then
    y = self.Y
  end
  self.y = y
end

return Position