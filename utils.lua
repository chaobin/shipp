local utils = {}

utils.string = require('string')

utils.string.split = function (s, sep)
  local sep = sep or "%S+"

  local t = {}
  local i = 0
  
  for word in string.gmatch(s, sep) do
    table.insert(t, word)
  end
  
  return t
end

utils.string.shuffle = function (s, sep)
  local sep = sep or "%S+"
  local _s = string.split(s, sep)
  local n = #_s
  
  while n >= 2 do
    local k = math.random(n) -- 1 <= k <= length
    -- Quick swap
    _s[n], _s[k] = _s[k], _s[n]
    n = n - 1
  end
  
  return table.concat(_s)
end

return utils
