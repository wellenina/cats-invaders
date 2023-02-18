Player = {

    load = function()
        playerImage = love.graphics.newImage('images/main-character.png')
        playerWidth = playerImage:getWidth()
        playerHeight = playerImage:getHeight()
        playerX = VIRTUAL_WIDTH / 2 - playerWidth / 2
        playerY = VIRTUAL_HEIGHT - playerHeight - 20
        PLAYER_SPEED = 200
        PlayerBulletImage = love.graphics.newImage('images/daikon.png')
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
        table.insert(bullets, Bullet.create(PlayerBulletImage, playerX, playerY, -1))
    end,

    render = function()
        love.graphics.draw(playerImage, playerX, playerY)
    end

}