local split = function(f,w,h)
  local graphics = {}
  local q = love.graphics.newQuad(w+16, h+16, 16, 16, 336, 624)
  graphics["NSEW"] = tile.create(f,q)

  local q = love.graphics.newQuad(w+80, h, 16, 16, 336, 624)
  graphics[""] = tile.create(f,q)

  local q = love.graphics.newQuad(w+80, h+16, 16, 16, 336, 624)
  graphics["WE"] = tile.create(f,q)

  local q = love.graphics.newQuad(w+48, h+16, 16, 16, 336, 624)
  graphics["NS"] = tile.create(f,q)

  local q = love.graphics.newQuad(w+32, h+16, 16, 16, 336, 624)
  graphics["NSW"] = tile.create(f,q)

  local q = love.graphics.newQuad(w+16, h+32, 16, 16, 336, 624)
  graphics["NWE"] = tile.create(f,q)

  local q = love.graphics.newQuad(w+16, h, 16, 16, 336, 624)
  graphics["SWE"] = tile.create(f,q)

  local q = love.graphics.newQuad(w, h+16, 16, 16, 336, 624)
  graphics["NSE"] = tile.create(f,q)

  local q = love.graphics.newQuad(w+48, h+32, 16, 16, 336, 624)
  graphics["N"] = tile.create(f,q)

  local q = love.graphics.newQuad(w+48, h, 16, 16, 336, 624)
  graphics["S"] = tile.create(f,q)

  local q = love.graphics.newQuad(w+32, h+32, 16, 16, 336, 624)
  graphics["NW"] = tile.create(f,q)

  local q = love.graphics.newQuad(w+32, h, 16, 16, 336, 624)
  graphics["SW"] = tile.create(f,q)

  local q = love.graphics.newQuad(w, h+32, 16, 16, 336, 624)
  graphics["NE"] = tile.create(f,q)

  local q = love.graphics.newQuad(w, h, 16, 16, 336, 624)
  graphics["SE"] = tile.create(f,q)

  local q = love.graphics.newQuad(w+96, h+16, 16, 16, 336, 624)
  graphics["W"] = tile.create(f,q)

  local q = love.graphics.newQuad(w+64, h+16, 16, 16, 336, 624)
  graphics["E"] = tile.create(f,q) 
  return graphics
end
if resources == nil then
  resources = {}
end
function resources.floor() 
  local floorSet01 = split(love.graphics.newImage("resources/DawnLike_1/Objects/Floor.png"),0,48)
  local floorSet02 = split(love.graphics.newImage("resources/DawnLike_1/Objects/Floor.png"),224,48)
  local floorSet03 = split(love.graphics.newImage("resources/DawnLike_1/Objects/Floor.png"),0,96)
  return {floorSet01,floorSet02,floorSet03}
end

