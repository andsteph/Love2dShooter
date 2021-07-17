-----------------------------------------------------------
-- stateMenu module
-----------------------------------------------------------

-- stateMenu table ----------------------------------------
local stateMenu = {}

-- init stateMenu -----------------------------------------
function stateMenu:init( options )
  love.mouse.setVisible(true)
  love.draw = self.draw
  love.mousepressed = gui.mousepressed
  love.update = self.update
  gui:init()
  local window = gui:Window( 'SPACE RUSH', WIDTH*.75, HEIGHT*.5, 4 )
  local startButton = gui:Button( 'START' )
  startButton.callback = function()
    local player = require('player/player')
    player:init( true )
    gameState( statePlay )
  end
  local settingsButton = gui:Button( 'SETTINGS' )
  settingsButton.callback = function()
    gameState( stateSettings )
  end
  local creditsButton = gui:Button( 'CREDITS' )
  creditsButton.callback = function()
    gameState( stateCredits )
  end
  local quitButton = gui:Button( 'QUIT' )
  quitButton.callback = function()
    gameState( 
      stateConfirm, {
        title = 'QUIT?',
        text = 'ARE YOU SURE YOU WANT TO QUIT?',
        cancelCallback = function()
          gameState( stateMenu )
        end,
        okCallback = function()
          love.event.quit()
        end
      }
    )
  end
  window:add( startButton )
  window:add( settingsButton )
  window:add( creditsButton )
  window:add( quitButton )
end

-- draw stateMenu -----------------------------------------
function stateMenu.draw()
  background:draw()
  gui:draw()
end

-- update stateMenu ---------------------------------------
function stateMenu.update(dt)
  background:update(dt)
end

-- return stateMenu module --------------------------------
return stateMenu
