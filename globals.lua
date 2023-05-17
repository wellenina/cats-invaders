RENDER_WIDTH = 480
RENDER_HEIGHT = 270

WHITE = {1, 1, 1}
SOFT_WHITE = {242/255, 240/255, 229/255}
GREEN = {193/255, 211/255, 104/255}
PURPLE = {207/255, 138/255, 204/255}
YELLOW = {211/255, 159/255, 104/255}
BACKGROUND_COLOR = {58/255, 56/255, 88/255}


gameData = {
    selectedPlayer = 1,
    selectedBullet = 1,
    soundVolume = 1,
    language = 1,
    highScores = {0, 0, 0, 0, 0}
}

texts = languages[gameData.language]

function loadGameData()
	if not love.filesystem.getInfo('gameData.txt') then
		saveGameData()
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

function drawButtons(buttons, selectedButton, y)
    local buttonY = y or 100
    local buttonMargin = 26

    love.graphics.setFont(mediumFont)

    for index,button in ipairs(buttons) do
        if index == selectedButton then
            love.graphics.setColor(SOFT_WHITE)
            Paw.render((RENDER_WIDTH - mediumFont:getWidth(button.text)) * 0.5 - 25, buttonY + (buttonMargin * (index-1)) + 3)
        else
            love.graphics.setColor(GREEN)
        end
        love.graphics.printf(button.text, 0, buttonY + (buttonMargin * (index-1)), RENDER_WIDTH, 'center')
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

function drawKeysAndDescriptions()
    love.graphics.setColor(GREEN)
    for i = 1, 3, 1 do
        love.graphics.setLineWidth(2)
        love.graphics.rectangle('line', 23 + 134*(i-1), 180, 119, 35)

        love.graphics.draw(keysSprite, keysQuads[i], 38 + 134*(i-1), 187)
        local y = string.find(texts.keyDescription[i], '\n') and 188 or 193
        love.graphics.printf(texts.keyDescription[i], 77 + 134*(i-1), y, 50, 'right')
    end
    love.graphics.setColor(WHITE)
end