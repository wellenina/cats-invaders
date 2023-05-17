local hurtDuration = 3
local hurtTimer = 0

HurtState = {

    stateType = 'play',

    load = function()
        sounds['playerHurt']:play()
        hurtTimer = 0
        lives = lives - 1
        isInvulnerable = true
    end,
    
    update = function(__self, dt)
        Player:flicker(dt)
        Player:walk(dt)
        Player:shoot(dt)
        Invaders:update(dt)
        Bullets:update(dt)
        Explosion.update(dt)

        hurtTimer = hurtTimer + dt
        if hurtTimer >= hurtDuration then
            StateMachine:changeState(PlayState)
            isInvulnerable = false
            playerScale = 1
        end
    end,
    
    render = function()
        Bullets.render()
        Player.render()
        Invaders.render()
        Explosion.render()

        drawScoreAndLives(score, lives, heart)
    end
}