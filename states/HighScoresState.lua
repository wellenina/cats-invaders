local width = 140
local x = (RENDER_WIDTH - width) * 0.5
local y = 70
local margin = 24

local backBtn


HighScoresState = {

    load = function()
        backBtn = createButton(
            texts.back,
            function()
                StateMachine:changeState(TitleScreenState, 2)
            end
        )
    end,

    update = function(dt)
        if love.keyboard.wasPressed('return') then
            backBtn.fn()
        end
    end,

    render = function()
        love.graphics.setFont(largeFont)
        love.graphics.setColor(GREEN)
        love.graphics.printf(texts.highScores, 0, 20, RENDER_WIDTH, 'center')

        love.graphics.setFont(mediumFont)
        love.graphics.setColor(PURPLE)
        for index,hScore in ipairs(gameData.highScores) do
            love.graphics.printf(index .. '. ', x, y + (margin * (index-1)), width, 'left')
            love.graphics.printf(hScore, x, y + (margin * (index-1)), width, 'right')
        end

        love.graphics.setColor(WHITE)
        love.graphics.printf(backBtn.text, 0, 200, RENDER_WIDTH, 'center')
    end
}