local generator = require "generator"

local g = generator:create("EMPTY")

function g:generate(acs,dwn)
  local game = require "game"
  local tile = require "tile"
  acs = acs or game.acs
  dwn = dwn or game.dwn
  local m = {} 
  for x = 1, acs do
    m[x] = {}
    for y = 1, dwn do
      if x > 1 and x < acs and y > 1 and y < dwn then 
        m[x][y] = nil 
      else
        m[x][y] = 1 
      end
    end
  end
  m = generator.edges(m,tile.sets.wall[1])
  return {map=m,startX=2,startY=2,endX=acs-1,endY=dwn-1}
end
