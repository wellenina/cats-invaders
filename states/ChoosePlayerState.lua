local rows, columns = 2, 6
local selectedRow, selectedColumn = 1, 1

local currentPlayerRow, currentPlayerColumn = 1, 1

local playersNames = {'Our Hero', 'Suit guy', 'Tank top Guy', 'Girl', 'The Mailman', 'Rapper',
    'Tuba Player', 'Fierce Ninja', 'Green Ranger', 'Pink Horse', 'Great Pumpkin', 'Santa'}


ChoosePlayerState = {

    load = function()
        currentPlayerRow = gameData.selectedPlayer <= columns and 1 or 2
        currentPlayerColumn = gameData.selectedPlayer % columns
        selectedRow, selectedColumn = currentPlayerRow, currentPlayerColumn
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
            gameData.selectedPlayer = selectedColumn + columns * (selectedRow - 1)
            currentPlayerRow = gameData.selectedPlayer <= columns and 1 or 2
            currentPlayerColumn = gameData.selectedPlayer % columns == 0 and columns or gameData.selectedPlayer % columns
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
                love.graphics.printf(playersNames[playerIndex], 24 + 67 * (column-1), 68 + 77 * (row-1), 48, 'center')
                love.graphics.setLineWidth(5)
                love.graphics.rectangle('line', 24 + 67 * (column-1), 16 + 77 * (row-1), 48, 48)
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