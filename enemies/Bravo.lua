-----------------------------------------------------------
-- Bravo 'class'
-----------------------------------------------------------

-- sprite -------------------------------------------------
local SPRITE = love.graphics.newImage( 'assets/sprites/enemies/ships/bravo.png' )

-- Bravo table --------------------------------------------
local Bravo = {}

-- new bravo object ---------------------------------------
function Bravo:new( x )
  local bravo = {
    life = 20,
    name = 'Bravo',
    speed = 200,
    sprite = SPRITE,
    shotDamage = 2,
    shotDelay = 2,
    shotTimer = 1,
    value = 2000,
    x = x,
  }
  bravo.width = SPRITE:getWidth()
  bravo.height = SPRITE:getHeight()
  bravo.y = -bravo.height
  function bravo:draw()
    local y = math.floor( self.y )
    love.graphics.setColor( 1, 1, 1, 1 )
    love.graphics.draw( self.sprite, self.x, y, 0, 1, 1, self.width/2, self.height/2 )
  end
  
  -- update bravo -----------------------------------------
  function bravo:update( dt )
    self.y = self.y + dt * self.speed
    self.body = {
      x = self.x,
      y = self.y,
      size = self.width / 2
    }
    self.shotTimer = self.shotTimer + dt
    if self.shotTimer > self.shotDelay then
      local angle = getDifferenceBetween( self, player )
      if angle then
        enemies.shots:new( 'Cannon', self.x, self.y, angle.dx, angle.dy, self.shotDamage )
      end
      self.shotTimer = 1
    end
  end
  return bravo
end

-- return Bravo 'class' -----------------------------------
return Bravo