StateMachine = {}

StateMachine.currentState = {}

function StateMachine:changeState(newState)
    self.currentState = newState
    self.currentState:load()
end

function StateMachine:load()
    self.currentState:load()
end

function StateMachine:update(dt)
    self.currentState:update(dt)
end

function StateMachine:render()
    self.currentState:render()
end



TitleScreenState = {
    load = function()
    end,

    update = function(dt)
        if love.keyboard.wasPressed('return') then
            StateMachine:changeState(CountDownState)
        end
    end,

    render = function()
        love.graphics.setFont(hugeFont)
        love.graphics.printf('CATS INVADERS', 20, 20, VIRTUAL_WIDTH, center)

        love.graphics.setFont(mediumFont)
        love.graphics.printf('Press Enter to play', 100, VIRTUAL_HEIGHT * 0.5, VIRTUAL_WIDTH, center)
    end
}

CountDownState = {
    load = function()
        Player:load()
        Invaders:load()
        Bullets.load()
        Explosion.load()

        totalTime = 3 -- seconds
        timePassed = 0
    end,

    update = function(__self, dt)
        timePassed = timePassed + dt
        if timePassed >= totalTime then
            StateMachine:changeState(PlayState)
            timePassed = 0
        end
    end,

    render = function()
        Player.render()
        Invaders.render()
        -- SCORE AND LIVES:
        love.graphics.setFont(smallFont)
        love.graphics.printf('SCORE: 0', 20, VIRTUAL_HEIGHT - 13, VIRTUAL_WIDTH, left)
        love.graphics.printf('LIVES: 3', 350, VIRTUAL_HEIGHT - 13, VIRTUAL_WIDTH, left)
    end
}

PlayState = {

    load = function()
        score = 0
        lives = 3
    end,

    update = function(__self, dt)
        Player:update(dt)
        Invaders:update(dt)
        Bullets:update(dt) -- aggiungere funzione che aumenta il punteggio, verifica se ci sono vite, se è game over CAMBIA STATO
        Explosion.update(dt)
    end,

    render = function()
        Player.render()
        Invaders.render()
        Bullets.render()
        Explosion.render()

        love.graphics.printf('SCORE: ' .. tostring(score), 20, VIRTUAL_HEIGHT - 13, VIRTUAL_WIDTH, left)
        love.graphics.printf('LIVES: 3', 350, VIRTUAL_HEIGHT - 13, VIRTUAL_WIDTH, left)
    end
}