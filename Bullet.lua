Bullet = {}
Bullet.__index = Bullet

function Bullet.create(image, x, y, direction)
  local instance = setmetatable({}, Bullet)
  instance.image = image
  instance.x = x
  instance.y = y
  instance.direction = direction
  return instance
end

function Bullet:render()
  love.graphics.draw(self.image, self.x, self.y)
end

function Bullet:move(dt)
    self.y = self.y + BULLET_SPEED * dt * self.direction
end

function Bullet:isOffScreen()
    if self.direction == 1 then -- invaders' bullet
        return self.y > VIRTUAL_HEIGHT
    end
    if self.direction == -1 then -- player's bullet
        return self.y + 50 < 0 -- 30 == approximate height of a bullet
    end
end