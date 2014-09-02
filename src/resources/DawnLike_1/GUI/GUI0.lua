local function init()
  local game = require "game"
  local function create(img,q) 
    return {sprite=img,quad=q,mdf=game.mdf}
  end
  local split = function(f,w,h)
    local q = love.graphics.newQuad(w, h, 16, 16, 256, 288)
    return create(f,q)
  end
  if resources == nil then
    resources = {}
  end

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

  d[10] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),144,96)
  d[11] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),144,112)
  d[12] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),160,96)
  d[13] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),176,96)
  d[14] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),176,112)
  d[15] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),176,128)
  d[16] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),160,128)
  d[17] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),144,128)
  d[18] = split(love.graphics.newImage("resources/DawnLike_1/GUI/GUI0.png"),160,112)
  return d 
end
return init()
