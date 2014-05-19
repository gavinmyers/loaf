require "lib/postshader"
require "lib/light"
require "map"
require "graphics"

area = nil
lightWorld = nil
function love.load()
  math.randomseed(os.time())
  graphics.init()
  area = map.create(200,200,map.themes.cave)
  area.batch = graphics.renderMap(area.width,area.height,area.tiles)

  lightWorld = love.light.newWorld()
  lightMouse = lightWorld.newLight(0, 0, 255, 255, 255, 3000)
  lightMouse.setGlowStrength(5) -- optional

  lightWorld2 = love.light.newWorld()
  lightWorld2.setAmbientColor(40, 40, 40) -- optional
  lightMouse2 = lightWorld2.newLight(0, 0, 255, 255, 255, 3000)
  lightMouse2.setGlowStrength(5) -- optional

  local tiles = area.tiles
  for x=2,198 do
    for y=2,198 do
      local v = area.tiles[x][y]
      local t = map.types.source(v)
      if t == map.types.full then
        local nx = 16 * x
        local ny = 16 * y

        local e1 = map.types.source(tiles[x-1][y-1]) 
        local e2 = map.types.source(tiles[x-1][y]) 
        local e3 = map.types.source(tiles[x-1][y+1])
        local e4 = map.types.source(tiles[x][y-1]) 
        local e5 = map.types.source(tiles[x][y+1]) 
        local e6 = map.types.source(tiles[x+1][y-1]) 
        local e7 = map.types.source(tiles[x+1][y]) 
        local e8 = map.types.source(tiles[x+1][y+1]) 
        if e1 == t and e2 == t and e3 == t and e4 == t and e5 == t and e6 == t and e7 == t and e8 == t then
          local r = lightWorld.newRectangle(nx+8,ny+8,16,16) -- (x, y, width, height)
        else
          local r = lightWorld2.newRectangle(nx+8,ny+8,16,16) -- (x, y, width, height)
        end
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
  lightMouse2.setPosition(love.mouse.getX(), love.mouse.getY())
end

function love.draw()
  lightWorld.update()
  lightWorld2.update()
  love.graphics.draw(area.batch,0,0,0,1)
  love.graphics.print("loaf " .. area.tiles[1][1],0,0,0.5)
  graphics.drawSprite("c0", 32, 256)
  lightWorld.drawShadow()
  lightWorld2.drawShadow()

  lightWorld.drawShine()
  lightWorld2.drawShine()
end
