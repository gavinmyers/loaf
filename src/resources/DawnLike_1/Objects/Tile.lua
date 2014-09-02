local function init() 
  local game = require "game"
  local function create(img,q) 
    return {sprite=img,quad=q,mdf=game.mdf}
  end
  local ti  = love.graphics.newImage("resources/DawnLike_1/Objects/Tile.png")
  local tq = love.graphics.newQuad(32, 32, 16, 16, 128, 64)
  local tl = create(ti,tq)

  local suq = love.graphics.newQuad(64,16, 16, 16, 128, 64)
  local sul = create(ti,suq)

  local sdq = love.graphics.newQuad(80,16, 16, 16, 128, 64)
  local sdl = create(ti,sdq)
  return {tl,sul,sdl}
end
return init()
