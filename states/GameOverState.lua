local gameOverButtons = {}

local selectedButton = 1
local buttonY = 150
local buttonMargin = 26

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

        selectedButton = 1
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
        if love.keyboard.wasPressed('down') then
            selectedButton = selectedButton < #gameOverButtons and selectedButton + 1 or 1
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('up') then
            selectedButton = selectedButton > 1 and selectedButton - 1 or #gameOverButtons
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('return') then
            gameOverButtons[selectedButton].fn()
            sounds['menuSelect']:stop()
            sounds['menuEnter']:play()
        end
    end,

    render = function()
        drawTitle(texts.gameOver)

        love.graphics.setFont(mediumFont)
        love.graphics.setColor(PURPLE)
        love.graphics.printf(comment, 0, 80, RENDER_WIDTH, 'center')
        love.graphics.printf(texts.scoreIs .. tostring(score), 0, 110, RENDER_WIDTH, 'center')

        drawButtons(gameOverButtons, selectedButton, 150)
    end
}