debug = true

PADDLE_WIDTH = 10
PADDLE_HEIGHT = 50
PADDLE_SPEED = 100

paddleOne = { x = 0,
			  y = 0,
			  color = {r = 255, g = 0, b = 0}
			}
paddleTwo = { x = love.graphics.getWidth() - PADDLE_WIDTH,
			  y = love.graphics.getHeight() - PADDLE_HEIGHT,
			  color = {r = 0, g = 0, b = 255}
			}

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255)
end

function love.update(dt)
	movePaddleOnInput(dt, paddleOne, 'w', 's')
	movePaddleOnInput(dt, paddleTwo, 'up', 'down')
end

function love.draw()
	drawPaddle(paddleOne)
	drawPaddle(paddleTwo)
end

function movePaddleOnInput(dt, paddle, upKey, downKey)
	local paddleMinY = 0
	local paddleMaxY = love.graphics.getHeight() - PADDLE_HEIGHT

	if love.keyboard.isDown(upKey) and paddle.y > paddleMinY then
		paddle.y = paddle.y - (PADDLE_SPEED * dt)
		if paddle.y < paddleMinY then
			paddle.y = paddleMinY
		end
	elseif love.keyboard.isDown(downKey) and paddle.y < paddleMaxY then
		paddle.y = paddle.y + (PADDLE_SPEED * dt)
		if paddle.y > paddleMaxY then
			paddle.y = paddleMaxY
		end
	end
end

function drawPaddle(paddle)
	love.graphics.setColor(paddle.color.r, paddle.color.g, paddle.color.b)
	love.graphics.rectangle('fill', paddle.x, paddle.y, PADDLE_WIDTH, PADDLE_HEIGHT)
end