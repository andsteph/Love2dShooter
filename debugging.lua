-----------------------------------------------------------
-- debug module
-----------------------------------------------------------

-- draw the body of an object -----------------------------
function drawBody( body )
  if body and body.size then
    love.graphics.setColor( 255, 0, 0, 1)
    love.graphics.circle( "line", body.x, body.y, body.size )
    love.graphics.setColor( 1, 1, 1, 1 )
  end
end

-- debug table --------------------------------------------
local debug = {}

-- handle keypresses --------------------------------------
function debug.keypressed( key, scancode, isrepeat )
  if key == "1" then
    enemies:new( 'Meteor', love.math.random(WIDTH) )
  elseif key == "2" then
    enemies:new( 'Alpha', love.math.random(WIDTH) )
  elseif key == "3" then
    enemies:new( 'Bravo', love.math.random(WIDTH) )
  elseif key == "4" then
    enemies:new( 'Charlie', love.math.random(WIDTH) )
  elseif key == "5" then
    enemies:new( 'Delta', love.math.random(WIDTH) )
  elseif key == "6" then
    enemies.Echo(love.math.random(WIDTH))
  elseif key == "f1" then
    enemies:new( 'Boss1' )
  elseif key == "c" then
    player.cannon = player.cannon + 1
    if player.cannon > 3 then
      player.cannon = 1
    end
  elseif key == "m" then
    player.missile = player.missile + 1
    if player.missile > 3 then
      player.missile = 1
    end
  elseif key == "w" then
    player.wave = player.wave + 1
    if player.wave > 3 then
      player.wave = 1
    end
  elseif key == "p" then
    player.pods:new()
  elseif key == "`" then
    DEBUG_DRAW = not DEBUG_DRAW
  end
end

-- draw debug stuff ---------------------------------------
function debug:draw()
  for i, hazard in ipairs( enemies ) do
    drawBody( hazard.body )
  end
  for i, enemyshot in ipairs( enemyShots ) do
    drawBody( enemyshot.body )
  end
  for i, pod in ipairs( player.pods ) do
    drawBody( pod.body )
  end
  for i, shot in ipairs( player.shots ) do
    drawBody( shot.body )
  end
  for c, upgrade in ipairs( upgrades ) do
    drawBody( cell.body )
  end
  drawBody( player.body )
end

-- echo to console ----------------------------------------
function debug:echo( text )
  print( text )
end

-- return debug module ------------------------------------
return debug