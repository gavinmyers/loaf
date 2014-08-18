require "game"
require "generators"
require "effects"
require "tile"

local inspect = require "lib/inspect"

font = love.graphics.newFont("resources/fonts/VeraMono.ttf",14)
love.graphics.setFont(font)

gameFont = love.graphics.newFont("resources/DawnLike_1/GUI/SDS_8x8.ttf",14)
gameFont = love.graphics.newFont("resources/fonts/VeraMono.ttf",18)

events = {}
events.db = {}
function events:create(id)
  local ev = {}
  ev.id = id
  ev.x = 0
  ev.y = 0
  function ev:trigger(target)
    if self._trigger ~= nil then
      return self:_trigger(target)
    end
  end
  events.db[id] = ev
  return ev
end 

item = {}
item.db = {}
function item:create(id)
  local ni = {}
  ni.id = id
  item.db[id] = ni
  return ni
end

ability = {}
ability.db = {}
function ability:create(id) 
  local newAbility = {}
  newAbility.id = id
  newAbility.modifiers = {}  
  function newAbility:use(target)
    if self._use ~= nil then
      return self:_use(target)
    end
  end

  function newAbility:useMod(ability,target)
    if self._useMod ~= nil then
      return self:_useMod(ability,target)
    end
  end

  function newAbility:attack(attacker,defender)
    local res = false
    if self._attack ~= nil then
      res = self:_attack(attacker,defender)
    end
    for i = 1, #self.modifiers do
      local mod = self.modifiers[i]
      res = res + mod:attackMod(self,attacker,defender)
    end
    return res
  end

  function newAbility:attackMod(ability,attacker,defender)
    if self._attackMod ~= nil then
      return self:_attackMod(ability,attacker,defender)
    end
  end

  function newAbility:defend(attacker,defender)
    if self._defend ~= nil then
      return self:_defend(attacker,defender)
    end
  end

  function newAbility:defendMod(ability,attacker,defender)
    if self._defendMod ~= nil then
      return self:_defendMod(ability,attacker,defender)
    end
  end

  function newAbility:damage(attacker,defender)
    local res
    if self._damage ~= nil then
      res = self:_damage(attacker,defender)
    end
    for i = 1, #self.modifiers do
      local mod = self.modifiers[i]
      res = res + mod:damageMod(self,attacker,defender)
    end
    return res
  end

  function newAbility:damageMod(ability,attacker,defender)
    local res = 0 
    if self._damageMod ~= nil then
      res = self:_damageMod(ability,attacker,defender)
    end
    return res

  end


  function newAbility:soak(attacker,defender)
    if self._soak ~= nil then
      return self:_soak(attacker,defender)
    end
  end

  function newAbility:soakMod(ability,attacker,defender)
    if self._soakMod ~= nil then
      return self:_soakMod(ability,attacker,defender)
    end
  end

  self.db[id] = newAbility

  return newAbility
end

longSwordAbility = ability:create("LS")
function longSwordAbility:_attack(attacker,defender)
  local base = attacker.attack
  local mod = 2
  local dice = base + mod
  return math.random(1,dice * 6)
end

function longSwordAbility:_damage(attacker,defender)
  local base = attacker.damage
  local mod = 2
  local dice = base + mod
  return math.random(1,dice * 6)
end


modifier = {}
modifier.db = {}
function modifier:create(id)
  local newModifier = {}
  newModifier.id = id
  newModifier.modifiers = {}  

  function newModifier:useMod(ability,target)
    if self._useMod ~= nil then
      return self:_useMod(ability,target)
    end
    return 0
  end

  function newModifier:attackMod(ability,attacker,defender)
    if self._attackMod ~= nil then
      return self:_attackMod(ability,attacker,defender)
    end
    return 0
  end

  function newModifier:defendMod(ability,attacker,defender)
    if self._defendMod ~= nil then
      return self:_defendMod(ability,attacker,defender)
    end
    return 0
  end

  function newModifier:damageMod(ability,attacker,defender)
    if self._damageMod ~= nil then
      return self:_damageMod(ability,attacker,defender)
    end
    return 0
  end

  function newModifier:soakMod(ability,attacker,defender)
    if self._soakMod ~= nil then
      return self:_soakMod(ability,attacker,defender)
    end
    return 0
  end

  self.db[id] = newModifier

  return newModifier
end

stabTown = modifier:create("TB")
function stabTown:_damageMod(ability,attacker,defender)
  return 1000
end
longSwordAbility.modifiers[1] = stabTown

function combat(attacker,defender)
  local ability = attacker.ability
  local attackRoll = ability:attack(attacker,defender)
  for i = 1, #attacker.abilities do
    local abilityMod = attacker.abilities[i]
    if abilityMod ~= ability then
      attackRoll = attackRoll * abilityMod:attackMod(ability,attacker,defender)
    end
  end
  
  local defendRoll = math.random(1,defender.defend * 6)
  for i = 1, #defender.abilities do
    local abilityMod = defender.abilities[i]
    defendRoll = defendRoll * abilityMod:defendMod(ability,attacker,defender)
  end

  if attackRoll > defendRoll then
    return damage(attacker,defender)
  else
    return false
  end
end

function damage(attacker,defender)
  local ability = attacker.ability
  local damageRoll = ability:damage(attacker,defender)
  for i = 1, #attacker.abilities do
    local abilityMod = attacker.abilities[i]
    if abilityMod ~= ability then
      damageRoll = damageRoll * abilityMod:damageMod(ability,attacker,defender)
    end
  end
  if damageRoll == nil then damageRoll = 0 end
  
  local soakRoll = math.random(1,defender.soak * 6)
  for i = 1, #defender.abilities do
    local abilityMod = defender.abilities[i]
    soakRoll = soakRoll * abilityMod:soakMod(ability,attacker,defender)
  end
  if soakRoll == nil then soakRoll = 0 end

  if damageRoll > soakRoll then
    defender.hp = defender.hp - (damageRoll - soakRoll)
    if defender.hp < 1 then
      defender:die()
    end
    return true
  else
    return false
  end
end

creature = {}
creature.db = {}
function creature:remove(id)
  local cr = self.db[id]
  map.creatures[cr.x][cr.y] = nil
  self.db[id] = nil
end

function creature:create(id) 
  local newCreature = {}
  newCreature.id = id
  newCreature.hostile = true
  newCreature.hp = 1
  newCreature.attack = 0
  newCreature.ability = nil
  newCreature.defend = 0
  newCreature.soak = 0
  newCreature.damage = 0
  newCreature.abilities = {}
  newCreature.x = 1 
  newCreature.y = 1 
  newCreature.tile = nil
  function newCreature:die()
    creature:remove(self.id)
    print("SQUEEEE!")
  end
  self.db[id] = newCreature
  return newCreature
end

player = creature:create("PLAYER") 

function main()
  math.randomseed(os.time())
  love.graphics.setDefaultFilter("nearest","nearest")
  love.window.setMode(game.w, game.h)

  tile.main()

  map = {}
  map.events = {}
  map.floor = {}
  map.structure = {}
  map.items = {}
  map.creatures = {}
  map.effects = {}
  map.gui_1 = {}
  map.gui_2 = {}
  map.gui_3 = {}
  for x = 1, game.acs do
    map.events[x] = {}
    map.floor[x] = {}
    map.structure[x] = {}
    map.creatures[x] = {}
    map.items[x] = {}
    map.effects[x] = {}
    map.gui_1[x] = {}
    map.gui_2[x] = {}
    map.gui_3[x] = {}
  end

  --[[
  drawSelectTile(2,1,tile.sets.longWeapon[2])
  drawSelectTile(7,1,tile.sets.longWeapon[4])
  drawSelectTile(12,1,tile.sets.longWeapon[6])
  drawSelectTile(17,1,tile.sets.longWeapon[8])

  drawSelectTile(2,6,tile.sets.longWeapon[2])
  drawSelectTile(7,6,tile.sets.longWeapon[2])
  drawSelectTile(12,6,tile.sets.longWeapon[2])
  drawSelectTile(17,6,tile.sets.longWeapon[2])

  drawSelectTile(2,11,tile.sets.longWeapon[2])
  drawSelectTile(7,11,tile.sets.longWeapon[2])
  drawSelectTile(12,11,tile.sets.longWeapon[2])
  drawSelectTile(17,11,tile.sets.longWeapon[2])

  drawSelectTile(2,16,tile.sets.longWeapon[2])
  drawSelectTile(7,16,tile.sets.longWeapon[2])
  drawSelectTile(12,16,tile.sets.longWeapon[2])
  drawSelectTile(17,16,tile.sets.longWeapon[2])
  ]]--

end

function action(who,targetX,targetY) 
  if targetX < 2 or targetX > game.acs -1 then 
  elseif targetY < 2 or targetY > game.dwn -1 then
  elseif game.mode == nil or game.mode == "" or game.mode == "MOVE" then
    if map.structure[targetX][targetY] ~= nil then
    elseif map.creatures[targetX][targetY] ~= nil then
      if map.creatures[targetX][targetY].hostile == true then
        game.mode = "ABILITY"
        action(who,targetX,targetY)
      end
    elseif map.events[targetX][targetY] ~= nil then
      map.events[targetX][targetY].trigger(who)
    else
      map.creatures[who.x][who.y] = nil 
      who.x = targetX
      who.y = targetY
      map.creatures[who.x][who.y] = who
    end
  elseif game.mode == "ABILITY" then
    if map.creatures[targetX][targetY] ~= nil then

      local attacker = who
      local defender = map.creatures[targetX][targetY]
      if combat(attacker,defender) then
        effect("DAMAGE",tile.sets.longWeapon[1],defender,defender.x,defender.y)
      else
        effect("DEFEND",tile.sets.longWeapon[1],defender,defender.x,defender.y)
      end
    end
    game.mode = "MOVE" 
  end
end

function love.keypressed(key)
  if game.screen == "WELCOME" then
    keyWelcome(key)
  elseif game.screen == "GAME" then
    keyGame(key)
  else 
    keyGame(key)
  end
end

function keyGame(key)
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
    game.mode = "ABILITY"
  elseif key == "e" then
    game.mode = "MOVE"
  elseif key == " " then
    main()
  end
end

function keyWelcome(key)
  if key == "x" then
    love.event.quit()
  elseif key == "1" then
    game.screen = "TUTORIAL"
  elseif key == "2" then
  end
end

function love.update(dt)
end

function love.draw()
  if game.screen == "WELCOME" then
    drawWelcome()
  elseif game.screen == "GAME" then
    drawGame()
  elseif game.screen == "TUTORIAL" then
    drawTutorial()
  end
end

drawTutorialFirst = false
function drawTutorial()
  if drawTutorialFirst == false then
    drawTutorialFirst = true
    currentMap = generators.simple(22,8) 
    map.structure = currentMap.map
    map.floor[currentMap.startX][currentMap.startY] = tile.sets.game[2] 
    map.floor[currentMap.endX][currentMap.endY] = tile.sets.game[3] 
    local ev = events:create("DWN")
    ev.x = currentMap.endX
    ev.y = currentMap.endY

    ev.trigger = function(target)
      print("DOWN!")
    end
    map.events[currentMap.endX][currentMap.endY] = ev 
    player.hp = 100
    player.attack = 4 
    player.defend = 4 
    player.damage = 4 
    player.x = currentMap.startX
    player.y = currentMap.startY
    player.tile = tile.sets.player[1]
    player.abilities[1] = longSwordAbility
    player.ability = longSwordAbility
    local goblin = creature:create("GOBLIN") 
    goblin.x = currentMap.endX
    goblin.y = currentMap.endY
    goblin.tile = tile.sets.player[2]
    goblin.hp = 5000
    goblin.attack = 1
    goblin.defend = 1 
    goblin.damage = 2
    map.creatures[player.x][player.y] = player
    map.creatures[goblin.x][goblin.y] = goblin 
  end
  drawGame()
  love.graphics.setColor(255, 255, 255)
  local screenWidth, screenHeight = love.window.getDimensions()
  love.graphics.setFont(gameFont)
  love.graphics.printf("\n Kill the guard! \n\n Use the [w a s d] keys to attack the guard. Don't worry, you're already equiped with a weapon. When he's dead flee down the staircase.", 25, screenHeight - 200, screenWidth, "left")
end

function drawWelcome()
  love.graphics.setColor(255, 255, 255)
  local screenWidth, screenHeight = love.window.getDimensions()
  love.graphics.setFont(gameFont)
  love.graphics.printf("\n******************\n   WELCOME TO LOAF \n******************\n\n [1] TUTORIAL \n\n [2] CONTINUE \n\n [X] QUIT", 0, 1, screenWidth, "center")
end

function drawTileset(ts)
  for x = 1, game.acs do
    if ts[x] ~= nil then
      for y = 1, game.dwn do
        if ts[x][y] ~= nil then
          tile.graphics.draw(ts[x][y],x,y)
        end
      end
    end
  end
end

function drawGame()
  for x = 1, game.acs do
    for y = 1, game.dwn do
      --tile.graphics.draw(tile.sets.game[1],x,y)
    end
  end

  drawTileset(map.floor)
  drawTileset(map.structure)
  drawTileset(map.creatures)
  drawTileset(map.items)
  drawTileset(map.effects)
  drawTileset(map.gui_1)
  drawTileset(map.gui_2)
  drawTileset(map.gui_3)
end

function drawSelectTile(x,y,t)
  map.gui_1[x    ][y    ] = tile.sets.gui[1]
  map.gui_1[x    ][y + 1] = tile.sets.gui[2]
  map.gui_1[x    ][y + 2] = tile.sets.gui[2]
  map.gui_1[x    ][y + 3] = tile.sets.gui[2]
  map.gui_1[x + 1][y    ] = tile.sets.gui[3]
  map.gui_1[x + 2][y    ] = tile.sets.gui[3]
  map.gui_1[x + 3][y    ] = tile.sets.gui[3]
  map.gui_1[x + 4][y    ] = tile.sets.gui[4]
  map.gui_1[x + 4][y + 1] = tile.sets.gui[5]
  map.gui_1[x + 4][y + 2] = tile.sets.gui[5]
  map.gui_1[x + 4][y + 3] = tile.sets.gui[5]
  map.gui_1[x + 4][y + 4] = tile.sets.gui[6]
  map.gui_1[x + 3][y + 4] = tile.sets.gui[7]
  map.gui_1[x + 2][y + 4] = tile.sets.gui[7]
  map.gui_1[x + 1][y + 4] = tile.sets.gui[7]
  map.gui_1[x    ][y + 4] = tile.sets.gui[8]
  map.gui_1[x + 1][y + 3] = tile.sets.gui[9]
  map.gui_1[x + 1][y + 2] = tile.sets.gui[9]
  map.gui_1[x + 1][y + 1] = tile.sets.gui[9]
  map.gui_1[x + 2][y + 3] = tile.sets.gui[9]
  map.gui_1[x + 2][y + 2] = tile.sets.gui[9]
  map.gui_1[x + 2][y + 1] = tile.sets.gui[9]
  map.gui_1[x + 3][y + 3] = tile.sets.gui[9]
  map.gui_1[x + 3][y + 2] = tile.sets.gui[9]
  map.gui_1[x + 3][y + 1] = tile.sets.gui[9]
  map.gui_2[x + 1][y + 1] = t 
end

function love.load()
  main()
end
