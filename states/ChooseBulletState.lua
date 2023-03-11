local rows, columns = 2, 7
local selectedRow, selectedColumn = 1, 1

local currentBulletRow, currentBulletColumn = 1, 1

local bulletsNames = {'Daikon', 'Broccoli', 'Carnation', 'Carrot', 'Lollipop', 'Radish', 'Trumpet',
    'Pineapple', 'Apple\ncore', 'Avocado', 'Straw-\nberry', 'Chocolate bar', 'Aubergine', 'Pear'}


ChooseBulletState = {

    load = function()
        currentBulletRow = gameData.selectedBullet <= columns and 1 or 2
        currentBulletColumn = gameData.selectedBullet % columns
        selectedRow, selectedColumn = currentBulletRow, currentBulletColumn
    end,

    update = function(dt)
        if love.keyboard.wasPressed('down') then
            selectedRow = selectedRow < rows and selectedRow + 1 or 1
        end

        if love.keyboard.wasPressed('up') then
            selectedRow = selectedRow > 1 and selectedRow - 1 or rows
        end

        if love.keyboard.wasPressed('right') then
            selectedColumn = selectedColumn < columns and selectedColumn + 1 or 1
        end

        if love.keyboard.wasPressed('left') then
            selectedColumn = selectedColumn > 1 and selectedColumn - 1 or columns
        end

        if love.keyboard.wasPressed('return') then
            gameData.selectedBullet = selectedColumn + columns * (selectedRow - 1)
            currentBulletRow = gameData.selectedBullet <= columns and 1 or 2
            currentBulletColumn = gameData.selectedBullet % columns == 0 and columns or gameData.selectedBullet % columns
        end

        if love.keyboard.wasPressed('escape') then
            saveGameData()
            StateMachine:changeState(OptionsState, 2)
        end        
    end,

    render = function()
        love.graphics.setFont(smallFont)

        for row = 1, rows, 1 do
            for column = 1, columns, 1 do
                -- currently selected bullet has a yellow background
                if row == currentBulletRow and column == currentBulletColumn then
                    love.graphics.setColor(YELLOW)
                    love.graphics.rectangle('fill', 27 + 57 * (column-1), 16 + 77 * (row-1), 36, 46)
                end

                local bulletIndex = column + columns * (row-1)
                love.graphics.setColor(WHITE)
                love.graphics.draw(playerBulletSprite, playerBulletQuads[bulletIndex], 39 + 57 * (column-1), 34 + 77 * (row-1), 0, 2, 2)

                if row == selectedRow and column == selectedColumn then
                    love.graphics.setColor(WHITE)
                else
                    love.graphics.setColor(GREEN)
                end
                love.graphics.printf(bulletsNames[bulletIndex], 15 + 57 * (column-1), 68 + 77 * (row-1), 60, 'center')
                love.graphics.setLineWidth(5)
                love.graphics.rectangle('line', 26 + 57 * (column-1), 16 + 77 * (row-1), 38, 48)
            end
        end

        love.graphics.setColor(GREEN)
        for i = 1, 3, 1 do
            love.graphics.setLineWidth(2)
            love.graphics.rectangle('line', 23 + 134*(i-1), 180, 119, 35)

            love.graphics.draw(keysSprite, keysQuads[i], 38 + 134*(i-1), 187)
            love.graphics.printf(keysExplanationTexts[i], 77 + 134*(i-1), 193, 50, 'right')
        end

        love.graphics.setColor(WHITE)
    end
}