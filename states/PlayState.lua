PlayState = {
    load = function()
    end,

    update = function(__self, dt)

        if love.keyboard.wasPressed('escape') then
            StateMachine:changeState(PauseState)
        end

        Player:walk(dt)
        Player:shoot(dt)
        Invaders:update(dt)
        Bullets:update(dt)
        Explosion.update(dt)
    end,

    render = function()
        Bullets.render()
        Player.render()
        Invaders.render()
        Explosion.render()

        drawScoreAndLives(score, lives, heart)
    end
}