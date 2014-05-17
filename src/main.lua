require "shader/lighting"
require "map"

area = nil
function love.load()
  area = map.create()
  print(area.tiles[20][20])
end

function love.update(dt)

end

function love.draw()
  love.graphics.print("loaf",0,0)
end
