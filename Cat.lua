Cat = {}
Cat.__index = Cat

function Cat.create(quads, bulletQuad, score, columnNum, x, y, sx, ox)
  local instance = setmetatable({}, Cat)
  instance.quads = quads
  instance.bulletQuad = bulletQuad
  instance.score = score
  instance.columnNum = columnNum
  instance.x = x
  instance.y = y
  instance.sx = sx
  instance.ox = ox
  return instance
end

function Cat:render()
  love.graphics.draw(catSprite, self.quads[catFrame], self.x, self.y, 0, self.sx, 1, self.ox, 0)
end

function Cat:shoot()
  local bullet = self.bulletQuad
  local x = self.x + (catWidth - BULLET_WIDTH) * 0.5
  local y = self.y + (catHeight - BULLET_HEIGHT) * 0.5
  table.insert(invadersBullets, Bullet.create(catBulletSprite, bullet, x, y, 1))
end