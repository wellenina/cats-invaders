local playerFrame
local catFrame
local catSx
local catOx

local bulletData = { {45 * (math.pi / 180), -4, 6}, {-45 * (math.pi / 180), 4, -2} }
local bulletDataIndex = 1

local x
local playerY = RENDER_HEIGHT - 53
local catY = RENDER_HEIGHT - 46
local bulletY = RENDER_HEIGHT - 43

local FRAME_DURATION = 0.3
local frameTimer = 0
local speed = 15


TitleScreenAnimation = {

    load = function()

        playerFrame = 4
        catFrame = 1
        catSx = -1.5
        catOx = 20

        x = -160
        frameTimer = 0

        titleScreenCatQuads = {
        love.graphics.newQuad(40, 120, 20, 20, 120, 160),
        love.graphics.newQuad(60, 120, 20, 20, 120, 160)}

    end,

    update = function(__self, dt)

        if x > RENDER_WIDTH + 40 then
            speed = speed * -1
            playerFrame = 1
            catSx = 1.5
            catOx = 0
            x = RENDER_WIDTH + 30
        elseif x < -170 then
            speed = speed * -1
            playerFrame = 4
            catSx = -1.5
            catOx = 20
            x = -160
        else
            frameTimer = frameTimer + dt
            if frameTimer > FRAME_DURATION then
                x = x + speed
                playerFrame = playerFrame < 3 and (playerFrame == 1 and 2 or 1) or (playerFrame == 4 and 5 or 4)
                catFrame = catFrame == 1 and 2 or 1
                bulletDataIndex = bulletDataIndex == 1 and 2 or 1
                frameTimer = 0
            end
        end

    end,

    render = function()
        love.graphics.draw(playersSprite, playersQuads[gameData.selectedPlayer][playerFrame], x, playerY)
        love.graphics.draw(catSprite, titleScreenCatQuads[catFrame], x + 59, catY, 0, catSx, 1.5, catOx, 0)
        love.graphics.draw(playerBulletSprite, playerBulletQuads[gameData.selectedBullet], x + 116, bulletY, bulletData[bulletDataIndex][1], 2, 2, bulletData[bulletDataIndex][2], bulletData[bulletDataIndex][3])
    end
}