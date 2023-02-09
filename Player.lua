Player = {

    load = function()
        playerImage = love.graphics.newImage('images/main-character.png')
        playerWidth = playerImage:getWidth()
        playerHeight = playerImage:getHeight()
        playerX = VIRTUAL_WIDTH / 2 - playerWidth / 2
        playerY = VIRTUAL_HEIGHT - playerHeight - 20
        PLAYER_SPEED = 200
    end,

    update = function(dt)
        if love.keyboard.isDown('left') then
            playerX = math.max(0, playerX + -PLAYER_SPEED * dt)
        elseif love.keyboard.isDown('right') then
            playerX = math.min(VIRTUAL_WIDTH - playerWidth, playerX + PLAYER_SPEED * dt)
        end
    end,

    render = function ()
        love.graphics.draw(playerImage, playerX, playerY)
    end

}