local rows, columns = 2, 6
local selectedRow, selectedColumn = 1, 1

local currentPlayerRow, currentPlayerColumn = 1, 1


ChoosePlayerState = {

    stateType = 'menu',

    load = function()
        currentPlayerRow = gameData.selectedPlayer <= columns and 1 or 2
        currentPlayerColumn = gameData.selectedPlayer % columns
        selectedRow, selectedColumn = currentPlayerRow, currentPlayerColumn
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
            gameData.selectedPlayer = selectedColumn + columns * (selectedRow - 1)
            currentPlayerRow = gameData.selectedPlayer <= columns and 1 or 2
            currentPlayerColumn = gameData.selectedPlayer % columns == 0 and columns or gameData.selectedPlayer % columns
            sounds['menuSelect']:stop()
            sounds['menuEnter']:play()
        end

        if love.keyboard.wasPressed('escape') then
            saveGameData()
            sounds['menuSelect']:stop()
            sounds['menuEnter']:play()
            StateMachine:changeState(OptionsState, 3)
        end        
    end,

    render = function()
        love.graphics.setFont(smallFont)

        for row = 1, rows, 1 do
            for column = 1, columns, 1 do
                -- currently selected player has a yellow background
                if row == currentPlayerRow and column == currentPlayerColumn then
                    love.graphics.setColor(YELLOW)
                    love.graphics.rectangle('fill', 25 + 67 * (column-1), 16 + 77 * (row-1), 46, 46)
                end

                local playerIndex = column + columns * (row-1)
                love.graphics.setColor(WHITE)
                love.graphics.draw(playersSprite, playersQuads[playerIndex][1], 32 + 67 * (column-1), 24 + 77 * (row-1))

                if row == selectedRow and column == selectedColumn then
                    love.graphics.setColor(WHITE)
                else
                    love.graphics.setColor(GREEN)
                end
                love.graphics.printf(texts.playersNames[playerIndex], 24 + 67 * (column-1), 68 + 77 * (row-1), 48, 'center')
                love.graphics.setLineWidth(5)
                love.graphics.rectangle('line', 24 + 67 * (column-1), 16 + 77 * (row-1), 48, 48)
            end
        end

        drawKeysAndDescriptions()
    end
}