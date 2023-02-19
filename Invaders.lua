Invaders = {

    load = function(__self)

        catWidth = 18
        catHeight = 18
        
        rows = 5
        columns = 12
    
        bottomRowY = 80 -- bottom row position
        firstColumnX = 100 -- first column on the left position
      
        rowGap = 8
        columnGap = 7
    
        horizontalTile = catWidth + columnGap
        verticalTile = catHeight + rowGap
    
        catImages = {
            love.graphics.newImage('images/white-cat.png'),
            love.graphics.newImage('images/brown-cat.png'),
            love.graphics.newImage('images/black-white-cat.png'),
            love.graphics.newImage('images/calico-cat.png'),
            love.graphics.newImage('images/white-kitten1.png')
        }

        bulletImages = {
            love.graphics.newImage('images/exlamation.png'),
            love.graphics.newImage('images/grass.png'),
            love.graphics.newImage('images/lightning.png'),
            love.graphics.newImage('images/meow.png'),
            love.graphics.newImage('images/poop.png')
        }

        catScores = { 10, 20, 30, 40, 50 }

        invaders = __self.initialiseFirstInvaders()

        bottomInvaders = __self.getBottomInvaders()

        timeSinceLastMovement = 0
        movementInterval = 0.6 -- in seconds
        catLateralMovement = 10
        catVerticalMovement = 9

        rowNum = rows

        timeSinceLastBullet = 0
        bulletInterval = 1.6 -- in seconds
        
    end,


    initialiseFirstInvaders = function()
        local firstInvaders = {}
      
        for i = 1, rows, 1 do -- for every row
            for j = 1, columns, 1 do -- for every column
                table.insert(firstInvaders, Cat.create(catImages[i], bulletImages[i], catScores[i], j, firstColumnX + horizontalTile * (j-1), bottomRowY - verticalTile * (i-1)))
            end
        end

        return firstInvaders
    end,

    getBottomInvaders = function()
        local bottomInvaders = {}

        for i = 1, columns, 1 do
            for index,cat in ipairs(invaders) do
                if cat.columnNum == i then
                    table.insert(bottomInvaders, cat)
                    break
                end
            end
        end


        return bottomInvaders
    end,


    update = function(__self, dt)

        -- make invaders move
        timeSinceLastMovement = timeSinceLastMovement + dt
        if timeSinceLastMovement > movementInterval then

            if __self.hasChangedDirection() then           -- if a cat reached a side
                catLateralMovement = catLateralMovement * -1    -- invert direction
                for index,cat in ipairs(invaders) do
                    cat.y = cat.y + catVerticalMovement     -- and move all the cats down
                end
            end

            for index,cat in ipairs(invaders) do
                cat.x = cat.x + catLateralMovement -- move all the cats laterally
            end

            if invaders[#invaders].y > 0 then
                __self.addNewInvadersRow()
            end

            timeSinceLastMovement = 0                      -- reset timer
        end

        -- make invaders shoot
        timeSinceLastBullet = timeSinceLastBullet + dt
        if timeSinceLastBullet > bulletInterval then
            bottomInvaders[math.random(columns)]:shoot()
            timeSinceLastBullet = 0
        end

    end,

    hasChangedDirection = function()
        for index,cat in ipairs(invaders) do
            if cat.x >= (VIRTUAL_WIDTH - catWidth) then
                return true
            elseif cat.x <= 0 then
                return true
            end
        end
        return false
    end,

    addNewInvadersRow = function()
        rowNum = rowNum + 1
        if rowNum > #catImages then
            rowNum = 1
        end
        local x = invaders[#invaders-columns+1].x
        local y = invaders[#invaders].y - verticalTile
        for i = 1, columns, 1 do
            table.insert(invaders, Cat.create(catImages[rowNum], bulletImages[rowNum], catScores[rowNum], i, x + horizontalTile * (i-1), y))
        end
    end,

    render = function()
        for index,cat in ipairs(invaders) do
            cat:render()
        end
    end

}