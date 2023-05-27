PlayState = {

    stateType = 'play',

    load = function()
    end,

    update = function(__self, dt)

        if isTouched(0, 0, 60, 58) then -- pause
            StateMachine:changeState(PauseState)
        end

        if not love.window.hasFocus() then
            StateMachine:changeState(PauseState)
        end

        Player:walk(dt)
        Player:shoot(dt)
        Invaders:update(dt)
        Bullets:update(dt)
        Explosion.update(dt)
    end,

    render = function()
        drawUI()

        Bullets.render()
        Player.render()
        Invaders.render()
        Explosion.render()

        drawScoreAndLives(score, lives, heart)
    end
}