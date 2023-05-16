local rows, columns = 2, 7
local selectedRow, selectedColumn = 1, 1

local currentBulletRow, currentBulletColumn = 1, 1


ChooseBulletState = {

    load = function()
        currentBulletRow = gameData.selectedBullet <= columns and 1 or 2
        currentBulletColumn = gameData.selectedBullet % columns
        selectedRow, selectedColumn = currentBulletRow, currentBulletColumn
    end,

    update = function(dt)
        if love.keyboard.wasPressed('down') then
            selectedRow = selectedRow < rows and selectedRow + 1 or 1
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('up') then
            selectedRow = selectedRow > 1 and selectedRow - 1 or rows
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('right') then
            selectedColumn = selectedColumn < columns and selectedColumn + 1 or 1
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('left') then
            selectedColumn = selectedColumn > 1 and selectedColumn - 1 or columns
            sounds['menuSelect']:stop()
            sounds['menuSelect']:play()
        end

        if love.keyboard.wasPressed('return') then
            gameData.selectedBullet = selectedColumn + columns * (selectedRow - 1)
            currentBulletRow = gameData.selectedBullet <= columns and 1 or 2
            currentBulletColumn = gameData.selectedBullet % columns == 0 and columns or gameData.selectedBullet % columns
            sounds['menuSelect']:stop()
            sounds['menuEnter']:play()
        end

        if love.keyboard.wasPressed('escape') then
            saveGameData()
            sounds['menuSelect']:stop()
            sounds['menuEnter']:play()
            StateMachine:changeState(OptionsState, 4)
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
                love.graphics.printf(texts.bulletsNames[bulletIndex], 15 + 57 * (column-1), 68 + 77 * (row-1), 60, 'center')
                love.graphics.setLineWidth(5)
                love.graphics.rectangle('line', 26 + 57 * (column-1), 16 + 77 * (row-1), 38, 48)
            end
        end

        drawKeysAndDescriptions()
    end
}