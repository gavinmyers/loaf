local function init() 
  local game = require "game"
  local function create(img,q) 
    return {sprite=img,quad=q,mdf=game.mdf}
  end
  local split = function(f,w,h)
    local q = love.graphics.newQuad(w, h, 16, 16, 128, 48)
    return create(f,q)
  end
  local d = {}
  d[1]  = split(love.graphics.newImage("resources/DawnLike_1/Items/Tool.png"),16,16)
  d[2]  = split(love.graphics.newImage("resources/DawnLike_1/Items/Tool.png"),16,16)
  d[2].mdf = 6 

  d[3]  = split(love.graphics.newImage("resources/DawnLike_1/Items/Tool.png"),16,16)
  d[4]  = split(love.graphics.newImage("resources/DawnLike_1/Items/Tool.png"),16,16)
  d[4].mdf = 6 

  d[5]  = split(love.graphics.newImage("resources/DawnLike_1/Items/Tool.png"),0,0)
  d[6]  = split(love.graphics.newImage("resources/DawnLike_1/Items/Tool.png"),0,0)
  d[6].mdf = 6 

  d[7]  = split(love.graphics.newImage("resources/DawnLike_1/Items/Tool.png"),16,0)
  d[8]  = split(love.graphics.newImage("resources/DawnLike_1/Items/Tool.png"),16,0)
  d[8].mdf = 6 
  return d 
end
return init()
