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

  return effect
end
if __effect ~= nil then
  return __effect
else
  __effect = _effect()
  return __effect
end

