local optionsButtons = {}
local selectedButton = 1

OptionsState = {

    stateType = 'menu',

    load = function(__self, selection)
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
                StateMachine:changeState(TitleScreenState, 2)
            end
        ))

        selectedButton = selection or 1

        arrows = love.graphics.newImage('images/arrows.png')
        leftArrow = love.graphics.newQuad(0, 0, 17, 19, 34, 19)
        rightArrow = love.graphics.newQuad(17, 0, 17, 19, 34, 19)
    end,

    update = function(dt)
        if love.keyboard.wasPressed('down') then
            selectedButton = selectedButton < #optionsButtons and selectedButton + 1 or 1
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('up') then
            selectedButton = selectedButton > 1 and selectedButton - 1 or #optionsButtons
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('return') then
            optionsButtons[selectedButton].fn()
            sounds['menuSelect']:stop()
            sounds['menuEnter']:play()
        end
    end,

    render = function()
        drawTitle(texts.options)
        drawButtons(optionsButtons, selectedButton, 93)
    end
}