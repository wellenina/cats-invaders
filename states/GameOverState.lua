local gameOverButtons = {}

table.insert(gameOverButtons, createButton(
    'Play again',
    function()
        StateMachine:changeState(GetReadyState)
    end
))
table.insert(gameOverButtons, createButton(
    'Menu',
    function()
        StateMachine:changeState(TitleScreenState)
    end
))

local selectedButton = 1
local buttonY = 150
local buttonMargin = 26


GameOverState = {

    load = function()
        selectedButton = 1
    end,

    update = function(dt)
        if love.keyboard.wasPressed('down') then
            selectedButton = selectedButton < #gameOverButtons and selectedButton + 1 or 1
        end

        if love.keyboard.wasPressed('up') then
            selectedButton = selectedButton > 1 and selectedButton - 1 or #gameOverButtons
        end

        if love.keyboard.wasPressed('return') then
            gameOverButtons[selectedButton].fn()
        end
    end,

    render = function()
        love.graphics.setFont(largeFont)
        love.graphics.setColor(GREEN)
        love.graphics.printf('GAME OVER', 0, 20, VIRTUAL_WIDTH, 'center')


        love.graphics.setFont(mediumFont)
        love.graphics.printf('Oof! Those cats are tough!', 0, 80, VIRTUAL_WIDTH, 'center')

        love.graphics.setColor(PURPLE)
        love.graphics.printf('Your score is ' .. tostring(score), 0, 110, VIRTUAL_WIDTH, 'center')

        for index,button in ipairs(gameOverButtons) do
            if index == selectedButton then
                love.graphics.setColor(WHITE)
            else
                love.graphics.setColor(GREEN)
            end
            love.graphics.printf(button.text, 0, buttonY + (buttonMargin * (index-1)), VIRTUAL_WIDTH, 'center')
        end
        love.graphics.setColor(WHITE)
    end
}