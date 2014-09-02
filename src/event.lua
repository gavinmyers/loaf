function _events()
  local events = {}
  events.db = {}
  function events:create(id)
    local ev = {}
    ev.id = id
    ev.x = 0
    ev.y = 0
    function ev:trigger(target)
      if self._trigger ~= nil then
        return self:_trigger(target)
      end
    end
    events.db[id] = ev
    return ev
  end 
  return events
end
if __events ~= nil then
  return __events
else
  __events = _events()
  return __events
end

