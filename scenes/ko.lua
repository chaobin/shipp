-- imported names
local BaseScene = require "scenes.base"
local grph = love.graphics

--
-- KO Scene Class
local KO = {}
KO.__index = KO

setmetatable(KO, {
  __index = BaseScene,
  __call = function ( cls, ... )
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function KO._init ( self, ... )
  self._base = BaseScene
  self._base._init(self, ...)
end

function KO.play ( self, ... )
  grph.print('you are fucked', 0, 20)
end

return KO