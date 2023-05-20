local chooseButtons
local selectedButton

local bulletSelected
local bulletOnScreen


ChooseBulletState = {

    stateType = 'menu', 

    load = function()
        bulletSelected = gameData.selectedBullet
        bulletOnScreen = bulletSelected

        chooseButtons = {}
        selectedButton = 1

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
                StateMachine:changeState(OptionsState, 4)
            end
        ))

    end,

    update = function(dt)
        if love.keyboard.wasPressed('right') then
            bulletOnScreen = bulletOnScreen == #playerBulletQuads and 1 or bulletOnScreen + 1
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end
        if love.keyboard.wasPressed('left') then
            bulletOnScreen = bulletOnScreen == 1 and #playerBulletQuads or bulletOnScreen - 1
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('down') then
            selectedButton = selectedButton < #chooseButtons and selectedButton + 1 or 1
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end
        if love.keyboard.wasPressed('up') then
            selectedButton = selectedButton > 1 and selectedButton - 1 or #chooseButtons
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('return') then
            chooseButtons[selectedButton].fn()
            sounds['menuSelect']:stop()
            sounds['menuEnter']:play()
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

        drawButtons(chooseButtons, selectedButton, 200)
        love.graphics.draw(playerBulletSprite, playerBulletQuads[bulletOnScreen], (RENDER_WIDTH-40) * 0.5, 94, 0, 5, 5)
    end
}