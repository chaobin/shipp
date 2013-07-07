-- imported names
local O = require "O"
local V = require "values"
local Position = require "position"

--
-- Weapon Base Class
local Weapon = {}
Weapon.__index = Weapon

setmetatable(Weapon, {
  __index = O,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function Weapon._init(self, options)

  self._base = O
  self._base._init(self, options)

  local options = options or {}

  -- weapon code is used to index weapons
  self.code = nil

  --
  -- game controls

  -- speed
  self.speed = options.speed or 1
  -- rate
  self.rate = options.rate or 1
  -- power, contributes to damage
  self.power = options.power or 0.02

end

function Weapon.update(self, ...)
end

function Weapon.draw(self)
end

function Weapon.fire(self, position, ...)
  -- param position: shooting position
  --  usually the ship position
end

return Weapon