--------------------------------------------------------------
-- Echo 'class'
--------------------------------------------------------------

-- sprite ----------------------------------------------------
local SPRITE = love.graphics.newImage( 'assets/sprites/enemies/echo.png' )

-- Echo table ---------------------------------------------
local Echo = {}

function Echo:new( x )
  local sprite = SPRITES.SHIPS[math.random(1, #SPRITES.SHIPS)]
  local echo = {
    dir = 0,
    sprite = sprite,
    y = HEIGHT / 2
  }
  if side == 'left' then
    echo.cx = -1000
    echo.direction = 'right'
  else
    echo.cx = WIDTH + 1000
    echo.direaction = 'left'
  end
  function echo:draw( dt )
    love.graphics.setColor( 1, 1, 1, 1 )
    love.graphics.draw( self.sprite, self.x, self.y, 0, 1, 1, self.sprite:getWidth()/2, self.sprite:getHeight()/2 )
  end
  function echo:update( dt )
    self.x = self.cx + math.cos(self.dir) * 100
    self.y = self.cy + math.sin(self.dir) * 100
  end
  table.insert( enemies, echo )
end

-- get closest hazard (to source) -------------------------
function enemies:closest( source )
  local result = nil
  for i, hazard in ipairs( self ) do
    local distance = getDistance( source, hazard )
    if result == nil or distance < result.distance then
      result = { item = hazard, distance = distance }
    end
  end
  if result then
    return result.item
  end
  return nil
end