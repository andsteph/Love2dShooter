-----------------------------------------------------------
-- upgrades module
-----------------------------------------------------------

local PERKS = { 'Cannon', 'Missile', 'Pod', 'Wave' }
local SPRITE = love.graphics.newImage('assets/sprites/player/upgrade.png')

-- single Upgrade -----------------------------------------
local Upgrade = {}

-- create new instance of Upgrade -------------------------
function Upgrade:new( x )
  
  local width, height = SPRITE:getDimensions()
  
  local upgrade = {
    perkIndex = 1,
    perk = 'Cannon',
    speed = 200,
    sprite = SPRITE,
    x = x,
    y = -height,
    width = width,
    height = height
  }
  upgrade.textObject = love.graphics.newText( LARGEFONT, text )
  
  -- draw the upgrade -------------------------------------
  function upgrade:draw()
    local color = { 1, 1, 1, 1 }
    if self.perk == 'Cannon' then
      color = { 0, 1, 1, 1 }
    elseif self.perk == 'Missile' then
      color = { 1, 0, 0, 1 }
    elseif self.perk == 'Pod' then
      color = { 1, 1, 0, 1 }
    elseif self.perk == 'Speed' then
      color = { 1, 1, 1, 1 }
    elseif self.perk == 'Wave' then
      color = { 1, 0, 1, 1 }
    end
    love.graphics.setColor( color )
    love.graphics.draw( self.sprite, self.x, self.y, 0, 1, 1, self.sprite:getWidth()/2, self.sprite:getHeight()/2 )
  end
  
  -- update the upgrade -----------------------------------
  function upgrade:update( dt )
    if self.perkIndex > #PERKS then
      self.perkIndex = 1
    end
    self.perk = PERKS[self.perkIndex]
    self.y = self.y + dt * self.speed
    self.body = {
      x = self.x,
      y = self.y,
      size = 8
    }
  end
  
  -- return upgrade instance ------------------------------
  return upgrade

end

-- cell table ---------------------------------------------
local upgrades = {}

-- draw all cells -----------------------------------------
function upgrades:draw()
  for i, upgrade in ipairs( self ) do
    upgrade:draw()
  end
end

-- new cell -----------------------------------------------
function upgrades:new( x, y, perk )
  table.insert( self, Upgrade:new(x, y) )
end

-- update cells -------------------------------------------
function upgrades:update( dt )
  for i, upgrade in ipairs( self ) do
    upgrade:update( dt )
  end
end

-- return upgrades module ---------------------------------
return upgrades
