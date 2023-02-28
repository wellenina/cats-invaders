local PLAYER_SPRITE_WIDTH, PLAYER_SPRITE_HEIGHT = 180, 30
local PLAYER_QUAD_WIDTH, PLAYER_QUAD_HEIGHT = 30, 30

local FRAME_DURATION = 0.2
local playerFrame = 1
local frameTimer = 0

local PLAYER_SPEED = 200

local PLAYER_BULLET_SPRITE_WIDTH, PLAYER_BULLET_SPRITE_HEIGHT = 84, 10
local BULLET_QUAD_WIDTH, BULLET_QUAD_HEIGHT = 6, 10

local PLAYER_BULLETS_LIMIT = 1

Player = {

    load = function()

        playerSprite = love.graphics.newImage('images/main-character-spritesheet.png')
        playerQuads = {}
        for i = 1, PLAYER_SPRITE_WIDTH / PLAYER_QUAD_WIDTH, 1 do
            table.insert(playerQuads, 
                love.graphics.newQuad(PLAYER_QUAD_WIDTH * (i-1), 0, PLAYER_QUAD_WIDTH, PLAYER_QUAD_HEIGHT, PLAYER_SPRITE_WIDTH, PLAYER_SPRITE_HEIGHT))
        end

--        playerFrame = 1
--        frameTimer = 0

        playerWidth, playerHeight = PLAYER_QUAD_WIDTH, PLAYER_QUAD_HEIGHT
        playerX = VIRTUAL_WIDTH / 2 - playerWidth / 2
        playerY = VIRTUAL_HEIGHT - playerHeight - 20

        playerBulletSprite = love.graphics.newImage('images/player-bullets-spritesheet.png')
        playerBulletQuads = {} -- 14 bullets
        for i = 1, PLAYER_BULLET_SPRITE_WIDTH / BULLET_QUAD_WIDTH, 1 do
            table.insert(playerBulletQuads, 
                love.graphics.newQuad(BULLET_QUAD_WIDTH * (i-1), 0, BULLET_QUAD_WIDTH, BULLET_QUAD_HEIGHT, PLAYER_BULLET_SPRITE_WIDTH, PLAYER_BULLET_SPRITE_HEIGHT))
        end
    end,

    update = function(__self, dt)
        __self:move(dt)

        if love.keyboard.wasPressed('space') then
            __self.shoot()
        end
    end,

    move = function(__self, dt)
        if love.keyboard.isDown('left') then
            playerX = math.max(0, playerX + -PLAYER_SPEED * dt)
            frameTimer = frameTimer + dt
            if frameTimer > FRAME_DURATION then
                playerFrame = playerFrame == 1 and 2 or 1
                frameTimer = 0
            end
        elseif love.keyboard.isDown('right') then
            playerX = math.min(VIRTUAL_WIDTH - playerWidth, playerX + PLAYER_SPEED * dt)
            frameTimer = frameTimer + dt
            if frameTimer > FRAME_DURATION then
                playerFrame = playerFrame == 4 and 5 or 4
                frameTimer = 0
            end
        end
    end,

    shoot = function()
        if #playerBullets >= PLAYER_BULLETS_LIMIT then return end
        table.insert(playerBullets, Bullet.create(playerBulletSprite, playerBulletQuads[1], playerX, playerY, -1))
    end,

    render = function()
        love.graphics.draw(playerSprite, playerQuads[playerFrame], playerX, playerY)
    end

}