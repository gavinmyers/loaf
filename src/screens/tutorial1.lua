local function init(screen)
  local game = require "game"
  local creature = require "creature"
  local generator = require "generator"
  local ability = require "ability"
  local modifier = require "modifier"
  local item = require "item"
  local tile = require "tile"
  local event = require "event"
  local effect = require "effect"
  local t1scr = screen:create("TUTORIAL_1")
  t1scr.data = {}
  function t1scr:_init()
    currentMap = generator.simple(22,8) 
    self.map.structure = currentMap.map
    self.map.floor[currentMap.endX][currentMap.endY] = tile.sets.game[3] 
    local ev = event:create("DWN")
    ev.x = currentMap.endX
    ev.y = currentMap.endY
    ev.trigger = function(target)
      screen:current("TUTORIAL_2")
    end
    self.map.event[currentMap.endX][currentMap.endY] = ev 
    local player = creature:create("PLAYER",self) 
    self.player = player
    player.hp = 100
    player.attack = 4 
    player.defend = 4 
    player.damage = 4 
    player.x = currentMap.startX
    player.y = currentMap.startY
    player.tile = tile.sets.player[1]

    local longsword = ability:create("LS")
    function longsword:_attack(attacker,defender)
      local base = attacker.attack
      local mod = 2
      local dice = base + mod
      return math.random(1,dice * 6)
    end
    function longsword:_damage(attacker,defender)
      local base = attacker.damage
      local mod = 2
      local dice = base + mod
      return math.random(1,dice * 6)
    end
    local stab = modifier:create("TB")
    function stab:_damageMod(ability,attacker,defender)
      return 1000
    end
    longsword.modifiers[1] = stab

    player.abilities[1] = longsword
    player.ability = longsword
    local goblin = creature:create("GOBLIN",self) 
    goblin.x = currentMap.endX
    goblin.y = currentMap.endY
    goblin.tile = tile.sets.player[2]
    goblin.hp = 5000
    goblin.attack = 0 
    goblin.defend = 6 
    goblin.damage = 0 
    self.map.creatures[player.x][player.y] = player
    self.map.creatures[goblin.x][goblin.y] = goblin 
  end
  function t1scr:_draw()
    love.graphics.setColor(255, 255, 255)
    local screenWidth, screenHeight = love.window.getDimensions()
    love.graphics.setFont(game.font)
    love.graphics.printf("\n Kill the guard! \n\n Use the [w a s d] keys to attack the guard. Don't worry, you're already equiped with a weapon. When he's dead flee down the staircase.", 25, screenHeight - 200, screenWidth, "left")
  end
  function t1scr:_keypressed(key)
    if key == "escape" then
      main() 
    elseif key == "n" and self.data.selected > 1 then
      self.data.selected = self.data.selected - 1 
    elseif key == "m" and self.data.selected < 3 then
      self.data.selected = self.data.selected + 1 
    elseif key == "w" then
      game:action(self.player, self.player.x, self.player.y-1)
    elseif key == "a" then
      game:action(self.player, self.player.x-1, self.player.y)
    elseif key == "s" then
      game:action(self.player, self.player.x, self.player.y+1)
    elseif key == "d" then
      game:action(self.player, self.player.x+1, self.player.y)
    elseif key == "q" then
      game.mode = "ABILITY"
    elseif key == "e" then
      game.mode = "MOVE"
    end
  end

end
return init
