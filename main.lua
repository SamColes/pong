debug = true

PADDLE_WIDTH = 10
PADDLE_HEIGHT = 50
PADDLE_SPEED = 100
BALL_SIZE = 15

paddleOne = { x = 0,
			  y = 0,
			  color = {r = 255, g = 0, b = 0},
			  score = 0
			}
paddleTwo = { x = love.graphics.getWidth() - PADDLE_WIDTH,
			  y = love.graphics.getHeight() - PADDLE_HEIGHT,
			  color = {r = 0, g = 0, b = 255},
			  score = 0
			}
			
ball = { x = (love.graphics.getWidth() / 2) - (BALL_SIZE + 2),
		 y = (love.graphics.getHeight() / 2) - (BALL_SIZE + 2),
		 xSpeed = 5,
		 ySpeed = 7,
		 color = {r = 0, g = 255, b = 0}
	   }

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255)
end

function love.update(dt)
	movePaddleOnInput(dt, paddleOne, "w", "s")
	movePaddleOnInput(dt, paddleTwo, "up", "down")
	moveBall(ball)
	checkVerticalCollisions(ball)
	checkScoringCollisions(ball)
end

function love.draw()
	drawPaddle(paddleOne)
	drawPaddle(paddleTwo)
	drawBall(ball)
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
	love.graphics.rectangle("fill", paddle.x, paddle.y, PADDLE_WIDTH, PADDLE_HEIGHT)
end

function drawBall(ball)
	love.graphics.setColor(ball.color.r, ball.color.g, ball.color.b)
	love.graphics.rectangle("fill", ball.x, ball.y, BALL_SIZE, BALL_SIZE)
end

function moveBall(ball)
	ball.x = ball.x + ball.xSpeed
	ball.y = ball.y + ball.ySpeed
end
	
function checkVerticalCollisions(ball)
	--check if ball hits top or bottom then invert y speed
	if ball.y < 0 or ball.y > (love.graphics.getHeight() - BALL_SIZE) then
		ball.ySpeed = -ball.ySpeed
	end
end
	
function checkScoringCollisions(ball)
	--if ball goes off lhs paddleTwo scores
	if ball.x < -BALL_SIZE then
		paddleTwo.score = paddleTwo.score + 1
		resetBall(ball)
	end
	
	--if ball goes off rhs player 1 scores
	if ball.x > love.graphics.getWidth() then
		paddleOne.score = paddleOne.score + 1
		resetBall(ball)
	end
end

function resetBall(ball)
	ball.x = (love.graphics.getWidth() / 2) - (BALL_SIZE + 2)
	ball.y = (love.graphics.getHeight() / 2) - (BALL_SIZE + 2)
	ball.xSpeed = 5
	ball.ySpeed = 7
end










