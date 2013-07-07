-- imported names
local BaseWeapon = require "weapons.base"
local Position = require "position"
local grph = love.graphics
local O = require "O"
local V = require "values"

--
-- Bullet class
local Bullet = {}
Bullet.__index = Bullet

setmetatable(Bullet, {
  __index = O,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function Bullet._init(self, options)
  self._base = O
  self._base._init(self, options)

  self.position = options.position
  self.size = options.size or nil
  self:calcRadius()
  -- indicates the bullet finished travelling or hit the target
  -- and then about to be cleared from the frame
  self.done = false
end

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
  local newBullet = Bullet({
    position = self.shootingPosition,
    size = {w=self.bulletSize * 2, h=self.bulletSize * 2}
  })
  return newBullet
end

function MachineGun.calcShootingPosition(self)
  self.ship:calcCenter()
  self.shootingPosition = Position({
    x = self.ship.center.x,
    y = (self.ship.center.y - self.ship.size.h / 2)
  })
end

function MachineGun.calcBulletPosition(self)
  -- TODO this needs to be much more sophisticated
  return {
    x = 0,
    y = -(self.speed)
  }
end

function MachineGun.fire(self)
  -- fire a new bullet
  self:calcShootingPosition()
  local newBullet = self:makeBullet()
  table.insert(self.bullets, newBullet)
end

function MachineGun.update(self, dt)
  -- check collisions with every enemy
  for i, enemy in pairs(self.ship.enemies) do
    for j, bullet in pairs(self.bullets) do
      if enemy:collidesWith(bullet) then
        enemy:isHit(self.power)
        bullet.done = true
      end
    end
  end
  for i, bullet in pairs(self.bullets) do
    if bullet.done or bullet.position.out then
      table.remove(self.bullets, i) -- IMPORTANT! table.remove is CPU hungry
    else
      local move = self:calcBulletPosition()
      bullet.position:moveY(move.y)
      bullet.position:moveX(move.x)
    end
  end
end

function MachineGun.draw(self)
  local oldColor = {grph.getColor()}
  grph.setColor(self.bulletColor)
  for i, bullet in pairs(self.bullets) do
    -- draw the bullets into little filled
    -- circles
    if not bullet.position.out then
      grph.circle("fill", (bullet.position.x + self.bulletSize), bullet.position.y, self.bulletSize)
    end
  end
  grph.setColor(oldColor)
end

return MachineGun