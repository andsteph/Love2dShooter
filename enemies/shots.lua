-----------------------------------------------------------
-- enemy shots module
-----------------------------------------------------------

-- enemyShots table ---------------------------------------
local shots = {}

-- draw enemyShots ----------------------------------------
function shots:draw()
  for i, shot in ipairs( self ) do
    shot:draw()
  end
end

-- new enemyShots -----------------------------------------
function shots:new( ClassName, x, y, dx, dy, damage )
  local Class = enemies[ClassName]
  local shot = Class:new( x, y, dx, dy, damage )
  table.insert( self, shot )
end

-- update enemy shots -------------------------------------
function shots:update( dt )
  for i, shot in ipairs( self ) do
    shot:update( dt )
    if shot.y > HEIGHT then
      table.remove( self, i )
    end
  end
end

-- return enemyShots modules ------------------------------
return shots