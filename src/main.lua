floorTiles,wallTiles,gameTiles,playerTiles = nil
currentMap = nil
player = nil

math.randomseed(os.time())
local inspect = require "lib/inspect"
require "generators"

tile = {}
tile.sz = 16 
tile.acs = 44 
tile.dwn = 44 
tile.mdf = 1
function tile.create(img,q) 
  return {sprite=img,quad=q}
end
tile.graphics = {}
function tile.graphics.draw(t,x,y) 
  love.graphics.draw(t.sprite,t.quad,x*tile.sz,y*tile.sz,0,tile.mdf,tile.mdf)
end
require "resources/DawnLike_1/Objects/Floor"
require "resources/DawnLike_1/Objects/Tile"
require "resources/DawnLike_1/Objects/Wall"
require "resources/DawnLike_1/Characters/Player"

win = {}
win.w = tile.sz * (tile.acs + 2) 
win.h = tile.sz * (tile.dwn + 2) 

function love.load()
  love.graphics.setDefaultFilter("nearest","nearest")
  love.window.setMode(win.w, win.h)

  floorTiles = resources.floor()
  wallTiles = resources.wall()
  gameTiles = resources.tile()
  playerTiles = resources.player()

  map = {}
  map.floor = {}
  map.structure = {}
  map.things = {}
  for x = 1, tile.acs do
    map.floor[x] = {}
    map.structure[x] = {}
    map.things[x] = {}
  end
  currentMap = generators.simple() 
  map.structure = currentMap.map
  map.things[currentMap.startX][currentMap.startY] = playerTiles[1] 
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  elseif key == "w" then
  elseif key == "a" then
  elseif key == "s" then
  elseif key == "d" then
  end
end

function love.update(dt)
end

function love.draw()
  for x = 1, tile.acs do
    for y = 1, tile.dwn do
      tile.graphics.draw(gameTiles[1],x,y)
      if map.floor[x] ~= nil and map.floor[x][y] ~= nil then
        tile.graphics.draw(map.floor[x][y],x,y)
      end
      if map.structure[x] ~= nil and map.structure[x][y] ~= nil then
        tile.graphics.draw(map.structure[x][y],x,y)
      end
      if map.things[x] ~= nil and map.things[x][y] ~= nil then
        tile.graphics.draw(map.things[x][y],x,y)
      end
    end
  end
end
