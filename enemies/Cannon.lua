-----------------------------------------------------------
-- EnemyCannon 'class'
-----------------------------------------------------------

-- sprite -------------------------------------------------
local SPRITE = love.graphics.newImage( 'assets/sprites/enemies/cannon.png' )

-- EnemyCannon table --------------------------------------
local Cannon = {}

-- new EnemyCannon 'object' -------------------------------
function Cannon:new( x, y, dx, dy, damage )
  
  local cannon = {
    damage = damage,
    dx = dx,
    dy = dy,
    sprite = SPRITE,
    speed = 400,
    x = x,
    y = y,
    width = SPRITE:getWidth(),
    height = SPRITE:getHeight()
  }
  
  -- draw enemy cannon ------------------------------------
  function cannon:draw()
    love.graphics.setColor( 1, 1, 1, 1 )
    local x = math.floor( self.x )
    local y = math.floor( self.y )
    love.graphics.draw( self.sprite, x, y, 0, 1, 1, self.width/2, self.height/2 )
  end
  
  -- update enemy cannon ----------------------------------
  function cannon:update( dt )
    self.x = self.x + dt * self.dx * self.speed
    if self.dy then
      self.y = self.y + dt * self.dy * self.speed
    else
      self.y = self.y + dt * self.speed
    end
    self.body = {
      x = self.x,
      y = self.y,
      size = math.min( self.sprite:getWidth(), self.sprite:getHeight() )
    }
  end
  
  -- return enemy Cannon instance -------------------------
  return cannon

end

-- return enemy Cannon 'class' -----------------------------
return Cannon