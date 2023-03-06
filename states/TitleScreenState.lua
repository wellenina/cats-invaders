TitleScreenState = {

    load = function()

        titleScreenButtons = {}

        table.insert(titleScreenButtons, createButton(
            'New Game',
            function()
                StateMachine:changeState(GetReadyState)
            end
        ))

        table.insert(titleScreenButtons, createButton(
            'High Scores',
            function()
                print('high scores button')
                --StateMachine:changeState(HighScoresState)
            end
        ))

        table.insert(titleScreenButtons, createButton(
            'Options',
            function()
                print('options button')
                --StateMachine:changeState(OptionsState)
            end
        ))

        table.insert(titleScreenButtons, createButton(
            'Exit',
            function()
                love.event.quit()
            end
        ))

        selectedButton = 1

        
    end,

    update = function(dt)
        if love.keyboard.wasPressed('down') then
            selectedButton = selectedButton < #titleScreenButtons and selectedButton + 1 or 1
        end

        if love.keyboard.wasPressed('up') then
            selectedButton = selectedButton > 1 and selectedButton - 1 or #titleScreenButtons
        end

        if love.keyboard.wasPressed('return') then
            titleScreenButtons[selectedButton].fn()
        end
    end,

    render = function()
        love.graphics.setFont(hugeFont)
        love.graphics.setColor(GREEN)
        love.graphics.printf('CATS INVADERS', 0, 20, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(mediumFont)
        buttonY = 100
        buttonMargin = 26

        for index,button in ipairs(titleScreenButtons) do
            if index == selectedButton then
                love.graphics.setColor(WHITE)
            else
                love.graphics.setColor(GREEN)
            end
            love.graphics.printf(button.text, 0, buttonY, VIRTUAL_WIDTH, 'center')
            buttonY = buttonY + buttonMargin
        end
        love.graphics.setColor(WHITE)
    end
}