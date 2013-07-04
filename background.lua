-- imported names
local grph = love.graphics

--
-- The Background Class
local Background = {}
Background.__index = Background

setmetatable(Background, {
  __call = function(cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function Background._init(self, options)
  local imgname = options.img
  self.image = grph.newImage(imgname)
  self.image2 = grph.newImage(imgname)
  self.lastupdated = 0
  self.x, self.y = 0, 0
  self.window = {x=grph.getWidth(), y=grph.getHeight()}
  self.y2 = - (self.window.y)
  self.speed = options.speed or 0.5
end

function Background.draw(self)
  grph.draw(self.image, self.x, self.y)
  grph.draw(self.image2, self.x, self.y2)
end

function Background.roll(self)
  -- Laying bg down a bit so that
  -- the scene looks moving forward
  if self.y > self.window.y then -- rolled out
    self.y = - (self.window.y)
  end
  if self.y2 > self.window.y then -- the replacement also rolled out
    self.y2 = - (self.window.y)
  end
  self.y = (self.y + self.speed)
  self.y2 = (self.y2 + self.speed)
end

function Background.update(self, dt)
  self.lastupdated = self.lastupdated + dt
  if self.lastupdated > 0.05 then -- longer than 50 miliseconds
    self.lastupdated = self.lastupdated - 0.05
    self:roll()
  end
end

return Background