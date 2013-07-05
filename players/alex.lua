-- imported names
local BasePlayer = require "players.base"
local V = require "values"
local grph = love.graphics

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
  local options = options or {}
  
  options.imgs = options.imgs or {
    image = 'img/spaceride.png'
  }
  options.hp = options.hp or 10
  BasePlayer._init(self, options)

  self.bullets = {}
end

function Alex.isHit(self)
  self.hp = self.hp - 0.2
end

function Alex.destroy(self)
  self:calcCenter()
  grph.circle("line", self.center.x, self.center.y, self.rad * 3, 100)
end

function Alex.fire(self)
  self:calcCenter()
  print(self.position.x, self.position.y)
  local bullet = {
    x = self.center.x,
    y = self.position.y - 10
  }
  table.insert(self.bullets, bullet)
end

function Alex.update(self, dt)
  BasePlayer.update(self, dt)
  for i, bullet in pairs(self.bullets) do
    bullet.y = bullet.y - 10
  end
end

function Alex.draw(self)
  BasePlayer.draw(self)
  local oldColor = {grph.getColor()}
  grph.setColor(V.red)
  for i, bullet in pairs(self.bullets) do
    grph.circle("fill", bullet.x, bullet.y, 2)
  end
  grph.setColor(oldColor)
end

return Alex