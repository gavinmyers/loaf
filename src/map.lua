map = {}
map.themes = {}

function map.create(theme) 
  if theme == nil then
    theme = map.themes.default
  end
  local mapinst = {}
  mapinst.tiles = theme() 
  return mapinst
end
-- 0 empty 
-- 1 full 
-- 2 exit 
-- 255 player start 
function map.themes.default()
  math.randomseed(os.time())
  local tiles = {}
  for x = 0, 200 do
    tiles[x] = {}
    for y = 0, 200 do
      local t = math.random(0,3)
      tiles[x][y] = t 
    end
  end
  return tiles
end

function map.themes.cave() 
  math.randomseed(os.time())
  local tiles = {}
  for x = 0, 200 do
    tiles[x] = {}
    for y = 0, 200 do
      tiles[x][y] = 1 
    end
  end
  local q = math.random(1,4)
  local sx = 0
  local sy = 0
  local ex = 0
  local ey = 0
  if q == 1 then
    sx = math.random(20)
    sy = math.random(20)
    ex = math.random(20) + 20
    ey = math.random(20) + 20
  elseif q == 2 then
    sx = math.random(20) + 20 
    sy = math.random(20)
    ex = math.random(20)
    ey = math.random(20) + 20
  elseif q == 3 then
    sx = math.random(20)  
    sy = math.random(20) + 20
    ex = math.random(20) + 20 
    ey = math.random(20) 
  else 
    sx = math.random(20) + 20 
    sy = math.random(20) + 20
    ex = math.random(20) 
    ey = math.random(20) 
  end
  local wx1 = sx
  local wy1 = sy
  local wx2 = ex
  local wy2 = ey
  local cntr = 0
  while ((cntr < 100) or (wx1 ~= ex and wy1 ~= ey) or (wx2 ~= sx and wy2 ~= sy)) do
    cntr = cntr + 1
    if wx1 == ex and wy1 == ey then
      break
    elseif wx2 == sx and wy2 == sy then
      break
    elseif cntr > 10000 then
      --break
    end
    d1 = math.random(1,4)
    d2 = math.random(1,4)
    if d1 == 1 then
      wx1 = wx1 + 1
    elseif d1 == 2 then
      wy1 = wy1 + 1
    elseif d1 == 3 then
      wx1 = wx1 - 1
    elseif d1 == 4 then
      wy1 = wy1 - 1
    end
    if wy1 < 0 then
      wy1 = 0
    elseif wy1 > 199 then
      wy1 = 199
    end 
    if wx1 < 0 then
      wx1 = 0
    elseif wx1 > 199 then
      wx1 = 199
    end 
    tiles[wx1][wy1] = 0
    if d2 == 2 then
      wx2 = wx2 + 1 
    elseif d2 == 2 then
      wy2 = wy2 + 1 
    elseif d2 == 3 then
      wx2 = wx2 - 1 
    elseif d2 == 4 then
      wy2 = wy2 - 1 
    end
    if wy2 < 0 then
      wy2 = 0
    elseif wy2 > 299 then
      wy2 = 299
    end 
    if wx2 < 0 then
      wx2 = 0
    elseif wx2 > 299 then
      wx2 = 299
    end 
    tiles[wx2][wy2] = 0
  end 
  tiles[sx][sy] = 2 
  tiles[ex][ey] = 2 
  return tiles
end

