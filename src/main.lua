local inspect = require "lib/inspect"

love.graphics.setDefaultFilter("nearest","nearest")
function main()
  local game = require "game"

  local screen = require "screen"
  local x = require "screens/welcome" 
  local x = require "screens/tutorial1" 
  local x = require "screens/tutorial2" 

  local effect = require "effect"
  
  local generator = require "generator"
  local x = require "generators/empty" 

  math.randomseed(os.time())
  love.window.setMode(game.w, game.h)
  effect.main()
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
