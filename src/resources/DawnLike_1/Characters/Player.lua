local split = function(f,w,h)
end

if resources == nil then
  resources = {}
end

function resources.player() 
  local ci  = love.graphics.newImage("resources/DawnLike_1/Characters/Player0.png")
  local cq = love.graphics.newQuad(16, 48, 16, 16, 128, 224)
  local tl = tile.create(ci,cq)
  return {tl}
end
