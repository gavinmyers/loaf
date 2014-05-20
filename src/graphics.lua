require "map"

graphics = {}
graphics.sprites = {}
graphics.batches = {}
graphics.images = {}

function graphics.floorPlan(w,h,c,f)
  local q = love.graphics.newQuad(w+16, h+16, 16, 16, 336, 624)
  graphics.sprites[c.."NSEW"] = {sprite=f,quad=q}

  local q = love.graphics.newQuad(w+80, h, 16, 16, 336, 624)
  graphics.sprites[c..""] = {sprite=f,quad=q}

  local q = love.graphics.newQuad(w+80, h+16, 16, 16, 336, 624)
  graphics.sprites[c.."WE"] = {sprite=f,quad=q}

  local q = love.graphics.newQuad(w+48, h+16, 16, 16, 336, 624)
  graphics.sprites[c.."NS"] = {sprite=f,quad=q}

  local q = love.graphics.newQuad(w+32, h+16, 16, 16, 336, 624)
  graphics.sprites[c.."NSW"] = {sprite=f,quad=q}

  local q = love.graphics.newQuad(w+16, h+32, 16, 16, 336, 624)
  graphics.sprites[c.."NWE"] = {sprite=f,quad=q}

  local q = love.graphics.newQuad(w+16, h, 16, 16, 336, 624)
  graphics.sprites[c.."SWE"] = {sprite=f,quad=q}

  local q = love.graphics.newQuad(w, h+16, 16, 16, 336, 624)
  graphics.sprites[c.."NSE"] = {sprite=f,quad=q}

  local q = love.graphics.newQuad(w+48, h+32, 16, 16, 336, 624)
  graphics.sprites[c.."N"] = {sprite=f,quad=q}

  local q = love.graphics.newQuad(w+48, h, 16, 16, 336, 624)
  graphics.sprites[c.."S"] = {sprite=f,quad=q}

  local q = love.graphics.newQuad(w+32, h+32, 16, 16, 336, 624)
  graphics.sprites[c.."NW"] = {sprite=f,quad=q}

  local q = love.graphics.newQuad(w+32, h, 16, 16, 336, 624)
  graphics.sprites[c.."SW"] = {sprite=f,quad=q}

  local q = love.graphics.newQuad(w, h+32, 16, 16, 336, 624)
  graphics.sprites[c.."NE"] = {sprite=f,quad=q}

  local q = love.graphics.newQuad(w, h, 16, 16, 336, 624)
  graphics.sprites[c.."SE"] = {sprite=f,quad=q}

  local q = love.graphics.newQuad(w+96, h+16, 16, 16, 336, 624)
  graphics.sprites[c.."W"] = {sprite=f,quad=q}

  local e = love.graphics.newQuad(w+64, h+16, 16, 16, 336, 624)
  graphics.sprites[c.."E"] = {sprite=f,quad=e}

end

function graphics.init() 
  local player0  = love.graphics.newImage("resources/DawnLike_1/Characters/Player0.png")
  graphics.images["player0"] = player0

  local player1  = love.graphics.newImage("resources/DawnLike_1/Characters/Player1.png")
  graphics.images["player1"] = player1

  local floor  = love.graphics.newImage("resources/DawnLike_1/Objects/Floor.png")
  graphics.images["floor"] = floor 

  local g0 = love.graphics.newQuad(0, 0, 16, 16, 336, 624)
  graphics.sprites["g0"] = {sprite=floor,quad=g0}

  local g1 = love.graphics.newQuad(16, 256, 16, 16, 336, 624)
  graphics.sprites["g1X"] = {sprite=floor,quad=g1}

  graphics.floorPlan(224,48,"g1",floor)

  local g2 = love.graphics.newQuad(256, 0, 16, 16, 336, 624)
  graphics.sprites["g2"] = {sprite=floor,quad=g2}

  graphics.floorPlan(224,240,"g2",floor)

  local g3 = love.graphics.newQuad(256, 256, 16, 16, 336, 624)
  graphics.sprites["g3"] = {sprite=floor,quad=g3}

  local g16 = love.graphics.newQuad(256, 256, 16, 16, 336, 624)
  graphics.sprites["g16"] = {sprite=floor,quad=g16}

  local g128 = love.graphics.newQuad(256, 256, 16, 16, 336, 624)
  graphics.sprites["g128"] = {sprite=floor,quad=g128}

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

graphics.tile = {}
function graphics.tile.style(x,y,tiles)
  local eN = tiles[x][y-1] 
  local eS = tiles[x][y+1] 
  local eE = tiles[x+1][y] 
  local eW = tiles[x-1][y] 

  local eX = tiles[x][y] 
  if eN ~= eX and eS ~= eX and eE ~= eX and eW ~= eX then 
    return ""
  elseif eN ~= eX and eS ~= eX and eE == eX and eW == eX then 
    return "WE"
  elseif eN == eX and eS == eX and eE ~= eX and eW ~= eX then 
    return "NS"
  elseif eN == eX and eS == eX and eE ~= eX and eW == eX then 
    return "NSW"
  elseif eN == eX and eS == eX and eE == eX and eW ~= eX then 
    return "NSE"
  elseif eN == eX and eS ~= eX and eE == eX and eW == eX then 
    return "NWE"
  elseif eN ~= eX and eS == eX and eE == eX and eW == eX then 
    return "SWE"
  elseif eN == eX and eS == eX and eE == eX and eW == eX then 
    return "NSEW"
  elseif eN ~= eX and eS ~= eX and eE == eX and eW ~= eX then 
    return "E"
  elseif eN ~= eX and eS ~= eX and eE ~= eX and eW == eX then 
    return "W"
  elseif eN ~= eX and eS == eX and eE ~= eX and eW ~= eX then 
    return "S"
  elseif eN == eX and eS ~= eX and eE ~= eX and eW ~= eX then 
    return "N"
  elseif eN == eX and eS ~= eX and eE ~= eX and eW == eX then 
    return "NW"
  elseif eN ~= eX and eS == eX and eE ~= eX and eW == eX then 
    return "SW"
  elseif eN == eX and eS ~= eX and eE == eX and eW ~= eX then 
    return "NE"
  elseif eN ~= eX and eS == eX and eE == eX and eW ~= eX then 
    return "SE"
  end
  return ""
end


function graphics.renderMap(w,h,m)
  local b = love.graphics.newSpriteBatch(graphics.images["floor"], 40000)
  for x = 2,w do
    for y = 2,h do
      local s = "g1X"
      local v = m[x][y]
      local t = map.types.source(v)
      local pri = map.types.primary(t)
      local sec = map.types.secondary(t)
      local typ = graphics.tile.style(x,y,m)
      if t == map.types.full then
        if v == pri then
          s = "g1" .. typ
        elseif v == sec then
          s = "g2" .. typ
        end
      elseif t == map.types.exit then
        s = "g3"
      end
      if x <= 1 or y <= 1 then
        s = "g0"
      end
      local q = graphics.sprites[s].quad
      b:add(q,x*16,y*16)
    end
  end
  return b
end
