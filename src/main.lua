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

function generators.edges(m,x,y)
  local eN, eS, eE, eW = nil
  eN = m[x][y-1] 
  eS = m[x][y+1] 

  if m[x+1] ~= nil then
    eE = m[x+1][y] 
  end

  if m[x-1] ~= nil then
    eW = m[x-1][y] 
  end

  local eX = m[x][y] 

  if eN ~= nil and eS ~= nil and eE ~= nil and eW ~= nil then 
    return "NSEW"

  elseif eN == nil and eS == nil and eE == nil and eW == nil then 
    return ""

  elseif eN ~= nil and eS == nil and eE == nil and eW == nil then 
    return "N"
  elseif eN == nil and eS ~= nil and eE == nil and eW == nil then 
    return "S"
  elseif eN == nil and eS == nil and eE ~= nil and eW == nil then 
    return "E"
  elseif eN == nil and eS == nil and eE == nil and eW ~= nil then 
    return "W"

  elseif eN ~= nil and eS ~= nil and eE == nil and eW == nil then 
    return "NS"

  elseif eN ~= nil and eS == nil and eE ~= nil and eW == nil then 
    return "NE"
  elseif eN ~= nil and eS == nil and eE == nil and eW ~= nil then 
    return "NW"

  elseif eN == nil and eS ~= nil and eE ~= nil and eW == nil then 
    return "SE"
  elseif eN == nil and eS ~= nil and eE == nil and eW ~= nil then 
    return "SW"

  elseif eN == nil and eS == nil and eE ~= nil and eW ~= nil then 
    return "EW"

  elseif eN ~= nil and eS ~= nil and eE ~= nil and eW == nil then 
    return "NSE"
  elseif eN ~= nil and eS ~= nil and eE == nil and eW ~= nil then 
    return "NSW"

  elseif eN ~= nil and eS == nil and eE ~= nil and eW ~= nil then 
    return "NEW"
  elseif eN == nil and eS ~= nil and eE ~= nil and eW ~= nil then 
    return "SEW"
  end
  
  return ""
end
-- should be a complete (if boring) map
function generators.simple() 
  local m = {} 
  for x = 1, tile.acs do
    m[x] = {}
    for y = 1, tile.dwn do
      if x > 1 and x < tile.acs and y > 1 and y < tile.dwn and x % 2 == 1 and y % 2 == 1 and math.random(1,6) == 6 then
        m[x][y] = nil 
      else
        m[x][y] = 1 
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
  map.things[sx][sy] = playerTiles[1] 

  for x = 1, tile.acs do
    for y = 1, tile.dwn do
      if m[x][y] ~= nil then
        m[x][y] = wallTiles[1][generators.edges(m,x,y)]
      end
    end
  end

  m[ex][ey] = wallTiles[1]["EW"]
  m[sx][sy] = wallTiles[1]["EW"]
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
