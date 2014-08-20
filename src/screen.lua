screen = {}
function screen:current(id)
  local sc = screen.db[id]
  reset()
  sc:init()
  game.screen = sc
end
function screen:create(id)
  local sc = {}
  sc.id = id
  screen.db[sc.id] = sc
  function sc:keypressed(key)
    if self._keypressed ~= nil then
      return self:_keypressed(key)
    end
  end
  function sc:update()
    if self._update ~= nil then
      return self:_update()
    end
  end

  function sc:draw()
    if self._draw ~= nil then
      self:_draw()
    end
    for x = 1, game.acs do
      for y = 1, game.dwn do
        --tile.graphics.draw(tile.sets.game[1],x,y)
      end
    end
    self:drawMapSet(map.floor)
    self:drawMapSet(map.structure)
    self:drawMapSet(map.creatures)
    self:drawMapSet(map.items)
    self:drawMapSet(map.effects)
    self:drawMapSet(map.gui_1)
    self:drawMapSet(map.gui_2)
    self:drawMapSet(map.gui_3)
  end

  function sc:init()
    if self._init ~= nil then
      return self:_init()
    end
  end
  function sc:drawMapSet(ts)
    for x = 1, game.acs do
      if ts[x] ~= nil then
        for y = 1, game.dwn do
          local t = ts[x][y]
          if t ~= nil then
            if t.draw then
              t.draw(x,y)
            elseif t.tile then
              tile.graphics.draw(t.tile,x,y)
            else
              tile.graphics.draw(t,x,y)
            end
          end
        end
      end
    end
  end

  return sc
end

function screen.main() 
  screen.db = {}
  local welscr = screen:create("WELCOME")
  function welscr:_draw()
    love.graphics.setColor(255, 255, 255)
    local screenWidth, screenHeight = love.window.getDimensions()
    love.graphics.setFont(gameFont)
    love.graphics.printf("\n******************\n   WELCOME TO LOAF \n******************\n\n [1] TUTORIAL \n\n [2] CONTINUE \n\n [X] QUIT", 0, 1, screenWidth, "center")
  end
  function welscr:_keypressed(key)
    if key == "x" then
      love.event.quit()
    elseif key == "1" then
      screen:current("TUTORIAL_1")
    elseif key == "2" then
      screen:current("TUTORIAL_2")
    end
  end

  local t1scr = screen:create("TUTORIAL_1")
  t1scr.data = {}
  function t1scr:_init()
    currentMap = generators.simple(22,8) 
    map.structure = currentMap.map
    map.structure = currentMap.map
    map.floor[currentMap.endX][currentMap.endY] = tile.sets.game[3] 
    local ev = events:create("DWN")
    ev.x = currentMap.endX
    ev.y = currentMap.endY
    ev.trigger = function(target)
      screen:current("TUTORIAL_2")
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
  function t1scr:_draw()
    love.graphics.setColor(255, 255, 255)
    local screenWidth, screenHeight = love.window.getDimensions()
    love.graphics.setFont(gameFont)
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
    end
  end


  local t2scr = screen:create("TUTORIAL_2")
  t2scr.data = {selected=1}
  function t2scr:_init()
    currentMap = generators.simple(22,8) 
    map.structure = currentMap.map
  end
  function t2scr:_draw()
    self:drawSelectTile(self.data.selected == 1,2,11,tile.sets.longWeapon[2])
    self:drawSelectTile(self.data.selected == 2,7,11,tile.sets.shortWeapon[2])
    self:drawSelectTile(self.data.selected == 3,12,11,tile.sets.tool[2])
    love.graphics.setColor(255, 255, 255)
    local screenWidth, screenHeight = love.window.getDimensions()
    love.graphics.setFont(gameFont)
    love.graphics.printf("\n Break out of jail! \n\n Use [n] and [m] to cycle between your  pick axe, lock pick and sword to get to the next level.", 25, screenHeight - 200, screenWidth, "left")
  end
  function t2scr:_keypressed(key)
    if key == "escape" then
      main() 
    elseif key == "n" and self.data.selected > 1 then
      self.data.selected = self.data.selected - 1 
    elseif key == "m" and self.data.selected < 3 then
      self.data.selected = self.data.selected + 1 
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
    end
  end
  function t2scr:drawSelectTile(selected,x,y,t)
    local m = 0
    if selected then
      m = 9
    end
    map.gui_1[x    ][y    ] = tile.sets.gui[1+m]
    map.gui_1[x    ][y + 1] = tile.sets.gui[2+m]
    map.gui_1[x    ][y + 2] = tile.sets.gui[2+m]
    map.gui_1[x    ][y + 3] = tile.sets.gui[2+m]
    map.gui_1[x + 1][y    ] = tile.sets.gui[3+m]
    map.gui_1[x + 2][y    ] = tile.sets.gui[3+m]
    map.gui_1[x + 3][y    ] = tile.sets.gui[3+m]
    map.gui_1[x + 4][y    ] = tile.sets.gui[4+m]
    map.gui_1[x + 4][y + 1] = tile.sets.gui[5+m]
    map.gui_1[x + 4][y + 2] = tile.sets.gui[5+m]
    map.gui_1[x + 4][y + 3] = tile.sets.gui[5+m]
    map.gui_1[x + 4][y + 4] = tile.sets.gui[6+m]
    map.gui_1[x + 3][y + 4] = tile.sets.gui[7+m]
    map.gui_1[x + 2][y + 4] = tile.sets.gui[7+m]
    map.gui_1[x + 1][y + 4] = tile.sets.gui[7+m]
    map.gui_1[x    ][y + 4] = tile.sets.gui[8+m]
    map.gui_1[x + 1][y + 3] = tile.sets.gui[9+m]
    map.gui_1[x + 1][y + 2] = tile.sets.gui[9+m]
    map.gui_1[x + 1][y + 1] = tile.sets.gui[9+m]
    map.gui_1[x + 2][y + 3] = tile.sets.gui[9+m]
    map.gui_1[x + 2][y + 2] = tile.sets.gui[9+m]
    map.gui_1[x + 2][y + 1] = tile.sets.gui[9+m]
    map.gui_1[x + 3][y + 3] = tile.sets.gui[9+m]
    map.gui_1[x + 3][y + 2] = tile.sets.gui[9+m]
    map.gui_1[x + 3][y + 1] = tile.sets.gui[9+m]
    map.gui_2[x + 1][y + 1] = t 
  end


end
