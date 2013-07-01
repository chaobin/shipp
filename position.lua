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

function Position.new(xy, XY)
  -- params xy: table initial x and y
  -- params XY: table 0 <= x <= X
  --                  0 <= y <= Y
  local self = setmetatable({}, Position)
  self.x = xy.x
  self.y = xy.y
  self.X = XY.x
  self.Y = XY.y
  return self
end

function Position.moveX(self, distance)
  if distance > 0 then -- moving to right
    if (self.x < self.X) then
      self.x = self.x + distance
    end
  end
  if distance < 0 then -- moving to left
    if (self.x > 0) then
      self.x = self.x + distance
    end
  end
end

function Position.moveY(self, distance)
  if distance > 0 then -- moving down
    if (self.y < self.Y) then
      self.y = self.y + distance
    end
  end
  if distance < 0 then -- moving up
    if (self.y > 0) then
      self.y = self.y + distance
    end
  end
end

return Position