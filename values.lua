--
-- All value definition in game

--
-- directions
local V = {}

V.up, V.left, V.down, V.right = math.rad(0), math.rad(90), math.rad(180), math.rad(270)

--
-- colors
V.white = {255, 255, 255}
V.black = {0, 0, 0}
V.purple = {135, 28, 64}
V.blue = {49, 119, 168}
V.red = {255, 0, 0}

--
-- fonts
V.fontbig = love.graphics.newFont(16)

return V
