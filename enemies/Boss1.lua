-----------------------------------------------------------
-- Boss1 'class'
-----------------------------------------------------------

-- sprite for boss ----------------------------------------
local SPRITE = love.graphics.newImage('assets/sprites/enemies/bosses/Boss1.png')

-- Boss1 table --------------------------------------------
local Boss1 = {}

-- new Boss1 'object' -------------------------------------
function Boss1:new()
  
  local height, width = SPRITE:getDimensions()
  
  local boss1 = {
    x = WIDTH / 2,
    y = -height,
    width = width,
    height = height,
    direction = 1,
    speed = 100,
    sprite = SPRITE,
    life = 1000,
    value = 10000,
    shot = {
      damage = 10,
      delay = 0.5,
      timer = 0,
      speed = 200,
    }
  }
  
  -- draw boss1 -------------------------------------------
  function boss1:draw()
    love.graphics.setColor( 1, 1, 1, 1 )
    love.graphics.draw( self.sprite, self.x, self.y, 0, 1, 1, self.width/2, self.height/2 )
  end
  
  -- update boss1 -----------------------------------------
  function boss1:update( dt )
    self.shot.timer = self.shot.timer + dt
    if self.shot.timer > self.shot.delay then
      self.shot.timer = 0
      enemies.shots:new( 'Cannon', self.x, self.y, 0, self.shot.speed, 100 )
    end
    if self.y < self.sprite:getHeight() then
      self.protected = true
      self.y = self.y + dt * self.speed
    else
      self.protected = false
      self.x = self.x + dt * self.direction * self.speed
      if self.x <= 0 or self.x >= WIDTH then
        self.direction = self.direction * -1
      end
    end
    self.body = {
      x = self.x,
      y = self.y,
      size = self.width / 2
    }
  end
  
  -- return boss object -----------------------------------
  return boss1

end

-- return Boss1 'class' -----------------------------------
return Boss1