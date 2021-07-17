-----------------------------------------------------------
-- background module
-----------------------------------------------------------

local MODULE_DIR = (...):gsub('%.init$', '')
local stars = require( MODULE_DIR .. '.stars' )

-- background image ---------------------------------------
local IMAGE = love.graphics.newImage( 'assets/backgrounds/nebula01.png' )
local IMAGE_WIDTH = IMAGE:getWidth()
local IMAGE_HEIGHT = IMAGE:getHeight()

-- background table ---------------------------------------
local background = {}

-- draw background ----------------------------------------
function background:draw()
  love.graphics.setColor( 1, 1, 1, 0.5 )
  love.graphics.draw( IMAGE, WIDTH/2, self.y, 0, 1, 1, IMAGE_WIDTH/2, IMAGE_HEIGHT/2 )
  love.graphics.setColor( 1, 1, 1, 1 )
  stars:draw()
end

-- update background --------------------------------------
function background:update( dt )
  stars:update( dt )
end

-- return background module -------------------------------
return background