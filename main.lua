-- imported names
local Alex = require "players.alex"
local E1 = require "enemies.e1"
local Tristar = require "backgrounds.tristar"
local V = require "values"


function love.load()
  grph = love.graphics

  bg = Tristar()
  player = Alex()
  enemies = {}
  for i=1, 10 do
    table.insert(enemies, E1())
  end
  grph.setBackgroundColor(V.black)
  grph.setColor(V.blue)
  grph.setFont(V.fontbig)
end

function love.draw()
  local grph = love.graphics

  do -- update frame
    local oldColor = {grph.getColor()}
    grph.setColor(V.white)
    bg:draw()
    player:draw()
    for key, enemy in pairs(enemies) do
      enemy:draw()
    end
    grph.setColor(oldColor)
  end

  do -- print game stats
    grph.print(string.format("ship speed: " .. player.speed), 0, 0)
    grph.print("ship position: " .. player.position.x .. ', ' .. player.position.y, 0, 16)
    grph.print("frame/sec: " .. love.timer.getFPS(), 0, 48)
  end
end


function love.update(dt)
  bg:update(dt)
  for key, enemy in pairs(enemies) do
    enemy:update(dt)
    if player:collidesWith(enemy) then
      player:isHit()
    end
  end
  player:update(dt)
end

function love.keypressed(key, unicode)
  player:listenToPressedKeys(key)
end

function love.keyreleased(key)
  player:listenToReleasedKeys(key)
end