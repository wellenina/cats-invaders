local COLORS = {
    {75/255, 128/255, 202/255, 1, 75/255, 128/255, 202/255, 0},
    {104/255, 193/255, 211/255, 1, 104/255, 193/255, 211/255, 0},
    {162/255, 220/255, 199/255, 1, 162/255, 220/255, 199/255, 0},
    {237/255, 225/255, 158/255, 1, 237/255, 225/255, 158/255, 0},
    {237/255, 200/255, 196/255, 1, 237/255, 200/255, 196/255, 0},
    {207/255, 138/255, 204/255, 1, 207/255, 138/255, 204/255, 0}
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

    explode = function(x, y, width, height, amount)
        local explosion = psystem:clone()
        explosion:setColors(COLORS[math.random(#COLORS)])
        explosion:setPosition(x + width * 0.5, y + height * 0.5)
        explosion:emit(amount)
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


