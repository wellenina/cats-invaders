local backBtn

CreditsState = {

    stateType = 'info',

    load = function()
        backBtn = createButton(
            texts.back,
            function()
                StateMachine:changeState(TitleScreenState, 4)
            end
        )
    end,

    update = function(__self, dt)
        if love.keyboard.wasPressed('return') then
            sounds['menuEnter']:play()
            backBtn.fn()
        end
        Paw:updatePosition(dt)
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

        love.graphics.setFont(mediumFont)
        love.graphics.setColor(SOFT_WHITE)
        love.graphics.printf(backBtn.text, 0, 219, RENDER_WIDTH, 'center')
        Paw.render((RENDER_WIDTH - mediumFont:getWidth(backBtn.text)) * 0.5 - 25, 222)
        love.graphics.setColor(WHITE)
    end
}