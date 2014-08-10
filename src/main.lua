local inspect = require "lib/inspect"
require "resources/DawnLike_1/Objects/Floor"
require "resources/DawnLike_1/Objects/Tile"
require "resources/DawnLike_1/Objects/Wall"
require "resources/DawnLike_1/Characters/Player"
math.randomseed(os.time())

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

win = {}
win.w = tile.sz * (tile.acs + 1) 
win.h = tile.sz * (tile.dwn + 1) 

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
  for x = 0, tile.acs do
    map.floor[x] = {}
    map.structure[x] = {}
    map.things[x] = {}
--    for y = 0, tile.dwn do
--      map.floor[x][y] = floorTiles[1]["NSEW"]
--    end
  end
  map.things[13][13] = playerTiles[1] 

end

function love.keypressed(key)
end

function love.update(dt)
end

function love.draw()
  for x = 0, tile.acs do
    for y = 0, tile.dwn do
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

  for x = 0, tile.acs do
    tile.graphics.draw(floorTiles[1]["NWE"],x,0,0)
    tile.graphics.draw(floorTiles[1]["SWE"],x,tile.dwn)
  end
  for x = 0, tile.dwn do
    tile.graphics.draw(floorTiles[1]["NSW"],0,x)
    tile.graphics.draw(floorTiles[1]["NSE"],tile.acs,x)
  end


  love.graphics.draw(floorTiles[2]["SE"].sprite, floorTiles[2]["SE"].quad,2 * tile.sz,3 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["WE"].sprite, floorTiles[2]["WE"].quad,3 * tile.sz,3 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["WE"].sprite, floorTiles[2]["WE"].quad,4 * tile.sz,3 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["WE"].sprite, floorTiles[2]["WE"].quad,5 * tile.sz,3 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["WE"].sprite, floorTiles[2]["WE"].quad,6 * tile.sz,3 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["WE"].sprite, floorTiles[2]["WE"].quad,7 * tile.sz,3 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["SW"].sprite, floorTiles[2]["SW"].quad,8 * tile.sz,3 * tile.sz,0,tile.mdf,tile.mdf)

  love.graphics.draw(floorTiles[2]["NE"].sprite, floorTiles[2]["NE"].quad,2 * tile.sz,13 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["WE"].sprite, floorTiles[2]["WE"].quad,3 * tile.sz,13 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["WE"].sprite, floorTiles[2]["WE"].quad,4 * tile.sz,13 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["WE"].sprite, floorTiles[2]["WE"].quad,5 * tile.sz,13 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["WE"].sprite, floorTiles[2]["WE"].quad,6 * tile.sz,13 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["WE"].sprite, floorTiles[2]["WE"].quad,7 * tile.sz,13 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NW"].sprite, floorTiles[2]["NW"].quad,8 * tile.sz,13 * tile.sz,0,tile.mdf,tile.mdf)

  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,2 * tile.sz,4 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,2 * tile.sz,5 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,2 * tile.sz,6 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,2 * tile.sz,7 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,2 * tile.sz,8 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,2 * tile.sz,9 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,2 * tile.sz,10 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,2 * tile.sz,11 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,2 * tile.sz,12 * tile.sz,0,tile.mdf,tile.mdf)

  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,8 * tile.sz,4 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,8 * tile.sz,5 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,8 * tile.sz,6 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,8 * tile.sz,7 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,8 * tile.sz,8 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,8 * tile.sz,9 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,8 * tile.sz,10 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,8 * tile.sz,11 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(floorTiles[2]["NS"].sprite, floorTiles[2]["NS"].quad,8 * tile.sz,12 * tile.sz,0,tile.mdf,tile.mdf)

  love.graphics.draw(wallTiles[1]["SE"].sprite, wallTiles[1]["SE"].quad,1 * tile.sz,2 * tile.sz,0,tile.mdf,tile.mdf)

  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,2 * tile.sz,2 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,3 * tile.sz,2 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,4 * tile.sz,2 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,5 * tile.sz,2 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,6 * tile.sz,2 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,7 * tile.sz,2 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,8 * tile.sz,2 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,8 * tile.sz,2 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["SW"].sprite, wallTiles[1]["SW"].quad,9 * tile.sz,2 * tile.sz,0,tile.mdf,tile.mdf)

  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,2 * tile.sz,14 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,3 * tile.sz,14 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,4 * tile.sz,14 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,5 * tile.sz,14 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,6 * tile.sz,14 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,7 * tile.sz,14 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,8 * tile.sz,14 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["EW"].sprite, wallTiles[1]["EW"].quad,8 * tile.sz,14 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["SW"].sprite, wallTiles[1]["SW"].quad,9 * tile.sz,14 * tile.sz,0,tile.mdf,tile.mdf)



  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,9 * tile.sz,3 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,9 * tile.sz,4 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,9 * tile.sz,5 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,9 * tile.sz,6 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,9 * tile.sz,7 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,9 * tile.sz,8 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,9 * tile.sz,9 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,9 * tile.sz,10 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,9 * tile.sz,11 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,9 * tile.sz,12 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,9 * tile.sz,13 * tile.sz,0,tile.mdf,tile.mdf)

  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,1 * tile.sz,3 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,1 * tile.sz,4 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,1 * tile.sz,5 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,1 * tile.sz,6 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,1 * tile.sz,7 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,1 * tile.sz,8 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,1 * tile.sz,9 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,1 * tile.sz,10 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,1 * tile.sz,11 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,1 * tile.sz,12 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NS"].sprite, wallTiles[1]["NS"].quad,1 * tile.sz,13 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NE"].sprite, wallTiles[1]["NE"].quad,1 * tile.sz,14 * tile.sz,0,tile.mdf,tile.mdf)
  love.graphics.draw(wallTiles[1]["NW"].sprite, wallTiles[1]["NW"].quad,9 * tile.sz,14 * tile.sz,0,tile.mdf,tile.mdf)
end
