WHITE = {1, 1, 1}
GREEN = {50/255, 205/255, 50/255}
BACKGROUND_COLOR = {29/255, 41/255, 81/255}

function drawLives(livesNum, img)
    local margin = 60
    for i = 1, livesNum, 1 do
        love.graphics.draw(img, VIRTUAL_WIDTH - margin, VIRTUAL_HEIGHT - 13)
        margin = margin + 15
    end
end


function createButton(text, fn)
    return {
        text = text,
        fn = fn,
        --selected = false
    }
end