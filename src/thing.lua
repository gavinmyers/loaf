Thing = {x=0,y=0,sprite=nil}
function Thing:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

Player = Thing:new()
Monster = Thing:new()
