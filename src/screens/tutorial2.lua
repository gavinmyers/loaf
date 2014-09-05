local game = require "game"
local creature = require "creature"
local generator = require "generator"
local ability = require "ability"
local modifier = require "modifier"
local item = require "item"
local door = require "door"
local tile = require "tile"
local event = require "event"
local effect = require "effect"
local event = require "event"
local screen = require "screen"

local scn = screen:create("TUTORIAL_2")
scn.data = {selected=1}
function scn:_init()
  local currentMap = generator.tutorial2(22,8) 
  self.map.structure = currentMap.map

  local lockpick = ability:create("LP")
  function lockpick:_use(target)
    if target.locked ~= nil and target.locked == true then
      target.locked = false
      game:announce("You use the lockpick to pick the " .. target.id)
    end
  end
  self.lockpick = lockpick
  
  local longsword = ability:create("LS")
  local pick = ability:create("PCK")
  local bow = ability:create("BOW")

  local player = creature:create("PLAYER",self) 
  player.abilities[1] = longsword
  player.abilities[2] = pick 
  player.abilities[3] = lockpick 
  player.abilities[4] = bow 

  self.player = player

  player.x = currentMap.startX
  player.y = currentMap.startY
  player.tile = tile.sets.player[1]
  self.map.creatures[player.x][player.y] = player
  local d

  local goblin = creature:create("GOBLIN1",self) 
  goblin.x = 10 
  goblin.y = 5 
  goblin.tile = tile.sets.player[2]
  goblin.hp = 5000
  goblin.attack = 0 
  goblin.defend = 6 
  goblin.damage = 0 
  self.map.creatures[goblin.x][goblin.y] = goblin 

  local goblin = creature:create("GOBLIN2",self) 
  goblin.x = 9 
  goblin.y = 5 
  goblin.tile = tile.sets.player[2]
  goblin.hp = 5000
  goblin.attack = 0 
  goblin.defend = 6 
  goblin.damage = 0 
  self.map.creatures[goblin.x][goblin.y] = goblin 

  local goblin = creature:create("GOBLIN3",self) 
  goblin.x = 8 
  goblin.y = 5 
  goblin.tile = tile.sets.player[2]
  goblin.hp = 5000
  goblin.attack = 0 
  goblin.defend = 6 
  goblin.damage = 0 
  self.map.creatures[goblin.x][goblin.y] = goblin 

  local d = door:create("D1",self,"wood",false,false) 
  d.x = 3 
  d.y = 3 
  self.map.items[d.x][d.y] = d 

  d = door:create("D2",self,"wood",false,true) 
  d.x = 5 
  d.y = 6 
  self.map.items[d.x][d.y] = d 

  d = door:create("D3",self,"wood",false,true) 
  d.x = 7 
  d.y = 6 
  self.map.items[d.x][d.y] = d 

end
function scn:_draw()
  self:drawSelectTile(self.data.selected == 1,2,11,tile.sets.longWeapon[2])
  self:drawSelectTile(self.data.selected == 2,7,11,tile.sets.shortWeapon[2])
  self:drawSelectTile(self.data.selected == 3,12,11,tile.sets.tool[2])
  self:drawSelectTile(self.data.selected == 4,17,11,tile.sets.ammo[2])
  love.graphics.setColor(255, 255, 255)
  game:announce()
  local screenWidth, screenHeight = love.window.getDimensions()
  love.graphics.setFont(game.font)
  love.graphics.printf("\n Break out of jail! \n\n Use [n] and [m] to cycle between your  pick axe, lock pick, bow and sword to get to the next level. \n Fire your bow with the [.] key.", 25, screenHeight - 200, screenWidth, "left")
end
function scn:_keypressed(key)
  if key == "escape" then
    main() 
  elseif key == "n" and self.data.selected > 1 then
    self.data.selected = self.data.selected - 1 
  elseif key == "m" and self.data.selected < 4 then
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

  self.player.ability = self.player.abilities[self.data.selected] 
end
function scn:drawSelectTile(selected,x,y,t)
  local m = 0
  if selected then
    m = 9
  end
  self.map.gui_1[x    ][y    ] = tile.sets.gui[1+m]
  self.map.gui_1[x    ][y + 1] = tile.sets.gui[2+m]
  self.map.gui_1[x    ][y + 2] = tile.sets.gui[2+m]
  self.map.gui_1[x    ][y + 3] = tile.sets.gui[2+m]
  self.map.gui_1[x + 1][y    ] = tile.sets.gui[3+m]
  self.map.gui_1[x + 2][y    ] = tile.sets.gui[3+m]
  self.map.gui_1[x + 3][y    ] = tile.sets.gui[3+m]
  self.map.gui_1[x + 4][y    ] = tile.sets.gui[4+m]
  self.map.gui_1[x + 4][y + 1] = tile.sets.gui[5+m]
  self.map.gui_1[x + 4][y + 2] = tile.sets.gui[5+m]
  self.map.gui_1[x + 4][y + 3] = tile.sets.gui[5+m]
  self.map.gui_1[x + 4][y + 4] = tile.sets.gui[6+m]
  self.map.gui_1[x + 3][y + 4] = tile.sets.gui[7+m]
  self.map.gui_1[x + 2][y + 4] = tile.sets.gui[7+m]
  self.map.gui_1[x + 1][y + 4] = tile.sets.gui[7+m]
  self.map.gui_1[x    ][y + 4] = tile.sets.gui[8+m]
  self.map.gui_1[x + 1][y + 3] = tile.sets.gui[9+m]
  self.map.gui_1[x + 1][y + 2] = tile.sets.gui[9+m]
  self.map.gui_1[x + 1][y + 1] = tile.sets.gui[9+m]
  self.map.gui_1[x + 2][y + 3] = tile.sets.gui[9+m]
  self.map.gui_1[x + 2][y + 2] = tile.sets.gui[9+m]
  self.map.gui_1[x + 2][y + 1] = tile.sets.gui[9+m]
  self.map.gui_1[x + 3][y + 3] = tile.sets.gui[9+m]
  self.map.gui_1[x + 3][y + 2] = tile.sets.gui[9+m]
  self.map.gui_1[x + 3][y + 1] = tile.sets.gui[9+m]
  self.map.gui_2[x + 1][y + 1] = t 
end
