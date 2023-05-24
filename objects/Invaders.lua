local ROWS, COLUMNS = 5, 12
local BOTTOM_ROW_Y, FIRST_COLUMN_X = 80, 76
local ROW_GAP, COLUMN_GAP = 8, 8

local CAT_SPRITE_WIDTH, CAT_SPRITE_HEIGHT = 120, 160
local CAT_QUAD_WIDTH, CAT_QUAD_HEIGHT = 20, 20
local sxValues = {-1, 1}

local CAT_BULLET_SPRITE_WIDTH, CAT_BULLET_SPRITE_HEIGHT = 128, 10
local BULLET_QUAD_WIDTH, BULLET_QUAD_HEIGHT = 8, 10

local CAT_MOVE_DELAY = 0.6 -- seconds
local moveDelay
local timeSinceLastMove
local catFrameDuration
local catFrameTimer
local CAT_LATERAL_MOVE, CAT_VERTICAL_MOVE = 10, 20
local catLateralMove
local hasChangedDirection

local SHOOT_DELAY = 1.6
local shootDelay
local timeSinceLastBullet
local BULLET_SPEED = 200

local MOVE_ACCELERATION, SHOOT_ACCELERATION = 0.03, 0.07
local BULLET_SPEED_ACCELERATION = 1.05
local MIN_MOVE_DELAY, MIN_SHOOT_DELAY = 0.1, 0.2


Invaders = {

    load = function(__self)

        catWidth, catHeight = CAT_QUAD_WIDTH, CAT_QUAD_HEIGHT
        horizontalTile, verticalTile = catWidth + COLUMN_GAP, catHeight + ROW_GAP
        catFrame = 1

        catsQuads = {} -- 24 cats, 2 frames each
        for i = 1, CAT_SPRITE_HEIGHT / CAT_QUAD_HEIGHT, 1 do
            for j = 1, CAT_SPRITE_WIDTH / CAT_QUAD_WIDTH, 2 do
                table.insert(catsQuads, 
                    {love.graphics.newQuad(CAT_QUAD_WIDTH * (j-1), CAT_QUAD_HEIGHT * (i-1), CAT_QUAD_WIDTH, CAT_QUAD_HEIGHT, CAT_SPRITE_WIDTH, CAT_SPRITE_HEIGHT),
                    love.graphics.newQuad(CAT_QUAD_WIDTH * (j), CAT_QUAD_HEIGHT * (i-1), CAT_QUAD_WIDTH, CAT_QUAD_HEIGHT, CAT_SPRITE_WIDTH, CAT_SPRITE_HEIGHT)})
            end
        end

        catBulletSprite = love.graphics.newImage('images/cats-bullets-spritesheet.png')
        catBulletQuads = {} -- 16 bullets
        for i = 1, CAT_BULLET_SPRITE_WIDTH / BULLET_QUAD_WIDTH, 1 do
            table.insert(catBulletQuads, 
                love.graphics.newQuad(BULLET_QUAD_WIDTH * (i-1), 0, BULLET_QUAD_WIDTH, BULLET_QUAD_HEIGHT, CAT_BULLET_SPRITE_WIDTH, CAT_BULLET_SPRITE_HEIGHT))
        end

        invaders = __self.initialiseFirstInvaders()
        bottomInvaders = __self.getBottomInvaders()

        timeSinceLastMove = 0
        moveDelay = CAT_MOVE_DELAY -- to be decreased as the game progresses
        catFrameDuration = moveDelay * 0.5
        catFrameTimer = 0
        catLateralMove = CAT_LATERAL_MOVE
        timeSinceLastBullet = 0
        shootDelay = SHOOT_DELAY -- to be decreased as the game progresses
        bulletSpeed = BULLET_SPEED -- to be increased as the game progresses

        level = 1

        hasChangedDirection = false
    end,


    initialiseFirstInvaders = function()
        local firstInvaders = {}
      
        for i = 1, ROWS, 1 do -- for every row
            local randomCat = love.math.random(6)
            local randomBullet = love.math.random(4)
            local sx = sxValues[love.math.random(2)]
            local ox = sx > 0 and 0 or catWidth
            for j = 1, COLUMNS, 1 do -- for every column
                table.insert(firstInvaders, Cat.create(catsQuads[randomCat], catBulletQuads[randomBullet], j, FIRST_COLUMN_X + horizontalTile * (j-1), BOTTOM_ROW_Y - verticalTile * (i-1), sx, ox))
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
        catFrameTimer = catFrameTimer + dt
        if timeSinceLastMove > moveDelay then

            catFrame = catFrame == 1 and 2 or 1
            timeSinceLastMove = 0 -- reset timer
            catFrameTimer = 0

            if __self.hasReachedEdge() then
                catLateralMove = catLateralMove * -1 -- invert direction
                hasChangedDirection = true
                sounds['invadersShiftDown']:play()
                for index,cat in ipairs(invaders) do
                    cat.y = cat.y + CAT_VERTICAL_MOVE -- move all the cats down
                end
                if __self.hasReachedGround() and StateMachine.currentState ~= VeryHurtState then
                    StateMachine:changeState(VeryHurtState)
                    return
                end
            else
                for index,cat in ipairs(invaders) do
                    cat.x = cat.x + catLateralMove -- move all the cats laterally
                end
            end

            if invaders[#invaders].y + catHeight > 0 then
                __self.addNewInvadersRow()
            end
        elseif catFrameTimer > catFrameDuration then
            catFrame = catFrame == 1 and 2 or 1
            catFrameTimer = 0
        end

        -- make invaders shoot
        timeSinceLastBullet = timeSinceLastBullet + dt
        if timeSinceLastBullet > shootDelay then
            timeSinceLastBullet = 0
            local shooter = bottomInvaders[love.math.random(#bottomInvaders)]
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
            if cat.x >= (RENDER_WIDTH - catWidth - 8) then
                return true
            elseif cat.x <= 8 then
                return true
            end
        end
        return false
    end,

    hasReachedGround = function()
        for index,cat in ipairs(bottomInvaders) do
            if cat.y + catHeight > playerY then
                return true
            end
        end
        return false
    end,

    addNewInvadersRow = function()
        local x = invaders[#invaders - COLUMNS + 1].x
        local y = invaders[#invaders].y - verticalTile
        local randomCat = love.math.random(#catsQuads)
        local bulletIndex = love.math.random(#catBulletQuads)
        local sx = sxValues[love.math.random(2)]
        local ox = sx > 0 and 0 or catWidth
        for i = 1, COLUMNS, 1 do
            table.insert(invaders, Cat.create(catsQuads[randomCat], catBulletQuads[bulletIndex], i, x + horizontalTile * (i-1), y, sx, ox))
        end
    end,

    increaseDifficulty = function()
        if moveDelay - MOVE_ACCELERATION >= MIN_MOVE_DELAY then
            moveDelay = moveDelay - MOVE_ACCELERATION
            catFrameDuration = moveDelay * 0.5
        end
        if shootDelay - SHOOT_ACCELERATION >= MIN_SHOOT_DELAY then
            shootDelay = shootDelay - SHOOT_ACCELERATION
        end
        bulletSpeed = bulletSpeed * BULLET_SPEED_ACCELERATION
        level = level + 1
    end,

    render = function()
        for index,cat in ipairs(invaders) do
            cat:render()
        end
    end,

    getReadyUpdate = function(__self, dt)
        timeSinceLastMove = timeSinceLastMove + dt
        if timeSinceLastMove > moveDelay / 10 then
            renderedCats = renderedCats < #invaders and renderedCats + 1 or #invaders
            timeSinceLastMove = 0
        end
    end,

    getReadyRender = function()
        for i = 1, renderedCats, 1 do
            invaders[i]:render()
        end
    end
}