-----------------------------------------------------------
-- Cannon 'class'
-----------------------------------------------------------

local SPRITE = love.graphics.newImage( 'assets/sprites/player/cannon.png' )

-- cannon table -------------------------------------------
local Cannon = {
  DELAY = 0.2
}

-- new Cannon 'object' ------------------------------------
function Cannon:new( x, y )
  sound:playEffect( 'CANNON' )

  local cannon = {
    color = 'Cyan',
    damage = 2,
    delay = Cannon.DELAY,
    index = 1,
    power = player.cannon,
    speed = -1000,
    sprite = SPRITE,
    x = x,
    y = y
  }
  function cannon:draw()
    love.graphics.setColor( 0, 1, 1, 1 )
    love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1, self.sprite:getWidth() / 2, self.sprite:getHeight() / 2)
  end
  function cannon:update( dt )
    self.y = self.y + dt * self.speed
    self.body = {
      x = self.x,
      y = self.y,
      size = math.min(self.sprite:getWidth(), self.sprite:getHeight()) / 2 * self.power
    }
  end
  return cannon
end

-- return Cannon 'class' ----------------------------------
return Cannon
