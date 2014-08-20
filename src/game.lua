-- global game settings used everywhere
game = {}
-- board and window settings
game.sz = 32 -- tile size in pixels
game.acs = 22 -- board size in tiles (Across)
game.dwn = 22 -- board size in tiles (Down)
game.mdf = 2 -- tile size modifier... needed for drawing large tiles 2 = 2 times current tile size
game.mdf_big = 4 -- big 
game.w = game.sz * (game.acs + 2) -- window size in pixels (width) 
game.h = game.sz * (game.dwn + 2) -- window size in pixels (height) 

-- gameplay setings
game.mode = nil

-- current view settings
game.screen = "WELCOME"

-- game methods
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

