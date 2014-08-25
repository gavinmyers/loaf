creature = {}
creature.db = {}
function creature:remove(id)
  local cr = self.db[id]
  --don't like this...
  game.screen.map.creatures[cr.x][cr.y] = nil
  self.db[id] = nil
end

function creature:create(id,screen) 
  local nc = {}
  nc.id = id
  nc.screen = screen 
  nc.hostile = true
  nc.hp = 1
  nc.attack = 0
  nc.ability = nil
  nc.defend = 0
  nc.soak = 0
  nc.damage = 0
  nc.abilities = {}
  nc.x = 1 
  nc.y = 1 
  nc.tile = nil
  function nc:die()
    creature:remove(self.id)
    print("SQUEEEE!")
  end
  self.db[id] = nc
  return nc
end

