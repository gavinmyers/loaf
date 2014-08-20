creature = {}
creature.db = {}
function creature:remove(id)
  local cr = self.db[id]
  map.creatures[cr.x][cr.y] = nil
  self.db[id] = nil
end

function creature:create(id) 
  local newCreature = {}
  newCreature.id = id
  newCreature.hostile = true
  newCreature.hp = 1
  newCreature.attack = 0
  newCreature.ability = nil
  newCreature.defend = 0
  newCreature.soak = 0
  newCreature.damage = 0
  newCreature.abilities = {}
  newCreature.x = 1 
  newCreature.y = 1 
  newCreature.tile = nil
  function newCreature:die()
    creature:remove(self.id)
    print("SQUEEEE!")
  end
  self.db[id] = newCreature
  return newCreature
end

