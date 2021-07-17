-----------------------------------------------------------
-- stateCredits module
-----------------------------------------------------------
local background = require('background')
local gui = require('gui')
local stateMenu = require('states/stateMenu')

-- stateCredit table --------------------------------------
local stateCredits = {}

function stateCredits:init()
  love.draw = self.draw
  love.mousepressed = gui.mousepressed
  love.update = self.update
  
  local text = ''
  text = text .. 'Sprites:\n'
  text = text .. 'Kenney\n'
  text = text .. 'Game Developers Studio\n'
  text = text .. 'https://rustybulletgames.itch.io/\n\n'
  text = text .. 'Music:\n'
  text = text .. 'Eric Matyas\n'
  text = text .. '(https://Soundimage.org)\n\n'
  text = text .. 'Sound:\n'
  text = text .. 'https://bleeoop.itch.io\n'
  text = text .. 'Cube Engine Games\n\n'
  text = text .. 'Framework:\n'
  text = text .. 'https://love2d.org/\n\n'
  text = text .. 'Other:\n'
  text = text .. 'https://www.aseprite.org/\n'
  text = text .. 'https://studio.zerobrane.com/'
 
  gui:init()
  local dialog = gui:Window( 'Credits', WIDTH*0.75, HEIGHT*0.5, 7 )
  local textArea = gui:Text( text, 'left', 6 )
  local button = gui:Button( 'BACK', 1 )
  button.callback = function()
    gameState( stateMenu )
  end
  dialog:add( textArea )
  dialog:add( button )
  
end

function stateCredits.draw()
  background:draw()
  gui:draw()
end

function stateCredits.update( dt )
  background:update( dt )
end

-- return stateCredit module
return stateCredits
