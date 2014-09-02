function _effect()
  local tile = require "tile"
  local effect = {}
  effect.db = {}
  function effect:get(id) 
    return self.db[id]
  end
  function effect:create(id) 
    local ef = {}
    ef.id = id
    ef.type = nil
    ef.tile = nil
    ef.timer = 10
    ef.target = nil
    function ef:trigger(dt)
      if dt.timer ~= nil then
        dt.timer = dt.timer + 1
      end
      if self._trigger ~= nil then
        return self:_trigger(dt)
      end
      return dt
    end
    function ef:init(scene,x,y,target)
      if self._init ~= nil then
        return self:_init(scene,x,y,target)
      end
      return {timer=0,effect=self,x=x,y=y,target=target}
    end
    self.db[id] = ef
    return ef
  end

  function effect:get(id)
    return effect.db[id]
  end

  function effect.main() 
    local efdmg = effect:create("DAMAGE")
    function efdmg:_trigger(dt)
      local x = dt.x
      local y = dt.y
      --effect("DAMAGE",map,tile.sets.longWeapon[1],defender,defender.x,defender.y)
      if(dt.timer > 20) then
        return false
      end
      love.graphics.setColor(255,255,255,255)
      love.graphics.setBlendMode("alpha")

      if (dt.timer % 2) == 0 then
        love.graphics.setColor(255,0,0,255)
      else
        love.graphics.setColor(0,0,0,255)
      end
      tile.graphics.draw(dt.target.tile,x,y)

      love.graphics.setColor(255, 255,255,255)
      tile.graphics.draw(tile.sets.longWeapon[1],x,y)

      dt.timer = dt.timer + 1 
      love.graphics.setColor(255,255,255,255)

    end
    local efdfnd = effect:create("DEFEND")
    function efdfnd:_trigger(dt)
      local x = dt.x
      local y = dt.y
      if(dt.timer > 20) then
        return false
      end
      love.graphics.setColor(255,255,255,255)
      love.graphics.setBlendMode("alpha")

      if (dt.timer % 2) == 0 then
        love.graphics.setColor(255,0,0,255)
      else
        love.graphics.setColor(0,0,0,255)
      end
      tile.graphics.draw(dt.target.tile,x,y)

      love.graphics.setColor(255, 255,255,255)
      tile.graphics.draw(tile.sets.shield[1],x,y)

      dt.timer = dt.timer + 1 
      love.graphics.setColor(255,255,255,255)
    end
  end
  return effect
end
if __effect ~= nil then
  return __effect
else
  __effect = _effect()
  return __effect
end

