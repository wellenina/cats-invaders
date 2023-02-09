-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

require 'Player'




function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- initialize virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

    Player:load()

    love.window.setTitle('Cats Invaders')

    largeFont = love.graphics.newFont('font.ttf', 40)
    love.graphics.setBackgroundColor(0,0,0)

end


function love.resize(w, h)
    push:resize(w, h)
end


function love.update(dt)

    Player.update(dt)

end




function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end

end



function love.draw()
    push:start()

    love.graphics.setFont(largeFont)
    love.graphics.print("HELLO", 10, 10)

    Player.render()

    push:finish()
end