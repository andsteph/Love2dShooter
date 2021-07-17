-----------------------------------------------------------
-- Missile 'class'
-----------------------------------------------------------

-- sprite -------------------------------------------------
local SPRITE = love.graphics.newImage('assets/sprites/player/missile.png')

-- missile table ------------------------------------------
local Missile = {
  DELAY = 1
}

-- new Missile 'object' -----------------------------------
function Missile:new( x, y )
  local missile = {
    color = 'Red',
    delay = Missile.DELAY,
    lock = nil,
    sprite = SPRITE,
    damage = 10,
    speed = 500,
    x = x,
    y = y
  }
  function missile:draw()
    love.graphics.setColor( 1, 0, 0, 1 )
    local radians = 0
    if self.lock then
      radians = (getRadiansBetween( self, self.lock ) + 3.14)*-1
    end
    love.graphics.draw(self.sprite, self.x, self.y, radians, 1, 1, self.sprite:getWidth() / 2, self.sprite:getHeight() / 2)
  end
  function missile:update( dt )
    if not self.lock or self.lock.dead or self.lock.protected then
      self.lock = enemies:closest( self )
      self.y = self.y - dt * self.speed
    else
      local difference = getDifferenceBetween( self, self.lock )
      if difference then
        self.x = self.x + dt * difference.dx * self.speed
        self.y = self.y + dt * difference.dy * self.speed
      else
        self.y = self.y - dt * self.speed
      end
    end
    self.body = {
      x = self.x,
      y = self.y,
      size = math.min(self.sprite:getWidth(), self.sprite:getHeight())
    }
  end
  return missile
end

-- return Missile 'class' ---------------------------------
return Missile