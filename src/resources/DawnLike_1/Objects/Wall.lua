local function init() 
  local game = require "game"
  local function create(img,q) 
    return {sprite=img,quad=q,mdf=game.mdf}
  end
  local split = function(f,w,h)
    local graphics = {}

    local q = love.graphics.newQuad(w+64, h+16, 16, 16, 320, 816)
    graphics["NSEW"] = create(f,q)

    local q = love.graphics.newQuad(w+16, h+16, 16, 16, 320, 816)
    graphics[""] = create(f,q)


    local q = love.graphics.newQuad(w, h+16, 16, 16, 320, 816)
    graphics["N"] = create(f,q)
    local q = love.graphics.newQuad(w, h+16, 16, 16, 320, 816)
    graphics["S"] = create(f,q)
    local q = love.graphics.newQuad(w+16, h, 16, 16, 320, 816)
    graphics["E"] = create(f,q)
    local q = love.graphics.newQuad(w+16, h, 16, 16, 320, 816)
    graphics["W"] = create(f,q)

    local q = love.graphics.newQuad(w, h+16, 16, 16, 320, 816)
    graphics["NS"] = create(f,q)

    local q = love.graphics.newQuad(w, h+32, 16, 16, 320, 816)
    graphics["NE"] = create(f,q)
    local q = love.graphics.newQuad(w+32, h+32, 16, 16, 320, 816)
    graphics["NW"] = create(f,q)

    local q = love.graphics.newQuad(w, h, 16, 16, 320, 816)
    graphics["SE"] = create(f,q)
    local q = love.graphics.newQuad(w+32, h, 16, 16, 320, 816)
    graphics["SW"] = create(f,q)

    local q = love.graphics.newQuad(w+16, h, 16, 16, 320, 816)
    graphics["EW"] = create(f,q)

    local q = love.graphics.newQuad(w+48, h+16, 16, 16, 320, 816)
    graphics["NSE"] = create(f,q)
    local q = love.graphics.newQuad(w+80, h+16, 16, 16, 320, 816)
    graphics["NSW"] = create(f,q)

    local q = love.graphics.newQuad(w+64, h+32, 16, 16, 320, 816)
    graphics["NEW"] = create(f,q)
    local q = love.graphics.newQuad(w+64, h, 16, 16, 320, 816)
    graphics["SEW"] = create(f,q)

    return graphics
  end
  local wallSet0 = split(love.graphics.newImage("resources/DawnLike_1/Objects/Wall.png"),0,0)
  local wallSet1 = split(love.graphics.newImage("resources/DawnLike_1/Objects/Wall.png"),0,48)
  return {wallSet1,wallSet0}
end
return init()
