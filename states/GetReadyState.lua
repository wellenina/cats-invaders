local GET_READY_DURATION = 3 -- seconds
local getReadyTimer

local TOTAL_NUMBER_OF_LIVES = 3

GetReadyState = {

    stateType = 'play',

    load = function()
        Player:load()
        Invaders:load()
        Bullets.load()
        Explosion.load()

        score = 0
        lives = TOTAL_NUMBER_OF_LIVES

        heart = love.graphics.newImage('images/heart.png')
        getReadyTimer = 0
        renderedCats = 1
    end,

    update = function(__self, dt)
        Player:flicker(dt)
        Player:walk(dt)
        Invaders:getReadyUpdate(dt)

        getReadyTimer = getReadyTimer + dt
        if getReadyTimer >= GET_READY_DURATION then
            StateMachine:changeState(PlayState)
            playerScale = 1
        end
    end,

    render = function()
        Player.render()
        Invaders.getReadyRender()

        drawScoreAndLives(score, lives, heart)
    end
}