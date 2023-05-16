RENDER_WIDTH = 480
RENDER_HEIGHT = 270

local windowWidth, windowHeight = love.window.getDesktopDimensions() * 0.7
local renderScale = windowWidth / RENDER_WIDTH
windowHeight = RENDER_HEIGHT * renderScale
local xPadding, yPadding = 0, 0


require 'languages'
require 'globals'
require 'objects/Player'
require 'objects/Cat'
require 'objects/Invaders'
require 'objects/Bullet'
require 'objects/Bullets'
require 'objects/Explosion'
require 'objects/Paw'
require 'states/StateMachine'
require 'states/TitleScreenState'
require 'states/OptionsState'
require 'states/HighScoresState'
require 'states/ResetScoreState'
require 'states/CreditsState'
require 'states/SelectLanguageState'
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
    love.window.setMode(windowWidth, windowHeight, {resizable=true, vsync=0, minwidth=RENDER_WIDTH, minheight=RENDER_HEIGHT})

    loadGameData()

    -- input table
    love.keyboard.keysPressed = {}

    smallFont = love.graphics.newFont('Apple-II.otf', 8)
    smallFont:setLineHeight(1.5)
    mediumFont = love.graphics.newFont('Apple-II.otf', 16)
    largeFont = love.graphics.newFont('Apple-II.otf', 32)
    hugeFont = love.graphics.newFont('Apple-II.otf', 40)

    paw = love.graphics.newImage('images/paw.png')
    playersSprite = love.graphics.newImage('images/players-spritesheet.png')
    playerBulletSprite = love.graphics.newImage('images/player-bullets-spritesheet.png')

    groundLine = {0, RENDER_HEIGHT - 17, RENDER_WIDTH, RENDER_HEIGHT - 17}

    sounds = {
        ['menuSelect'] = love.audio.newSource('sounds/menuSelect.wav', 'static'),
        ['menuEnter'] = love.audio.newSource('sounds/menuEnter.wav', 'static'),
        ['playerShoot'] = love.audio.newSource('sounds/player-shoot.wav', 'static'),
        ['playerHurt'] = love.audio.newSource('sounds/player-hurt.wav', 'static'),
        ['gameOver'] = love.audio.newSource('sounds/player-explosion.mp3', 'static'),
        ['invaderShoot'] = love.audio.newSource('sounds/invader-shoot.wav', 'static'),
        ['invaderExplosion'] = love.audio.newSource('sounds/invader-explosion.wav', 'static'),
        ['invadersShiftDown'] = love.audio.newSource('sounds/ominously-shift-down.wav', 'static'),
    }

    StateMachine:changeState(TitleScreenState)
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


function love.resize(w, h)
    windowWidth, windowHeight = w, h
    local renderScaleX, renderScaleY = windowWidth / RENDER_WIDTH, windowHeight / RENDER_HEIGHT

    if renderScaleX == renderScaleY then
        renderScale = renderScaleX
        xPadding, yPadding = 0, 0
    elseif renderScaleX < renderScaleY then
        renderScale = renderScaleX
        xPadding = 0
        yPadding = (windowHeight - (RENDER_HEIGHT * renderScale)) * 0.5
    else
        renderScale = renderScaleY
        xPadding = (windowWidth - (RENDER_WIDTH * renderScale)) * 0.5
        yPadding = 0
    end
end


function love.draw()
    love.graphics.push()
    love.graphics.translate(xPadding, yPadding)
	love.graphics.scale(renderScale, renderScale)

    love.graphics.setBackgroundColor(BACKGROUND_COLOR)

    love.graphics.setColor(GREEN)
    love.graphics.setLineWidth(1)
    love.graphics.line(groundLine)

    love.graphics.setColor(WHITE)
    StateMachine:render()

    if yPadding > 0 then
        love.graphics.setColor(BACKGROUND_COLOR)
        love.graphics.rectangle('fill', 0, 0-yPadding, windowWidth, yPadding)
        love.graphics.setColor(WHITE)
    end

    love.graphics.pop()
end