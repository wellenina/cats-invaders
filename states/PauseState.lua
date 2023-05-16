local pauseButtons = {}
local selectedButton = 1

PauseState = {
    load = function()
        pauseButtons = {}
        table.insert(pauseButtons, createButton(
            texts.resume,
            function()
                StateMachine:changeState(PlayState)
            end
        ))
        table.insert(pauseButtons, createButton(
            texts.abort,
            function()
                StateMachine:changeState(TitleScreenState)
            end
        ))
        table.insert(pauseButtons, createButton(
            texts.exit,
            function()
                love.event.quit()
            end
        ))

        selectedButton = 1
    end,

    update = function(__self, dt)
        if love.keyboard.wasPressed('down') then
            selectedButton = selectedButton < #pauseButtons and selectedButton + 1 or 1
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('up') then
            selectedButton = selectedButton > 1 and selectedButton - 1 or #pauseButtons
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('return') then
            pauseButtons[selectedButton].fn()
            sounds['menuSelect']:stop()
            sounds['menuEnter']:play()
        end
        Paw:updatePosition(dt)
    end,

    render = function()
        Bullets.render()
        Player.render()
        Invaders.render()
        Explosion.render()

        drawScoreAndLives(score, lives, heart)

        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle('fill', 0, 0, RENDER_WIDTH, RENDER_HEIGHT)

        love.graphics.setColor(WHITE)
        love.graphics.setLineWidth(4)
        love.graphics.rectangle('line', 70, 10, RENDER_WIDTH-140, RENDER_HEIGHT-70)

        drawTitle(texts.paused)
        drawButtons(pauseButtons, selectedButton)
    end
}