local WIDTH = 140
local X = (RENDER_WIDTH - WIDTH) * 0.5
local Y = 68
local MARGIN = 22

local highScoresButtons
local buttonsY = 189


HighScoresState = {

    stateType = 'menu',

    load = function()
        highScoresButtons = {}
        table.insert(highScoresButtons, createButton(
            texts.back,
            function()
                StateMachine:changeState(TitleScreenState)
            end
        ))
        table.insert(highScoresButtons, createButton(
            texts.reset,
            function()
                StateMachine:changeState(ResetScoreState)
            end
        ))
        getButtonsCoordinates(highScoresButtons, buttonsY)
    end,

    update = function(dt)
        if next(touches) ~= nil then
            touchButton(highScoresButtons)
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

        drawButtons(highScoresButtons, buttonsY)
    end
}