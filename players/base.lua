-- imported names
local Ship = require "ship"

--
-- Base class for all battle ship variants
-- that can be controlled by player
local PlayerShip = {}
PlayerShip.__index = PlayerShip

setmetatable(PlayerShip, {
  __index = Ship,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function PlayerShip._init(self, options)
  Ship._init(self, options)
end

return PlayerShip