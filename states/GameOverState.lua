local gameOverButtons
local buttonsY = 178
local comment = ''


GameOverState = {

    stateType = 'menu',

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
        getButtonsCoordinates(gameOverButtons, buttonsY)

        comment = texts.gameOverComment3

        for index,hScore in ipairs(gameData.highScores) do
            if score > hScore then
                table.insert(gameData.highScores, index, score)
                table.remove(gameData.highScores)
                comment = (index == 1) and texts.gameOverComment1 or texts.gameOverComment2
                break
            end
        end
        saveGameData()
    end,

    update = function(dt)
        if next(touches) ~= nil then
            touchButton(gameOverButtons)
        end
    end,

    render = function()
        drawTitle(texts.gameOver)

        love.graphics.setFont(mediumFont)
        love.graphics.setColor(PURPLE)
        love.graphics.printf(comment, 0, 80, RENDER_WIDTH, 'center')
        love.graphics.printf(texts.scoreIs .. tostring(score), 0, 132, RENDER_WIDTH, 'center')

        drawButtons(gameOverButtons, buttonsY)
    end
}