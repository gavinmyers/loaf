local split = function(f,w,h)
  local q = love.graphics.newQuad(w, h, 16, 16, 128, 80)
  return tile.create(f,q)
end
if resources == nil then
  resources = {}
end

function resources.shortWeapon() 
  local d = {}
  d[1]  = split(love.graphics.newImage("resources/DawnLike_1/Items/ShortWep.png"),32,48)
  d[2]  = split(love.graphics.newImage("resources/DawnLike_1/Items/ShortWep.png"),32,48)
  d[2].mdf = 6 

  d[3]  = split(love.graphics.newImage("resources/DawnLike_1/Items/ShortWep.png"),16,16)
  d[4]  = split(love.graphics.newImage("resources/DawnLike_1/Items/ShortWep.png"),16,16)
  d[4].mdf = 6 

  d[5]  = split(love.graphics.newImage("resources/DawnLike_1/Items/ShortWep.png"),0,0)
  d[6]  = split(love.graphics.newImage("resources/DawnLike_1/Items/ShortWep.png"),0,0)
  d[6].mdf = 6 

  d[7]  = split(love.graphics.newImage("resources/DawnLike_1/Items/ShortWep.png"),16,0)
  d[8]  = split(love.graphics.newImage("resources/DawnLike_1/Items/ShortWep.png"),16,0)
  d[8].mdf = 6 
  return d 
end
