-- imported names
local BaseEnemy = require "enemies.base"

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
  BaseEnemy._init(self, options)
end


return E1