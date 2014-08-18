local split = function(f,w,h)
  local q = love.graphics.newQuad(w, h, 16, 16, 128, 96)
  return tile.create(f,q)
end
if resources == nil then
  resources = {}
end

function resources.scroll() 
  local scr01 = split(love.graphics.newImage("resources/DawnLike_1/Items/Scroll.png"),0,0)
  return {scr01}
end
