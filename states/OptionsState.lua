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
    'Choose your fighter',
    function()
        StateMachine:changeState(ChoosePlayerState)
    end
))
table.insert(optionsButtons, createButton(
    'Choose your weapon',
    function()
        StateMachine:changeState(ChooseBulletState)
    end
))
table.insert(optionsButtons, createButton(
    'Back',
    function()
        StateMachine:changeState(TitleScreenState, 3)
    end
))

local selectedButton = 1
local buttonY = 100
local buttonMargin = 26

keysQuads = {}
for i = 1, 3, 1 do
    table.insert(keysQuads, love.graphics.newQuad(37 * (i-1), 0, 37, 21, 111, 21))
end
keysExplanationTexts = {'select', 'confirm', 'go back'}


OptionsState = {

    load = function(__self, selection)
        selectedButton = selection or 1
        keysSprite = love.graphics.newImage('images/keys.png')
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