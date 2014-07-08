require "lib/postshader"
require "lib/light"
require "lib/json"
require "map"
require "thing"
require "client"
require "graphics"

local inspect = require "lib/inspect"

player = Player:new{x=0,y=0,sprite="c0"}
--sceneChange = false
playerMoving = false
playerMoveToX = 0
playerMoveToY = 0
cameraX = 0
cameraOffsetX = 392 
cameraOffsetY = 312 
cameraY = 0
area = nil
lightWorld = nil
lightEnable = true
math.randomseed(os.time())

function love.load()
  print(inspect(love.graphics))
  --connection:connect("127.0.0.1", 9988)
  --log in
  --connection:send('{"token":"'..token..'","action":"connect"}\r\n')
  --generate map (move current map.create to go)
  --connection:send('{"token":"'..token..'","action":"map"}\r\n')
  graphics.init()
  area = map.create(100,100,map.themes.cave)
  area.batch = graphics.renderMap(area.width,area.height,area.tiles)
  print(area.width .. " by " .. area.height)
  for x = 2,area.width do
    for y = 2,area.height do
      local v = area.tiles[x][y]
      local t = map.types.source(v) 
      if t == map.types.exit then
        player.x = x * 16
        player.y = y * 16
        local mx = player.x
        local my = player.y
        cameraX = cameraOffsetX + mx * -1 
        cameraY = cameraOffsetY + my * -1 
      end
    end
  end
  lightPlayer()
  --sceneChange = true
end

function lightPlayer() 
  lightWorld = love.light.newWorld()
  lightWorld.blur = 10.0
  lightWorld.setAmbientColor(0, 0, 0) -- optional
  lightMouse = lightWorld.newLight(255, 255, 255, 255, 255, 300)
  lightMouse.setGlowStrength(1) -- optional

  lightWorld2 = love.light.newWorld()
  lightWorld2.blur = 8.0
  lightWorld2.setAmbientColor(180, 180, 180) -- optional

  lightMouse2 = lightWorld2.newLight(0, 0, 255, 255, 255, 3000)
  lightMouse2.setGlowStrength(1) -- optional

  local tiles = area.tiles
  for x=2,area.width do
    for y=2,area.height do
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
          local r = lightWorld.newRectangle(nx+8,ny+8,16,16) 
        else
          local r = lightWorld2.newRectangle(nx+8,ny+8,16,16)
        end
      end
    end
  end

  lightWorld.translate(math.abs(cameraX), math.abs(cameraY))
  lightWorld2.translate(math.abs(cameraX), math.abs(cameraY))
end

function love.keypressed(key)
  if playerMoving then
    return
  end

  local tx = player.x / 16
  local ty = player.y / 16
  if key == "escape" then
    love.event.quit()
  elseif key == "w" then
    local v = area.tiles[tx][ty-1]
    local t = map.types.source(v) 
    if(t == map.types.free) then
      playerMoving = true
      playerMoveToX = player.x
      playerMoveToY = player.y - 16
    end
  elseif key == "s" then
    local v = area.tiles[tx][ty+1]
    local t = map.types.source(v) 
    if(t == map.types.free) then
      playerMoving = true
      playerMoveToX = player.x
      playerMoveToY = player.y + 16
    end
  elseif key == "a" then
    local v = area.tiles[tx-1][ty]
    local t = map.types.source(v) 
    if(t == map.types.free) then
      playerMoving = true
      playerMoveToY = player.y
      playerMoveToX = player.x - 16
    end
  elseif key == "d" then
    local v = area.tiles[tx+1][ty]
    local t = map.types.source(v) 
    if(t == map.types.free) then
      playerMoving = true
      playerMoveToY = player.y
      playerMoveToX = player.x + 16
    end
  elseif key == "l" then
    --connection:send('{"token":"'..token..'","action":"ack"}\r\n')
    lightEnable = lightEnable == false
  elseif key == " " then
    area = map.create(100,100,map.themes.cave)
    area.batch = graphics.renderMap(area.width,area.height,area.tiles)
    lightPlayer()
  end
end

function love.update(dt)
  local playerSpeed = 4 
  if playerMoving and (player.x ~= playerMoveToX or player.y ~= playerMoveToY) then
    if player.x > playerMoveToX then
      player.x = player.x - playerSpeed 
    elseif player.x < playerMoveToX then
      player.x = player.x + playerSpeed 
    end 
    if player.y > playerMoveToY then
      player.y = player.y - playerSpeed 
    elseif player.y < playerMoveToY then
      player.y = player.y + playerSpeed 
    end 
  else 
    playerMoving = false
  end


  --connection:update()
  --lightMouse.setPosition(love.mouse.getX(), love.mouse.getY())
  --lightMouse2.setPosition(love.mouse.getX(), love.mouse.getY())
  lightMouse.setPosition(player.x+8, player.y+8) 
  lightMouse2.setPosition(player.x+8, player.y+8) 
end

function love.draw()
    --love.graphics.scale(0.1,0.1)
  local mx = player.x
  local my = player.y
  if math.abs(cameraX - (cameraOffsetX + mx * -1)) > 256 
    or math.abs(cameraY - (cameraOffsetY + my * -1)) > 256 then
    local addOffsetX = (cameraX - (cameraOffsetX + mx * -1))
    local addOffsetY = (cameraY - (cameraOffsetY + my * -1))
    addOffsetX = 0
    addOffsetY = 0
    cameraX = cameraOffsetX + addOffsetX + mx * -1
    cameraY = cameraOffsetY + addOffsetY + my * -1
    if(cameraX > 0) then
      cameraX = 0
    end
    if(cameraY > 0) then
      cameraY = 0
    end
    --cameraX =  50 - mx
    --cameraY =  50 + my * -1
    lightWorld.translate(math.abs(cameraX), math.abs(cameraY))
    lightWorld2.translate(math.abs(cameraX), math.abs(cameraY))
  end
  love.graphics.translate(cameraX, cameraY)

  love.graphics.draw(area.batch)
  if lightEnable then
    lightWorld.update()
    lightWorld2.update()
    lightWorld2.drawShadow()
    lightWorld.drawShadow()
  end
  graphics.drawThing(player)
  love.graphics.rectangle("fill", math.abs(cameraX), math.abs(cameraY), 800, 50)
  love.graphics.rectangle("fill", math.abs(cameraX), math.abs(cameraY) + 586, 800, 50)
  love.graphics.rectangle("fill", math.abs(cameraX), math.abs(cameraY) , 140, 800)
  love.graphics.rectangle("fill", math.abs(cameraX) + 670, math.abs(cameraY) , 140, 800)
  love.graphics.print("loaf " .. player.x .. "," ..player.y,0,0,0)
end
