-----------------------------------------------------------
-- main.lua
-- main file for game
-----------------------------------------------------------

FULLSCREEN = false
DEBUG = false
DEBUG_DRAW = true
WIDTH, HEIGHT = love.graphics.getDimensions()
DATADIR = love.filesystem.getSaveDirectory()
MUSIC = love.audio.newSource( 'assets/audio/music/play-looping.mp3', 'static' )

love.graphics.setDefaultFilter( 'nearest', 'nearest' )

FONTFILE = 'assets/fonts/ethnocentric rg it.ttf'
HUGEFONT = love.graphics.newFont( FONTFILE, 24, 'none' )
LARGEFONT = love.graphics.newFont( FONTFILE, 16, 'none' )
FONT = love.graphics.newFont( FONTFILE, 10, 'none' )
SMALLFONT = love.graphics.newFont( FONTFILE, 8, 'none' )

stateComplete = require('states/stateComplete')
stateConfirm = require('states/stateConfirm')
stateCredits = require('states/stateCredits')
stateMenu = require('states/stateMenu')
stateMessage = require('states/stateMessage')
stateOver = require('states/stateOver')
statePause = require('states/statePause')
statePlay = require('states/statePlay')

background = require('background')
upgrades = require('upgrades')
collisions = require('collisions')
debugging = require('debugging')
effects = require('effects')
enemies = require('enemies')
gui = require('gui')
levels = require('levels')
player = require('player')
osd = require('osd')
sound = require('sound')

-- https://love2d.org/wiki/General_math -------------------

-- get distance between points ----------------------------
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

-- lerp ---------------------------------------------------
function lerp(a,b,t) return (1-t)*a + t*b end

-- get difference vector between objects ------------------
function getDifferenceBetween( start, dest )
  if start and dest then
    local angle = math.atan2( dest.x - start.x, dest.y - start.y )
    return { dx = math.sin(angle), dy = math.cos(angle) }
  end
  return nil
end

-- distance between points --------------------------------
function getDistance( obj1, obj2 )
  if obj1.body and obj2.body then
    local x1, x2 = obj1.body.x, obj2.body.x
    local y1, y2 = obj1.body.y, obj2.body.y
    return math.dist( x1, y1, x2, y2 )
  end
  return nil
end

-- get angle between objects in radians -------------------
function getRadiansBetween( start, dest )
  if start and dest then
    local angle = math.atan2( dest.x - start.x, dest.y - start.y )
    --local angle = math.atan2( dest.y, dest.x ) - math.atan2( start.y, start.x )
    if angle < 0 then
      --angle = angle + 2 * 3.14
    end
    return angle
  end
  return nil
end

-- clear game state ---------------------------------------
function gameState( state, options )
  sound:playMusic( MUSIC )
  love.mouse.setGrabbed( false )
  love.mouse.setRelativeMode( false )
  love.mouse.setVisible( true )
  love.draw = nil
  love.keypressed = nil
  love.mousemoved = nil
  love.mousepressed = nil
  love.update = nil
  state:init( options )
end

-- is object WAY off screen? ------------------------------
function isOffScreen( obj )
  return obj.x < -WIDTH or obj.x > WIDTH*2 or obj.y < -HEIGHT or obj.y > HEIGHT*2
end

-- split a string using delimiter -------------------------
function string.split( inputstr, sep )
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

-- love.load (obviously) ----------------------------------
function love.load()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  love.graphics.setDefaultFilter('nearest','nearest')
  gameState( statePlay )
end
