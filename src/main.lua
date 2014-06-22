require "lib/postshader"
require "lib/light"
require "lib/json"
require "map"
require "thing"
require "client"
require "graphics"

local inspect = require "lib/inspect"

player = Player:new{x=0,y=0,sprite="c0"}
area = nil
lightWorld = nil
lightEnable = true
math.randomseed(os.time())

function love.load()
  connection:connect("127.0.0.1", 9988)
  --log in
  connection:send('{"token":"'..token..'","action":"connect"}\r\n')
  --generate map (move current map.create to go)
  connection:send('{"token":"'..token..'","action":"map"}\r\n')
  graphics.init()
  area = map.create(200,200,map.themes.cave)
  area.batch = graphics.renderMap(area.width,area.height,area.tiles)
  for x = 2,area.width do
    for y = 2,area.height do
      local v = area.tiles[x][y]
      local t = map.types.source(v) 
      if t == map.types.exit then
        player.x = x * 16
        player.y = y * 16
      end
    end
  end
  lightPlayer()
end

function lightPlayer() 
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
  local tx = player.x / 16
  local ty = player.y / 16
  if key == "escape" then
    love.event.quit()
  elseif key == "w" then
    local v = area.tiles[tx][ty-1]
    local t = map.types.source(v) 
    if(t == map.types.free) then
      player.y = player.y - 16
    end
  elseif key == "s" then
    local v = area.tiles[tx][ty+1]
    local t = map.types.source(v) 
    if(t == map.types.free) then
      player.y = player.y + 16
    end
  elseif key == "a" then
    local v = area.tiles[tx-1][ty]
    local t = map.types.source(v) 
    if(t == map.types.free) then
      player.x = player.x - 16
    end
  elseif key == "d" then
    local v = area.tiles[tx+1][ty]
    local t = map.types.source(v) 
    if(t == map.types.free) then
      player.x = player.x + 16
    end
  elseif key == "l" then
    connection:send('{"token":"'..token..'","action":"ack"}\r\n')
    lightEnable = lightEnable == false
  elseif key == " " then
    area = map.create(200,200,map.themes.cave)
    area.batch = graphics.renderMap(area.width,area.height,area.tiles)
    lightPlayer()
  end
end

function love.update(dt)
  connection:update()
  --lightMouse.setPosition(love.mouse.getX(), love.mouse.getY())
  --lightMouse2.setPosition(love.mouse.getX(), love.mouse.getY())
  lightMouse.setPosition(player.x+8, player.y+8) 
  lightMouse2.setPosition(player.x+8, player.y+8) 
end

function love.draw()
  local mx = player.x
  local my = player.y
  love.graphics.translate(128 + mx * -1,128 + my * -1)

  if lightEnable then
    lightWorld.update()
    lightWorld2.update()
  end
  love.graphics.draw(area.batch)
  love.graphics.print("loaf " .. player.x .. "," ..player.y,0,0,0)
  graphics.drawThing(player)
  if lightEnable then
    lightWorld2.drawShadow()
    lightWorld.drawShadow()
    lightWorld2.drawShine()
    lightWorld.drawShine()
  end
end
