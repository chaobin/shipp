local Ship = require "ship"
-- placeholder for all settings
local settings = {}

settings.controller = 'keyboard'

-- sub placeholder for colors
settings.color = require "color"

-- sub placeholder for fonts
settings.font = {}
settings.font.big = love.graphics.newFont(16)

function love.load()
  local grph = love.graphics
  local color = settings.color
  local font = settings.font

  ship = Ship()

  grph.setBackgroundColor(color.black)
  grph.setColor(color.blue)
  grph.setFont(font.big)
end

function love.draw()
  local grph = love.graphics

  ship:draw()
  grph.print(string.format("ship speed: " .. ship.speed), 0, 0)
  grph.print("ship position: " .. ship.position.x .. ', ' .. ship.position.y, 0, 16)
  grph.print("ship scale: " .. ship.scale, 0, 32)
end

function love.update()
  if settings.controller == 'mouse' then
    ship:moveByMouse()
  elseif settings.controller == 'keyboard' then
    ship:moveByKeys()
  end
end

function love.keypressed(key, unicode)
  ship:listenToPressedKeys(key)
end