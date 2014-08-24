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
  math.randomseed(os.time())
  love.window.setMode(game.w, game.h)
  tile.main()
  effect.main()
  screen.main()
  screen:current("WELCOME")
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
