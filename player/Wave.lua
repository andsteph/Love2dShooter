-----------------------------------------------------------
-- Wave 'class'
-----------------------------------------------------------

-- sprite -------------------------------------------------
local SPRITE = love.graphics.newImage( 'assets/sprites/player/wave.png' )

-- wave table ---------------------------------------------
local Wave = {
  DELAY = 0.5,
}

-- new Wave 'object' --------------------------------------
function Wave:new( x, y, dx )
  local wave = {
    color = 'Purple',
    damage = 2,
    speed = -800,
    sprite = SPRITE,
    x = x,
    y = y,
    dx = dx or 0
  }
  function wave:draw()
    love.graphics.setColor( 1, 0, 1, 1 )
    love.graphics.draw( self.sprite, self.x, self.y, self.dx*-1, 1, 1, self.sprite:getWidth()/2, self.sprite:getHeight()/2 )
  end
  function wave:update( dt )
    self.y = self.y + dt * self.speed
    self.x = self.x + dt * self.dx * self.speed
    self.body = {
      x = self.x,
      y = self.y,
      size = math.min( self.sprite:getWidth(), self.sprite:getHeight() )
    }
  end
  return wave
end

-- return Wave 'class' ------------------------------------
return Wave