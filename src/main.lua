require "shader/lighting"
require "map"
require "graphics"

area = nil
function love.load()
  graphics.init()
  area = map.create()
  area.batch = graphics.renderMap(area.tiles)
end

function love.update(dt)

end

function love.draw()
  love.graphics.draw(area.batch, 0, 0)
  love.graphics.print("loaf " .. area.tiles[0][0],0,0)
  graphics.drawSprite("player1", 32, 256)
end
