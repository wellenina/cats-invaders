-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

require 'Player'

timer = 0

Cat = {
    load = function()
        catImage = love.graphics.newImage('images/white-cat.png')
        catWidth = catImage:getWidth()
        catHeight = catImage:getHeight()
        catX = VIRTUAL_WIDTH / 2 - catWidth / 2
        catY = 20
        catLateralMovement = 5
        catVerticalMovent = 15
    end,

    update = function(dt)
        timer = timer + dt
        if timer > 0.2 then
            catX = catX + catLateralMovement
            timer = 0
        end

        if catX >= VIRTUAL_WIDTH - catWidth then
            catLateralMovement = catLateralMovement * -1
            catX = VIRTUAL_WIDTH - catWidth -5
            catY = catY + catVerticalMovent
        elseif catX <= 0 then
            catLateralMovement = catLateralMovement * -1
            catX = 5
            catY = catY + catVerticalMovent
        end
    end,

    render = function()
        love.graphics.draw(catImage, catX, catY)
    end
  }




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
    Cat:load()

    love.window.setTitle('Cats Invaders')

    largeFont = love.graphics.newFont('font.ttf', 40)
    love.graphics.setBackgroundColor(0,0,0)

end


function love.resize(w, h)
    push:resize(w, h)
end


function love.update(dt)

    Player.update(dt)
    Cat.update(dt)

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
    Cat.render()

    push:finish()
end