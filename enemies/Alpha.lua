-----------------------------------------------------------
-- Alpha 'class'
-----------------------------------------------------------

-- sprite -------------------------------------------------
local SPRITE = love.graphics.newImage( 'assets/sprites/enemies/ships/alpha.png' )

-- alpha table --------------------------------------------
local Alpha = {}

-- new alpha object ---------------------------------------
function Alpha:new( x )
  local sprite = SPRITE
  local alpha = {
    life = 10,
    rotation = 0,
    speed = 300,
    sprite = sprite,
    value = 1000,
    x = x,
    y = -sprite:getHeight()
  }
  function alpha:draw()
    love.graphics.draw( self.sprite, self.x, self.y, self.rotation, 1, 1, self.sprite:getWidth()/2, self.sprite:getHeight()/2 )
  end
  function alpha:update( dt )
    self.y = self.y + dt * self.speed
    self.rotation = self.rotation + dt * 5
    self.body = {
      x = self.x,
      y = self.y,
     size = math.min( self.sprite:getWidth(), self.sprite:getHeight() ) / 2
    }
  end
  return alpha
end

-- return Alpha 'class' -----------------------------------
return Alpha