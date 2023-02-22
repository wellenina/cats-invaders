local COLORS = {
    {1, 227/255, 250/255, 1, 1, 227/255, 250/255, 0},
    {190/255, 1, 223/255, 1, 190/255, 1, 223/255, 0},
    {189/255, 219/255, 1, 1, 189/255, 219/255, 1, 0},
    {1, 251/255, 190/255, 1, 1, 251/255, 190/255, 0},
    {1, 188/255, 1, 1, 1, 188/255, 1, 0}
}

Explosion = {

    load = function()
        local blast = love.graphics.newCanvas(2, 2)
        love.graphics.setCanvas(blast)
        love.graphics.rectangle("fill", 0, 0, 2, 2)
        love.graphics.setCanvas()

        psystem = love.graphics.newParticleSystem(blast, 50)
        psystem:setParticleLifetime(0.1, 0.5)
        psystem:setEmissionRate(30)
        psystem:setSpeed(50)
        psystem:setSpread(20)
        psystem:setLinearAcceleration(-20, -20, 20, 20)
        psystem:setEmitterLifetime(0.3)

        activeExplosions = {}
    end,

    explode = function(x, y, width, height)
        local explosion = psystem:clone()
        explosion:setColors(COLORS[math.random(#COLORS)])
        explosion:setPosition(x + width * 0.5, y + height * 0.5)
        explosion:emit(50)
        table.insert(activeExplosions, explosion)
    end,

    update = function(dt)
        for index,explosion in ipairs(activeExplosions) do
            explosion:update(dt)
            if not explosion:isActive() then
                table.remove(activeExplosions, index)
            end
        end
    end,

    render = function()
        for index,explosion in ipairs(activeExplosions) do
            love.graphics.draw(explosion)
        end
    end
}


