Cat = {}
Cat.__index = Cat

function Cat.create(quads, bulletImage, score, columnNum, x, y)
  local instance = setmetatable({}, Cat)
  instance.quads = quads
  instance.bulletImage = bulletImage
  instance.score = score
  instance.columnNum = columnNum
  instance.x = x
  instance.y = y
  return instance
end

function Cat:render()
  love.graphics.draw(sprite, self.quads[frame], self.x, self.y)
end

function Cat:shoot()
  local bulletImage = self.bulletImage
  local x = self.x
  local y = self.y
  table.insert(bullets, Bullet.create(bulletImage, x, y, 1))
    ---- SISTEMARE LE COORDINATE DEI PROIETTILI per centrarli:
    --[[
        local x = self.x + (catWidth - bulletWidth) * 0.5
        local y = self.y + (catHeight) - bulletHeight * 0.5
    ]]
end