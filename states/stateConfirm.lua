-- --------------------------------------------------------
-- stateConfirm module
-- --------------------------------------------------------

local background = require('background')
local gui = require('gui')

-- stateConfirm table -------------------------------------
local stateConfirm = {}

-- initialize stateConfirm --------------------------------
function stateConfirm:init( options )
  love.draw = self.draw
  love.mousepressed = gui.mousepressed
  love.update = self.update
  gui:init()
  local window = gui:Window( options.title, WIDTH*.75, HEIGHT/3, 4 )
  local text = gui:Text( options.text, 'center', 2 )
  local okButton = gui:Button( 'OK' )
  okButton.callback = options.okCallback
  local cancelButton = gui:Button( 'CANCEL' )
  cancelButton.callback = options.cancelCallback
  window:add( text )
  window:add( okButton )
  window:add( cancelButton )
end

-- draw stateConfirm --------------------------------------
function stateConfirm.draw()
  background:draw()
  gui:draw()
end

-- update stateConfirm ------------------------------------
function stateConfirm.update( dt )
  background:update( dt )
end

-- return stateConfirm module -----------------------------
return stateConfirm
