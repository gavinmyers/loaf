item = {}
item.db = {}
function item:create(id, screen)
  local ni = {}
  ni.id = id
  ni.screen = screen
  item.db[id] = ni
  return ni
end


