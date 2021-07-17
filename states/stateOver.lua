-----------------------------------------------------------
-- game over state
-----------------------------------------------------------

local background = require('background')
local gui = require('gui')

local stateOver = {}

function stateOver:init()
  love.mouse.setVisible( true )
  love.draw = self.draw
  love.mousepressed = gui.mousepressed
  love.update = self.update
  local window = gui:Window('GAME OVER', WIDTH*0.75, HEIGHT*0.33, 2)
  local playAgainButton = gui:Button('PLAY AGAIN')
  playAgainButton.callback = function()
    gameState( statePlay )
  end
  local menuButton = gui:Button('RETURN TO MENU')
  menuButton.callback = function()
    gameState( stateMenu )
  end
  window:add( playAgainButton )
  window:add( menuButton )
end

function stateOver.draw()
  background:draw()
  gui:draw()
end

function stateOver.update( dt )
  background:update( dt )
end

return stateOver