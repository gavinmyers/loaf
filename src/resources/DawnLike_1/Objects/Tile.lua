local split = function(f,w,h)
end

if resources == nil then
  resources = {}
end

function resources.tile() 
  local ti  = love.graphics.newImage("resources/DawnLike_1/Objects/Tile.png")
  local tq = love.graphics.newQuad(32, 32, 16, 16, 128, 64)
  local tl = tile.create(ti,tq)
  return {tl}
end
