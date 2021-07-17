-----------------------------------------------------------
-- enemies module
-----------------------------------------------------------

local MODULE_DIR = (...):gsub('%.init$', '')

-- enemies table ------------------------------------------
local enemies = {
  -- weapons ----------------------------------------------
  Cannon = require( MODULE_DIR .. '.Cannon' ),
  -- normal enemies ---------------------------------------
  Alpha = require( MODULE_DIR .. '.Alpha' ),
  Bravo = require( MODULE_DIR .. '.Bravo' ),
  Charlie = require( MODULE_DIR .. '.Charlie' ),
  Delta = require( MODULE_DIR .. '.Delta' ),
  -- Echo = require( MODULE_DIR .. '.Echo' ),
  -- meteors ----------------------------------------------
  Meteor = require( MODULE_DIR .. '.Meteor' ),
  -- bosses -----------------------------------------------
  Boss1 = require( MODULE_DIR .. '.Boss1' ),
  -- submodule for shots ----------------------------------
  shots = require( MODULE_DIR .. '.shots' )
}

-- return closest enemy to source -------------------------
function enemies:closest( source )
  local result = {
    enemy = nil,
    distance = 9999
  }
  for i, enemy in ipairs( self ) do
    local distance = getDistance( source, enemy )
    if distance and distance < result.distance then
      result = { 
        enemy = enemy,
        distance = distance 
      }
    end
  end
  return result.enemy
end

-- draw all enemies ---------------------------------------
function enemies:draw()
  for e, enemy in ipairs( self ) do
    if enemy.hit and enemy.hit > 0 then
      love.graphics.setColor( 1, 1, 1, 0.5 )
    else
      love.graphics.setColor( 1, 1, 1, 1 )
    end
    enemy:draw()
  end
  -- draw enemy shots -------------------------------------
  self.shots:draw()
end

-- new hazard ---------------------------------------------
function enemies:new( EnemyName, x )
  local words = string.split( EnemyName, ':' )
  local enemy
  if words[1] == 'Upgrade' then
    upgrades:new( x )
  elseif words[1] == 'Meteor' then
    enemy = require('enemies/Meteor'):new( x, tonumber(words[2]) )
  else
    enemy = require('enemies/' .. EnemyName):new( x )
  end
  table.insert( self, enemy )
end

-- update all enemies -------------------------------------
function enemies:update( dt )
  for e, enemy in ipairs( self ) do
    enemy:update( dt )
    if enemy.hit and enemy.hit > 0 then
      enemy.hit = enemy.hit - dt
    end
    if enemy.y > HEIGHT then
      table.remove( self, e )
    end
  end
  -- update enemy shots -----------------------------------
  self.shots:update( dt )
end

-- return enemies module ----------------------------------
return enemies
