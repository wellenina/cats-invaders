local getReadyDuration = 3 -- seconds
local getReadyTimer = 0

GetReadyState = {
    load = function()
        Player:load()
        Invaders:load()
        Bullets.load()
        Explosion.load()

        score = 0
        lives = 3

        heart = love.graphics.newImage('images/heart.png')
        getReadyTimer = 0
        renderedCats = 1
    end,

    update = function(__self, dt)
        Player:flicker(dt)
        Player:walk(dt)
        Invaders:getReadyUpdate(dt)

        getReadyTimer = getReadyTimer + dt
        if getReadyTimer >= getReadyDuration then
            StateMachine:changeState(PlayState)
            playerScale = 1
        end
    end,

    render = function()
        Player.render()
        Invaders.getReadyRender()

        love.graphics.setFont(smallFont)
        drawScoreAndLives(score, lives, heart)
    end
}