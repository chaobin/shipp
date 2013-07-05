-- imported names
local TristarStage = require "stages.tristar_invaders"
local grph = love.graphics

function love.load()
  stage = TristarStage()
  stage:load()
end

function love.draw()
  stage:draw()
  stage:stats()
end

function love.update(dt)
  stage:update(dt)
end

function love.keypressed(key, unicode)
  stage:keypressed(key, unicode)
end

function love.keyreleased(key)
  stage:keyreleased(key)
end