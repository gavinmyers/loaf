local split = function(f,w,h)
end

if resources == nil then
  resources = {}
end

function resources.player() 
  local ci  = love.graphics.newImage("resources/DawnLike_1/Characters/Player0.png")
  local cq = love.graphics.newQuad(16, 48, 16, 16, 128, 224)
  local t1 = tile.create(ci,cq)
  local cq = love.graphics.newQuad(16, 176, 16, 16, 128, 224)
  local t2 = tile.create(ci,cq)
  return {t1, t2}
end
