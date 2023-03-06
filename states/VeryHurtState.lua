local veryHurtDuration = 3
local veryHurtTimer = 0

VeryHurtState = {
    load = function()
        veryHurtTimer = 0
        lives = 0
        isInvulnerable = true
        playerFrame = (playerFrame == 1 or playerFrame == 2) and 3 or 6
    end,
    
    update = function(__self, dt)
        Invaders:update(dt)
        Bullets:update(dt)
        Explosion.update(dt)

        veryHurtTimer = veryHurtTimer + dt
        if veryHurtTimer >= veryHurtDuration then
            StateMachine:changeState(GameOverState)
            playerScale = 1
        elseif veryHurtTimer >= 1.2 and veryHurtTimer <= 1.4 then
            sounds['gameOver']:play()
            Explosion.explode(playerX, playerY, playerWidth, playerHeight, 10)
            playerScale = 0
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