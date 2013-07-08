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
    image = 'img/e1_32.png'
  }
  options.speed = options.speed or 1
  
  options.hp = options.hp or 1
  BaseEnemy._init(self, options)
end

return E1