function effect(typ,tile,tar,targetX,targetY)
  if typ == "DAMAGE" then
    map.effects[targetX][targetY] = {type=typ,tile=tile,method=effectDamage,start=10,target=tar} 
  elseif typ == "DEFEND" then
    map.effects[targetX][targetY] = {type=typ,tile=tile,method=effectDefend,start=10,target=tar} 
  end
end

function effectDefend(x, y)
  local dt = map.effects[x][y]
  love.graphics.setColor(255,255,255,255)

  love.graphics.setBlendMode("alpha")
  if (dt.start % 2) == 0 then
    love.graphics.setColor(0,0,0,255)
  else
    love.graphics.setColor(0,0,0,255)
  end
  tile.graphics.draw(dt.target.tile,x,y)

  love.graphics.setColor(255, 255,255,255)
  tile.graphics.draw(tile.sets.shield[1],x,y)

  dt.start = dt.start - 1 
  if(dt.start < 1) then
    map.effects[x][y] = nil
  end
  love.graphics.setColor(255,255,255,255)
end

function effectDamage(x, y)
  local dt = map.effects[x][y]
  love.graphics.setColor(255,255,255,255)

  love.graphics.setBlendMode("alpha")
  if (dt.start % 2) == 0 then
    love.graphics.setColor(255,0,0,255)
  else
    love.graphics.setColor(0,0,0,255)
  end
  tile.graphics.draw(dt.target.tile,x,y)

  love.graphics.setColor(255, 255,255,255)
  tile.graphics.draw(map.effects[x][y].tile,x,y)

  dt.start = dt.start - 1 
  if(dt.start < 1) then
    map.effects[x][y] = nil
  end
  love.graphics.setColor(255, 255,255,255)
end

