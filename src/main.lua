require "game"
require "generators"
require "effects"
require "tile"
require "screen"
require "event"
require "item"
require "creature"
require "ability"
require "modifier"

local inspect = require "lib/inspect"

font = love.graphics.newFont("resources/fonts/VeraMono.ttf",14)
love.graphics.setFont(font)
gameFont = love.graphics.newFont("resources/DawnLike_1/GUI/SDS_8x8.ttf",14)
gameFont = love.graphics.newFont("resources/fonts/VeraMono.ttf",18)
love.graphics.setDefaultFilter("nearest","nearest")

function main()
  reset()
  screen:current("WELCOME")
end
function reset()
  math.randomseed(os.time())
  player = creature:create("PLAYER") 
  love.window.setMode(game.w, game.h)
  tile.main()
  screen.main()
  map = {}
  map.events = {}
  map.floor = {}
  map.structure = {}
  map.items = {}
  map.creatures = {}
  map.effects = {}
  map.gui_1 = {}
  map.gui_2 = {}
  map.gui_3 = {}
  for x = 1, game.acs do
    map.events[x] = {}
    map.floor[x] = {}
    map.structure[x] = {}
    map.creatures[x] = {}
    map.items[x] = {}
    map.effects[x] = {}
    map.gui_1[x] = {}
    map.gui_2[x] = {}
    map.gui_3[x] = {}
  end
end
function love.keypressed(key)
  game.screen:keypressed(key)
end
function love.update(dt)
  game.screen:update(dt)
end
function love.draw()
  game.screen:draw()
end
function love.load()
  main()
end
