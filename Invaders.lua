Invaders = {

    load = function(__self)

        catWidth = 18
        catHeight = 18
        
        rowsCount = 5
        columnsCount = 12
    
        rowY = 94 -- bottom row position
        columnX = 100 -- first column on the left position
      
        rowGap = 10
        columnGap = 6
    
        horizontalTile = catWidth + columnGap
        verticalTile = catHeight + rowGap
    
        catImages = {
            love.graphics.newImage('images/white-cat.png'),
            love.graphics.newImage('images/brown-cat.png'),
            love.graphics.newImage('images/black-white-cat.png'),
            love.graphics.newImage('images/calico-cat.png'),
            love.graphics.newImage('images/white-kitten.png')
        }

        catScores = { 10, 20, 30, 40, 50 }

        invaders = __self.initialiseFirstInvaders()

        --[[ for later, maybe?
            shooters = {} -- bottom row cats, able to shoot
            bullets = {}
            timeSinceLastBullet = 0
        ]]

        timeSinceLastMovement = 0
        movementInterval = 0.6 -- in seconds
        catLateralMovement = 10
        catVerticalMovement = 9
    end,


    initialiseFirstInvaders = function()
        local firstInvaders = {}
      
        for i = 1, rowsCount, 1 do -- for every row
            for j = 1, columnsCount, 1 do -- for every column
                table.insert(firstInvaders, Cat.create(catImages[i], catScores[i], columnX + horizontalTile * (j-1), rowY - verticalTile * (i-1)))
                --[[    make the cats of the first (bottom) row able to shoot (?)
                if #invaders < columnsCount then
                    table.insert(shooters, invaders[j])
                    invaders[j]canShoot = true
                end]]
            end
        end

        return firstInvaders
    end,


    update = function(__self, dt)
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
            timeSinceLastMovement = 0                      -- reset timer



        end

        -- also: make invaders shoot & detect collisions
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





      


    render = function()
        for index,cat in ipairs(invaders) do
            cat:render()
        end
    end

}