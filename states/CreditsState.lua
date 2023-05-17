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
        drawTitle(texts.credits) -- height 28px

        love.graphics.setFont(smallFont)
        love.graphics.setColor(PURPLE)
        love.graphics.printf(texts.creditsContent, 0, 66, RENDER_WIDTH, 'center') -- height 61px

        drawTitle(texts.creditsThanks, smallFont, 152) -- height 7px

        love.graphics.setColor(PURPLE)
        love.graphics.printf(texts.creditsThanksContent, 0, 169, RENDER_WIDTH, 'center') -- height 20px

        love.graphics.setFont(mediumFont)
        love.graphics.setColor(SOFT_WHITE)
        love.graphics.printf(backBtn.text, 0, 227, RENDER_WIDTH, 'center') -- height 14px
        Paw.render((RENDER_WIDTH - mediumFont:getWidth(backBtn.text)) * 0.5 - 25, 230)
        love.graphics.setColor(WHITE)
    end
}