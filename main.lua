min_dt = 1/30
next_time = love.timer.getTime()
even = true
sprites = nil
sprites2 = nil
groundSprites = nil
groundBatch = nil
p0 = nil
p1 = nil
sx = 0
sy = 0
spd = 2
cx = 100
cy = 100
gnd1 = nil
gnd2 = nil
shader = nil

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function love.load()
    texture = love.graphics.newShader([[
        vec4 effect(vec4 colour, Image image, vec2 local, vec2 screen)
        {
            // red and green components scale with texture coordinates
            vec4 coord_colour = vec4(local.x, local.y, 0.0, 1.0);
            // use the appropriate pixel from the texture
            vec4 image_colour = Texel(image, local);
            // mix the two colours equally
            return mix(coord_colour, image_colour, 0.3);
        }
    ]])
  sprites  = love.graphics.newImage("resources/DawnLike_1/Characters/Player0.png")
  sprites2  = love.graphics.newImage("resources/DawnLike_1/Characters/Player1.png")
  groundSprites  = love.graphics.newImage("resources/DawnLike_1/Objects/Floor.png")
  groundBatch = love.graphics.newSpriteBatch(groundSprites, 4000)
  gnd1 = love.graphics.newQuad(16, 256, 16, 16, 336, 624)
  gnd2 = love.graphics.newQuad(16, 240, 16, 16, 336, 624)
  for x = 0, 60 do
    for y = 0, 40 do
      groundBatch:add(gnd2,x * 16, y * 16)
    end
  end
  p0 = love.graphics.newQuad(0, 0, 16, 16, 128, 224)
  p1 = love.graphics.newQuad(16, 16, 16, 32, 128, 224)
end

function love.update(dt)
  next_time = next_time + min_dt
end

function love.keypressed(key)
  if key == "h" then
    sy = 0 
    sx = spd * -1 
  elseif key == "l" then
    sy = 0 
    sx = spd 
  elseif key == "j" then
    sx = 0 
    sy = spd 
  elseif key == "k" then
    sx = 0 
    sy = spd * -1 
  elseif key == " " then
    sx = 0 
    sy = 0 
  end
end

function love.draw()
  love.graphics.setShader(texture)
  love.graphics.draw(groundBatch, 0, 0)
  love.graphics.setShader()
  love.graphics.draw(sprites, p0, cx, cy)
  love.graphics.draw(sprites, p1, 200, 200)
  if CheckCollision(cx+sx,cy+sy,16,16,200,200,16,16) == false then
    cx = cx + sx
    cy = cy + sy 
  end
  love.graphics.print(sx .. "|" .. cx, 400, 300)

  local cur_time = love.timer.getTime()
  if next_time <= cur_time then
     next_time = cur_time
     return
  end
  love.timer.sleep(next_time - cur_time)
end
