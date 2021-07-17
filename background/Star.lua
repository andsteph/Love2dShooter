-----------------------------------------------------------
-- Star 'class'
-----------------------------------------------------------

-- Star table ---------------------------------------------
local Star = {}

-- images -------------------------------------------------
local SPRITES = {}
for i = 1, 9 do
  SPRITES[i] = love.graphics.newImage( 'assets/sprites/stars/star_0' .. i .. '.png' )
end

-- new star object ----------------------------------------
function Star:new( y )
  
  local star = {
    speed = love.math.random( 50 ) + 50,
    variant = love.math.random( 9 ),
    x = love.math.random( WIDTH ) - 1,
    y = y,
  }
  star.sprite = SPRITES[star.variant]
  
  -- draw star --------------------------------------------
  function star:draw()
    love.graphics.setColor( 0.5, 0.5, 0.5, 1 )
    love.graphics.draw( self.sprite, self.x, self.y, 0, 0.05, 0.05, self.sprite:getWidth()/2, self.sprite:getHeight()/2 )
    love.graphics.setColor( 1, 1, 1, 1 )
  end
  
  -- reset star position ----------------------------------
  function star:reset()
    self.x = love.math.random( WIDTH ) - 1
    self.y = -50
  end
  
  -- update star ------------------------------------------
  function star:update( dt )
    self.y = self.y + dt * self.speed
  end
  
  -- return star object -----------------------------------
  return star

end

-- return Star 'class' ------------------------------------
return Star