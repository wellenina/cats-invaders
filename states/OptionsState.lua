local soundVolume = 1

local optionsButtons = {}

table.insert(optionsButtons, createButton(
    'Sound is on',
    function()
        if soundVolume == 1 then
            optionsButtons[1].text = 'Sound is off'
            soundVolume = 0
        else
            optionsButtons[1].text = 'Sound is on'
            soundVolume = 1
        end

        love.audio.setVolume(soundVolume)
    end
))
table.insert(optionsButtons, createButton(
    'Choose your character',
    function()
        print('Choose your character')
        --StateMachine:changeState( )
    end
))
table.insert(optionsButtons, createButton(
    'Choose your weapon',
    function()
        print('Choose your weapon')
        --StateMachine:changeState( )
    end
))
table.insert(optionsButtons, createButton(
    'Back',
    function()
        StateMachine:changeState(TitleScreenState)
    end
))

local selectedButton = 1
local buttonY = 100
local buttonMargin = 26


OptionsState = {

    load = function()
        selectedButton = 1
    end,

    update = function(dt)
        if love.keyboard.wasPressed('down') then
            selectedButton = selectedButton < #optionsButtons and selectedButton + 1 or 1
        end

        if love.keyboard.wasPressed('up') then
            selectedButton = selectedButton > 1 and selectedButton - 1 or #optionsButtons
        end

        if love.keyboard.wasPressed('return') then
            optionsButtons[selectedButton].fn()
        end
    end,

    render = function()
        love.graphics.setFont(largeFont)
        love.graphics.setColor(GREEN)
        love.graphics.printf('Options', 0, 20, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(mediumFont)

        for index,button in ipairs(optionsButtons) do
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