-----------------------------------------------------------
-- effects module
-----------------------------------------------------------

local MODULE_DIR = (...):gsub('%.init$', '')

local Explosion = require( MODULE_DIR .. '.Explosion' )
local Feedback = require( MODULE_DIR .. '.Feedback' )

-- effects table ------------------------------------------
local effects = {}

-- draw effects -------------------------------------------
function effects:draw()
  for i, effect in ipairs( self ) do
    effect:draw()
  end
end

-- new effect ---------------------------------------------
function effects:new( x, y, EffectClass, color )
  local effect
  if EffectClass == 'Explosion' then
    effect = Explosion:new( x, y, color )
  else
    effect = Feedback:new( x, y )
  end
  table.insert( self, effect )
end

-- update effects -----------------------------------------
function effects:update( dt )
  for e, effect in ipairs( self ) do
    effect:update( dt )
    if effect.done then
      table.remove( self, e )
    end
  end
end

-- return effects module ----------------------------------
return effects
