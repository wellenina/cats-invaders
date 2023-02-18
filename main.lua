-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

require 'Player'
require 'Cat'
require 'Invaders'
require 'Bullet'
require 'Bullets'
require 'Explosion'
require 'StateMachine'


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- initialize virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

    love.window.setTitle('Cats Invaders')

    -- input table
    love.keyboard.keysPressed = {}

    groundLine = {0, VIRTUAL_HEIGHT - 17, VIRTUAL_WIDTH, VIRTUAL_HEIGHT - 17}

    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('font.ttf', 20)
    hugeFont = love.graphics.newFont('font.ttf', 52)

    StateMachine:changeState(TitleScreenState)
    StateMachine:load()
end


function love.resize(w, h)
    push:resize(w, h)
end


function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end


function love.update(dt)
    StateMachine:update(dt)
    love.keyboard.keysPressed = {}
end


function love.draw()
    push:start()

    love.graphics.clear(0.4,0.4,0.4)

    -- love.graphics.setColor()
    love.graphics.line(groundLine)

    StateMachine:render()

    push:finish()
end