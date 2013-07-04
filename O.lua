-- imported names

--
-- The root of inheritance
local O = {}
O.__index = O

setmetatable(O, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function O._init(self, options)
  -- All subclass should override this
  -- for this constructor to do something
  -- useful
end

function O.mergeOptions(self, first, second)
  -- merge the second table into the first one
  for k,v in pairs(second) do first[k] = v end
  return results
end

function O.collidesWith(self, body)
  local dx = body.position.x - self.position.x
  local dy = body.position.y - self.position.y
  local dis = math.sqrt(dx * dx + dy * dy)
  return dis < (self.rad + body.rad)
end

return O
