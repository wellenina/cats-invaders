local gameOverButtons = {}

local selectedButton = 1
local buttonY = 150
local buttonMargin = 26


GameOverState = {

    load = function()
        gameOverButtons = {}
        table.insert(gameOverButtons, createButton(
            texts.playAgain,
            function()
                StateMachine:changeState(GetReadyState)
            end
        ))
        table.insert(gameOverButtons, createButton(
            texts.menu,
            function()
                StateMachine:changeState(TitleScreenState)
            end
        ))

        selectedButton = 1

        for index,hScore in ipairs(gameData.highScores) do
            if score > hScore then
                table.insert(gameData.highScores, index, score)
                table.remove(gameData.highScores)
                break
            end
        end
        saveGameData()
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
        drawTitle(texts.gameOver)

        love.graphics.setFont(mediumFont)
        love.graphics.printf(texts.gameOverComment, 0, 80, RENDER_WIDTH, 'center')

        love.graphics.setColor(PURPLE)
        love.graphics.printf(texts.scoreIs .. tostring(score), 0, 110, RENDER_WIDTH, 'center')

        drawButtons(gameOverButtons, selectedButton, 150)
    end
}