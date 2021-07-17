-----------------------------------------------------------
-- stars module
-----------------------------------------------------------

local MODULE_DIR = (...):match("(.+)%.[^%.]+$") or (...)
local Star = require( MODULE_DIR .. '.Star' )

-- how many stars? ----------------------------------------
local MAX_STARS = 50

-- stars table --------------------------------------------
local stars = {}

-- draw stars ---------------------------------------------
function stars:draw()
  for s, star in ipairs( self ) do
    star:draw()
  end
end

-- update stars -------------------------------------------
function stars:update( dt )
  for s, star in ipairs( self ) do
    star:update( dt )
    if star.y > HEIGHT then
      star:reset()
    end
  end
end

-- build some starter stars -------------------------------
for i = 1, MAX_STARS do
  local y = love.math.random(HEIGHT)
  table.insert( stars, Star:new(y) )
end

-- return stars module ------------------------------------
return stars