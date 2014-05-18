require "shader/lighting"
require "map"
require "graphics"

area = nil
function love.load()
  graphics.init()
  area = map.create(200,200,map.themes.cave)
  area.batch = graphics.renderMap(area.width,area.height,area.tiles)
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  elseif key == " " then
    area = map.create(200,200,map.themes.cave)
    area.batch = graphics.renderMap(area.width,area.height,area.tiles)
  end
end

function love.update(dt)

end

function love.draw()
  love.graphics.draw(area.batch, 0, 0,0,0.15)
  love.graphics.print("loaf " .. area.tiles[1][1],0,0,0,0.5)
  graphics.drawSprite("c0", 32, 256)
end
