Cat = {}
Cat.__index = Cat

function Cat.create(image, score, x, y)
  local instance = setmetatable({}, Cat)
  instance.image = image
  instance.score = score
  instance.x = x
  instance.y = y
  return instance
end

function Cat:render()
  love.graphics.draw(self.image, self.x, self.y)
end