-- global game settings used everywhere
function _game()
  local game = {}
  local font = love.graphics.newFont("resources/fonts/VeraMono.ttf",14)
  --local gameFont = love.graphics.newFont("resources/DawnLike_1/GUI/SDS_8x8.ttf",14)
  --gameFont = love.graphics.newFont("resources/fonts/VeraMono.ttf",18)
  love.graphics.setFont(font)
  game.font = font 
  -- board and window settings
  game.sz = 16 -- tile size in pixels
  game.acs = 48 -- board size in tiles (Across)
  game.dwn = 32 -- board size in tiles (Down)
  game.mdf = 1 -- tile size modifier... needed for drawing large tiles 2 = 2 times current tile size
  game.mdf_big = 4 -- big 
  game.w = game.sz * (game.acs + 2) -- window size in pixels (width) 
  game.h = game.sz * (game.dwn + 2) -- window size in pixels (height) 

  -- gameplay setings
  game.mode = nil

  -- current view settings
  game.screen = nil

  game.lastMessage = ""
  function game:announce(message)
    if message ~= nil then
      self.lastMessage = message
    end
    local screenWidth, screenHeight = love.window.getDimensions()
    love.graphics.printf(self.lastMessage, 25, screenHeight - 50, screenWidth, "left")
  end

  -- game methods
  function game:combat(attacker,defender)
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
      return self:damage(attacker,defender)
    else
      return false
    end
  end

  function game:damage(attacker,defender)
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
  function game:action(who,targetX,targetY) 
    local map = self.screen.map
    if targetX < 2 or targetX > self.acs -1 then 
    elseif targetY < 2 or targetY > self.dwn -1 then
    elseif self.mode == nil or self.mode == "" or self.mode == "MOVE" then
      if map.structure[targetX][targetY] ~= nil then
        return
      elseif map.creatures[targetX][targetY] ~= nil then
        if map.creatures[targetX][targetY].hostile == true then
          self.mode = "ABILITY"
          self:action(who,targetX,targetY)
        end
        return
      elseif map.items[targetX][targetY] ~= nil then
        local ability = who.ability
        local itm = map.items[targetX][targetY]
        local r1 = true
        if ability ~= nil then
          r1 = ability:use(itm)
        end
        local r2 = itm:interact(who) 
        if r1 == false or r2 == false then
          return
        end
      elseif map.event[targetX][targetY] ~= nil then
        local r = map.event[targetX][targetY].trigger(who)
        if r == false then
          return
        end
      end
      map.creatures[who.x][who.y] = nil 
      who.x = targetX
      who.y = targetY
      map.creatures[who.x][who.y] = who
    elseif self.mode == "ABILITY" then
      if map.creatures[targetX][targetY] ~= nil then
        local attacker = who
        local defender = map.creatures[targetX][targetY]
        if self:combat(attacker,defender) then
          self.screen:addEffect("DAMAGE",targetX,targetY,attacker,defender)
        else
          self.screen:addEffect("DEFEND",targetX,targetY,attacker,defender)
        end
      end
      self.mode = "MOVE" 
    end
  end
  return game
end

if __game ~= nil then
  return __game
else
  __game = _game()
  return __game
end

