local titleScreenButtons = {}
local selectedButton = 1

TitleScreenState = {

    stateType = 'menu',

    load = function(__self, selection)
        titleScreenButtons = {}
        table.insert(titleScreenButtons, createButton(
            texts.newGame,
            function()
                StateMachine:changeState(GetReadyState)
            end
        ))
        table.insert(titleScreenButtons, createButton(
            texts.options,
            function()
                StateMachine:changeState(OptionsState)
            end
        ))
        table.insert(titleScreenButtons, createButton(
            texts.highScores,
            function()
                StateMachine:changeState(HighScoresState)
            end
        ))
        table.insert(titleScreenButtons, createButton(
            texts.credits,
            function()
                StateMachine:changeState(CreditsState)
            end
        ))
        table.insert(titleScreenButtons, createButton(
            texts.exit,
            function()
                love.event.quit()
            end
        ))

        selectedButton = selection or 1

        TitleScreenAnimation:load()
    end,

    update = function(__self, dt)
        if love.keyboard.wasPressed('down') then 
            selectedButton = selectedButton < #titleScreenButtons and selectedButton + 1 or 1
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('up') then
            selectedButton = selectedButton > 1 and selectedButton - 1 or #titleScreenButtons
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('return') then
            titleScreenButtons[selectedButton].fn()
            sounds['menuSelect']:stop()
            sounds['menuEnter']:play()
        end
        TitleScreenAnimation:update(dt)
    end,

    render = function()
        drawTitle('CATS INVADERS', hugeFont)
        drawButtons(titleScreenButtons, selectedButton, 93)
        TitleScreenAnimation:render()
    end
}