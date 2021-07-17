-----------------------------------------------------------
-- Delta 'class'
-----------------------------------------------------------

-- sprite -------------------------------------------------
local SPRITE = love.graphics.newImage( 'assets/sprites/enemies/ships/delta.png' )

-- Delta table --------------------------------------------
local Delta = {}

-- new delta object ---------------------------------------
function Delta:new( x )
  local sprite = SPRITE
  local delta = {
    rotation = 1,
    dir = 0,
    life = 10,
    speed = 100,
    sprite = sprite,
    cx = x,
    cy = -sprite:getHeight(),
    value = 400,
    shotDelay = 1.5,
    shotTimer = 1,
    shotDamage = 4
  }
  function delta:draw()
    love.graphics.setColor( 1, 1, 1, 1 )
    love.graphics.draw( self.sprite, self.x, self.y, self.dir, 1, 1, self.sprite:getWidth()/2, self.sprite:getHeight()/2 )
  end
  function delta:update( dt )
    self.dir = self.dir + 0.05
    self.x = self.cx + math.cos(self.dir) * 100
    self.y = self.cy + math.sin(self.dir) * 100
    self.cy = self.cy + dt * self.speed
    self.body = {
      x = self.x,
      y = self.y,
      size = math.max( self.sprite:getWidth(), self.sprite:getHeight() ) / 2
    }
    self.shotTimer = self.shotTimer + dt
    if self.shotTimer > self.shotDelay then
      local player = require('player/player')
      local angle = getDifferenceBetween( self, player )
      if angle then
        local enemyShots = require('enemies/enemyShots')
        enemyShots:new( 'EnemyCannon', self.x, self.y, angle.dx, angle.dy, self.shotDamage )
      end
      self.shotTimer = 1
    end
  end
  return delta
end

-- return Delta 'class' -----------------------------------
return Delta