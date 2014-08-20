item = {}
item.db = {}
function item:create(id)
  local ni = {}
  ni.id = id
  item.db[id] = ni
  return ni
end


