-----------------------------------------------------------
-- collisions module
-----------------------------------------------------------

-- sound effects ------------------------------------------
local HIT_TIME = 0.2

-- collisions table ---------------------------------------
local collisions = {}

-- compare objects to see if they collide -----------------
function collisions:oneToOne( obj1, obj2 )
  if obj1.body and obj2.body then
    local body1 = obj1.body
    local body2 = obj2.body
    if body1.y-body1.size > 0 and body2.y-body2.size > 0 and getDistance( obj1, obj2 ) < body1.size+body2.size then
      return true
    end
  end
  return false
end

-- process all collisions ---------------------------------
function collisions:process()

  for e, enemy in ipairs( enemies ) do
    if self:oneToOne( enemy, player ) and not player.hit and not enemy.hit then
      sound:playEffect( 'HIT' )
      player.hit = HIT_TIME
      player.life = player.life - 1
      enemy.hit = HIT_TIME
      enemy.life = enemy.life - 1
      effects:new( enemy.x, enemy.y, 'Feedback' )
    end
    for ps, playerShot in ipairs( player.shots ) do
      if self:oneToOne( enemy, playerShot ) then
        sound:playEffect( 'HIT' )
        enemy.life = enemy.life - playerShot.damage
        enemy.hit = HIT_TIME
        enemy.lastColor = playerShot.color
        effects:new( playerShot.x, playerShot.y, 'Feedback' )
        table.remove( player.shots, ps )
      end
    end -- playerShot loop
    for pp, playerPod in ipairs( player.pods ) do
      if self:oneToOne( enemy, playerPod ) then
        enemy.life = enemy.life - playerPod.damage
        enemy.hit = HIT_TIME
        enemy.lastColor = 'Orange'
        effects:new( playerPod.x, playerPod.y, 'Feedback' )
      end
    end
    if enemy.life <= 0 then
      effects:new( enemy.x, enemy.y, 'Explosion', enemy.lastColor )
      player.score = player.score + enemy.value
      if enemy.perk then
        upgrades:new( enemy.x, enemy.y, enemy.perk )
      end
      enemy.dead = true
      table.remove( enemies, e )
    end
  end -- enemies loop

  for es, enemyShot in ipairs( enemies.shots ) do
    if self:oneToOne( enemyShot, player ) then
      effects:new( enemyShot.x, enemyShot.y, 'Feedback' )
      player.life = player.life - enemyShot.damage
      player.hit = HIT_TIME
    end
  end -- enemyShot loop

  for u, upgrade in ipairs( upgrades ) do
    if self:oneToOne( upgrade, player ) then
      sound:playEffect( 'UPGRADE' )
      osd:newMessage( upgrade.perk .. ' upgrade' )
      local perk = upgrade.perk:lower()
      if perk == 'pod' then
        player.pods:new()
      else
        player[perk] = player[perk] + 1
      end
      table.remove( upgrades, u )
    end
    for ps, playerShot in ipairs( player.shots ) do
      if self:oneToOne( upgrade, playerShot ) then
        upgrade.perkIndex = upgrade.perkIndex + 1
        table.remove( player.shots, ps )
      end
    end -- player.shots loop
  end -- upgrades loop

end -- collisions:process()

-- return collisions module -------------------------------
return collisions
