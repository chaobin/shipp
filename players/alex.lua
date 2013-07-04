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
  
  BasePlayer._init(self, options)
end


return Alex