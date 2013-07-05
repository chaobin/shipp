-- imported names
local O = require "O"
local grph = love.graphics

--
-- Base Stage Class
local Stage = {}
Stage.__index = Stage

setmetatable(Stage, {
  __index = O,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self._base = O
    self:_init(...)
    return self
  end
})

function Stage._init( self, ... )
  self._base._init(self, ...)
end

function Stage.load( self, ... )
  -- called from love.load in main.lua
  --
  -- this function should load
  -- as many laodable resources
  -- as possible so that later in game
  -- you don't need to load stuff like
  -- images or files which lowers framerate
end

function Stage.update( self, dt )
  -- called from love.update in main.lua
  --
  -- this function maintains all internal
  -- states currently existing in the game
  -- such as the positions of all bodies
  -- speed and stuff of player object
end

function Stage.draw( self, ... )
  -- called from love.draw in main.lua
  --
  -- draw stuff
end

function Stage.begin( self, ... )
  -- When a stage begins
end

function Stage.fail( self, ... )
  -- When player fails a stage
end

function Stage.pass( self, ... )
  -- When player passes a stage
end

function Stage.stats( self, ... )
  -- Called from love.draw in main.lua
  -- Log the gameplay stats
  grph.print("frame/sec: " .. love.timer.getFPS(), 0, 0)
end

function Stage.keypressed( self, ... )
  -- event dispatcher for keypressed
end

function Stage.keyreleased( self, ... )
  -- event dispatcher for keyreleased
end

function Stage.loadPlayer( self, ... )
  -- determine and setup and player
end

return Stage