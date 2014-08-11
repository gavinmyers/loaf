local split = function(f,w,h)
  local q = love.graphics.newQuad(w, h, 16, 16, 128, 16)
  return tile.create(f,q)
end
if resources == nil then
  resources = {}
end

function resources.shield() 
  local s1 = split(love.graphics.newImage("resources/DawnLike_1/Items/Shield.png"),96,0)
  return {s1}
end
