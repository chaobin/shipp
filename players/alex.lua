-- imported names
local PlayerShip = require "player"

--
-- Alex Ship Class
local Alex = {}
Alex.__index = Alex

setmetatable(Alex, {
  __index = PlayerShip,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function Alex._init(self, options)
  PlayerShip._init(self, options)
end

return Alex