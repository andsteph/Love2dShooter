-----------------------------------------------------------
-- simple message box with ok button
-----------------------------------------------------------

local background = require('background')
local gui = require('gui')

local stateMessage = {}

function stateMessage:init( options )
  love.draw = self.draw
  love.mousepressed = gui.mousepressed
  love.update = self.update
  gui:init()
  local window = gui:Window( options.title, WIDTH*.75, HEIGHT/3, 2 )
  local text = gui:Text( options.text )
  local button = gui:Button( 'OK' )
  button.callback = options.callback
  window:add( text )
  window:add( button )
end

function stateMessage.draw()
  background:draw()
  gui:draw()
end

function stateMessage.update( dt )
  background:update( dt )
end

return stateMessage