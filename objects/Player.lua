-- players
local PLAYERS_SPRITE_WIDTH, PLAYERS_SPRITE_HEIGHT = 192, 384
local PLAYER_QUAD_WIDTH, PLAYER_QUAD_HEIGHT = 32, 32
local PLAYERS = PLAYERS_SPRITE_HEIGHT / PLAYER_QUAD_HEIGHT
local PLAYER_FRAMES = PLAYERS_SPRITE_WIDTH / PLAYER_QUAD_WIDTH

playersQuads = {}
for i = 1, PLAYERS, 1 do
    local quads = {}
    for j = 1, PLAYER_FRAMES, 1 do
        table.insert(quads, love.graphics.newQuad(PLAYER_QUAD_WIDTH * (j-1), PLAYER_QUAD_HEIGHT * (i-1),
        PLAYER_QUAD_WIDTH, PLAYER_QUAD_HEIGHT, PLAYERS_SPRITE_WIDTH, PLAYERS_SPRITE_HEIGHT))
    end
    table.insert(playersQuads, quads)
end

playerWidth, playerHeight = PLAYER_QUAD_WIDTH - 2, PLAYER_QUAD_HEIGHT - 2

local FRAME_DURATION = 0.2
local frameTimer = 0

local FLICKER_DURATION = 0.1
local flickerTimer = 0

local PLAYER_SPEED = 200

-- bullets
local PLAYER_BULLET_SPRITE_WIDTH, PLAYER_BULLET_SPRITE_HEIGHT = 128, 10
local BULLET_QUAD_WIDTH, BULLET_QUAD_HEIGHT = 8, 10

playerBulletQuads = {} -- 16 bullets
for i = 1, PLAYER_BULLET_SPRITE_WIDTH / BULLET_QUAD_WIDTH, 1 do
    table.insert(playerBulletQuads, love.graphics.newQuad(BULLET_QUAD_WIDTH * (i-1), 0,
    BULLET_QUAD_WIDTH, BULLET_QUAD_HEIGHT, PLAYER_BULLET_SPRITE_WIDTH, PLAYER_BULLET_SPRITE_HEIGHT))
end

local PLAYER_BULLETS_LIMIT = 1


Player = {

    load = function()
        playerX, playerY = RENDER_WIDTH / 2 - playerWidth / 2, RENDER_HEIGHT - playerHeight - 23

        playerFrame = 1
        playerScale = 1

        isInvulnerable = false
    end,

    flicker = function(__self, dt)
        flickerTimer = flickerTimer + dt
        if flickerTimer > FLICKER_DURATION then
            playerScale = playerScale == 1 and 0 or 1
            flickerTimer = 0
        end
    end,

    walk = function(__self, dt)
        if isTouched(0, 70, 100, 180) then
            playerX = math.max(0, playerX + -PLAYER_SPEED * dt)
            frameTimer = frameTimer + dt
            if frameTimer > FRAME_DURATION then
                playerFrame = playerFrame == 1 and 2 or 1
                frameTimer = 0
            end
        elseif isTouched(380, 70, 100, 180) then
            playerX = math.min(RENDER_WIDTH - playerWidth, playerX + PLAYER_SPEED * dt)
            frameTimer = frameTimer + dt
            if frameTimer > FRAME_DURATION then
                playerFrame = playerFrame == 4 and 5 or 4
                frameTimer = 0
            end
        end
    end,

    shoot = function(__self, dt)
        if isTouched(115, 210, 250, 60) then
            if #playerBullets >= PLAYER_BULLETS_LIMIT then return end
            table.insert(playerBullets, Bullet.create(playerBulletSprite, playerBulletQuads[gameData.selectedBullet], playerX, playerY, -1))
            sounds['playerShoot']:play()
        end
    end,

    render = function()
        love.graphics.draw(playersSprite, playersQuads[gameData.selectedPlayer][playerFrame], playerX, playerY, 0, playerScale)
    end

}