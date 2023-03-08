local pauseButtons = {}

table.insert(pauseButtons, createButton(
    'Resume',
    function()
        StateMachine:changeState(PlayState)
    end
))
table.insert(pauseButtons, createButton(
    'Abort mission',
    function()
        StateMachine:changeState(TitleScreenState)
    end
))
table.insert(pauseButtons, createButton(
    'Exit',
    function()
        love.event.quit()
    end
))

local selectedButton = 1
local buttonY = 100
local buttonMargin = 26

PauseState = {
    load = function()
        selectedButton = 1
    end,

    update = function(dt)
        if love.keyboard.wasPressed('down') then
            selectedButton = selectedButton < #pauseButtons and selectedButton + 1 or 1
        end

        if love.keyboard.wasPressed('up') then
            selectedButton = selectedButton > 1 and selectedButton - 1 or #pauseButtons
        end

        if love.keyboard.wasPressed('return') then
            pauseButtons[selectedButton].fn()
        end
    end,

    render = function()
        Bullets.render()
        Player.render()
        Invaders.render()
        Explosion.render()

        drawScoreAndLives(score, lives, heart)

        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

        love.graphics.setColor(WHITE)
        love.graphics.setLineWidth(4)
        love.graphics.rectangle('line', 70, 10, VIRTUAL_WIDTH-140, VIRTUAL_HEIGHT-70)

        love.graphics.setFont(largeFont)
        love.graphics.setColor(GREEN)
        love.graphics.printf('Paused', 0, 20, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(mediumFont)

        for index,button in ipairs(pauseButtons) do
            if index == selectedButton then
                love.graphics.setColor(WHITE)
            else
                love.graphics.setColor(GREEN)
            end
            love.graphics.printf(button.text, 0, buttonY + (buttonMargin * (index-1)), VIRTUAL_WIDTH, 'center')
        end
        love.graphics.setColor(WHITE)
    end
}