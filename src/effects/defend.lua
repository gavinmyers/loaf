local effect = require "effect"
local tile = require "tile"
local ef = effect:create("DEFEND")
function ef:_trigger(dt)
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

