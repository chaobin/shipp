-- imported names
local BaseWeapon = require "weapons.base"
local Position = require "position"
local grph = love.graphics
local V = require "values"

--
-- Machine Gun Class
local MachineGun = {}
MachineGun.__index = MachineGun

setmetatable(MachineGun, {
  __index = BaseWeapon,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function MachineGun._init(self, options)
  self._base = BaseWeapon
  self._base._init(self, options)

  local options = options or {}

  -- the ship that fires this weapon
  self.ship = options.ship

  -- weapon properties
  self.code = 'MG'
  self.bulletColor = V.red
  self.bulletSize = 2
  self.speed = 10
  self.rate = 2
  self.power = 0.02

  self.bullets = {}
end

function MachineGun.makeBullet(self)
  -- in this case, the bullet's starting
  -- position is slightly above the ship
  local newBullet = {
    position = self.shootingPosition
  }
  return newBullet
end

function MachineGun.calcShootingPosition(self)
  self.ship:calcCenter()
  self.shootingPosition = Position({
    x = self.ship.center.x,
    y = (self.ship.center.y - self.ship.size.h / 2)
  })
end

function MachineGun.fire(self)
  self:calcShootingPosition()
  local newBullet = self:makeBullet()
  table.insert(self.bullets, newBullet)
end

function MachineGun.update(self, dt)
  for i, bullet in pairs(self.bullets) do
    bullet.position:moveY(-(self.speed))
  end
end

function MachineGun.draw(self)
  local oldColor = {grph.getColor()}
  grph.setColor(self.bulletColor)
  for i, bullet in pairs(self.bullets) do
    -- draw the bullets into little filled
    -- circles
    grph.circle("fill", (bullet.position.x + self.bulletSize), bullet.position.y, self.bulletSize)
  end
  grph.setColor(oldColor)
end

return MachineGun