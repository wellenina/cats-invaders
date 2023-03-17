local languageButtons = {}

table.insert(languageButtons, createButton(
    'English',
    function()
        gameData.language = 'ENG'
        texts = languages[gameData.language]
        languageButtons[#languageButtons].text = texts.back
        saveGameData()
    end
))
table.insert(languageButtons, createButton(
    'Italiano',
    function()
        gameData.language = 'ITA'
        texts = languages[gameData.language]
        languageButtons[#languageButtons].text = texts.back
        saveGameData()
    end
))
--[[table.insert(languageButtons, createButton(
    '日本',
    function()
        
    end
))]]
table.insert(languageButtons, createButton(
    '',
    function()
        StateMachine:changeState(OptionsState, 2)
    end
))

local selectedButton = 1
-- local currentLanguage = 
local buttonY = 100
local buttonMargin = 26


SelectLanguageState = {

    load = function(__self, selection)
        languageButtons[#languageButtons].text = texts.back
    end,

    update = function(dt)
        if love.keyboard.wasPressed('down') then
            selectedButton = selectedButton < #languageButtons and selectedButton + 1 or 1
        end

        if love.keyboard.wasPressed('up') then
            selectedButton = selectedButton > 1 and selectedButton - 1 or #languageButtons
        end

        if love.keyboard.wasPressed('return') then
            languageButtons[selectedButton].fn()
        end
    end,

    render = function()
        love.graphics.setFont(largeFont)
        love.graphics.setColor(GREEN)
        love.graphics.printf(texts.language, 0, 20, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(mediumFont)

        for index,button in ipairs(languageButtons) do
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