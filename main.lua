min_dt = 1/12
next_time = love.timer.getTime()
even = true
start = 100
sprites = nil
sprites2 = nil
p0 = nil

function love.load()
  sprites  = love.graphics.newImage("resources/DawnLike_1/Characters/Player0.png")
  sprites2  = love.graphics.newImage("resources/DawnLike_1/Characters/Player1.png")
  p0 = love.graphics.newQuad(0, 0, 16, 16, 128, 224)
end

function love.update(dt)
  next_time = next_time + min_dt
end

function love.draw()
  --rest of function here
  if(even == true) then
    even = false
    love.graphics.draw(sprites, p0, 100, start)
  else 
    even = true 
    love.graphics.draw(sprites2, p0, 100, start)
  end
  start = start + 2 
  love.graphics.print(next_time, 400, 300)

  local cur_time = love.timer.getTime()
  if next_time <= cur_time then
     next_time = cur_time
     return
  end
  love.timer.sleep(next_time - cur_time)
end
