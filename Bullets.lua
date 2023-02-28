local BULLET_SPEED = 200

Bullets = {

    load = function()
        invadersBullets =  {}
        playerBullets = {}
        BULLET_WIDTH = 6
        BULLET_HEIGHT = 10
        bulletSpeed = BULLET_SPEED
    end,

    update = function(__self, dt)
        -- invaders' bullets
        for index,bullet in ipairs(invadersBullets) do
            bullet:move(dt)
            if bullet:isOffScreen() then
                table.remove(invadersBullets, index)
            elseif not isInvulnerable and __self.checkCollision(bullet, playerX, playerY, playerWidth, playerHeight) then
                -- the player has been hit
                table.remove(invadersBullets, index)
                if lives > 1 then StateMachine:changeState(HurtState) else StateMachine:changeState(VeryHurtState) end
            end
        end

        -- player's bullets
        for bulletIndex,bullet in ipairs(playerBullets) do
            bullet:move(dt)
            if bullet:isOffScreenPl() then
                table.remove(playerBullets, bulletIndex)
            else
                for catIndex,cat in ipairs(invaders) do
                    if cat.y + catHeight <= 0 then
                        return
                    elseif __self.checkCollision(bullet, cat.x, cat.y, catWidth, catHeight) then
                        -- a cat has been hit
                        table.remove(playerBullets, bulletIndex)
                        table.remove(invaders, catIndex)
                        Explosion.explode(cat.x, cat.y, catWidth, catHeight, 50)
                        bottomInvaders = Invaders.getBottomInvaders()
                        score = score + cat.score
                        defeatedCats = defeatedCats + 1
                        if defeatedCats >= (80 * level) then
                            Invaders:increaseDifficulty()
                        end
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
        for index,bullet in ipairs(invadersBullets) do
            bullet:render()
        end
        for index,bullet in ipairs(playerBullets) do
            bullet:render()
        end
    end
}