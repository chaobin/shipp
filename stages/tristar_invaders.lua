-- imported names
local BaseStage = require "stages.base"
local TristarScene = require "scenes.tristar"
local KOScene = require "scenes.ko"
local Alex = require "players.alex"
local E1 = require "enemies.e1"

--
-- Tristar Invaders Stage Class

local TristarInvader = {}
TristarInvader.__index = TristarInvader

setmetatable(TristarInvader, {
  __index = BaseStage,
  __call = function(cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end
})

function TristarInvader._init(self, ...)
  self.tristarscene = nil
  self.koscene = nil
  self.enemies = {}
  self.player = nil
end

function TristarInvader.loadScenes(self, ...)
  self.tristarscene = TristarScene()
  self.koscene = KOScene()
  -- set the current scene
  self.currentScene = self.tristarscene
end

function TristarInvader.loadPlayer(self, ...)
  -- load player
  self.player = Alex({
    enemies = self.enemies
  })
end

function TristarInvader.loadEnemies(self, ...)
  for i=1, 10 do
    local e = E1()
    table.insert(self.enemies, e)
  end
end

function TristarInvader.load(self, ...)
  self:loadScenes()
  self:loadPlayer()
  self:loadEnemies()
end

function TristarInvader.update(self, dt)
  if self.player:isDead() then
    self.currentScene = self.koscene
  end
  self.currentScene:next(dt)
  self.player:update(dt)
  for index, enemy in pairs(self.enemies) do
    -- check any collisions
    if self.player:collidesWith(enemy) then
      self.player:isHit()
    end
    enemy:update(dt)
  end
end

function TristarInvader.draw(self, ...)
  self.currentScene:play()
  if not self.player:isDead() then
    self.player:draw()
    for index, enemy in pairs(self.enemies) do
      enemy:draw()
    end
  end
end

function TristarInvader.keyreleased(self, key)
  -- body
  self.player:keyreleased(key)
end

function TristarInvader.keypressed(self, key)
  self.player:keypressed(key)
end

return TristarInvader