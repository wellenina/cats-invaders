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
                StateMachine:changeState(TitleScreenState, 3)
            end
        )
    end,

    update = function(__self, dt)
        Paw:updatePosition(dt)
        if love.keyboard.wasPressed('return') then
            sounds['menuEnter']:play()
            backBtn.fn()
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

        love.graphics.setColor(WHITE)
        love.graphics.printf(backBtn.text, 0, 200, RENDER_WIDTH, 'center')
        Paw.render((RENDER_WIDTH - mediumFont:getWidth(backBtn.text)) * 0.5 - 20, 200 + 6)
    end
}