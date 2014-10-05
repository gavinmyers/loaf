local generator = require "generator"
local g = generator:create("CAVE_1")
function g:valid(acs,dwn,x,y)
  if x > 1 and x < acs and y > 1 and y < dwn then 
    return true
  else
    return false
  end
end
function g:area(acs,dwn,x,y,m)
  local m2 = {}
  for x = 1, acs do
    m2[x] = {}
    for y = 1, dwn do
      m2[x][y] = 1 
    end
  end
  if m[x][y] ~= nil then
    return m2
  end
  m2[x][y] = nil
  m2 = self:_area(acs,dwn,x,y,m,m2)
  return m2
end
function g:_area(acs,dwn,x,y,m,m2)
  if self:valid(acs,dwn,x,y+1) and m[x][y+1] ~= 1 then
    if m2[x][y+1] == 1 then
      m2[x][y+1] = nil
      m2 = self:_area(acs,dwn,x,y+1,m,m2)
    end
  end
  if self:valid(acs,dwn,x,y-1) and m[x][y-1] ~= 1 then
    if m2[x][y-1] == 1 then
      m2[x][y-1] = nil
      m2 = self:_area(acs,dwn,x,y-1,m,m2)
    end
  end
  if self:valid(acs,dwn,x+1,y) and m[x+1][y] ~= 1 then
    if m2[x+1][y] == 1 then
      m2[x+1][y] = nil
      m2 = self:_area(acs,dwn,x+1,y,m,m2)
    end
  end
  if self:valid(acs,dwn,x-1,y) and m[x-1][y] ~= 1 then
    if m2[x-1][y] == 1 then
      m2[x-1][y] = nil
      m2 = self:_area(acs,dwn,x-1,y,m,m2)
    end
  end
  return m2

end
function g:surrounded(acs,dwn,x,y,m)
  return self:cardinals(acs,dwn,x,y,m) + self:neighbors(acs,dwn,x,y,m) == 0 
end
function g:cardinals(acs,dwn,x,y,m)
  local c = 0
  if self:valid(acs,dwn,x+1,y+1) and m[x+1][y+1] ~= 1 then
    c = c + 1
  end
  if self:valid(acs,dwn,x+1,y-1) and m[x+1][y-1] ~= 1 then
    c = c + 1
  end
  if self:valid(acs,dwn,x-1,y+1) and m[x-1][y+1] ~= 1 then
    c = c + 1
  end
  if self:valid(acs,dwn,x-1,y-1) and m[x-1][y-1] ~= 1 then
    c = c + 1
  end
  return c
end

function g:neighbors(acs,dwn,x,y,m)
  local c = 0
  if self:valid(acs,dwn,x,y+1) and m[x][y+1] ~= 1 then
    c = c + 1
  end
  if self:valid(acs,dwn,x,y-1) and m[x][y-1] ~= 1 then
    c = c + 1
  end
  if self:valid(acs,dwn,x+1,y) and m[x+1][y] ~= 1 then
    c = c + 1
  end
  if self:valid(acs,dwn,x-1,y) and m[x-1][y] ~= 1 then
    c = c + 1
  end
  return c
end
function g:opposites(acs,dwn,x,y,m)
  local c1,c2,c1x,c1y,c2x,c2y
  if self:valid(acs,dwn,x,y+1) and m[x][y+1] ~= 1 then
    c1 = m[x][y+1]
    c1x = x
    c1y = y+1
  end
  if self:valid(acs,dwn,x,y-1) and m[x][y-1] ~= 1 then 
    if c1 == nil then
      c1 = m[x][y-1]
      c1x = x
      c1y = y-1
    elseif c1 ~= m[x][y-1] then
      c2 = m[x][y-1]
      c2x = x
      c2y = y-1
    end
  end
  if self:valid(acs,dwn,x+1,y) and m[x+1][y] ~= 1 then 
    if c1 == nil then
      c1 = m[x+1][y]
      c1x = x+1
      c1y = y
    elseif c1 ~= m[x+1][y] then
      c2 = m[x+1][y]
      c2x = x+1
      c2y = y
    end

  end
  if self:valid(acs,dwn,x-1,y) and m[x-1][y] ~= 1 then 
    if c1 == nil then
      c1 = m[x-1][y]
      c1x = x-1
      c1y = y
    elseif c1 ~= m[x-1][y] then
      c2 = m[x-1][y]
      c2x = x-1
      c2y = y
    end
  end
  if c2 == nil or c1 == nil then
    return m
  end
  m[x][y] = c1
  return self:neighbor(acs,dwn,c2x,c2y,m,c1)
end

function g:neighbor(acs,dwn,x,y,m,counter)
  if self:valid(acs,dwn,x,y+1) and m[x][y+1] == nil then
    m[x][y+1]=counter
    m = self:neighbor(acs,dwn,x,y+1,m,counter)
  end
  if self:valid(acs,dwn,x,y-1) and m[x][y-1] == nil then
    m[x][y-1]=counter
    m = self:neighbor(acs,dwn,x,y-1,m,counter)
  end
  if self:valid(acs,dwn,x+1,y) and m[x+1][y] == nil then
    m[x+1][y]=counter
    m = self:neighbor(acs,dwn,x+1,y,m,counter)
  end
  if self:valid(acs,dwn,x-1,y) and m[x-1][y] == nil then
    m[x-1][y]=counter
    m = self:neighbor(acs,dwn,x-1,y,m,counter)
  end
  return m
end
function g:room(acs,dwn,x,y,m,size)
  for bx = 0, size do
    for by = 0, size do
      if x + bx < acs then
        if y + by < dwn then
          m[x + bx][y + by] = nil
        end
        if y - by > 1 then
          m[x + bx][y - by] = nil
        end
      end
      if x - bx > 1 then
        if y + by < dwn then
          m[x - bx][y + by] = nil
        end
        if y - by > 1 then
          m[x - bx][y - by] = nil
        end
      end
    end
  end
  return m
end
function g:generate(acs,dwn)
  local game = require "game"
  local tile = require "tile"
  acs = acs or game.acs
  dwn = dwn or game.dwn
  local m = {} 
  for x = 1, acs do
    m[x] = {}
    for y = 1, dwn do
      m[x][y] = 1 
    end
  end

  local startX = math.random(acs - 2) + 1
  local startY = math.random(dwn - 2) + 1
  local rm = math.random(3) + 2
  m = self:room(acs,dwn,startX,startY,m,rm) 

  for i=1,8 do
    local rx = math.random(acs - 2) + 1
    local ry = math.random(dwn - 2) + 1
    local rm = math.random(3) + 2
    m = self:room(acs,dwn,rx,ry,m,rm) 
  end

  local endX = math.random(acs - 2) + 1
  local endY = math.random(dwn - 2) + 1
  local ext = true 
  while ext do
    if m[endX][endY] == 1 then
      ext = false  
    else
      endX = math.random(acs - 2) + 1
      endY = math.random(dwn - 2) + 1
    end
  end
  local rm = math.random(3) + 2
  m = self:room(acs,dwn,endX,endY,m,rm) 

  local m2 = {}
  for x = 1, acs do
    m2[x] = {}
    for y = 1, dwn do
      if self:valid(acs,dwn,x,y,m) ~= true then
        m2[x][y] = 1
      elseif self:surrounded(acs,dwn,x,y,m) then
        m2[x][y] = nil
      else
        m2[x][y] = 1
      end
    end
  end
  for x = 1, acs do
    for y = 1, dwn do
      if m2[x][y] == nil then 
        m[x][y] = nil
      end
    end
  end
  for x = 1, acs do
    for y = 1, dwn do
      if self:valid(acs,dwn,x,y,m) 
          and m[x][y] == nil then 
        if self:valid(acs,dwn,x,y+1) and m[x][y+1] == 1 then
          local m2 = self:area(acs,dwn,x,y,m)
          if self:valid(acs,dwn,x,y+2) and m[x][y+2] ~= 1 then
            if m2[x][y+2] == 1 and math.random(12) == 1 then
              m[x][y+1] = nil
            end
          end
        end
        if self:valid(acs,dwn,x,y-1) and m[x][y-1] == 1 then
          local m2 = self:area(acs,dwn,x,y,m)
          if self:valid(acs,dwn,x,y-2) and m[x][y-2] ~= 1 then
            if m2[x][y-2] == 1 and math.random(12) == 1 then
              m[x][y-1] = nil
            end
          end
        end
        if self:valid(acs,dwn,x+1,y) and m[x+1][y] == 1 then
          local m2 = self:area(acs,dwn,x,y,m)
          if self:valid(acs,dwn,x+2,y) and m[x+2][y] ~= 1 then
            if m2[x+2][y] == 1 and math.random(12) == 1 then
              m[x+1][y] = nil
            end
          end
        end
        if self:valid(acs,dwn,x-1,y) and m[x-1][y] == 1 then
          local m2 = self:area(acs,dwn,x,y,m)
          if self:valid(acs,dwn,x-2,y) and m[x-2][y] ~= 1 then
            if m2[x-2][y] == 1 and math.random(12) == 1 then
              m[x-1][y] = nil
            end
          end
        end
      end

      if self:valid(acs,dwn,x,y,m) 
          and m[x][y] == nil then 
        if self:valid(acs,dwn,x,y+1) and m[x][y+1] == 1 then
          local m2 = self:area(acs,dwn,x,y,m)
          if self:valid(acs,dwn,x,y+2) and m[x][y+2] ~= 1 then
            if m2[x][y+2] == 1 then 
              m[x][y+1] = nil
            end
          end
        end
        if self:valid(acs,dwn,x,y-1) and m[x][y-1] == 1 then
          local m2 = self:area(acs,dwn,x,y,m)
          if self:valid(acs,dwn,x,y-2) and m[x][y-2] ~= 1 then
            if m2[x][y-2] == 1 then 
              m[x][y-1] = nil
            end
          end
        end
        if self:valid(acs,dwn,x+1,y) and m[x+1][y] == 1 then
          local m2 = self:area(acs,dwn,x,y,m)
          if self:valid(acs,dwn,x+2,y) and m[x+2][y] ~= 1 then
            if m2[x+2][y] == 1 then 
              m[x+1][y] = nil
            end
          end
        end
        if self:valid(acs,dwn,x-1,y) and m[x-1][y] == 1 then
          local m2 = self:area(acs,dwn,x,y,m)
          if self:valid(acs,dwn,x-2,y) and m[x-2][y] ~= 1 then
            if m2[x-2][y] == 1 then 
              m[x-1][y] = nil
            end
          end
        end
      end


    end
  end
  m = generator.edges(acs,dwn,m,tile.sets.wall[1])
  return {map=m,startX=startX,startY=startY,endX=endX,endY=endY}
end
function g:generate2(acs,dwn)
  local game = require "game"
  local tile = require "tile"
  acs = acs or game.acs
  dwn = dwn or game.dwn
  local m = {} 
  for x = 1, acs do
    m[x] = {}
    for y = 1, dwn do
      if self:valid(acs,dwn,x,y) then 
        if math.random(2) == 1 then 
          m[x][y] = 1 
        else
          m[x][y] = nil 
        end
      else
        m[x][y] = 1 
      end
    end
  end

  for t = 1, 9 do
    for x = 1, acs do
      for y = 1, dwn do
        if x > 1 and x < acs and y > 1 and y < dwn then 
          local n = m[x][y-1] or 0
          local s = m[x][y+1] or 0
          local w = m[x-1][y] or 0
          local e = m[x+1][y] or 0
          local sum = n + s + e + w
          if sum < 2 then
            m[x][y] = nil
          elseif sum > 3 then
            m[x][y] = 1 
          end
        end
      end
    end
  end


  local counter = 10 
  for x = 1, acs do
    for y = 1, dwn do
      if m[x][y] == nil then
        m = self:neighbor(acs,dwn,x,y,m,counter)
        counter = counter + 1
      end
    end
  end

  for t = 1, 2 do
    for x = 1, acs do
      for y = 1, dwn do
        if m[x][y] == 1 then
          m = self:opposites(acs,dwn,x,y,m)
        end
      end
    end

    for x = 1, acs do
      for y = 1, dwn do
        if m[x][y] ~= 1 and self:neighbors(acs,dwn,x,y,m) == 1  then
          m[x][y] = 1
        end
      end
    end
  end

  for x = 1, acs do
    for y = 1, dwn do
      if m[x][y] ~= 1 and self:neighbors(acs,dwn,x,y,m) == 4 then 
        if math.random(2) == 1 then 
          m[x][y] = 1 
        end
      end
    end
  end

  for t = 1,9 do
    for x = 1, acs do
      for y = 1, dwn do
        if m[x][y] ~= 1 and self:neighbors(acs,dwn,x,y,m) == 1 then 
          m[x][y] = 1 
        end
      end
    end
  end


  local startX, startY, endX, endY
  for x = 1, acs do
    for y = 1, dwn do
      if m[x][y] ~= 1 then
        m[x][y] = nil
        if startX == nil then
          startX = x
          startY = y
        end
      end
    end
  end


  m = generator.edges(acs,dwn,m,tile.sets.wall[1])
  return {map=m,startX=startX,startY=startY,endX=acs-1,endY=dwn-1}
end
