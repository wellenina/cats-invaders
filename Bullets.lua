Bullets = {

    load = function()
        bullets =  {}
        BULLET_SPEED = 200
    end,

    update = function(dt)
        if #bullets == 0 then
            return
        end

        for index,bullet in ipairs(bullets) do
            bullet:move(dt)
            if bullet:isOffScreen() then
                table.remove(bullets, index)
            end
        end
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