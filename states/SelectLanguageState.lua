local languageButtons = {}
local BUTTON_Y = 115
local BUTTON_MARGIN = 26

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
        StateMachine:changeState(OptionsState)
    end
))


SelectLanguageState = {

    stateType = 'menu',

    load = function(__self)
        languageButtons[#languageButtons].text = texts.back
        getButtonsCoordinates(languageButtons, BUTTON_Y)
    end,

    update = function(dt)
        if next(touches) ~= nil then
            touchButton(languageButtons)
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

        drawButtons(languageButtons, BUTTON_Y)
    end
}