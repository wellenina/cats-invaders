Bullet = {}
Bullet.__index = Bullet

function Bullet.create(sprite, quad, x, y, direction)
  local instance = setmetatable({}, Bullet)
  instance.sprite = sprite
  instance.quad = quad
  instance.x = x
  instance.y = y
  instance.direction = direction
  return instance
end

function Bullet:render()
  love.graphics.draw(self.sprite, self.quad, self.x, self.y)
end

function Bullet:move(dt)
    self.y = self.y + BULLET_SPEED * dt * self.direction
end

function Bullet:isOffScreen()
    if self.direction == 1 then -- invaders' bullet
        return self.y > VIRTUAL_HEIGHT
    else -- player's bullet
        return self.y + BULLET_HEIGHT < 0
    end
end