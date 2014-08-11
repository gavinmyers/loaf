local split = function(f,w,h)
end

if resources == nil then
  resources = {}
end

function resources.tile() 
  local ti  = love.graphics.newImage("resources/DawnLike_1/Objects/Tile.png")
  local tq = love.graphics.newQuad(32, 32, 16, 16, 128, 64)
  local tl = tile.create(ti,tq)

  local suq = love.graphics.newQuad(64,16, 16, 16, 128, 64)
  local sul = tile.create(ti,suq)

  local sdq = love.graphics.newQuad(80,16, 16, 16, 128, 64)
  local sdl = tile.create(ti,sdq)
  return {tl,sul,sdl}
end
