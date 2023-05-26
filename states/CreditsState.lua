local creditButtons
local buttonY = 219

CreditsState = {

    stateType = 'info',

    load = function()

        creditButtons = {}
        table.insert(creditButtons, createButton(
            texts.back,
            function()
                StateMachine:changeState(TitleScreenState)
            end
        ))

        getButtonsCoordinates(creditButtons, buttonY)

    end,

    update = function(__self, dt)
        if next(touches) ~= nil then
            touchButton(creditButtons)
        end
    end,

    render = function()
        drawTitle(texts.credits)

        love.graphics.setFont(smallFont)
        love.graphics.setColor(PURPLE)
        love.graphics.printf(texts.creditsContent, 0, 66, RENDER_WIDTH, 'center')

        love.graphics.setColor(GREEN)
        love.graphics.printf(texts.creditsThanks, 0, 149, RENDER_WIDTH, 'center')

        love.graphics.setColor(PURPLE)
        love.graphics.printf(texts.creditsThanksContent, 0, 165, RENDER_WIDTH, 'center')

        love.graphics.setColor(GREEN)
        love.graphics.printf(texts.creditsDisclaimer, 0, 194, RENDER_WIDTH, 'center')

        drawButtons(creditButtons, buttonY)
    end
}