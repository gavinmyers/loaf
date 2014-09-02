local function init() 
  local game = require "game"
  local function create(img,q) 
    return {sprite=img,quad=q,mdf=game.mdf}
  end
  local split = function(f,w,h)
    local q = love.graphics.newQuad(w, h, 16, 16, 128, 16)
    return create(f,q)
  end

    local s1 = split(love.graphics.newImage("resources/DawnLike_1/Items/Shield.png"),96,0)
    return {s1}
end
return init()
