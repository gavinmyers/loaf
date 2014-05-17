map = {}
map.themes = {}

function map.create(theme) 
  if theme == nil then
    theme = map.themes.default
  end
  local mapinst = {}
  mapinst.tiles = {}
  mapinst.draw = theme
  mapinst.draw(mapinst)
  return mapinst
end

function map.themes.default(self)
  math.randomseed( os.time() )
  for x = 0, 200 do
    self.tiles[x] = {}
    for y = 0, 200 do
      local t = math.random(0,800)
      self.tiles[x][y] = t 
    end
  end
end

