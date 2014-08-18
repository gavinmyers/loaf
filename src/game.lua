-- global game settings used everywhere
game = {}
-- board and window settings
game.sz = 32 -- tile size in pixels
game.acs = 22 -- board size in tiles (Across)
game.dwn = 22 -- board size in tiles (Down)
game.mdf = 2 -- tile size modifier... needed for drawing large tiles 2 = 2 times current tile size
game.mdf_big = 4 -- big 
game.w = game.sz * (game.acs + 2) -- window size in pixels (width) 
game.h = game.sz * (game.dwn + 2) -- window size in pixels (height) 

-- gameplay setings
game.mode = nil

-- current view settings
game.screen = "WELCOME"
