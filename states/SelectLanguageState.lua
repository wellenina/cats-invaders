local languageButtons = {}

for index,language in ipairs(languages) do
	table.insert(languageButtons, createButton(
		language.name,
        function()
            gameData.language = index
            texts = languages[index]
            languageButtons[#languageButtons].text = texts.back
            saveGameData()
        end
    ))
end
table.insert(languageButtons, createButton(
    '',
    function()
        StateMachine:changeState(OptionsState, 2)
    end
))

local selectedButton = 1
local BUTTON_Y = 115
local BUTTON_MARGIN = 26


SelectLanguageState = {

    stateType = 'menu',

    load = function(__self, selection)
        selectedButton = gameData.language
        languageButtons[#languageButtons].text = texts.back
    end,

    update = function(dt)
        if love.keyboard.wasPressed('down') then
            selectedButton = selectedButton < #languageButtons and selectedButton + 1 or 1
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('up') then
            selectedButton = selectedButton > 1 and selectedButton - 1 or #languageButtons
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('return') then
            languageButtons[selectedButton].fn()
            sounds['menuSelect']:stop()
            sounds['menuEnter']:play()
        end
    end,

    render = function()
        drawTitle(texts.language)

        for index,button in ipairs(languageButtons) do
            if index == gameData.language then
                love.graphics.setColor(YELLOW)
                local width = mediumFont:getWidth(button.text) + 10
                love.graphics.rectangle('fill', (RENDER_WIDTH - width) * 0.5, BUTTON_Y - 3 + (BUTTON_MARGIN * (index-1)), width, mediumFont:getHeight() + 1)
            end
        end

        drawButtons(languageButtons, selectedButton, BUTTON_Y)
    end
}