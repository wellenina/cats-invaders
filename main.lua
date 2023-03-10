-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

require 'globals'
require 'objects/Player'
require 'objects/Cat'
require 'objects/Invaders'
require 'objects/Bullet'
require 'objects/Bullets'
require 'objects/Explosion'
require 'states/StateMachine'
require 'states/TitleScreenState'
require 'states/HighScoresState'
require 'states/OptionsState'
require 'states/ChoosePlayerState'
require 'states/ChooseBulletState'
require 'states/GetReadyState'
require 'states/PlayState'
require 'states/PauseState'
require 'states/HurtState'
require 'states/VeryHurtState'
require 'states/GameOverState'


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

    loadGameData()

    -- input table
    love.keyboard.keysPressed = {}

    playersSprite = love.graphics.newImage('images/players-spritesheet.png')
    playerBulletSprite = love.graphics.newImage('images/player-bullets-spritesheet.png')

    groundLine = {0, VIRTUAL_HEIGHT - 17, VIRTUAL_WIDTH, VIRTUAL_HEIGHT - 17}

    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('font.ttf', 16)
    largeFont = love.graphics.newFont('font.ttf', 32)
    hugeFont = love.graphics.newFont('font.ttf', 40)

    sounds = {
        ['playerShoot'] = love.audio.newSource('sounds/player-shoot.wav', 'static'),
        ['playerHurt'] = love.audio.newSource('sounds/player-hurt.wav', 'static'),
        ['gameOver'] = love.audio.newSource('sounds/player-explosion.mp3', 'static'),
        ['invaderShoot'] = love.audio.newSource('sounds/invader-shoot.wav', 'static'),
        ['invaderExplosion'] = love.audio.newSource('sounds/invader-explosion.wav', 'static'),
        ['invadersShiftDown'] = love.audio.newSource('sounds/ominously-shift-down.wav', 'static'),
    }

    StateMachine:changeState(TitleScreenState)
end


function love.resize(w, h)
    push:resize(w, h)
end


function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
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

    love.graphics.clear(BACKGROUND_COLOR)

    love.graphics.setColor(GREEN)
    love.graphics.setLineWidth(1)
    love.graphics.line(groundLine)

    love.graphics.setColor(WHITE)
    StateMachine:render()

    push:finish()
end