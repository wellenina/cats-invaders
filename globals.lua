RENDER_WIDTH = 480
RENDER_HEIGHT = 270

WHITE = {1, 1, 1}
SOFT_WHITE = {242/255, 240/255, 229/255}
GREY = {184/255, 181/255, 185/255}
GREEN = {193/255, 211/255, 104/255}
PURPLE = {207/255, 138/255, 204/255}
YELLOW = {211/255, 159/255, 104/255}
BRIGHT_YELLOW = {237/255, 225/255, 158/255}
BACKGROUND_COLOR = {58/255, 56/255, 88/255}


gameData = {
    selectedPlayer = 1,
    selectedBullet = 1,
    soundVolume = 1,
    language = 1,
    highScores = {0, 0, 0, 0, 0}
}

texts = {}

function loadGameData()
	if not love.filesystem.getInfo('gameData.txt') then
		saveGameData()
        texts = languages[gameData.language]
		return
	end
    local savedData = love.filesystem.load('gameData.txt')
    gameData = savedData()
    love.audio.setVolume(gameData.soundVolume)
    texts = languages[gameData.language]
end

function saveGameData()
    local str = 'return ' .. tableToString(gameData)
    local file = love.filesystem.newFile('gameData.txt')
	file:open('w')
    file:write(str)
	file:close()
end

function tableToString(tabl)
    local str = '{ '
    for k,v in pairs(tabl) do
        if type(k) == 'number' then
            str = str .. '[' .. k .. ']'
        else
            str = str .. k
        end
        str = str .. ' = '
        if type(v) == 'table' then
            str = str .. tableToString(v) .. ', '
        elseif type(v) == 'string' then
            str = str .. '"' .. v .. '", '
        else
            str = str .. v .. ', '
        end
    end
    str = str .. '}'
    return str
end


function drawTitle(title, font, y)
    local newFont = font or largeFont
    local titleY = y or 20
    love.graphics.setFont(newFont)
    love.graphics.setColor(GREEN)
    love.graphics.printf(title, 0, titleY, RENDER_WIDTH, 'center')
end

function createButton(text, fn)
    return {
        text = text,
        fn = fn,
    }
end

function drawButtons(buttons, y)
    local buttonMargin = 26
    love.graphics.setFont(mediumFont)
    love.graphics.setColor(GREEN)
    for index,button in ipairs(buttons) do
        love.graphics.printf(button.text, 0, y + (buttonMargin * (index-1)), RENDER_WIDTH, 'center')
    end
    love.graphics.setColor(WHITE)
end

function drawScoreAndLives(score, livesNum, img)
    love.graphics.setColor(SOFT_WHITE)
    love.graphics.setFont(smallFont)
    local y = RENDER_HEIGHT - 13
    love.graphics.printf(texts.score .. '  ' .. tostring(score), 20, y, RENDER_WIDTH, 'left')
    love.graphics.printf(texts.lives, RENDER_WIDTH-48, y, RENDER_WIDTH, 'left')
    local margin = 65
    for i = 1, livesNum, 1 do
        love.graphics.draw(img, RENDER_WIDTH - margin, y)
        margin = margin + 15
    end
    love.graphics.setColor(WHITE)
end

function drawOverlayBox()
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle('fill', -15, -15, RENDER_WIDTH + 30, RENDER_HEIGHT + 30)

    love.graphics.setColor(SOFT_WHITE)
    love.graphics.setLineWidth(3)
    love.graphics.rectangle('line', 45, 24, RENDER_WIDTH-90, RENDER_HEIGHT-64)

    love.graphics.setColor(GREY)
    love.graphics.rectangle('line', 48, 27, RENDER_WIDTH-96, RENDER_HEIGHT-70)
end

-- for mobile devices

function isTouched(elementX, elementY, width, height)
	for index, id in ipairs(touches) do
		local touchX, touchY = love.touch.getPosition(id)
		if touchX >= elementX and touchX <= elementX + width
			and touchY >= elementY and touchY <= elementY + height then
				return true
		end
	end
	return false
end

function getButtonsCoordinates(buttons, buttonsY)
	for index,button in ipairs(buttons) do
		button.width = mediumFont:getWidth(button.text) + 12
		button.height = 26
		button.x = (RENDER_WIDTH - button.width) * 0.5
		button.y = buttonsY - 6 + (26 * (index-1))
	end
end

function touchButton(buttons)
	for index,button in ipairs(buttons) do
		if isTouched(button.x, button.y, button.width, button.height) then
			botton.fn()
			sounds['menuEnter']:play()
			break
		end
	end
end

function drawUI()

    -- testing the touch areas for mobile
--    love.graphics.setColor(PURPLE)
    --pausa:
--    love.graphics.rectangle('fill', 0, 0, 60, 58)
    --left:
--    love.graphics.rectangle('fill', 0, 70, 100, 180)
    --right:
--    love.graphics.rectangle('fill', 380, 70, 100, 180)
    --shoot:
--    love.graphics.rectangle('fill', 115, 210, 250, 60)


    love.graphics.setColor(GREEN)

    love.graphics.draw(pauseButton, 20, 20)

    love.graphics.draw(arrows, leftArrow, 20, 192, 0, 1.5, 1.5)
    love.graphics.draw(arrows, rightArrow, 433, 192, 0, 1.5, 1.5)

    love.graphics.setFont(smallFont)
    love.graphics.printf(texts.shoot, 0, 257, RENDER_WIDTH, 'center')

    love.graphics.setColor(WHITE)
end