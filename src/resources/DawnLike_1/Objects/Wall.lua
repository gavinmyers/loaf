local split = function(f,w,h)
  local graphics = {}

  local q = love.graphics.newQuad(w+64, h+16, 16, 16, 320, 816)
  graphics["NSEW"] = tile.create(f,q)

  local q = love.graphics.newQuad(w+16, h+16, 16, 16, 320, 816)
  graphics[""] = tile.create(f,q)


  local q = love.graphics.newQuad(w, h+16, 16, 16, 320, 816)
  graphics["N"] = tile.create(f,q)
  local q = love.graphics.newQuad(w, h+16, 16, 16, 320, 816)
  graphics["S"] = tile.create(f,q)
  local q = love.graphics.newQuad(w+16, h, 16, 16, 320, 816)
  graphics["E"] = tile.create(f,q)
  local q = love.graphics.newQuad(w+16, h, 16, 16, 320, 816)
  graphics["W"] = tile.create(f,q)

  local q = love.graphics.newQuad(w, h+16, 16, 16, 320, 816)
  graphics["NS"] = tile.create(f,q)

  local q = love.graphics.newQuad(w, h+32, 16, 16, 320, 816)
  graphics["NE"] = tile.create(f,q)
  local q = love.graphics.newQuad(w+32, h+32, 16, 16, 320, 816)
  graphics["NW"] = tile.create(f,q)

  local q = love.graphics.newQuad(w, h, 16, 16, 320, 816)
  graphics["SE"] = tile.create(f,q)
  local q = love.graphics.newQuad(w+32, h, 16, 16, 320, 816)
  graphics["SW"] = tile.create(f,q)

  local q = love.graphics.newQuad(w+16, h, 16, 16, 320, 816)
  graphics["EW"] = tile.create(f,q)

  local q = love.graphics.newQuad(w+48, h+16, 16, 16, 320, 816)
  graphics["NSE"] = tile.create(f,q)
  local q = love.graphics.newQuad(w+80, h+16, 16, 16, 320, 816)
  graphics["NSW"] = tile.create(f,q)

  local q = love.graphics.newQuad(w+64, h+32, 16, 16, 320, 816)
  graphics["NEW"] = tile.create(f,q)
  local q = love.graphics.newQuad(w+64, h, 16, 16, 320, 816)
  graphics["SEW"] = tile.create(f,q)

  --[[
  local q = love.graphics.newQuad(w, h, 16, 16, 320, 816)
  graphics["N"] = tile.create(f,q)

  local q = love.graphics.newQuad(w + 16, h, 16, 16, 320, 816)
  graphics["S"] = tile.create(f,q)
  local q = love.graphics.newQuad(w + 16, h, 16, 16, 320, 816)
  graphics["E"] = tile.create(f,q)
  local q = love.graphics.newQuad(w + 16, h, 16, 16, 320, 816)
  graphics["W"] = tile.create(f,q)
  local q = love.graphics.newQuad(w + 16, h, 16, 16, 320, 816)
  graphics["SE"] = tile.create(f,q)
  local q = love.graphics.newQuad(w + 16, h, 16, 16, 320, 816)
  graphics["EW"] = tile.create(f,q)
  local q = love.graphics.newQuad(w + 32, h, 16, 16, 320, 816)
  graphics["SW"] = tile.create(f,q)
  local q = love.graphics.newQuad(w, h + 16, 16, 16, 320, 816)
  graphics["NS"] = tile.create(f,q)
  local q = love.graphics.newQuad(w + 32, h + 32, 16, 16, 320, 816)
  graphics["NW"] = tile.create(f,q)
  local q = love.graphics.newQuad(w + 0, h + 32, 16, 16, 320, 816)
  graphics["NE"] = tile.create(f,q)
  local q = love.graphics.newQuad(w + 0, h + 32, 16, 16, 320, 816)
  graphics["NSE"] = tile.create(f,q)
  local q = love.graphics.newQuad(w + 0, h + 32, 16, 16, 320, 816)
  graphics["NSW"] = tile.create(f,q)
  local q = love.graphics.newQuad(w + 0, h + 32, 16, 16, 320, 816)
  graphics["SEW"] = tile.create(f,q)
  local q = love.graphics.newQuad(w + 0, h + 32, 16, 16, 320, 816)
  graphics["NEW"] = tile.create(f,q)
  local q = love.graphics.newQuad(w + 0, h + 32, 16, 16, 320, 816)
  graphics["NSEW"] = tile.create(f,q)
  local q = love.graphics.newQuad(w + 0, h + 32, 16, 16, 320, 816)
  graphics[""] = tile.create(f,q)
  --]]
  return graphics
end
if resources == nil then
  resources = {}
end
function resources.wall() 
  wallSet0 = split(love.graphics.newImage("resources/DawnLike_1/Objects/Wall.png"),0,0)
  wallSet1 = split(love.graphics.newImage("resources/DawnLike_1/Objects/Wall.png"),0,48)
  return {wallSet1}
end
