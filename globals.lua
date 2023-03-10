WHITE = {1, 1, 1}
GREEN = {50/255, 205/255, 50/255}
PURPLE = {191/255, 112/255, 1}
YELLOW = {1, 233/255, 0}
BACKGROUND_COLOR = {29/255, 41/255, 81/255}

gameData = {
    selectedPlayer = 1,
    selectedBullet = 1,
    soundVolume = 1,
    highScores = {0, 0, 0, 0, 0}
}

function loadGameData()
	if not love.filesystem.getInfo('gameData.txt') then
		saveGameData()
		return
	end
    local savedData = love.filesystem.load('gameData.txt')
    gameData = savedData()
    love.audio.setVolume(gameData.soundVolume)
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
        else
            str = str .. v .. ', '
        end
    end
    str = str .. '}'
    return str
end



function drawScoreAndLives(score, livesNum, img)
    love.graphics.setFont(smallFont)
    local y = VIRTUAL_HEIGHT - 13
    love.graphics.printf('SCORE  ' .. tostring(score), 20, y, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('LIVES', VIRTUAL_WIDTH-48, y, VIRTUAL_WIDTH, 'left')
    local margin = 65
    for i = 1, livesNum, 1 do
        love.graphics.draw(img, VIRTUAL_WIDTH - margin, y)
        margin = margin + 15
    end
end


function createButton(text, fn)
    return {
        text = text,
        fn = fn,
    }
end