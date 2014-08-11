floorTiles,wallTiles,gameTiles,playerTiles = nil
currentMap = nil
player = nil
mode = "MOVE" 

math.randomseed(os.time())
local inspect = require "lib/inspect"
require "generators"

tile = {}
tile.sz = 32 
tile.acs = 22 
tile.dwn = 22 
tile.mdf =2 
function tile.create(img,q) 
  return {sprite=img,quad=q}
end
tile.graphics = {}
function tile.graphics.draw(t,x,y) 
  love.graphics.draw(t.sprite,t.quad,x*tile.sz,y*tile.sz,0,tile.mdf,tile.mdf)
end
require "resources/DawnLike_1/Objects/Floor"
require "resources/DawnLike_1/Objects/Tile"
require "resources/DawnLike_1/Objects/Wall"
require "resources/DawnLike_1/Characters/Player"

win = {}
win.w = tile.sz * (tile.acs + 2) 
win.h = tile.sz * (tile.dwn + 2) 

player = {}
player.hp = 100
player.attack = 2
player.defend = 2
player.damage = 2
player.x = 1
player.y = 1
player.tile = nil
player.die = function()
end

goblin = {}
goblin.hp = 50
goblin.attack = 1
goblin.defend = 2
goblin.damage = 2
goblin.x = 1
goblin.y = 1
goblin.tile = nil
goblin.die = function()
  map.creatures[goblin.x][goblin.y] = nil 
  print("SQUEEEEE!")
end


function main()
  
  love.graphics.setDefaultFilter("nearest","nearest")
  love.window.setMode(win.w, win.h)

  floorTiles = resources.floor()
  wallTiles = resources.wall()
  gameTiles = resources.tile()
  playerTiles = resources.player()


  map = {}
  map.floor = {}
  map.structure = {}
  map.creatures = {}
  for x = 1, tile.acs do
    map.floor[x] = {}
    map.structure[x] = {}
    map.creatures[x] = {}
  end
  currentMap = generators.simple() 
  map.structure = currentMap.map

  map.floor[currentMap.startX][currentMap.startY] = gameTiles[2] 
  map.floor[currentMap.endX][currentMap.endY] = gameTiles[3] 

  player.x = currentMap.startX
  player.y = currentMap.startY
  player.tile = playerTiles[1]

  goblin.x = currentMap.endX
  goblin.y = currentMap.endY
  goblin.tile = playerTiles[2]

  map.creatures[player.x][player.y] = player
  map.creatures[goblin.x][goblin.y] = goblin 
end

function action(who,targetX,targetY) 
  if targetX < 2 or targetX > tile.acs -1 then 
  elseif targetY < 2 or targetY > tile.dwn -1 then
  elseif mode == "MOVE" then
    if map.structure[targetX][targetY] ~= nil then
    elseif map.creatures[targetX][targetY] ~= nil then
    else
      map.creatures[who.x][who.y] = nil 
      who.x = targetX
      who.y = targetY
      map.creatures[who.x][who.y] = who
      if who.x == currentMap.endX and who.y == currentMap.endY then
        main()
      end
    end
  elseif mode == "PRIMARY" then
    if map.creatures[targetX][targetY] ~= nil then
      local attacker = who
      local defender = map.creatures[targetX][targetY]
      if math.random(1,attacker.attack * 6) > math.random(1, defender.defend * 6) then
        defender.hp = defender.hp - math.random(1,attacker.damage * 6)
        if defender.hp < 1 then
          defender.die()
        end
      end
    end
    mode = "MOVE" 
  end
end

function love.load()
  main()
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  elseif key == "w" then
    action(player, player.x, player.y-1)
  elseif key == "a" then
    action(player, player.x-1, player.y)
  elseif key == "s" then
    action(player, player.x, player.y+1)
  elseif key == "d" then
    action(player, player.x+1, player.y)
  elseif key == "q" then
    mode = "PRIMARY"
  elseif key == "e" then
    mode = "MOVE"
  elseif key == " " then
    main()
  end
end

function love.update(dt)
end

function love.draw()
  for x = 1, tile.acs do
    for y = 1, tile.dwn do
      tile.graphics.draw(gameTiles[1],x,y)
      if map.floor[x] ~= nil and map.floor[x][y] ~= nil then
        tile.graphics.draw(map.floor[x][y],x,y)
      end
      if map.structure[x] ~= nil and map.structure[x][y] ~= nil then
        tile.graphics.draw(map.structure[x][y],x,y)
      end
      if map.creatures[x] ~= nil and map.creatures[x][y] ~= nil then
        tile.graphics.draw(map.creatures[x][y].tile,x,y)
      end
    end
  end
end
