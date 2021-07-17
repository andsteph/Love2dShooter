-----------------------------------------------------------
-- levels module
-----------------------------------------------------------

local MODULE_DIR = (...):match("(.+)%.[^%.]+$") or (...)
local levelData = require( MODULE_DIR .. '.data' )

-- levels table -------------------------------------------
local levels = {
  delay = 1,
  timer = 0,
  counter = 0,
  index = 1,
}

-- fetch next row -----------------------------------------
function levels:fetch()
  local row = self[self.index]
  if type(row) == 'string' then
    if #enemies == 0 then
      osd:newMessage( row )
      self.index = self.index + 1
    end
  elseif type(row) == 'table' then
    local columnWidth = WIDTH / #row
    for i, cell in ipairs( row ) do
      if cell ~= '' then
        enemies:new( cell, columnWidth * i - columnWidth/2 )
      end
    end
    self.index = self.index + 1
  end
end

-- message about level ------------------------------------
function levels:message( text )
  osd:newMessage( text )
end

-- update levels stuff ------------------------------------
function levels:update( dt )
  self.timer = self.timer + dt
  if self.timer > self.delay then
    self:fetch()
    self.timer = 0
  end
end

-- load levels into table ---------------------------------
for l, line in ipairs( levelData ) do
  table.insert( levels, line )
end

-- return levels module -----------------------------------
return levels