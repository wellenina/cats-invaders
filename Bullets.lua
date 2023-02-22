Bullets = {

    load = function()
        bullets =  {}
        BULLET_WIDTH = 6
        BULLET_HEIGHT = 10
        BULLET_SPEED = 200
    end,

    update = function(__self, dt)
        for bulletIndex,bullet in ipairs(bullets) do
            bullet:move(dt)
            if bullet:isOffScreen() then
                table.remove(bullets, bulletIndex)
            elseif bullet.direction == 1 then -- invaders' bullet
                if __self.checkCollision(bullet, playerX, playerY, playerWidth, playerHeight) then
                    -- the player has been hit
                    table.remove(bullets, bulletIndex)
                    if lives > 1 then lives = lives - 1 else StateMachine:changeState(GameOverState) end
                end
            else -- player's bullet
                for catIndex,cat in ipairs(invaders) do
                    if cat.y + catHeight <= 0 then
                        return
                    elseif __self.checkCollision(bullet, cat.x, cat.y, catWidth, catHeight) then
                        -- a cat has been hit
                        table.remove(bullets, bulletIndex)
                        table.remove(invaders, catIndex)
                        Explosion.explode(cat.x, cat.y, catWidth, catHeight)
                        bottomInvaders = Invaders.getBottomInvaders()
                        score = score + cat.score
                    end
                end
            end
        end
    end,

    checkCollision = function(bullet, targetX, targetY, targetWidth, targetHeight)
        return
            bullet.y + BULLET_HEIGHT > targetY
            and
            bullet.y < targetY + targetHeight
            and
            bullet.x + BULLET_WIDTH > targetX
            and
            bullet.x < targetX + targetWidth
    end,

    render = function()
        for index,bullet in ipairs(bullets) do
            bullet:render()
        end
    end
}