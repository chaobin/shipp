-- imported names
local O = require "O"

--
-- Scene Base Class
local BaseScene = {}
BaseScene.__index = BaseScene

setmetatable(BaseScene, {
  __index = O,
  __call = function ( cls, ... )
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function BaseScene._init( self, ... )
  self._base = O
  self._base._init(self, ...)
end

function BaseScene.load( self, ... )
  -- body
end

function BaseScene.play ( self, ... )
end

function BaseScene.next ( self, ... )
end

function BaseScene.stop ( self, ... )
end

return BaseScene