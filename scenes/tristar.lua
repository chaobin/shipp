-- imported names
local BaseScene = require "scenes.base"
local TristarBG = require "backgrounds.tristar"

--
-- TristarScene Class
local TristarScene = {}
TristarScene.__index = TristarScene

setmetatable(TristarScene, {
  __index = BaseScene,
  __call = function ( cls, ... )
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function TristarScene._init ( self, ... )
  self._base = BaseScene
  self._base._init(self, ...)
  self.background = TristarBG()
end

function TristarScene.play ( self, ... )
  self.background:draw()
end

function TristarScene.next ( self, dt )
  self.background:update(dt)
end

return TristarScene