-----------------------------------------------------------
-- GUI routines for game
-----------------------------------------------------------

local AUDIO = {
  SELECT = love.audio.newSource( 'assets/audio/gui/select.wav', 'static' )
}

local COLORS = {
  ACTIVE = { 0, 1, 0, 1 },
  INACTIVE = { 1, 1, 1, 1 },
  LOCKED = { 1, 0, 0, 1 }
}

-- is object being hovered by the mouse -------------------
function isHovered( item )
  local mouseX, mouseY = love.mouse.getPosition()
  if mouseX > item.x and mouseY > item.y and mouseX < item.x+item.width and mouseY < item.y+item.height then
    return true
  end
  return false
end

-- the gui table ------------------------------------------
local gui = {}

-- initialize the gui -------------------------------------
function gui:init()
  for k, v in pairs( self ) do
    if type(v) ~= 'function' then
      self[k] = nil
    end
  end
end

-- window object ------------------------------------------
function gui:Window( title, width, height, rows )

  local font = LARGEFONT
  local fontHeight = font:getHeight()
  local headerHeight = fontHeight + 20
  local x = love.graphics.getWidth()/2 - width/2
  local y = HEIGHT/2 - height/2
  local containerHeight = height - headerHeight - 10
  local containerWidth = width - 10
  local x1 = x + 5
  local y1 = y + headerHeight + 5

  local window = {
    title = title,
    x = x,
    y = y,
    x1 = x1,
    y1 = y1,
    width = width,
    height = height,
    rows = rows,
    headerHeight = headerHeight,
    containerHeight = containerHeight,
    containerWidth = containerWidth,
    count = 0
  }

  function window:addBackButton( backButton )
    backButton.x = self.x
    backButton.y = self.y
    backButton.height = fontHeight+20
    backButton.width = fontHeight+20
    table.insert( self, backButton )
  end

  function window:add( widget )
    widget.width = self.containerWidth
    widget.height = containerHeight / self.rows * widget.rowspan
    widget.x = self.x1
    widget.y = self.y1
    self.y1 = self.y1 + widget.height
    table.insert( self, widget )
    self.count = self.count + 1
  end

  function window:draw()
    love.graphics.setColor( 0, 0, 0, 1 )
    love.graphics.rectangle( 'fill', self.x, self.y, self.width, self.height )
    love.graphics.setColor( 1, 1, 1, 1 )
    love.graphics.setLineStyle( 'rough' )
    love.graphics.rectangle( 'line', self.x, self.y, self.width, self.height )
    love.graphics.rectangle( 'fill', self.x, self.y, self.width, self.headerHeight )
    love.graphics.setColor( 0, 0, 0, 1 )
    love.graphics.setFont( font )
    love.graphics.printf( self.title, self.x, self.y+10, self.width, 'center' )
  end

  table.insert( gui, window )
  return window

end

-- text object --------------------------------------------
function gui:Text( content, alignment, rowspan )
  local text = {
    alignment = alignment or 'center',
    content = content,
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    rowspan = rowspan or 1
  }
  function text:draw()
    love.graphics.setColor( 1, 1, 1, 1 )
    local textObject = love.graphics.newText( FONT, content )
    if self.alignment == 'left' then
      love.graphics.draw( textObject, self.x+16, self.y+self.height/2-textObject:getHeight()/2 )
    else
      love.graphics.draw( textObject, self.x+self.width/2, self.y+self.height/2, 0, 1, 1, textObject:getWidth()/2, textObject:getHeight()/2 )
    end
  end
  return text
end

-- button object ------------------------------------------
function gui:Button( text, rowspan )
  local button = {
    text = text,
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    rowspan = rowspan or 1
  }
  function button:draw()
    love.graphics.setFont( FONT )
    self.hover = isHovered( self )
    if self.hover then
      love.graphics.setColor( 1, 1, 1, 0.9 )
    else
      love.graphics.setColor( 1, 1, 1, 1 )
    end
    love.graphics.rectangle( 'fill', self.x, self.y, self.width, self.height-5 )
    love.graphics.setColor( 0, 0, 0, 1 )
    love.graphics.printf( self.text, self.x, self.y+self.height/2-FONT:getHeight()/2, self.width, 'center' )
  end
  return button
end


-- draw the gui -------------------------------------------

function gui:draw()
  for w, window in ipairs( self ) do
    window:draw()
    for i, item in ipairs( window ) do
      item:draw()
    end
  end
end

-- mousepressed event -------------------------------------
function gui.mousepressed( x, y, button, istouch, presses )
  for w, window in ipairs( gui ) do
    for i, item in ipairs( window ) do
      if item.hover and item.callback then
        sound:playEffect( AUDIO.SELECT )
        item.callback()
      end
    end
  end
end

-- return the gui module ----------------------------------
return gui