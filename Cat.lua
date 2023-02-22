Cat = {}
Cat.__index = Cat

function Cat.create(quads, bulletQuad, score, columnNum, x, y)
  local instance = setmetatable({}, Cat)
  instance.quads = quads
  instance.bulletQuad = bulletQuad
  instance.score = score
  instance.columnNum = columnNum
  instance.x = x
  instance.y = y
  return instance
end

function Cat:render()
  love.graphics.draw(catSprite, self.quads[frame], self.x, self.y)
end

function Cat:shoot()
  local bullet = self.bulletQuad
  local x = self.x + (catWidth - BULLET_WIDTH) * 0.5
  local y = self.y + (catHeight - BULLET_HEIGHT) * 0.5
  table.insert(bullets, Bullet.create(catBulletSprite, bullet, x, y, 1))
end