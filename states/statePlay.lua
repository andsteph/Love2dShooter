-----------------------------------------------------------
-- statePlay module
-----------------------------------------------------------

local Cannon = require('player/Cannon')
local Missile = require('player/Missile')
local Wave = require('player/Wave')

local cannonTimer = 0
local missileTimer = 0
local waveTimer = 0

-- statePlay table ----------------------------------------
local statePlay = {}

-- initialize statePlay -----------------------------------
function statePlay:init( newGame )
  love.mouse.setRelativeMode( true )
  love.mouse.setGrabbed( true )
  love.mouse.setVisible( false )
  love.mouse.setY( HEIGHT - 128 )
  love.mouse.setX( WIDTH / 2 )
  love.draw = statePlay.draw
  love.keypressed = statePlay.keypressed
  love.mousemoved = statePlay.mousemoved
  love.update = statePlay.update
  if newGame then
    player:init()
  end
end

-- draw statePlay -----------------------------------------
function statePlay.draw()
  background:draw()

  enemies:draw()
  upgrades:draw()
  player.shots:draw()
  player.pods:draw()
  effects:draw()
  player:draw()
  osd:draw()
  if DEBUG and DEBUG_DRAW then
    debugging:draw()
  end
end

-- statePlay keypressed -----------------------------------
function statePlay.keypressed( key, scancode, isrepeat )
  if key == "escape" then
    gameState( statePause )
  end
  if DEBUG then
    debugging.keypressed( key, scancode, isrepeat )
  end
end

-- statePlay mousemoved -----------------------------------
function statePlay.mousemoved( x, y, dx, dy )
  player.movement = {
    x = x,
    y = y,
    dx = dx,
    dy = dy
  }
end

-- statePlay update ---------------------------------------
function statePlay.update( dt )
  
  cannonTimer = cannonTimer + dt
  if cannonTimer > Cannon.DELAY then
    player.shots:newCannon( player.x, player.y, player.cannon )
    cannonTimer = 0
  end

  if player.missile > 0 then
    missileTimer = missileTimer + dt
    if missileTimer > Missile.DELAY then
      player.shots:newMissile( player.x, player.y, player.missile )
      missileTimer = 0
    end
  end

  if player.wave > 0 then
    waveTimer = waveTimer + dt
    if waveTimer > Wave.DELAY then
      player.shots:newWave( player.x, player.y, player.wave )
      waveTimer = 0
    end
  end

  background:update( dt )
  effects:update( dt )
  upgrades:update( dt )
  enemies:update( dt )
  
  player:update( dt )

  collisions:process()
  osd:update( dt )
  levels:update( dt )

end

-- return statePlay module --------------------------------
return statePlay
