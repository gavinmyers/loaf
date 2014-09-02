function _door()
  local game = require "game"
  local tile = require "tile"
  local item = require "item"
  local door = {}
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
  return door
end
if __door ~= nil then
  return __door
else
  __door = _door()
  return __door
end

