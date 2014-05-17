require "shader/lighting"
require "map"
require "graphics"

area = nil
function love.load()
  graphics.init()
  area = map.create(map.themes.cave)
  area.batch = graphics.renderMap(area.tiles)
end

function love.update(dt)

end

function love.draw()
  love.graphics.draw(area.batch, 0, 0)
  love.graphics.print("loaf " .. area.tiles[0][0],0,0)
  graphics.drawSprite("c0", 32, 256)
end
