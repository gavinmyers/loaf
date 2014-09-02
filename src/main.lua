local inspect = require "lib/inspect"

love.graphics.setDefaultFilter("nearest","nearest")
function main()
  local game = require "game"
  local screen = require "screen"
  local effect = require "effects"
  math.randomseed(os.time())
  love.window.setMode(game.w, game.h)
  effect.main()
  screen.main()
  screen:current("WELCOME")
end
function love.keypressed(key)
  local game = require "game"
  game.screen:keypressed(key)
end
function love.update(dt)
  local game = require "game"
  game.screen:update(dt)
end
function love.draw()
  local game = require "game"
  game.screen:draw()
end
function love.load()
  main()
end
