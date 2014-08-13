require "resources/DawnLike_1/Objects/Floor"
require "resources/DawnLike_1/Objects/Tile"
require "resources/DawnLike_1/Objects/Wall"
require "resources/DawnLike_1/Items/LongWep"
require "resources/DawnLike_1/Items/Shield"
require "resources/DawnLike_1/Characters/Player"

tile = {}
function tile.create(img,q) 
  return {sprite=img,quad=q}
end
tile.graphics = {}
function tile.graphics.draw(t,x,y) 
  love.graphics.draw(t.sprite,t.quad,x*game.sz,y*game.sz,0,game.mdf,game.mdf)
end

tile.sets = {}
function tile.main() 
  tile.sets.floor = resources.floor()
  tile.sets.wall = resources.wall()
  tile.sets.game = resources.tile()
  tile.sets.player = resources.player()
  tile.sets.longWeapon = resources.longWeapon()
  tile.sets.shield = resources.shield()
end

