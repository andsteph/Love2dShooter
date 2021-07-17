-----------------------------------------------------------
-- osd (on screen display) module
-----------------------------------------------------------

local font = LARGEFONT
local fontHeight = font:getHeight()
local textY = HEIGHT - fontHeight * 1.5

-- osd table ----------------------------------------------
local osd = {
  message = nil  
}

-- draw osd message (if there is one) ---------------------
function osd:draw()
  self:drawLife()
  self:drawMessage()
  self:drawScore()
end

-- draw life ----------------------------------------------
function osd:drawLife()
  local x = 70
  local y = textY
  local height = fontHeight
  local width = player.life * 1.25
  love.graphics.setFont( font )
  love.graphics.setColor( 0, 1, 0, 1 )
  love.graphics.rectangle( 'fill', x, y, width, height )
  love.graphics.setColor( 1, 1, 1, 1 )
  love.graphics.print( 'LIFE:', 10, textY )
end

-- draw message -------------------------------------------
function osd:drawMessage()
  if self.message then
    love.graphics.setFont( HUGEFONT )
    love.graphics.setColor( 1, 1, 1, 1 )
    love.graphics.printf( self.message.text, 0, textY-HUGEFONT:getHeight()*1.5, WIDTH, 'center' )
  end
end

-- draw score ---------------------------------------------
function osd:drawScore()
  love.graphics.setFont( font )
  love.graphics.setColor(1, 1, 1, 1 )
  local score = string.format( 'SCORE: %06d', player.score )
  love.graphics.printf( score, 0, textY, WIDTH-10, 'right' )
end

-- new osd message ----------------------------------------
function osd:newMessage( text )
  self.message = {
    text = text,
    timer = 5
  }
end

-- update osd message -------------------------------------
function osd:update( dt )
  if self.message then
    self.message.timer = self.message.timer - dt
    if self.message.timer < 0 then
      self.message = nil
    end
  end
end

-- return osd module --------------------------------------
return osd