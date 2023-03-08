WHITE = {1, 1, 1}
GREEN = {50/255, 205/255, 50/255}
PURPLE = {191/255, 112/255, 1}
BACKGROUND_COLOR = {29/255, 41/255, 81/255}

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