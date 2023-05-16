local backBtn

CreditsState = {

    load = function()
        backBtn = createButton(
            texts.back,
            function()
                StateMachine:changeState(TitleScreenState, 4)
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
        drawTitle(texts.credits) -- height 28px

        love.graphics.setFont(smallFont)
        love.graphics.setColor(PURPLE)
        love.graphics.printf(texts.creditsContent, 0, 66, RENDER_WIDTH, 'center') -- height 61px

        drawTitle(texts.creditsThanks, smallFont, 145) -- height 7px

        love.graphics.setColor(PURPLE)
        love.graphics.printf(texts.creditsThanksContent, 0, 162, RENDER_WIDTH, 'center') -- height 20px

        love.graphics.setFont(mediumFont)
        love.graphics.setColor(WHITE)
        love.graphics.printf(backBtn.text, 0, 227, RENDER_WIDTH, 'center') -- height 14px
        Paw.render((RENDER_WIDTH - mediumFont:getWidth(backBtn.text)) * 0.5 - 20, 230)
    end
}