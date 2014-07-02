map = {}
map.themes = {}

function map.create(w,h,theme) 
  if theme == nil then
    theme = map.themes.default
  end
  local mapinst = {}
  mapinst.width = w
  mapinst.height = h
  mapinst.tiles = theme(w + 4,h + 4) 
  return mapinst
end

map.types = {
  void={0},
  free={1,2,3,4,5,6,7,8},
  full={9,10,11,12,13,14,15,16},
  exit={128}}

function map.types.source(r) 
  for k,v in pairs(map.types) do
    if type(v) == "table" then 
      if v[1] <= r and v[#v] >= r then
        return v 
      end
    end
  end
end

function map.types.any(t)
  return t[math.random(#t)]
end

function map.types.primary(t) 
  return t[1]
end

function map.types.secondary(t) 
  if t[2] == nil then
    return t[1]
  else
    return t[2]
  end
end

function map.themes.default(w,h)
  local tiles = {}
  for x = 1,w do
    tiles[x] = {}
    for y = 1,h do
      tiles[x][y] = map.types.primary(map.types.free) 
    end
  end
  return tiles
end

function map.themes.cave(w,h) 
  local tiles = {}
  for x = 1,w+1 do
    tiles[x] = {}
    for y = 1,h+1 do
      if math.random(1,3) ~= 1 then
        tiles[x][y] = map.types.primary(map.types.full) 
      else
        tiles[x][y] = map.types.secondary(map.types.full) 
      end
    end
  end
  --average out the colors
  for i=1,1 do
    for x=2,w-2 do
      for y=2,h-2 do
        local s = tiles[x][y]
        if s ~= nil then
          local e1 = tiles[x-1][y-1] 
          local e2 = tiles[x-1][y] 
          local e3 = tiles[x-1][y+1] 
          local e4 = tiles[x][y-1] 
          local e5 = tiles[x][y+1] 
          local e6 = tiles[x+1][y-1] 
          local e7 = tiles[x+1][y] 
          local e8 = tiles[x+1][y+1] 
          local t = {e1,e2,e3,e4,e5,e6,e7,e8}
          tiles[x][y] = t[math.random(#t)]
        end
      end
    end
  end
  local q = math.random(1,4)
  local sx = 0
  local sy = 0
  local ex = 0
  local ey = 0
  local sw = (w/2) - 1
  local sh = (h/2) - 1
  if q == 1 then
    sx = math.random(1,sw)
    sy = math.random(1,sh)
    ex = math.random(sw) + sw 
    ey = math.random(sh) + sh 
  elseif q == 2 then
    sx = math.random(sw) + sw 
    sy = math.random(1,sh)
    ex = math.random(1,sw)
    ey = math.random(sw) + sw 
  elseif q == 3 then
    sx = math.random(1,sw)  
    sy = math.random(sh) + sh 
    ex = math.random(sw) + sw 
    ey = math.random(1,sh) 
  else 
    sx = math.random(sw) + sw 
    sy = math.random(sh) + sh 
    ex = math.random(1,sw) 
    ey = math.random(1,sh) 
  end
  local wx1 = sx
  local wy1 = sy
  local wx2 = ex
  local wy2 = ey
  local cntr = 0
  while true do 
    cntr = cntr + 1
    if wx1 == ex and wy1 == ey then
      break
    elseif wx2 == sx and wy2 == sy then
      break
    elseif cntr > 100000 then
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
    if wy1 < 1 then
      wy1 = 1  
    elseif wy1 > h then
      wy1 = h 
    end 
    if wx1 < 1 then
      wx1 = 1 
    elseif wx1 > w then
      wx1 = w 
    end 
    tiles[wx1][wy1] = map.types.primary(map.types.free) 
    if d2 == 1 then
      wx2 = wx2 + 1 
    elseif d2 == 2 then
      wy2 = wy2 + 1 
    elseif d2 == 3 then
      wx2 = wx2 - 1 
    elseif d2 == 4 then
      wy2 = wy2 - 1 
    end
    if wy2 < 1 then
      wy2 = 1 
    elseif wy2 >= h then
      wy2 = h 
    end 
    if wx2 < 1 then
      wx2 = 1 
    elseif wx2 >= w then
      wx2 = w 
    end 
    tiles[wx2][wy2] = map.types.primary(map.types.free) 
  end 
  tiles[sx][sy] = map.types.primary(map.types.exit) 
  tiles[ex][ey] = map.types.secondary(map.types.exit) 
  return tiles
end

