require "shader/lighting"
require "map"
require "graphics"

area = nil
function love.load()
  graphics.init()
  area = map.create()
  
end

function love.update(dt)

end

function love.draw()
  love.graphics.print("loaf " .. area.tiles[0][0],0,0)
  local f1 = graphics.sprites["floor001"]
  local f2 = graphics.sprites["floor002"]
  local p = graphics.sprites["player001"]
  love.graphics.draw(f1.sprite, f1.quad, 200, 200)
  love.graphics.draw(f2.sprite, f2.quad, 200, 216)
  love.graphics.draw(p.sprite, p.quad, 200, 200)
end
