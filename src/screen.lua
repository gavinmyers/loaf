
function _screen()
  local game = require "game"
  local creature = require "creature"
  local generator = require "generator"
  local ability = require "ability"
  local modifier = require "modifier"
  local item = require "item"
  local tile = require "tile"
  local event = require "event"
  local effect = require "effect"
  local event = require "event"
  local shader = require "lib/postshader"
  local light = require "lib/light"
  local screen = {}
  screen.db = {}

  local lightWorld = love.light.newWorld()
  lightWorld.blur = 10.0
  lightWorld.setAmbientColor(50, 50, 50) -- optional
  local lightMouse = lightWorld.newLight(255, 255, 255, 255, 255, 300)
  lightMouse.setGlowStrength(1)
  local lightRedraw = true


  function screen:current(id)
    local sc = screen.db[id]
    print(sc)
    sc:init()
    game.screen = sc

    lightRedraw = true
    if lightRedraw == true then
      lightRedraw = false
      for x = 1, game.acs  do
        for y = 1, game.dwn  do
          if sc.map.structure[x][y] ~= nil then
            local e = generator.edge(sc.map.structure, x, y)
            local m = game.sz * game.mdf
            if e == "NS" or e == "N" or e == "S" then
              local r = lightWorld.newRectangle((x*m)+8,y*m,8,16) 
            elseif e == "EW" or e == "W" or e == "E" then
              local r = lightWorld.newRectangle(x*m,(y*m)+8,16,8) 
            end
          end
        end
      end
    end

    
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
      lightMouse.setPosition(love.mouse.getX(), love.mouse.getY())


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

      self:drawMapSet(self.map.floor)

      self:drawMapSet(self.map.structure)
      self:drawMapSet(self.map.creatures)
      self:drawMapSet(self.map.items)
      self:drawEffects()
      self:drawMapSet(self.map.gui_1)
      self:drawMapSet(self.map.gui_2)
      self:drawMapSet(self.map.gui_3)


      lightWorld.update()
      --love.graphics.scale(1.5,1.5)
      lightWorld.drawShadow()

    end

    function sc:init()
      self.map = {}
      self.map.event = {}
      self.map.floor = {}
      self.map.structure = {}
      self.map.items = {}
      self.map.creatures = {}
      self.map.effect = {}
      self.map.gui_1 = {}
      self.map.gui_2 = {}
      self.map.gui_3 = {}
      for x = 1, game.acs do
        self.map.event[x] = {}
        self.map.floor[x] = {}
        self.map.structure[x] = {}
        self.map.creatures[x] = {}
        self.map.items[x] = {}
        self.map.effect[x] = {}
        self.map.gui_1[x] = {}
        self.map.gui_2[x] = {}
        self.map.gui_3[x] = {}
      end

      if self._init ~= nil then
        return self:_init()
      end


    end
    function sc:addEffect(id,x,y,source,target)
      local ef = effect:get(id)
      local m = self.map.effect[x][y]
      if m == nil then
        m = {}
      end
      m[#m+1] = ef:init(self,x,y,source,target) 
      self.map.effect[x][y] = m 
    end
    function sc:drawEffects()
      local ts = self.map.effect
      for x = 1, game.acs do
        if ts[x] ~= nil then
          for y = 1, game.dwn do
            local t = ts[x][y]
            if t ~= nil then
              for e = 1, #t do
                local dt = t[e]
                dt.effect:trigger(dt)
              end
            end
          end
        end
      end

    end
    function sc:drawMapSet(ts)
      for x = 1, game.acs do
        if ts[x] ~= nil then
          for y = 1, game.dwn do
            local t = ts[x][y]
            if t ~= nil then
              if t.draw then
                t.draw(self.map,x,y)
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

  return screen
end

if __screen ~= nil then
  return __screen
else
  __screen = _screen()
  return __screen
end

