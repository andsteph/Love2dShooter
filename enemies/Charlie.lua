-----------------------------------------------------------
-- Charlie 'class'
-----------------------------------------------------------

-- sprite -------------------------------------------------
local SPRITE = love.graphics.newImage( 'assets/sprites/enemies/ships/charlie.png' )

-- Charlie table ------------------------------------------
local Charlie = {}

-- new charlie object -------------------------------------
function Charlie:new( x )

  local charlie = {
    life = 30,
    radians = 0,
    shotDamage = 3,
    shotDelay = 1.5,
    shotTimer = 1,
    speed = 200,
    sprite = SPRITE,
    value = 300,
    x = x,
    y = -SPRITE:getHeight()
  }

  -- draw charlie -----------------------------------------
  function charlie:draw()
    love.graphics.setColor( 1, 1, 1, 1 )
    self.radians = getRadiansBetween( self, player ) * -1
    love.graphics.draw( self.sprite, self.x, self.y, self.radians, 1, 1, self.sprite:getWidth()/2, self.sprite:getHeight() )
  end

  -- update charlie ---------------------------------------
  function charlie:update( dt )
    local diff = getDifferenceBetween( self, player )
    if diff then
      self.x = self.x + dt * diff.dx * self.speed
    end
    self.y = self.y + dt * self.speed
    self.body = {
      x = self.x,
      y = self.y,
      size = self.sprite:getWidth()/2
    }
    self.shotTimer = self.shotTimer + dt
    if self.shotTimer > self.shotDelay then
      local angle = getDifferenceBetween( self, player )
      enemies.shots:new( 'Cannon', self.x, self.y, angle.dx, angle.dy, self.shotDamage )
      self.shotTimer = 1
    end
  end
  
  -- return charlie object --------------------------------
  return charlie

end

-- return Charlie 'class' ---------------------------------
return Charlie