local function init() 
  local game = require "game"
  local function create(img,q) 
    return {sprite=img,quad=q,mdf=game.mdf}
  end
  local split = function(f,w,h)
    local q = love.graphics.newQuad(w, h, 16, 16, 128, 80)
    return create(f,q)
  end

  local d = {}
  d[1]  = split(love.graphics.newImage("resources/DawnLike_1/Objects/Door0.png"),0,0)
  d[2]  = split(love.graphics.newImage("resources/DawnLike_1/Objects/Door0.png"),32,0)
  d[3]  = split(love.graphics.newImage("resources/DawnLike_1/Objects/Door1.png"),0,0)
  return d 
end
return init()
