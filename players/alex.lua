-- imported names
local BasePlayer = require "players.base"
local V = require "values"

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
end

function Alex.isHit(self)
  self.hp = self.hp - 0.2
end

function Alex.destroy(self)
  self:calcCenter()
  grph.circle("line", self.center.x, self.center.y, self.rad * 3, 100)
end

return Alex