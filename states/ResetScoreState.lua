local width = 140
local x = (RENDER_WIDTH - width) * 0.5
local y = 70
local margin = 24

local resetButtons = {}
local selectedButton = 2

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
        selectedButton = 2
    end,

    update = function(dt)
        if love.keyboard.wasPressed('down') then
            selectedButton = selectedButton < #resetButtons and selectedButton + 1 or 1
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('up') then
            selectedButton = selectedButton > 1 and selectedButton - 1 or #resetButtons
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('return') then
            resetButtons[selectedButton].fn()
            sounds['menuSelect']:stop()
            sounds['menuEnter']:play()
        end
    end,

    render = function()
        love.graphics.setFont(mediumFont)
        love.graphics.setColor(PURPLE)
        for index,hScore in ipairs(gameData.highScores) do
            love.graphics.printf(index .. '. ', x, y + (margin * (index-1)), width, 'left')
            love.graphics.printf(hScore, x, y + (margin * (index-1)), width, 'right')
        end

        drawOverlayBox()
        drawTitle(texts.resetConfirmTitle, largeFont, 50)
        drawButtons(resetButtons, selectedButton, 150)
    end
}