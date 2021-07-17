-----------------------------------------------------------
-- playerPods module
-----------------------------------------------------------

-- playerPods table ---------------------------------------
local pods = {
  SPRITE = love.graphics.newImage( 'assets/sprites/player/pod.png' ),
  MAX = 5
}

-- draw all playerPods ------------------------------------
function pods:draw()
  love.graphics.setColor( 1, 1, 1, 1 )
  for i, pod in ipairs( self ) do
    love.graphics.draw( self.SPRITE, pod.x, pod.y, pod.rotation, 0.5, 0.5, self.SPRITE:getWidth()/2, self.SPRITE:getHeight()/2 )
  end
end

-- add new playerPod --------------------------------------
function pods:new()
  if #self < self.MAX then
    local pod = {
      x = 0,
      y = 0,
      damage = 10,
      dir = 0,
      rotation = 0,
      body = {
        x = 0,
        y = 0,
        width = 0,
        height = 0
      }
    }
    table.insert( self, pod )
    local dir = 1
    local step = 6.28 / #self
    for i, pod in ipairs( self ) do
      pod.dir = dir
      dir = pod.dir + step
    end    
  end
end

-- update all playerPods ----------------------------------
function pods:update( dt )
  for i, pod in ipairs( self ) do
    pod.dir = pod.dir + 0.05
    pod.x = player.x + math.cos(pod.dir) * 100
    pod.y = player.y - math.sin(pod.dir) * 100
    pod.rotation = pod.rotation + dt * 25
    pod.body = {
      x = pod.x,
      y = pod.y,
      size = self.SPRITE:getWidth()/4
    }
  end
end

-- return playerPods module -------------------------------
return pods