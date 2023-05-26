local titleScreenButtons
local buttonsY = 93

TitleScreenState = {

    stateType = 'menu',

    load = function(__self)
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

        getButtonsCoordinates(titleScreenButtons, buttonsY)

        TitleScreenAnimation:load()
    end,

    update = function(__self, dt)
        if next(touches) ~= nil then
            touchButton(titleScreenButtons)
        end

        TitleScreenAnimation:update(dt)
    end,

    render = function()
        drawTitle('CATS INVADERS', hugeFont)
        drawButtons(titleScreenButtons, buttonsY)
        TitleScreenAnimation:render()
    end
}