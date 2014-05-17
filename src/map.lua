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
-- 0 nothing
-- 1 wall
-- 2 exit
function map.themes.default()
  math.randomseed( os.time() )
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

function map.themes.dungeon() 
  local tiles = {}
  return tiles
end

