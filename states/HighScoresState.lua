local WIDTH = 140
local X = (RENDER_WIDTH - WIDTH) * 0.5
local Y = 68
local MARGIN = 22

local highScoresButtons = {}
local selectedButton = 1

HighScoresState = {

    stateType = 'menu',

    load = function()
        highScoresButtons = {}
        table.insert(highScoresButtons, createButton(
            texts.back,
            function()
                StateMachine:changeState(TitleScreenState, 3)
            end
        ))
        table.insert(highScoresButtons, createButton(
            texts.reset,
            function()
                StateMachine:changeState(ResetScoreState)
            end
        ))
        selectedButton = 1
    end,

    update = function(dt)
        if love.keyboard.wasPressed('down') then
            selectedButton = selectedButton < #highScoresButtons and selectedButton + 1 or 1
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('up') then
            selectedButton = selectedButton > 1 and selectedButton - 1 or #highScoresButtons
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('return') then
            highScoresButtons[selectedButton].fn()
            sounds['menuSelect']:stop()
            sounds['menuEnter']:play()
        end
    end,

    render = function()
        drawTitle(texts.highScores)

        love.graphics.setFont(mediumFont)
        love.graphics.setColor(PURPLE)
        for index,hScore in ipairs(gameData.highScores) do
            love.graphics.printf(index .. '. ', X, Y + (MARGIN * (index-1)), WIDTH, 'left')
            love.graphics.printf(hScore, X, Y + (MARGIN * (index-1)), WIDTH, 'right')
        end

        drawButtons(highScoresButtons, selectedButton, 189)
    end
}