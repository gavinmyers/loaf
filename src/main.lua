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
win.w = tile.sz * (tile.acs + 2) 
win.h = tile.sz * (tile.dwn + 2) 

generators = {}

-- should be a complete (if boring) map
function generators.simple() 
  local m = {} 
  for x = 1, tile.acs do
    m[x] = {}
    for y = 1, tile.dwn do
      if x > 1 and x < tile.acs and y > 1 and y < tile.dwn and x % 2 == 1 and y % 2 == 1 and math.random(1,6) == 6 then
        m[x][y] = nil 
      else
        m[x][y] = wallTiles[1]["NS"]
      end
    end
  end
  for p = 1, 4 do
    for x = 1, tile.acs do
      for y = 1, tile.dwn do
        t = m[x][y]
        if t == nil then 
          if x > 2 and x < tile.acs - 1 then
            if math.random(1,6) > 3 then
              m[x-1][y] = -1 
            end
            if math.random(1,6) > 3 then
              m[x+1][y] = -1 
            end
          end
          if y > 2 and y < tile.dwn - 1 then
            if math.random(1,6) > 3 then
              m[x][y-1] = -1 
            end
            if math.random(1,6) > 3 then
              m[x][y+1] = -1 
            end
          end
        end
       
      end
    end
    for x = 1, tile.acs do
      for y = 1, tile.dwn do
        if m[x][y] == -1 then
          m[x][y] = nil
        end
      end
    end
  end
  local sx,sy = nil
  while sx == nil do 
    for x = math.random(2,tile.acs/2), tile.acs-1 do
      for y = math.random(2,tile.dwn/2), tile.dwn-1 do
        if m[x][y] == nil and sx == nil and math.random(1,256) == 1 then
          sx = x
          sy = y
        end
      end
    end
  end
  local path = false
  local cx = sx
  local cy = sy
  local ex, ey = nil
  while path == false do
    if math.random(1,3) == 1 and cx > 2 then 
      cx = cx - 1
    elseif math.random(1,3) == 1 and cx < tile.acs - 1 then 
      cx = cx + 1
    elseif math.random(1,3) == 1 and cy > 2 then 
      cy = cy - 1
    elseif math.random(1,3) == 1 and cy < tile.dwn - 1 then 
      cy = cy + 1
    end
    m[cx][cy] = nil
    if math.random(1,2048) == 1 then
      path = true
    end
  end
  ex = cx
  ey = cy
  m[ex][ey] = wallTiles[1]["EW"]
  m[sx][sy] = wallTiles[1]["EW"]
  map.things[sx][sy] = playerTiles[1] 

  return m
end

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
  map.structure = generators.simple()

end

function love.keypressed(key)
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
