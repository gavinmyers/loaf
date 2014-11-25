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
  local x = require "generators/cave1" 

  math.randomseed(os.time())
  love.window.setMode(game.w, game.h)
  screen:current("WELCOME")
end
local keypressed = nil
local keycounter = 0
function love.keypressed(key)
  keypressed = key 
end
function love.keyreleased(key)
  if key == keypressed then
    keypressed = nil
    game.screen:keyreleased(key)
  end
end
function love.update(dt)
  if keycounter <= 0 and keypressed ~= nil then
    keycounter = 0.1 
    game.screen:keypressed(keypressed)
  end
  if keypressed ~= nil then
    keycounter = keycounter - dt
  else
    keycounter = 0
  end
  game.screen:update(dt)
end
function love.draw()
  game.screen:draw()
end
function love.load()
  main()
end
