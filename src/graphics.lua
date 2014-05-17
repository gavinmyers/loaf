graphics = {}
graphics.sprites = {}
graphics.batches = {}
graphics.images = {}

function graphics.init() 
  local player0  = love.graphics.newImage("resources/DawnLike_1/Characters/Player0.png")
  graphics.images["player0"] = player0

  local player1  = love.graphics.newImage("resources/DawnLike_1/Characters/Player1.png")
  graphics.images["player1"] = player1

  local floor  = love.graphics.newImage("resources/DawnLike_1/Objects/Floor.png")
  graphics.images["floor"] = floor 

  local g0 = love.graphics.newQuad(0, 0, 16, 16, 336, 624)
  graphics.sprites["g0"] = {sprite=floor,quad=g0}

  local g1 = love.graphics.newQuad(272, 0, 16, 16, 336, 624)
  graphics.sprites["g1"] = {sprite=floor,quad=g1}

  local g2 = love.graphics.newQuad(256, 0, 16, 16, 336, 624)
  graphics.sprites["g2"] = {sprite=floor,quad=g2}

  local g3 = love.graphics.newQuad(256, 256, 16, 16, 336, 624)
  graphics.sprites["g3"] = {sprite=floor,quad=g3}

  local c0 = love.graphics.newQuad(0, 0, 16, 16, 128, 224)
  graphics.sprites["c0"] = {sprite=player0,quad=c0}

  local c1 = love.graphics.newQuad(16, 16, 16, 32, 128, 224)
  graphics.sprites["c1"] = {sprite=player0,quad=c1}

  local c2 = love.graphics.newQuad(16, 16, 16, 32, 128, 224)
  graphics.sprites["c2"] = {sprite=player0,quad=c2}
end

function graphics.drawSprite(k,x,y) 
  local o = graphics.sprites[k]
  love.graphics.draw(o.sprite, o.quad, x, y)
end

function graphics.renderMap(m)
  local b = love.graphics.newSpriteBatch(graphics.images["floor"], 40000)
  for x = 0,200 do
    for y = 0,200 do
      local s = "g"..m[x][y]
      local q = graphics.sprites[s].quad
      b:add(q,x*16,y*16)
    end
  end
  return b
end
