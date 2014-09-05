local generator = require "generator"
local g = generator:create("SIMPLE")
function g:generate(acs,dwn)
  local game = require "game"
  local tile = require "tile"
  acs = acs or game.acs
  dwn = dwn or game.dwn
  local m = {} 
  for x = 1, acs do
    m[x] = {}
    for y = 1, dwn do
      if x > 1 and x < acs and y > 1 and y < dwn and x % 2 == 1 and y % 2 == 1 and math.random(1,6) == 6 then
        m[x][y] = nil 
      else
        m[x][y] = 1 
      end
    end
  end
  for p = 1, 4 do
    for x = 1, acs do
      for y = 1, dwn do
        local t = m[x][y]
        if t == nil then 
          if x > 2 and x < acs - 1 then
            if math.random(1,6) > 3 then
              m[x-1][y] = -1 
            end
            if math.random(1,6) > 3 then
              m[x+1][y] = -1 
            end
          end
          if y > 2 and y < dwn - 1 then
            if math.random(1,6) > 3 then
              m[x][y-1] = -1 
            end
            if math.random(1,6) > 3 then
              m[x][y+1] = -1 
            end
          end
        end
       
      end
    end
    for x = 1, acs do
      for y = 1, dwn do
        if m[x][y] == -1 then
          m[x][y] = nil
        end
      end
    end
  end
  local sx,sy = nil
  while sx == nil do 
    for x = math.random(2,acs/2), acs-1 do
      for y = math.random(2,dwn/2), dwn-1 do
        if m[x][y] == nil and sx == nil and math.random(1,256) == 1 then
          sx = x
          sy = y
        end
      end
    end
  end
  local path = false
  local cx = sx
  local cy = sy
  local ex, ey = nil
  while path == false do
    if math.random(1,3) == 1 and cx > 2 then 
      cx = cx - 1
    elseif math.random(1,3) == 1 and cx < acs - 1 then 
      cx = cx + 1
    elseif math.random(1,3) == 1 and cy > 2 then 
      cy = cy - 1
    elseif math.random(1,3) == 1 and cy < dwn - 1 then 
      cy = cy + 1
    end
    m[cx][cy] = nil
    if math.random(1,128) == 1 then
      path = true
    end
  end
  ex = cx
  ey = cy
  m = generator.edges(m,tile.sets.wall[1])
  return {map=m,startX=sx,startY=sy,endX=ex,endY=ey}
end
