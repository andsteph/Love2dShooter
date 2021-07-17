-----------------------------------------------------------
-- paused game state module
-----------------------------------------------------------
local background = require('background')
local gui = require('gui')

-- statePause table ---------------------------------------
local statePause = {}

-- initialize the game state (pause) ----------------------
function statePause:init()
    love.draw = self.draw
    love.keypressed = self.keypressed
    love.mousepressed = gui.mousepressed
    love.update = self.update
    gui:init()
    local window = gui:Window( 'PAUSED', WIDTH*.75, HEIGHT*.25, 2 )
    local backButton = gui:Button( 'BACK TO GAME' )
    backButton.callback = function()
      gameState( statePlay )
    end
    local quitButton = gui:Button( 'QUIT' )
    quitButton.callback = function()
      gameState( stateConfirm, {
          title='QUIT TO MENU?',
          text='Are you sure you want to quit?',
          cancelCallback = function()
            gameState( require('states/statePause') )
          end,
          okCallback = function()
            gameState( require('states/stateMenu') )
          end
        })
    end
    window:add( backButton )
    window:add( quitButton )
end

-- statePause draw ----------------------------------------
function statePause.draw()
    background:draw()
    gui:draw()
end

-- handle keypresses --------------------------------------
function statePause.keypressed( key, scancode, isrepeat )
  if key == 'escape' then
    gameState( require('states/statePlay') )
  end
end

-- update statePause --------------------------------------
function statePause.update( dt )
    background:update( dt )
end

-- return statePause module -------------------------------
return statePause