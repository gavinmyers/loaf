function _tile() 
  local game = require "game"
  local tile = {}
  tile.sets = {}
  tile.sets.floor = require "resources/DawnLike_1/Objects/Floor"
  tile.sets.game  = require "resources/DawnLike_1/Objects/Tile"
  tile.sets.wall  = require "resources/DawnLike_1/Objects/Wall"
  tile.sets.door = require "resources/DawnLike_1/Objects/Door"
  tile.sets.longWeapon = require "resources/DawnLike_1/Items/LongWep"
  tile.sets.shortWeapon = require "resources/DawnLike_1/Items/ShortWep"
  tile.sets.tool = require "resources/DawnLike_1/Items/Tool"
  tile.sets.shield = require "resources/DawnLike_1/Items/Shield"
  tile.sets.scroll = require "resources/DawnLike_1/Items/Scroll"
  tile.sets.ammo = require "resources/DawnLike_1/Items/Ammo"
  tile.sets.player = require "resources/DawnLike_1/Characters/Player"
  tile.sets.gui = require "resources/DawnLike_1/GUI/GUI0"

  function tile.create(img,q) 
    return {sprite=img,quad=q,mdf=game.mdf}
  end
  tile.graphics = {}
  function tile.graphics.draw(t,x,y,m) 
    if t == nil or t == 0 then
      return
    end
    if m == nil then
      m = t.mdf
    end
    if m == nil then
      m = game.mdf
    end
    love.graphics.draw(t.sprite,t.quad,x*game.sz,y*game.sz,0,m,m)
  end

  return tile
end
if __tile ~= nil then
  return __tile
else
  __tile = _tile()
  return __tile
end

