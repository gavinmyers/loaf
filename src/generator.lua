function _generator()
  local game = require "game"
  local tile = require "tile"
  local generator = {}
  generator.db = {}

  function generator:create(id)
    local g = {}
    self.db[id] = g
    return g
  end

  function generator:get(id)
    return self.db[id] 
  end

  function generator.edges(acs,dwn,m,set) 
    local m2 = {}
    for x = 1, acs do
      m2[x] = {}
      for y = 1, dwn do
        if m[x][y] ~= nil then
          m2[x][y] = set[generator.edge(m,x,y)]
        end
      end
    end
    return m2
  end

  function generator.edge(m,x,y)
    local eN, eS, eE, eW = nil
    eN = m[x][y-1] 
    eS = m[x][y+1] 

    if m[x+1] ~= nil then
      eE = m[x+1][y] 
    end

    if m[x-1] ~= nil then
      eW = m[x-1][y] 
    end

    local eX = m[x][y] 

    if eN ~= nil and eS ~= nil and eE ~= nil and eW ~= nil then 
      return "NSEW"

    elseif eN == nil and eS == nil and eE == nil and eW == nil then 
      return ""

    elseif eN ~= nil and eS == nil and eE == nil and eW == nil then 
      return "N"
    elseif eN == nil and eS ~= nil and eE == nil and eW == nil then 
      return "S"
    elseif eN == nil and eS == nil and eE ~= nil and eW == nil then 
      return "E"
    elseif eN == nil and eS == nil and eE == nil and eW ~= nil then 
      return "W"

    elseif eN ~= nil and eS ~= nil and eE == nil and eW == nil then 
      return "NS"

    elseif eN ~= nil and eS == nil and eE ~= nil and eW == nil then 
      return "NE"
    elseif eN ~= nil and eS == nil and eE == nil and eW ~= nil then 
      return "NW"

    elseif eN == nil and eS ~= nil and eE ~= nil and eW == nil then 
      return "SE"
    elseif eN == nil and eS ~= nil and eE == nil and eW ~= nil then 
      return "SW"

    elseif eN == nil and eS == nil and eE ~= nil and eW ~= nil then 
      return "EW"

    elseif eN ~= nil and eS ~= nil and eE ~= nil and eW == nil then 
      return "NSE"
    elseif eN ~= nil and eS ~= nil and eE == nil and eW ~= nil then 
      return "NSW"

    elseif eN ~= nil and eS == nil and eE ~= nil and eW ~= nil then 
      return "NEW"
    elseif eN == nil and eS ~= nil and eE ~= nil and eW ~= nil then 
      return "SEW"
    end
    return ""
  end

  return generator
end
if __generator ~= nil then
  return __generator
else
  __generator = _generator()
  return __generator
end

