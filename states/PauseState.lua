local pauseButtons
local buttonsY = 110

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

        getButtonsCoordinates(pauseButtons, buttonsY)
    end,

    update = function(__self, dt)
        if next(touches) ~= nil then
            touchButton(pauseButtons)
        end
    end,

    render = function()
        Bullets.render()
        Player.render()
        Invaders.render()
        Explosion.render()

        drawScoreAndLives(score, lives, heart)

        drawOverlayBox()
        drawTitle(texts.paused, largeFont, 50)
        drawButtons(pauseButtons, buttonsY)
    end
}