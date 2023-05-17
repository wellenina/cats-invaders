local pauseButtons = {}
local selectedButton = 1

PauseState = {

    stateType = 'play',

    load = function()
        pauseButtons = {}
        table.insert(pauseButtons, createButton(
            texts.resume,
            function()
                StateMachine:changeState(PlayState)
            end
        ))
        table.insert(pauseButtons, createButton(
            texts.sound[gameData.soundVolume],
            function()
                if gameData.soundVolume == 1 then
                    pauseButtons[2].text = texts.sound[0]
                    gameData.soundVolume = 0
                else
                    pauseButtons[2].text = texts.sound[1]
                    gameData.soundVolume = 1
                end
                saveGameData()
                love.audio.setVolume(gameData.soundVolume)
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

        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle('fill', -15, -15, RENDER_WIDTH + 30, RENDER_HEIGHT + 30)

        love.graphics.setColor(SOFT_WHITE)
        love.graphics.setLineWidth(5)
        love.graphics.rectangle('line', 45, 24, RENDER_WIDTH-90, RENDER_HEIGHT-64)

        drawTitle(texts.paused, largeFont, 50)
        drawButtons(pauseButtons, selectedButton, 110)
    end
}