-- imported names
local BasePlayer = require "players.base"
local V = require "values"
local grph = love.graphics
local MachineGun = require "weapons.machine_gun"

--
-- Alex Ship Class
local Alex = {}
Alex.__index = Alex

setmetatable(Alex, {
  __index = BasePlayer,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function Alex._init(self, options)
  self._base = BasePlayer
  local options = options or {}
  
  options.imgs = options.imgs or {
    image = 'img/spaceride.png'
  }
  options.hp = options.hp or 10
  options.damage = options.damage or 0.2
  options.defense = options.defense or 0.1
  -- set machine gun as default weapon
  options.weapon = MachineGun({
    ship = self
  })
  self._base._init(self, options)
end

return Alex