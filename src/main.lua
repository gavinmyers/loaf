require "game"
require "generators"
require "effects"
require "tile"

local inspect = require "lib/inspect"

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
goblin.defend = 6 
goblin.damage = 2
goblin.x = 1
goblin.y = 1
goblin.tile = nil
goblin.die = function()
  map.creatures[goblin.x][goblin.y] = nil 
  print("SQUEEEEE!")
end


function main()
  math.randomseed(os.time())
  love.graphics.setDefaultFilter("nearest","nearest")
  love.window.setMode(game.w, game.h)

  tile.main()

  map = {}
  map.floor = {}
  map.structure = {}
  map.items = {}
  map.creatures = {}
  map.effects = {}
  for x = 1, game.acs do
    map.floor[x] = {}
    map.structure[x] = {}
    map.creatures[x] = {}
    map.items[x] = {}
    map.effects[x] = {}
  end
  currentMap = generators.simple() 
  map.structure = currentMap.map


  map.floor[currentMap.startX][currentMap.startY] = tile.sets.game[2] 
  map.floor[currentMap.endX][currentMap.endY] = tile.sets.game[3] 

  player.x = currentMap.startX
  player.y = currentMap.startY
  player.tile = tile.sets.player[1]

  goblin.x = currentMap.endX
  goblin.y = currentMap.endY
  goblin.tile = tile.sets.player[2]

  map.creatures[player.x][player.y] = player
  map.creatures[goblin.x][goblin.y] = goblin 
end

function action(who,targetX,targetY) 
  if targetX < 2 or targetX > game.acs -1 then 
  elseif targetY < 2 or targetY > game.dwn -1 then
  elseif game.mode == nil or game.mode == "" or game.mode == "MOVE" then
    if map.structure[targetX][targetY] ~= nil then
      map.structure[targetX][targetY] = nil
      map.structure = generators.edges(map.structure) 
    elseif map.creatures[targetX][targetY] ~= nil then
      if map.creatures[targetX][targetY].hostile == true then
        game.mode = "PRIMARY"
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
  elseif game.mode == "PRIMARY" then
    if map.creatures[targetX][targetY] ~= nil then
      local attacker = who
      local defender = map.creatures[targetX][targetY]
      if math.random(1,attacker.attack * 6) > math.random(1, defender.defend * 6) then
        defender.hp = defender.hp - math.random(1,attacker.damage * 6)
        effect("DAMAGE",tile.sets.longWeapon[1],defender,defender.x,defender.y)
        if defender.hp < 1 then
          defender.die()
          game.mode = "MOVE"
        end
      else
        effect("DEFEND",tile.sets.longWeapon[1],defender,defender.x,defender.y)
      end
    end
    game.mode = "MOVE" 
  end
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
    game.mode = "PRIMARY"
  elseif key == "e" then
    game.mode = "MOVE"
  elseif key == " " then
    main()
  end
end

function love.update(dt)
end

function love.draw()
  for x = 1, game.acs do
    for y = 1, game.dwn do
      tile.graphics.draw(tile.sets.game[1],x,y)
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

function love.load()
  main()
end
