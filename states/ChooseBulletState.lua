local chooseButtons
local buttonsY = 197

local bulletSelected
local bulletOnScreen


ChooseBulletState = {

    stateType = 'menu', 

    load = function()
        bulletSelected = gameData.selectedBullet
        bulletOnScreen = bulletSelected

        chooseButtons = {}

        table.insert(chooseButtons, createButton(
            texts.select,
            function()
                bulletSelected = bulletOnScreen
            end
        ))
        table.insert(chooseButtons, createButton(
            texts.back,
            function()
                gameData.selectedBullet = bulletSelected
                saveGameData()
                StateMachine:changeState(OptionsState)
            end
        ))

        getButtonsCoordinates(chooseButtons, buttonsY)
    end,

    update = function(dt)
        if next(touches) ~= nil then
            if isTouched(307, 100, 32, 30) then --right arrow
                bulletOnScreen = bulletOnScreen == #playerBulletQuads and 1 or bulletOnScreen + 1
                sounds['menuSelect']:stop()
                sounds['menuSelect']:play()
            elseif isTouched(142, 100, 32, 30) then --left arrow
                bulletOnScreen = bulletOnScreen == 1 and #playerBulletQuads or bulletOnScreen - 1
                sounds['menuSelect']:stop()
                sounds['menuSelect']:play()
            else
                touchButton(chooseButtons)
            end
        end
    end,

    render = function()
        drawTitle(texts.chooseBulletTitle)

        love.graphics.setColor(95/255, 85/255, 106/255) -- background
        love.graphics.rectangle('fill', (RENDER_WIDTH-84) * 0.5, 73, 84, 84)

        love.graphics.setLineWidth(3)
        love.graphics.setColor(bulletOnScreen == bulletSelected and BRIGHT_YELLOW or SOFT_WHITE) -- outer line
        love.graphics.rectangle('line', (RENDER_WIDTH-90) * 0.5, 70, 90, 90)
    
        love.graphics.setColor(bulletOnScreen == bulletSelected and YELLOW or GREY) -- inner line
        love.graphics.rectangle('line', (RENDER_WIDTH-84) * 0.5, 73, 84, 84)

        love.graphics.setColor(SOFT_WHITE)
        love.graphics.draw(arrows, leftArrow, 145, 101, 0, 1.5, 1.5)
        love.graphics.draw(arrows, rightArrow, 310, 101, 0, 1.5, 1.5)

        love.graphics.setFont(smallFont)
        love.graphics.setColor(PURPLE)
        love.graphics.printf(texts.bulletsNames[bulletOnScreen], 0, 170, RENDER_WIDTH, 'center')

        drawButtons(chooseButtons, buttonsY)
        love.graphics.draw(playerBulletSprite, playerBulletQuads[bulletOnScreen], (RENDER_WIDTH-40) * 0.5, 95, 0, 5, 5)
    end
}