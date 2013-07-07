-- imported names
local grph = love.graphics

local O = require "O"
local Position = require "position"
local V = require "values"

--
-- A class represents a Ship
local Ship = {}
Ship.__index = Ship

-- so that an instance can be created
-- by Ship()
setmetatable(Ship, {
  __index = O,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function Ship._init(self, options)
  O._init(self, options)
  -- speed, images, geometries
  
  self.image = grph.newImage(options.imgs.image)
  self.speedmin, self.speedmax = 5, 12
  self:setSpeed(options.speed)
  self.direction = options.direction or V.up
  self.window = {x=grph.getWidth(), y=grph.getHeight()}
  self.size = {
    w = self.image:getWidth(),
    h = self.image:getHeight()
  }
  self.boundaries = {
    x = (self.window.x - self.size.w / 2),
    y = (self.window.y - self.size.h / 2)
  }
  self:calcRadius()

  --
  -- gameplays

  -- initial hp
  self.hp = options.hp or 0
  -- damage per hit
  self.damage = options.damage or 0
  -- defense lowers damage
  self.defense = options.defense or 0
  -- weapon, nil or Weapon subclass
  self.weapons = {}
  self.currentWeapon = nil
  if options.weapon then
    self:addWeapon(options.weapon)
  end
end

function Ship.calcRadius(self)
  -- rectangle shaped only
  self.rad = math.max(self.size.w, self.size.h) / 2
end

function Ship.calcCenter(self)
  self.center = {
    x = (self.position.x + self.size.w / 2),
    y = (self.position.y + self.size.h / 2)
  }
  return self.center
end

-- Moving controls

function Ship.setSpeed(self, speed)
  if (speed == 'fast') then
    self.speed = self.speedmax
  elseif (speed == 'slow') then
    self.speed = self.speedmin
  else
    self.speed = (self.speedmin + self.speedmax) / 2
  end
end

function Ship.moveDown(self)
  self.position:moveY(self.speed)
end

function Ship.moveUp(self)
  self.position:moveY(-(self.speed))
end

function Ship.moveRight(self)
  self.position:moveX(self.speed)
end

function Ship.moveLeft(self)
  self.position:moveX(-(self.speed))
end

function Ship.accelerate(self)
  if (self.speed < self.speedmax) then
    self.speed = self.speed + 0.07
  end
end

function Ship.slowdown(self)
  if (self.speed > self.speedmin) then
    self.speed = self.speed - 0.1
  end
end

-- HP systems
function Ship.isHit(self, damage)
  -- Calculate the damage
  if self:isDead() then
    self:dies()
  else
    local damage = damage or self.damage
    local damage = (self.damage - self.defense)
    self.hp = self.hp - self.damage
  end
end

function Ship.isDead(self)
  return (self.hp <= 0)
end

function Ship.dies(self)
  -- do things when dead
end

function Ship.destroy(self)
  -- Subclass should override this
  -- to simulate the blaster
end

-- Weapons

function Ship.addWeapon(self, weapon)
  if weapon then
    self.weapons[weapon.code] = weapon
    -- automatically arm this weapon up to kill!!!
    self:arm(weapon)
  end
end

function Ship.arm(self, weapon)
  -- set the currentWeapon to this weapon
  if weapon then
    self.currentWeapon = weapon
  end
end

function Ship.fire(self)
  if self.currentWeapon then
    self.currentWeapon:fire()
  end
end

-- Update and draw frames

function Ship.draw(self)
  grph.draw(self.image, self.position.x, self.position.y, self.direction)

  if self.currentWeapon then
    self.currentWeapon:draw()
  end
end

function Ship.update(self, dt)
  if self.currentWeapon then
    self.currentWeapon:update(dt)
  end
end

return Ship