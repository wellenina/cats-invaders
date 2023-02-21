local ROWS, COLUMNS = 5, 12
local BOTTOM_ROW_Y, FIRST_COLUMN_X = 80, 48
local ROW_GAP, COLUMN_GAP = 8, 8

local SPRITE_WIDTH, SPRITE_HEIGHT = 120, 160
local QUAD_WIDTH, QUAD_HEIGHT = 20, 20

local CAT_MOVE_DELAY = 0.6 -- seconds
local CAT_LATERAL_MOVE, CAT_VERTICAL_MOVE = 10, 9

local SHOOT_DELAY = 1.6 -- seconds


Invaders = {

    load = function(__self)

        catWidth, catHeight = QUAD_WIDTH, QUAD_HEIGHT
    
        horizontalTile = catWidth + COLUMN_GAP
        verticalTile = catHeight + ROW_GAP
    
        frame = 1

        sprite = love.graphics.newImage("images/cats-spritesheet.png")

        catsQuads = {
        --PRIMA RIGA, 3 GATTI:
        {love.graphics.newQuad(0, 0, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT),
        love.graphics.newQuad(20, 0, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT)},

        {love.graphics.newQuad(40, 0, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT),
        love.graphics.newQuad(60, 0, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT)},

        {love.graphics.newQuad(80, 0, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT),
        love.graphics.newQuad(100, 0, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT)},

        --SECONDA RIGA, 3 GATTI:
        {love.graphics.newQuad(0, 20, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT),
        love.graphics.newQuad(20, 20, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT)},

        {love.graphics.newQuad(40, 20, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT),
        love.graphics.newQuad(60, 20, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT)},

        {love.graphics.newQuad(80, 20, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT),
        love.graphics.newQuad(100, 20, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT)}
        }

        bulletImages = {
            love.graphics.newImage('images/exlamation.png'),
            love.graphics.newImage('images/grass.png'),
            love.graphics.newImage('images/lightning.png'),
            love.graphics.newImage('images/meow.png'),
            love.graphics.newImage('images/poop.png'),
            love.graphics.newImage('images/poop.png')
        }

        catScores = { 10, 20, 30, 40, 50, 60 }

        invaders = __self.initialiseFirstInvaders()
        bottomInvaders = __self.getBottomInvaders()

        timeSinceLastMove = 0
        moveDelay = CAT_MOVE_DELAY -- to be increased as the game progresses
        catLateralMove = CAT_LATERAL_MOVE
        timeSinceLastBullet = 0
        shootDelay = SHOOT_DELAY -- to be increased as the game progresses

        rowNum = ROWS -- serve solo come contatore per aggiungere nuova riga di invaders (addNewInvadersRow), DA MODIFICARE

        hasChangedDirection = false
    end,


    initialiseFirstInvaders = function()
        local firstInvaders = {}
      
        for i = 1, ROWS, 1 do -- for every row
            for j = 1, COLUMNS, 1 do -- for every column
                table.insert(firstInvaders, Cat.create(catsQuads[i], bulletImages[i], catScores[i], j, FIRST_COLUMN_X + horizontalTile * (j-1), BOTTOM_ROW_Y - verticalTile * (i-1)))
            end
        end

        return firstInvaders
    end,

    getBottomInvaders = function()
        local bottomInvaders = {}

        for i = 1, COLUMNS, 1 do
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
        timeSinceLastMove = timeSinceLastMove + dt
        if timeSinceLastMove > moveDelay then

            frame = frame == 1 and 2 or 1

            if __self.hasReachedEdge() then
                catLateralMove = catLateralMove * -1 -- invert direction
                hasChangedDirection = true
                for index,cat in ipairs(invaders) do
                    cat.y = cat.y + CAT_VERTICAL_MOVE -- move all the cats down
                end
            else
                for index,cat in ipairs(invaders) do
                    cat.x = cat.x + catLateralMove -- move all the cats laterally
                end
            end

            if invaders[#invaders].y + catHeight > 0 then
                __self.addNewInvadersRow()
            end

            timeSinceLastMove = 0 -- reset timer
        end

        -- make invaders shoot
        timeSinceLastBullet = timeSinceLastBullet + dt
        if timeSinceLastBullet > shootDelay then
            timeSinceLastBullet = 0
            local shooter = bottomInvaders[math.random(#bottomInvaders)]
            if shooter.y + catHeight < 0 then return end
            shooter:shoot()
        end

    end,

    hasReachedEdge = function()
        if hasChangedDirection then
            hasChangedDirection = false
            return false
        end
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
        if rowNum > #catsQuads then
            rowNum = 1
        end
        local x = invaders[#invaders - COLUMNS + 1].x
        local y = invaders[#invaders].y - verticalTile
        for i = 1, COLUMNS, 1 do
            table.insert(invaders, Cat.create(catsQuads[rowNum], bulletImages[rowNum], catScores[rowNum], i, x + horizontalTile * (i-1), y))
        end
    end,

    render = function()
        for index,cat in ipairs(invaders) do
            cat:render()
        end
    end
}