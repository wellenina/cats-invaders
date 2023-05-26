local WIDTH = 140
local X = (RENDER_WIDTH - WIDTH) * 0.5
local Y = 68
local MARGIN = 22

local resetButtons
local resetButtonsY = 150

ResetScoreState = {

    stateType = 'menu',
    
    load = function()
        resetButtons = {}
        table.insert(resetButtons, createButton(
            texts.resetConfirmYes,
            function()
                gameData.highScores = {0, 0, 0, 0, 0}
                saveGameData()
                StateMachine:changeState(HighScoresState)
            end
        ))
        table.insert(resetButtons, createButton(
            texts.resetConfirmNo,
            function()
                StateMachine:changeState(HighScoresState)
            end
        ))

        getButtonsCoordinates(resetButtons, resetButtonsY)
    end,

    update = function(dt)
        if next(touches) ~= nil then
            touchButton(resetButtons)
        end
    end,

    render = function()
        love.graphics.setFont(mediumFont)
        love.graphics.setColor(PURPLE)
        for index,hScore in ipairs(gameData.highScores) do
            love.graphics.printf(index .. '. ', X, Y + (MARGIN * (index-1)), WIDTH, 'left')
            love.graphics.printf(hScore, X, Y + (MARGIN * (index-1)), WIDTH, 'right')
        end

        drawOverlayBox()
        drawTitle(texts.resetConfirmTitle, largeFont, 50)
        drawButtons(resetButtons, resetButtonsY)
    end
}