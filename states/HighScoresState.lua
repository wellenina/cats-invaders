local width = 140
local x = (RENDER_WIDTH - width) * 0.5
local y = 70
local margin = 24

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
            love.graphics.printf(index .. '. ', x, y + (margin * (index-1)), width, 'left')
            love.graphics.printf(hScore, x, y + (margin * (index-1)), width, 'right')
        end

        drawButtons(highScoresButtons, selectedButton, 200)
    end
}