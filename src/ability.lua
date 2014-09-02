function _ability()
  local ability = {}
  ability.db = {}
  function ability:create(id) 
    local newAbility = {}
    newAbility.id = id
    newAbility.modifiers = {}  
    function newAbility:use(target)
      if self._use ~= nil then
        return self:_use(target)
      end
      return true
    end

    function newAbility:useMod(ability,target)
      if self._useMod ~= nil then
        return self:_useMod(ability,target)
      end
    end

    function newAbility:attack(attacker,defender)
      local res = 0 
      if self._attack ~= nil then
        res = self:_attack(attacker,defender)
      end
      for i = 1, #self.modifiers do
        local mod = self.modifiers[i]
        res = res + mod:attackMod(self,attacker,defender)
      end
      return res
    end

    function newAbility:attackMod(ability,attacker,defender)
      local res = 0
      if self._attackMod ~= nil then
        res = self:_attackMod(ability,attacker,defender)
      end
      return res
    end

    function newAbility:defend(attacker,defender)
      local res = 0
      if self._defend ~= nil then
        res = self:_defend(attacker,defender)
      end
      return res
    end

    function newAbility:defendMod(ability,attacker,defender)
      if self._defendMod ~= nil then
        return self:_defendMod(ability,attacker,defender)
      end
    end

    function newAbility:damage(attacker,defender)
      local res
      if self._damage ~= nil then
        res = self:_damage(attacker,defender)
      end
      for i = 1, #self.modifiers do
        local mod = self.modifiers[i]
        res = res + mod:damageMod(self,attacker,defender)
      end
      return res
    end

    function newAbility:damageMod(ability,attacker,defender)
      local res = 0 
      if self._damageMod ~= nil then
        res = self:_damageMod(ability,attacker,defender)
      end
      return res

    end


    function newAbility:soak(attacker,defender)
      if self._soak ~= nil then
        return self:_soak(attacker,defender)
      end
    end

    function newAbility:soakMod(ability,attacker,defender)
      if self._soakMod ~= nil then
        return self:_soakMod(ability,attacker,defender)
      end
    end

    self.db[id] = newAbility
    return newAbility
  end
  return ability
end
if __ability ~= nil then
  return __ability
else
  __ability = _ability()
  return __ability
end

