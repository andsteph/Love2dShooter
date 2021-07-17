-----------------------------------------------------------
-- shots module
-----------------------------------------------------------

-- shots table --------------------------------------
local shots = {
  Cannon = require('player/Cannon'),
  Missile = require('player/Missile'),
  Wave = require('player/Wave')  
}

-- process collisions -------------------------------------
function shots:collisions()
  for s, shot in ipairs( self ) do
    for e, enemy in ipairs( enemies ) do
      if self:oneToOne( shot, enemy ) then
        sound:playEffect( HIT_SOUND )
        enemy.life = enemy.life - shot.damage
        enemy.hit = HIT_TIME
        enemy.lastColor = shot.color
        effects:new( shot.x, shot.y, 'Feedback' )
        table.remove( self, shot )
      end
    end -- enemies loop
    for u, upgrade in ipairs( upgrades ) do
      if self:oneToOne( shot, upgrade ) then
        table.remove( upgrades, u )
        table.remove( self, shot )
      end
    end -- upgrades loop
  end -- shots loop
end

-- draw all playeshots ------------------------------------
  function shots:draw()
    for i, shot in ipairs(self) do
      shot:draw()
    end
  end

-- new shots ----------------------------------------
  function shots:newCannon( x, y, level )
    table.insert( self, self.Cannon:new(x, y) )
    if level > 1 then
      table.insert( self, self.Cannon:new(x-16, y) )
      table.insert( self, self.Cannon:new(x+16, y) )
    end
    if level > 2 then
      table.insert( self, self.Cannon:new(x-32, y) )
      table.insert( self, self.Cannon:new(x+32, y) )
    end
  end

  -- new missiles -------------------------------------------
  function shots:newMissile( x, y )
    table.insert( self, self.Missile:new(x-48, y) )
    table.insert( self, self.Missile:new(x+48, y) )
  end

  -- new waves ----------------------------------------------
  function shots:newWave( x, y, level )
    table.insert( self, self.Wave:new(x, y, -0.25) )
    table.insert( self, self.Wave:new(x, y, 0.25) )
    if level > 1 then
      table.insert( self, self.Wave:new(x, y, -0.5) )
      table.insert( self, self.Wave:new(x, y, 0.5) )  
    end
    if level > 2 then
      table.insert( self, self.Wave:new(x, y, -0.75) )
      table.insert( self, self.Wave:new(x, y, 0.75) )  
    end
  end

  -- update all shots ---------------------------------
  function shots:update(dt)
    for s, shot in ipairs(self) do
      shot:update(dt)
      if shot.y < -100 then
        table.remove(self, s)
      end
    end
  end

  -- return shots module ------------------------------
  return shots