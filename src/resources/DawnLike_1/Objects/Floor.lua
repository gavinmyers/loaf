local function init() 
  local game = require "game"
  local function create(img,q) 
    return {sprite=img,quad=q,mdf=game.mdf}
  end
  local split = function(f,w,h)
    local graphics = {}

    local q = love.graphics.newQuad(w+16, h+16, 16, 16, 336, 624)
    graphics["NSEW"] = create(f,q)

    local q = love.graphics.newQuad(w+80, h, 16, 16, 336, 624)
    graphics[""] = create(f,q)

    
    local q = love.graphics.newQuad(w+48, h+32, 16, 16, 336, 624)
    graphics["N"] = create(f,q)
    local q = love.graphics.newQuad(w+48, h, 16, 16, 336, 624)
    graphics["S"] = create(f,q)
    local q = love.graphics.newQuad(w+64, h+16, 16, 16, 336, 624)
    graphics["E"] = create(f,q) 
    local q = love.graphics.newQuad(w+96, h+16, 16, 16, 336, 624)
    graphics["W"] = create(f,q)


    local q = love.graphics.newQuad(w+48, h+16, 16, 16, 336, 624)
    graphics["NS"] = create(f,q)

    local q = love.graphics.newQuad(w, h+32, 16, 16, 336, 624)
    graphics["NE"] = create(f,q)
    local q = love.graphics.newQuad(w+32, h+32, 16, 16, 336, 624)
    graphics["NW"] = create(f,q)

    local q = love.graphics.newQuad(w, h, 16, 16, 336, 624)
    graphics["SE"] = create(f,q)
    local q = love.graphics.newQuad(w+32, h, 16, 16, 336, 624)
    graphics["SW"] = create(f,q)

    local q = love.graphics.newQuad(w+80, h+16, 16, 16, 336, 624)
    graphics["EW"] = create(f,q)

    local q = love.graphics.newQuad(w+32, h+16, 16, 16, 336, 624)
    graphics["NSW"] = create(f,q)
    local q = love.graphics.newQuad(w+16, h+32, 16, 16, 336, 624)
    graphics["NEW"] = create(f,q)
    local q = love.graphics.newQuad(w+16, h, 16, 16, 336, 624)
    graphics["SEW"] = create(f,q)
    local q = love.graphics.newQuad(w, h+16, 16, 16, 336, 624)
    graphics["NSE"] = create(f,q)

    return graphics
  end
  local floorSet01 = split(love.graphics.newImage("resources/DawnLike_1/Objects/Floor.png"),0,48)
  local floorSet02 = split(love.graphics.newImage("resources/DawnLike_1/Objects/Floor.png"),224,48)
  local floorSet03 = split(love.graphics.newImage("resources/DawnLike_1/Objects/Floor.png"),0,96)
  local floorSet04 = split(love.graphics.newImage("resources/DawnLike_1/Objects/Floor.png"),0,192)
  return {floorSet01,floorSet02,floorSet03,floorSet04}
end
return init()
