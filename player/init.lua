-----------------------------------------------------------
-- player module
-----------------------------------------------------------

-- player table -------------------------------------------
local player = {}

-- module parts -------------------------------------------
local MODULE_DIR = (...):gsub('%.init$', '')
player.Cannon = require( MODULE_DIR .. '.Cannon' )
player.Missile = require( MODULE_DIR .. '.Missile' )
player.Wave = require( MODULE_DIR .. '.Wave' )
player.pods = require( MODULE_DIR .. '.pods' )
player.shots = require( MODULE_DIR .. '.shots' )

-- sprites for player -------------------------------------
local EXHAUST = love.graphics.newImage( 'assets/sprites/player/effect_purple.png' )
local SPRITE = love.graphics.newImage( 'assets/sprites/player/ship.png' )

-- draw player --------------------------------------------
function player:draw()
  love.graphics.setColor( 1, 1, 1, 1 )
  if self.index > 1 then
    love.graphics.draw( self.exhaust.sprite, self.x, self.y+self.height*0.75, 0, 1, 1, self.exhaust.width/2, self.exhaust.height/2 )
  end
  if self.hit > 0 then
    love.graphics.setColor( 1, 1, 1, 0.5 )
  end
  love.graphics.draw( self.sprite, self.x, self.y, 0, 1, 1, self.width/2, self.height/2 )
  love.graphics.setColor( 1, 1, 1, 1 )
  self.pods:draw()
  self.shots:draw()
end

-- init player (new game) ---------------------------------
function player:init()
  player.exhaust = EXHAUST
  player.sprite = SPRITE
  player.x = WIDTH / 2
  player.y = HEIGHT / 2
  player.width = SPRITE:getWidth()
  player.height = SPRITE:getHeight()
  player.cannon = 1
  player.missile = 0
  player.wave = 0
  player.life = 100
  player.hit = 0
  player.index = 1
  player.score = 0
  player.speed = 1
  player.exhaust = {
    sprite = EXHAUST,
    width = EXHAUST:getWidth(),
    height = EXHAUST:getHeight()
  }
end

-- update player ------------------------------------------
function player:update( dt )
  if player.life <= 0 then
    gameState( stateOver )
  end
  if player.movement then
    player.x = player.x + player.movement.dx * dt * player.speed * 50
    player.y = player.y + player.movement.dy * dt * player.speed * 50
  end
  if love.keyboard.isDown('up') then
    player.y = player.y - dt * player.speed * 100
  end
  self.index = self.index + dt * 10
  if self.index > 2 then
    self.index = 1
  end
  if self.hit and self.hit > 0 then
    self.hit = self.hit - dt * 10
  end
  self.body = {
    x = self.x,
    y = self.y,
    size = self.width / 2
  }
  self.pods:update( dt )
  self.shots:update( dt )
  self.movement = nil
end

-- init for first time ------------------------------------
player:init()

-- return player module -----------------------------------
return player
