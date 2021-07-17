-----------------------------------------------------------
-- stateComplete module
-----------------------------------------------------------

local background = require('background')

local textY = HEIGHT

-- stateComplete table ------------------------------------
local stateComplete = {}

-- init stateComplete -------------------------------------
function stateComplete:init()
  love.draw = self.draw
  love.update = self.update
end

-- draw stateComplete -------------------------------------
function stateComplete.draw()
  background:draw()
  love.graphics.setFont( LARGEFONT )
  love.graphics.setColor( 1, 1, 1, 1 )
  love.graphics.printf( 'LEVEL COMPLETE', 0, textY, WIDTH, 'center' )
end

-- update stateComplete -----------------------------------
function stateComplete.update( dt )
  background:update( dt )
  textY = textY - dt * 500
  if textY < 0 then
    gameState( stateIntro )
  end
end

-- return stateComplete module ----------------------------
return stateComplete