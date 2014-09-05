local inspect = require "lib/inspect"
local game = require "game"
love.graphics.setDefaultFilter("nearest","nearest")
function main()
  local screen = require "screen"
  local effect = require "effect"
  math.randomseed(os.time())
  love.window.setMode(game.w, game.h)
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
