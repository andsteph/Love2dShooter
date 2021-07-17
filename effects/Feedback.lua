-----------------------------------------------------------
-- Feedback 'class
-----------------------------------------------------------

local DIR = 'assets/sprites/effects/feedback/'
local SPRITES = {}
for f, file in ipairs( love.filesystem.getDirectoryItems(DIR) ) do
  SPRITES[f] = love.graphics.newImage( DIR .. file )
end

-- Feedback table -----------------------------------------
local Feedback = {}

-- new Feedback 'object' ----------------------------------
function Feedback:new( x, y )
  
  local feedback = {
    x = x,
    y = y,
    width = SPRITES[1]:getWidth(),
    height = SPRITES[1]:getHeight(),
    index = 1
  }
  
  -- draw feedback ----------------------------------------
  function feedback:draw()
    local index = math.floor( self.index )
    local image = SPRITES[index]
    love.graphics.draw(image, self.x, self.y, 0, 1, 1, self.width, self.height )
  end
  
  -- update feedback --------------------------------------
  function feedback:update( dt )
    self.index = self.index + dt * 50
    if self.index > #SPRITES then
      self.done = true
      self.index = 1
    end
  end
  
  -- return feedback object -------------------------------
  return feedback
  
end

-- return Feedback 'class' --------------------------------
return Feedback