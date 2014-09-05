local inspect = require "lib/inspect"
local game = require "game"
love.graphics.setDefaultFilter("nearest","nearest")
function main()
  local screen = require "screen"
  local x = require "screens/welcome" 
  local x = require "screens/tutorial1" 
  local x = require "screens/tutorial2" 

  local effect = require "effect"
  local x = require "effects/defend"
  local x = require "effects/damage"
  
  local generator = require "generator"
  local x = require "generators/empty" 
  local x = require "generators/simple" 
  local x = require "generators/static" 
  local x = require "generators/tutorial2" 

  math.randomseed(os.time())
  love.window.setMode(game.w, game.h)
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
