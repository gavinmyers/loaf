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
require "resources/DawnLike_1/Items/LongWep"
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
goblin.hostile = true
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
  longWeaponTiles = resources.longWeapon()


  map = {}
  map.floor = {}
  map.structure = {}
  map.items = {}
  map.creatures = {}
  map.effects = {}
  for x = 1, tile.acs do
    map.floor[x] = {}
    map.structure[x] = {}
    map.creatures[x] = {}
    map.items[x] = {}
    map.effects[x] = {}
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

function effect(typ,tile,tar,targetX,targetY)
  if typ == "DAMAGE" then
    map.effects[targetX][targetY] = {type=typ,tile=tile,method=effectDamage,start=10,target=tar} 
  elseif typ == "DEFEND" then
    map.effects[targetX][targetY] = {type=typ,tile=tile,method=effectDefend,start=10,target=tar} 
  end
end

function effectDefend(x, y)
  local dt = map.effects[x][y]
  love.graphics.setColor(255,255,255,255)

  love.graphics.setBlendMode("alpha")
  if (dt.start % 2) == 0 then
    love.graphics.setColor(0,0,0,255)
  else
    love.graphics.setColor(0,0,0,255)
  end
  tile.graphics.draw(dt.target.tile,x,y)

  dt.start = dt.start - 1 
  if(dt.start < 1) then
    map.effects[x][y] = nil
  end
  love.graphics.setColor(255,255,255,255)
end

function effectDamage(x, y)
  local dt = map.effects[x][y]
  love.graphics.setColor(255,255,255,255)

  love.graphics.setBlendMode("alpha")
  if (dt.start % 2) == 0 then
    love.graphics.setColor(255,0,0,255)
  else
    love.graphics.setColor(0,0,0,255)
  end
  tile.graphics.draw(dt.target.tile,x,y)

  love.graphics.setColor(255, 255,255,255)
  tile.graphics.draw(map.effects[x][y].tile,x,y)

  dt.start = dt.start - 1 
  if(dt.start < 1) then
    map.effects[x][y] = nil
  end
  love.graphics.setColor(255, 255,255,255)
end

function action(who,targetX,targetY) 
  if targetX < 2 or targetX > tile.acs -1 then 
  elseif targetY < 2 or targetY > tile.dwn -1 then
  elseif mode == "MOVE" then
    if map.structure[targetX][targetY] ~= nil then
    elseif map.creatures[targetX][targetY] ~= nil then
      if map.creatures[targetX][targetY].hostile == true then
        mode = "PRIMARY"
        action(who,targetX,targetY)
      end
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
        effect("DAMAGE",longWeaponTiles[1],defender,defender.x,defender.y)
        if defender.hp < 1 then
          defender.die()
          mode = "MOVE"
        end
      else
        effect("DEFEND",longWeaponTiles[1],defender,defender.x,defender.y)
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
      if map.items[x] ~= nil and map.items[x][y] ~= nil then
        tile.graphics.draw(map.items[x][y],x,y)
      end
      if map.effects[x] ~= nil and map.effects[x][y] ~= nil then
        map.effects[x][y].method(x,y)
      end
    end
  end
end
