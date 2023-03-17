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

local selectedButton = gameData.language
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
            if index == gameData.language then
                love.graphics.setColor(YELLOW)
                local width = mediumFont:getWidth(button.text) + 10
                love.graphics.rectangle('fill', (VIRTUAL_WIDTH - width) * 0.5, buttonY - 3 + (buttonMargin * (index-1)), width, mediumFont:getHeight() + 1)
            end

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