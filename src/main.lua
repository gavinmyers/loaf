require "lib/postshader"
require "lib/light"
require "map"
require "graphics"

area = nil
lightWorld = nil
function love.load()
  graphics.init()
  area = map.create(200,200,map.themes.cave)
  area.batch = graphics.renderMap(area.width,area.height,area.tiles)

  lightWorld = love.light.newWorld()
  -- lightWorld.setAmbientColor(20, 20, 20) -- optional
  lightMouse = lightWorld.newLight(0, 0, 255, 255, 255, 3000)
  lightMouse.setGlowStrength(1) -- optional
  for x=1,200 do
    for y=1,200 do
      local v = area.tiles[x][y]
      local t = map.types.source(v)
      if t == map.types.full then
        local nx = 16 * x
        local ny = 16 * y

        local r = lightWorld.newRectangle(nx+8,ny+8,16,16) -- (x, y, width, height)
      end
    end
  end

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
  lightMouse.setPosition(love.mouse.getX(), love.mouse.getY())
end

function love.draw()
  lightWorld.update()
  love.graphics.draw(area.batch,0,0,0,1)
  love.graphics.print("loaf " .. area.tiles[1][1],0,0,0.5)
  graphics.drawSprite("c0", 32, 256)
  lightWorld.drawShadow()

  lightWorld.drawShine()
end
