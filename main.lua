min_dt = 1/30
next_time = love.timer.getTime()
even = true
sprites = nil
sprites2 = nil
p0 = nil
sx = 0
sy = 0
cx = 100
cy = 100

function love.load()
  sprites  = love.graphics.newImage("resources/DawnLike_1/Characters/Player0.png")
  sprites2  = love.graphics.newImage("resources/DawnLike_1/Characters/Player1.png")
  p0 = love.graphics.newQuad(0, 0, 16, 16, 128, 224)
end

function love.update(dt)
  next_time = next_time + min_dt
end

function love.keypressed(key)
  if key == "h" then
    sx = -1 
  elseif key == "l" then
    sx = 1 
  elseif key == "j" then
    sy = 1
  elseif key == "k" then
    sy = -1
  end
end

function love.draw()
  love.graphics.draw(sprites, p0, cx, cy)
  cx = cx + sx
  cy = cy + sy 
  love.graphics.print(sx .. "|" .. cx, 400, 300)

  local cur_time = love.timer.getTime()
  if next_time <= cur_time then
     next_time = cur_time
     return
  end
  love.timer.sleep(next_time - cur_time)
end
