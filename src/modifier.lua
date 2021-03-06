function _modifier()
  local modifier = {}
  modifier.db = {}
  function modifier:create(id)
    local newModifier = {}
    newModifier.id = id
    newModifier.modifiers = {}  

    function newModifier:useMod(ability,target)
      if self._useMod ~= nil then
        return self:_useMod(ability,target)
      end
      return 0
    end

    function newModifier:attackMod(ability,attacker,defender)
      if self._attackMod ~= nil then
        return self:_attackMod(ability,attacker,defender)
      end
      return 0
    end

    function newModifier:defendMod(ability,attacker,defender)
      if self._defendMod ~= nil then
        return self:_defendMod(ability,attacker,defender)
      end
      return 0
    end

    function newModifier:damageMod(ability,attacker,defender)
      if self._damageMod ~= nil then
        return self:_damageMod(ability,attacker,defender)
      end
      return 0
    end

    function newModifier:soakMod(ability,attacker,defender)
      if self._soakMod ~= nil then
        return self:_soakMod(ability,attacker,defender)
      end
      return 0
    end

    self.db[id] = newModifier

    return newModifier
  end
  return modifier
end
if __modifier ~= nil then
  return __modifier
else
  __modifier = _modifier()
  return __modifier
end

