local titleScreenButtons = {}

local selectedButton = 1
local buttonY = 100
local buttonMargin = 26


TitleScreenState = {

    load = function(__self, selection)
        titleScreenButtons = {}
        table.insert(titleScreenButtons, createButton(
            texts.newGame,
            function()
                StateMachine:changeState(GetReadyState)
            end
        ))
        table.insert(titleScreenButtons, createButton(
            texts.highScores,
            function()
                StateMachine:changeState(HighScoresState)
            end
        ))
        table.insert(titleScreenButtons, createButton(
            texts.options,
            function()
                StateMachine:changeState(OptionsState)
            end
        ))
        table.insert(titleScreenButtons, createButton(
            texts.exit,
            function()
                love.event.quit()
            end
        ))

        selectedButton = selection or 1
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
        love.graphics.printf('CATS INVADERS', 0, 20, RENDER_WIDTH, 'center')

        love.graphics.setFont(mediumFont)

        for index,button in ipairs(titleScreenButtons) do
            if index == selectedButton then
                love.graphics.setColor(WHITE)
            else
                love.graphics.setColor(GREEN)
            end
            love.graphics.printf(button.text, 0, buttonY + (buttonMargin * (index-1)), RENDER_WIDTH, 'center')
        end
        love.graphics.setColor(WHITE)
    end
}