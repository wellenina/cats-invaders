local optionsButtons
local buttonsY = 93

OptionsState = {

    stateType = 'menu',

    load = function(__self)
        optionsButtons = {}
        table.insert(optionsButtons, createButton(
            texts.sound[gameData.soundVolume],
            function()
                if gameData.soundVolume == 1 then
                    optionsButtons[1].text = texts.sound[0]
                    gameData.soundVolume = 0
                else
                    optionsButtons[1].text = texts.sound[1]
                    gameData.soundVolume = 1
                end
                saveGameData()
                love.audio.setVolume(gameData.soundVolume)
            end
        ))
        table.insert(optionsButtons, createButton(
            texts.language,
            function()
                StateMachine:changeState(SelectLanguageState)
            end
        ))
        table.insert(optionsButtons, createButton(
            texts.choosePlayer,
            function()
                StateMachine:changeState(ChoosePlayerState)
            end
        ))
        table.insert(optionsButtons, createButton(
            texts.chooseBullet,
            function()
                StateMachine:changeState(ChooseBulletState)
            end
        ))
        table.insert(optionsButtons, createButton(
            texts.back,
            function()
                StateMachine:changeState(TitleScreenState)
            end
        ))

        getButtonsCoordinates(optionsButtons, buttonsY)
    end,

    update = function(dt)
        if next(touches) ~= nil then
            touchButton(optionsButtons)
        end
    end,

    render = function()
        drawTitle(texts.options)
        drawButtons(optionsButtons, buttonsY)
    end
}