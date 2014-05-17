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

  local floor0 = love.graphics.newQuad(16, 256, 16, 16, 336, 624)
  graphics.sprites["floor0"] = {sprite=floor,quad=floor0}

  local floor1 = love.graphics.newQuad(16, 256, 16, 16, 336, 624)
  graphics.sprites["floor1"] = {sprite=floor,quad=floor1}

  local floor2 = love.graphics.newQuad(128, 256, 16, 16, 336, 624)
  graphics.sprites["floor2"] = {sprite=floor,quad=floor2}

  local floor3 = love.graphics.newQuad(256, 256, 16, 16, 336, 624)
  graphics.sprites["floor3"] = {sprite=floor,quad=floor3}

  local player1 = love.graphics.newQuad(0, 0, 16, 16, 128, 224)
  graphics.sprites["player1"] = {sprite=player0,quad=player1}

  local player2 = love.graphics.newQuad(16, 16, 16, 32, 128, 224)
  graphics.sprites["player2"] = {sprite=player0,quad=player2}

end

function graphics.drawSprite(k,x,y) 
  local o = graphics.sprites[k]
  love.graphics.draw(o.sprite, o.quad, x, y)
end

function graphics.renderMap(m)
  local b = love.graphics.newSpriteBatch(graphics.images["floor"], 40000)
  for x = 0,200 do
    for y = 0,200 do
      local s = "floor"..m[x][y]
      local q = graphics.sprites[s].quad
      b:add(q,x*16,y*16)
    end
  end
  return b
end
