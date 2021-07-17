-----------------------------------------------------------
-- Explosion 'class'
-----------------------------------------------------------

-- get sprites --------------------------------------------
local PATH = 'assets/sprites/effects/explosions/'
local SPRITES = {}
for d, dir in ipairs( love.filesystem.getDirectoryItems( PATH ) ) do
  SPRITES[dir] = {}
  local fulldir = PATH .. dir .. '/'
  for f, file in ipairs( love.filesystem.getDirectoryItems(fulldir) ) do
    local fullfile = fulldir .. file
    SPRITES[dir][f] = love.graphics.newImage(fullfile)
  end
end

-- Explosion table ----------------------------------------
local Explosion = {}

-- new Explosion 'object' ---------------------------------
function Explosion:new( x, y, color )
  sound:playEffect( 'EXPLOSION' )
  local explosion = {
    x = x,
    y = y,
    color = color,
    index = 1,
  }
  function explosion:draw()
    love.graphics.setColor( 1, 1, 1, 1 )
    local index = math.floor( self.index )
    local image = SPRITES[self.color][index]
    love.graphics.draw(image, self.x, self.y, 0, 1, 1, image:getWidth()/2, image:getHeight()/2 )
  end
  function explosion:update( dt )
    self.index = self.index + 1
    if self.index > #SPRITES[self.color] then
      self.done = true
      self.index = 1
    end
  end
  return explosion
end

-- return Explosion 'class' ----------------------------------
return Explosion
