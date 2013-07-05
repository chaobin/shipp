-- imported names
local BaseBackground = require "backgrounds.base"

--
-- Tristar background class
local Tristar = {}
Tristar.__index = Tristar

setmetatable(Tristar,{
  __index = BaseBackground,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function Tristar._init(self, options)
  local options = options or {}
  local image = 'img/tristar.jpg'
  options.img = options.img or image
  options.speed = options.speed or 0.5
  
  BaseBackground._init(self, options)
end


return Tristar