require "lib/postshader"
require "lib/light"
require "map"
require "graphics"

host, port = "127.0.0.1", 9988 
socket = require("socket")
tcp = assert(socket.tcp())
tcp:connect(host, port)

area = nil
lightWorld = nil
lightEnable = true


function love.load()
  math.randomseed(os.time())
  graphics.init()
  area = map.create(200,200,map.themes.cave)
  area.batch = graphics.renderMap(area.width,area.height,area.tiles)
  light()


  --while false do
  --    local s, status, partial = tcp:receive()
  --    print(s or partial)
  --    if status == "closed" then break end
  --end
  --tcp:close()
end

function light() 
  lightWorld = love.light.newWorld()
  lightWorld.setAmbientColor(0, 0, 0) -- optional
  lightMouse = lightWorld.newLight(255, 255, 255, 255, 255, 300)
  lightMouse.setGlowStrength(1) -- optional

  lightWorld2 = love.light.newWorld()
  lightWorld2.setAmbientColor(180, 180, 180) -- optional

  lightMouse2 = lightWorld2.newLight(0, 0, 255, 255, 255, 3000)
  lightMouse2.setGlowStrength(1) -- optional

  local tiles = area.tiles
  for x=2,198 do
    for y=2,198 do
      local et = area.tiles[x][y]
      local t = map.types.source(et)
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
        local es = {e1,e2,e3,e4,e5,e6,e7,e8}
        local tt = 0
        for i, v in ipairs(es) do
          if v == map.types.full then
            tt = tt + 1
          end
        end
        if tt == 8 then 
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
  elseif key == "l" then

    tcp:send('{"token":"love2d20","action":"connect"}\r\n')
    tcp:send('{"token":"love2d_t1","action":"connect"}\r\n')
    tcp:send('{"token":"love2d_t2","action":"connect","data":false}\r\n')
    tcp:send('{"token":"love2d_t3","action":"connect","data":null}\r\n')
    tcp:send('{"token":"love2d_t4","action":"connect","data":""}\r\n')
    tcp:send('{"token":"love2d_t4","action":"disconnect","data":""}\r\n')

    lightEnable = lightEnable == false
  elseif key == " " then
    area = map.create(200,200,map.themes.cave)
    area.batch = graphics.renderMap(area.width,area.height,area.tiles)
    light()
  end
end

function love.update(dt)
  lightMouse.setPosition(love.mouse.getX(), love.mouse.getY())
  lightMouse2.setPosition(love.mouse.getX(), love.mouse.getY())
end

function love.draw()
  if lightEnable then
    lightWorld.update()
    lightWorld2.update()
  end
  love.graphics.draw(area.batch,0,0,0,1)
  love.graphics.print("loaf " .. area.tiles[1][1],0,0,0.5)
  graphics.drawSprite("c0", 32, 256)
  if lightEnable then
    lightWorld2.drawShadow()
    lightWorld.drawShadow()

    lightWorld2.drawShine()
    lightWorld.drawShine()
  end
end
