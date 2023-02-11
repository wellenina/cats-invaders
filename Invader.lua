timer = 0
Invader = {
    --[[load = function()
        catImage = love.graphics.newImage('images/white-cat.png')
        catWidth = catImage:getWidth()
        catHeight = catImage:getHeight()
        catX = VIRTUAL_WIDTH / 2 - catWidth / 2
        catY = 20
        catLateralMovement = 5
        catVerticalMovent = 15
    end,]]

    load = function()
        invaders = {} -- tutti i gatti sullo schermo
        --shooters = {} -- i gatti che possono sparare (bottom row)
      
        catWidth = 28
        catHeight = 28
        
        rowsCount = 4
        columnsCount = 6
    
        rowY = 130 -- posizione della riga più in basso
        columnX = 100 -- posizione della prima colonna a sinistra
      
        rowGap = 10
        columnGap = 10
    
        horizontalTile = catWidth + columnGap
        verticalTile = catHeight + rowGap
    
        catImages = {
            love.graphics.newImage('images/white-cat.png'),
            love.graphics.newImage('images/brown-cat.png'),
            love.graphics.newImage('images/black-white-cat.png'),
            love.graphics.newImage('images/calico-cat.png'),
            love.graphics.newImage('images/white-kitten.png')
        }
    
        for i = 1, rowsCount, 1 do -- per ogni riga
            for j = 1, columnsCount, 1 do -- per ogni colonna
                table.insert(invaders,{image = catImages[i], x = columnX + horizontalTile * (j-1), y = rowY - verticalTile * (i-1)})
                --[[if #invaders < columnsCount then -- solo per la prima riga
                    invaders[j]canShoot = true
                end]]
            end
        end
    end,

    update = function(dt)
        timer = timer + dt
        if timer > 0.2 then
            catX = catX + catLateralMovement
            timer = 0
        end

        if catX >= VIRTUAL_WIDTH - catWidth then
            catLateralMovement = catLateralMovement * -1
            catX = VIRTUAL_WIDTH - catWidth -5
            catY = catY + catVerticalMovent
        elseif catX <= 0 then
            catLateralMovement = catLateralMovement * -1
            catX = 5
            catY = catY + catVerticalMovent
        end
    end,

    --[[render = function()
        love.graphics.draw(catImage, catX, catY)
    end]]

    render = function()
        for index,cat in ipairs(invaders) do
            love.graphics.draw(cat.image, cat.x, cat.y)
        end
    end
  }









    -- for index,cat in ipairs(invaders) do
    --     print(index .. ' ' .. cat.x .. ' ' .. cat.y)
    -- end


    --   for index,cat in ipairs(invaders) do
--     cat:render()
-- end



  -- function Cat:render ()
  --     love.graphics.draw(self.image, self.x, self.y)
  -- end