require "resources/DawnLike_1/Objects/Floor"
require "resources/DawnLike_1/Objects/Tile"
require "resources/DawnLike_1/Objects/Wall"
require "resources/DawnLike_1/Items/LongWep"
require "resources/DawnLike_1/Items/ShortWep"
require "resources/DawnLike_1/Items/Tool"
require "resources/DawnLike_1/Items/Shield"
require "resources/DawnLike_1/Items/Scroll"
require "resources/DawnLike_1/Characters/Player"
require "resources/DawnLike_1/GUI/GUI0"

tile = {}
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

tile.sets = {}
function tile.main() 
  tile.sets.floor = resources.floor()
  tile.sets.wall = resources.wall()
  tile.sets.game = resources.tile()
  tile.sets.player = resources.player()
  tile.sets.longWeapon = resources.longWeapon()
  tile.sets.shortWeapon = resources.shortWeapon()
  tile.sets.tool = resources.tool()
  tile.sets.shield = resources.shield()
  tile.sets.scroll = resources.scroll()
  tile.sets.gui = resources.gui()
end

