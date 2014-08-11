floorTiles,wallTiles,gameTiles,playerTiles = nil
currentMap = nil
player = nil

math.randomseed(os.time())
local inspect = require "lib/inspect"
require "generators"

tile = {}
tile.sz = 32 
tile.acs = 22 
tile.dwn = 22 
tile.mdf =2 
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

player = {}
player.x = 1
player.y = 1
player.tile = nil


function main()
  
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

  map.floor[currentMap.startX][currentMap.startY] = gameTiles[2] 
  map.floor[currentMap.endX][currentMap.endY] = gameTiles[3] 

  player.x = currentMap.startX
  player.y = currentMap.startY
  player.tile = playerTiles[1]

  map.things[player.x][player.y] = player.tile 

  map.things[currentMap.endX][currentMap.endY] = playerTiles[2] 
end

function action(who,targetX,targetY) 
  if targetX < 2 or targetX > tile.acs -1 then 
  elseif targetY < 2 or targetY > tile.dwn -1 then
  elseif map.structure[targetX][targetY] ~= nil then
  else
    map.things[player.x][player.y] = nil 
    player.x = targetX
    player.y = targetY
    map.things[player.x][player.y] = player.tile 
    if player.x == currentMap.endX and player.y == currentMap.endY then
      main()
    end
  end
end

function love.load()
  main()
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  elseif key == "w" then
    action(player, player.x, player.y-1)
  elseif key == "a" then
    action(player, player.x-1, player.y)
  elseif key == "s" then
    action(player, player.x, player.y+1)
  elseif key == "d" then
    action(player, player.x+1, player.y)
  elseif key == " " then
    main()
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
