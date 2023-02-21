Bullets = {

    load = function()
        bullets =  {}
        BULLET_SPEED = 200
    end,

    update = function(__self, dt)
        if #bullets == 0 then
            return
        end

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
            else -- player's bullet (bullet.direction == -1)
                for catIndex,cat in ipairs(invaders) do
                    if __self.checkCollision(bullet, cat.x, cat.y, catWidth, catHeight) then
                        -- a cat has been hit
                        if cat.y + catHeight <= 0 then return end
                        table.remove(bullets, bulletIndex) -- il proiettile sparisce
                        table.remove(invaders, catIndex) -- il gatto sparisce
                        Explosion.explode(cat.x, cat.y, catWidth, catHeight) -- il gatto esplode
                        bottomInvaders = Invaders.getBottomInvaders()
                        score = score + cat.score
                    end
                end
            end
        end
    end,

    checkCollision = function(bullet, targetX, targetY, targetWidth, targetHeight)
        return
            bullet.y + bullet.height > targetY
            and
            bullet.y < targetY + targetHeight
            and
            bullet.x + bullet.width > targetX
            and
            bullet.x < targetX + targetWidth
    end,

    render = function()
        if #bullets == 0 then
            return
        end

        for index,bullet in ipairs(bullets) do
            bullet:render()
        end
    end
}