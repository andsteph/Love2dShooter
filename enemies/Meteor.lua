-----------------------------------------------------------
-- Meteor "object"
-----------------------------------------------------------

-- Meteor table -------------------------------------------
local Meteor = {}

-- load all the variant images ----------------------------
local SPRITES = {}
local files = love.filesystem.getDirectoryItems( 'assets/sprites/enemies/meteors/' )
for i, filename in ipairs(files) do
  SPRITES[i] = love.graphics.newImage( 'assets/sprites/enemies/meteors/' .. filename )
end

-- new Meteor object --------------------------------------
function Meteor:new( x, variant )
  variant = variant or 1
  local sprite = SPRITES[variant]
  local meteor = {
    life = 5,
    rotation = 0,
    rotationSpeed = math.random( -50, 50 ),
    speed = variant * 200,
    sprite = sprite,
    value = 50,
    x = x or love.math.random(WIDTH),
    y = -sprite:getHeight(),
  }
  function meteor:draw()
    local radians = math.rad( self.rotation )
    love.graphics.draw( self.sprite, self.x, self.y, radians, 1, 1, self.sprite:getWidth()/2, self.sprite:getHeight()/2 )
  end
  function meteor:update( dt )
    self.rotation = self.rotation + dt * self.rotationSpeed
    if self.rotation > 360 then
      self.rotation = 0
    end
    self.y = self.y + dt * self.speed
    self.body = {
      x = self.x,
      y = self.y,
      size = math.min( self.sprite:getWidth(), self.sprite:getHeight() ) / 4
    }
  end
  return meteor
end

-- return Meteor object -----------------------------------
return Meteor
