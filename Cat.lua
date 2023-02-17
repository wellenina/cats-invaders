Cat = {}
Cat.__index = Cat

function Cat.create(image, bulletImage, score, columnNum, x, y)
  local instance = setmetatable({}, Cat)
  instance.image = image
  instance.bulletImage = bulletImage
  instance.score = score
  instance.columnNum = columnNum
  instance.x = x
  instance.y = y
  instance.index = 0
  return instance
end

function Cat:render()
  love.graphics.draw(self.image, self.x, self.y)
end

function Cat:shoot()
  local bulletImage = self.bulletImage
  local x = self.x
  local y = self.y
  table.insert(bullets, Bullet.create(bulletImage, x, y, 1))
  ---- SISTEMARE LE COORDINATE DEI PROIETTILI per centrarli
end