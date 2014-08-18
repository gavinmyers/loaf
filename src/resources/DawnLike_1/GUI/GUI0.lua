local split = function(f,w,h)
  local q = love.graphics.newQuad(w, h, 16, 16, 256, 288)
  return tile.create(f,q)
end
if resources == nil then
  resources = {}
end

function resources.gui() 
  local d = {}
  d[1] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),208,96)
  d[2] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),208,112)
  d[3] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),224,96)
  d[4] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),240,96)
  d[5] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),240,112)
  d[6] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),240,128)
  d[7] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),224,128)
  d[8] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),208,128)
  d[9] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),224,112)

  return d 
end
