StateMachine = {}

StateMachine.currentState = {}

function StateMachine:changeState(newState)
    self.currentState = newState
    self.currentState:load()
end

function StateMachine:update(dt)
    self.currentState:update(dt)
end

function StateMachine:render()
    self.currentState:render()
end


function drawLives(livesNum, img)
    local margin = 60
    for i = 1, livesNum, 1 do
        love.graphics.draw(img, VIRTUAL_WIDTH - margin, VIRTUAL_HEIGHT - 13)
        margin = margin + 15
    end
end


TitleScreenState = {
    load = function()
    end,

    update = function(dt)
        if love.keyboard.wasPressed('return') then
            StateMachine:changeState(GetReadyState)
        end
    end,

    render = function()
        love.graphics.setFont(hugeFont)
        love.graphics.printf('CATS INVADERS', 0, 30, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(mediumFont)
        love.graphics.printf('Press Enter to play', 0, VIRTUAL_HEIGHT * 0.5, VIRTUAL_WIDTH, 'center')
    end
}


GetReadyState = {
    load = function()
        Player:load()
        Invaders:load()
        Bullets.load()
        Explosion.load()

        heart = love.graphics.newImage('images/heart.png')

        getReadyDuration = 3 -- seconds
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
            getReadyTimer = 0
        end
    end,

    render = function()
        Player.render()
        Invaders.getReadyRender()

        love.graphics.setFont(smallFont)
        love.graphics.printf('SCORE  ' .. tostring(score), 20, VIRTUAL_HEIGHT - 13, VIRTUAL_WIDTH, 'left')
        love.graphics.printf('LIVES', VIRTUAL_WIDTH-20-smallFont:getWidth('LIVES'), VIRTUAL_HEIGHT - 13, VIRTUAL_WIDTH, 'left')
        drawLives(lives, heart)
    end
}


PlayState = {
    load = function()
    end,

    update = function(__self, dt)
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

        love.graphics.printf('SCORE  ' .. tostring(score), 20, VIRTUAL_HEIGHT - 13, VIRTUAL_WIDTH, 'left')
        love.graphics.printf('LIVES', VIRTUAL_WIDTH-20-smallFont:getWidth('LIVES'), VIRTUAL_HEIGHT - 13, VIRTUAL_WIDTH, 'left')
        drawLives(lives, heart)
    end
}


HurtState = {
    load = function()
        sounds['playerHurt']:play()
        hurtDuration = 3
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
            hurtTimer = 0
        end
    end,
    
    render = function()
        Bullets.render()
        Player.render()
        Invaders.render()
        Explosion.render()

        love.graphics.printf('SCORE  ' .. tostring(score), 20, VIRTUAL_HEIGHT - 13, VIRTUAL_WIDTH, 'left')
        love.graphics.printf('LIVES', VIRTUAL_WIDTH-20-smallFont:getWidth('LIVES'), VIRTUAL_HEIGHT - 13, VIRTUAL_WIDTH, 'left')
        drawLives(lives, heart)
    end
}


VeryHurtState = {
    load = function()
        veryHurtDuration = 3
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
            hurtTimer = 0
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

        love.graphics.printf('SCORE  ' .. tostring(score), 20, VIRTUAL_HEIGHT - 13, VIRTUAL_WIDTH, 'left')
        love.graphics.printf('LIVES', VIRTUAL_WIDTH-20-smallFont:getWidth('LIVES'), VIRTUAL_HEIGHT - 13, VIRTUAL_WIDTH, 'left')
        drawLives(lives, heart)
    end
}


GameOverState = {

    load = function()
        displayScore = tostring(score)
    end,

    update = function(dt)
        if love.keyboard.wasPressed('return') then
            score = 0 -- reset score
            lives = 3 -- reset lives
            StateMachine:changeState(GetReadyState)
        end
    end,

    render = function()
        love.graphics.setFont(mediumFont)
        love.graphics.printf('Oof! Those cats are tough!', 0, 30, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Your score is: ' .. displayScore, 0, 100, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to play again', 0, VIRTUAL_HEIGHT - 70, VIRTUAL_WIDTH, 'center')
    end
}