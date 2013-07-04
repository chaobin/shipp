-- imported names
local BaseEnemy = require "enemies.base"
local V = require "values"

--
-- E1 ship class definition
local E1 = {}
E1.__index = E1

setmetatable(E1, {
  __index = BaseEnemy,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function E1._init(self, options)
  local options = options or {}
  
  options.imgs = options.imgs or  {
    image = 'img/spaceride.png'
  }
  options.direction = options.direction or V.down
  options.position = options.position or self:makeStartPosition()
  options.scale = options.scale or 0.2
  options.speed = options.speed or 2
  
  BaseEnemy._init(self, options)
end

return E1