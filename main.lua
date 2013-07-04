-- imported names
local Alex = require "players.alex"
local E1 = require "enemies.e1"
local Background = require "background"
local V = require "values"


function love.load()
  local grph = love.graphics

  bg = Background({
    img = 'img/tristar.png',
    speed = 0.5
  })

  player = Alex({
    imgs = {
      image = 'img/spaceride.png'
    }
  })
  
  enemies = {
    enemy = E1({
      imgs = {
        image = 'img/spaceride.png'
      },
      direction = V.down,
      position = {x=500, y=100},
      scale = 0.2,
      speed = 2
    }),
  
    enemy2 = E1({
      imgs = {
        image = 'img/spaceride.png'
      },
      direction = V.down,
      position = {x=300, y=80},
      scale = 0.2,
      speed = 1
    })
  }

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
    grph.print("ship scale: " .. player.scale, 0, 32)
    grph.print("frame/sec: " .. love.timer.getFPS(), 0, 48)
  end
end


function love.update(dt)
  bg:update(dt)
  for key, enemy in pairs(enemies) do
    enemy:update(dt)
  end
  player:update(dt)
end

function love.keypressed(key, unicode)
  player:listenToPressedKeys(key)
end

function love.keyreleased(key)
  player:listenToReleasedKeys(key)
end