pawPos = 0
local pawDir = -1

Paw = {
	updatePosition = function(__self, dt)
		pawPos = pawPos + pawDir * dt * 20
			if pawPos < -10 then
				pawDir = 1
				pawPos = -10
			elseif pawPos > 1 then
				pawDir = -1
				pawPos = 1
			end
	end,

	render = function(x, y)
		love.graphics.draw(paw, x + pawPos, y)
	end
}