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
    ni.x = 0
    ni.y = 0
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


  door = {}
  function door:create(id,screen,style,open,locked)
    local d = item:create(id,screen)
    d.style = style
    d.locked = locked
    d.open = open
    if style == "wood" and locked == true and open == false then
      d.tile = tile.sets.door[2] 
    elseif style == "wood" and locked == false and open == false then
      d.tile = tile.sets.door[1] 
    elseif open == true then 
      d.tile = tile.sets.door[3] 
    end

    function d:_interact(target)
      if self.locked == true and self.open == false then
        game:announce("You run into a locked door. Ouch!") 
        return false
      elseif self.locked == false and self.open == false then
        game:announce("You open the door.") 
        self.open = true
        self.tile = tile.sets.door[3] 
        return false
      elseif self.locked == false and self.open == true then
        return true 
      end
    end

    return d
  end
  return item
end
if __item ~= nil then
  return __item
else
  __item = _item()
  return __item
end

