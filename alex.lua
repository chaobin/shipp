-- imported names
local Ship = require "ship"

--
-- Alex Ship Class
local Alex = {}
Alex.__index = Alex

setmetatable(Alex, {
  __index = Ship,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self._base = Ship
    self:_init(...)
    return self
  end
})

function Alex._init(self, options)
  self._base._init(self, options)
end

return Alex