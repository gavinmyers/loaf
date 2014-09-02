local function init() 
  local game = require "game"
  local function create(img,q) 
    return {sprite=img,quad=q,mdf=game.mdf}
  end

  local ci  = love.graphics.newImage("resources/DawnLike_1/Characters/Player0.png")
  local cq = love.graphics.newQuad(16, 48, 16, 16, 128, 224)
  local t1 = create(ci,cq)
  local cq = love.graphics.newQuad(16, 176, 16, 16, 128, 224)
  local t2 = create(ci,cq)
  return {t1, t2}
end
return init()
