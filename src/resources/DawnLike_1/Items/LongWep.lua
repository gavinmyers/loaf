local split = function(f,w,h)
  local q = love.graphics.newQuad(w, h, 16, 16, 128, 112)
  return tile.create(f,q)
end
if resources == nil then
  resources = {}
end

function resources.longWeapon() 
  local longSword = split(love.graphics.newImage("resources/DawnLike_1/Items/LongWep.png"),32,16)
  return {longSword}
end
