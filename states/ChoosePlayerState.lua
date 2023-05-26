local chooseButtons
local buttonsY = 197

local playerSelected
local playerOnScreen


ChoosePlayerState = {

    stateType = 'menu', 

    load = function()
        playerSelected = gameData.selectedPlayer
        playerOnScreen = playerSelected

        chooseButtons = {}

        table.insert(chooseButtons, createButton(
            texts.select,
            function()
                playerSelected = playerOnScreen
            end
        ))
        table.insert(chooseButtons, createButton(
            texts.back,
            function()
                gameData.selectedPlayer = playerSelected
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
        drawTitle(texts.choosePlayerTitle)

        love.graphics.setColor(95/255, 85/255, 106/255) -- background
        love.graphics.rectangle('fill', (RENDER_WIDTH-84) * 0.5, 73, 84, 84)

        love.graphics.setLineWidth(3)
        love.graphics.setColor(playerOnScreen == playerSelected and BRIGHT_YELLOW or SOFT_WHITE) -- outer line
        love.graphics.rectangle('line', (RENDER_WIDTH-90) * 0.5, 70, 90, 90)
    
        love.graphics.setColor(playerOnScreen == playerSelected and YELLOW or GREY) -- inner line
        love.graphics.rectangle('line', (RENDER_WIDTH-84) * 0.5, 73, 84, 84)

        love.graphics.setColor(SOFT_WHITE)
        love.graphics.draw(arrows, leftArrow, 145, 101, 0, 1.5, 1.5)
        love.graphics.draw(arrows, rightArrow, 310, 101, 0, 1.5, 1.5)

        love.graphics.setFont(smallFont)
        love.graphics.setColor(PURPLE)
        love.graphics.printf(texts.playersNames[playerOnScreen], 0, 170, RENDER_WIDTH, 'center')

        drawButtons(chooseButtons, buttonsY)
        love.graphics.draw(playersSprite, playersQuads[playerOnScreen][1], (RENDER_WIDTH-64) * 0.5, 88, 0, 2, 2)
    end
}