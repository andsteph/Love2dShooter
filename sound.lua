-----------------------------------------------------------
-- sound module
-----------------------------------------------------------

-- sounds -------------------------------------------------
local SOUNDS = {
  CANNON = love.audio.newSource( 'assets/audio/effects/cannon.ogg', 'static' ),
  HIT = love.audio.newSource( 'assets/audio/effects/hit.ogg', 'static' ),
  EXPLOSION = love.audio.newSource( 'assets/audio/effects/explosion.wav', 'static' ),
  UPGRADE = love.audio.newSource( 'assets/audio/effects/powerup.wav', 'static' ),
}

-- sound table --------------------------------------------
local sound = {
  current = nil
}

-- play (or keep playing) music ---------------------------
function sound:playMusic( track )
  if current == nil or current ~= track then
    love.audio.stop()
    love.audio.play( track )
    current = track
  end
end

-- play sound effect --------------------------------------
function sound:playEffect( effectName )
  local effect = SOUNDS[effectName]
  if effect then
    love.audio.stop( effect )
    love.audio.play( effect )
  end
end

-- return sound module ------------------------------------
return sound