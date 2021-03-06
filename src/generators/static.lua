local generator = require "generator"
local g = generator:create("STATIC")
function g:generate(acs,dwn)
  local game = require "game"
  local tile = require "tile"
  local acs = 22 
  local dwn = 8 
  local l = {
    {1,1,1,1,1,1,1,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1},
    {1,1,1,1,1,1,1,1}}
  local m = {} 
  for x = 1, acs do
    m[x] = {}
    for y = 1, dwn do
      if l[x][y] == 0 then
        m[x][y] = nil 
      else
        m[x][y] = 1 
      end
    end
  end
  m = generator.edges(m,tile.sets.wall[1])
  return {map=m,startX=2,startY=2,endX=acs-1,endY=dwn-1}
end
