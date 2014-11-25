function _item()
  local game = require "game"
  local tile = require "tile"
  local item = {}
  item.db = {}
  function item:create(id,screen)
    local ni = {}
    ni.transparency = 0
    ni.size = 100
    ni.id = id
    ni.cx = 0
    ni.cy = 0
    ni.x = 0
    ni.y = 0
    ni.h = 16
    ni.w = 16
    ni.speed = 128
    ni.tile = nil
    ni.screen = screen
    function ni:interact(target)
      if self._interact ~= nil then
        return self:_interact(target)
      end
      return false 
    end
    item.db[id] = ni
    return ni
  end
  return item
end
if __item ~= nil then
  return __item
else
  __item = _item()
  return __item
end

