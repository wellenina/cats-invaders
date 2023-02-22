local PLAYER_SPEED = 200

local PLAYER_BULLET_SPRITE_WIDTH, PLAYER_BULLET_SPRITE_HEIGHT = 84, 10
local BULLET_QUAD_WIDTH, BULLET_QUAD_HEIGHT = 6, 10

Player = {

    load = function()
        playerImage = love.graphics.newImage('images/main-character.png')
        playerWidth = playerImage:getWidth()
        playerHeight = playerImage:getHeight()
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
        if love.keyboard.isDown('left') then
            playerX = math.max(0, playerX + -PLAYER_SPEED * dt)
        elseif love.keyboard.isDown('right') then
            playerX = math.min(VIRTUAL_WIDTH - playerWidth, playerX + PLAYER_SPEED * dt)
        end

        if love.keyboard.wasPressed('space') then
            __self.shoot()
        end
    end,

    shoot = function()
        table.insert(bullets, Bullet.create(playerBulletSprite, playerBulletQuads[1], playerX, playerY, -1))
    end,

    render = function()
        love.graphics.draw(playerImage, playerX, playerY)
    end

}