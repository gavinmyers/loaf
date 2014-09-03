local function init(screen)
  local game = require "game"
  local welscr = screen:create("WELCOME")
  function welscr:_draw()
    love.graphics.setColor(255, 255, 255)
    local screenWidth, screenHeight = love.window.getDimensions()
    love.graphics.setFont(game.font)
    love.graphics.printf("\n******************\n   WELCOME TO LOAF \n******************\n\n [1] TUTORIAL \n\n [2] CONTINUE \n\n [X] QUIT", 0, 1, screenWidth, "center")
  end
  function welscr:_keypressed(key)
    if key == "x" then
      love.event.quit()
    elseif key == "1" then
      screen:current("TUTORIAL_1")
    elseif key == "2" then
      screen:current("TUTORIAL_2")
    end
  end
end
return init
