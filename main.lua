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
		 xSpeed = 50,
		 ySpeed = 75,
		 color = {r = 0, g = 255, b = 0}
	   }

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255)
	math.randomseed(os.time())
end

function love.update(dt)
	movePaddleOnInput(dt, paddleOne, "w", "s")
	movePaddleOnInput(dt, paddleTwo, "up", "down")
	moveBall(dt, ball)
	checkVerticalCollisions(ball)
	checkScoringCollisions(ball)
	checkPaddleCollisions(ball, paddleOne, paddleTwo)
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

function moveBall(dt, ball)
	ball.x = ball.x + (ball.xSpeed * dt)
	ball.y = ball.y + (ball.ySpeed * dt)
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
	ball.xSpeed = 50
	ball.ySpeed = 75
end

function checkPaddleCollisions(ball, leftPaddle, rightPaddle)
	--check if ball hits rhs of leftPaddle
	if (ball.x <= (leftPaddle.x + PADDLE_WIDTH) and ball.y > (leftPaddle.y - BALL_SIZE) and ball.y < (leftPaddle.y + PADDLE_HEIGHT)) then
		ball.xSpeed = -ball.xSpeed
		print("BEFORE: xSpeed = " .. ball.xSpeed .. "; ySpeed = " .. ball.ySpeed)
		ball.xSpeed = ball.xSpeed + math.random(-50, 50)
		ball.ySpeed = ball.ySpeed + math.random(-50, 50)
		print("AFTER: xSpeed = " .. ball.xSpeed .. "; ySpeed = " .. ball.ySpeed)
	end
		
	--check if ball hits lhs of rightPaddle
	if ((ball.x + BALL_SIZE) >= rightPaddle.x and ball.y > (rightPaddle.y - BALL_SIZE) and ball.y < (rightPaddle.y + PADDLE_HEIGHT)) then
		ball.xSpeed = -ball.xSpeed
		print("BEFORE: xSpeed = " .. ball.xSpeed .. "; ySpeed = " .. ball.ySpeed)
		ball.xSpeed = ball.xSpeed + math.random(-50, 50)
		ball.ySpeed = ball.ySpeed + math.random(-50, 50)
		print("AFTER: xSpeed = " .. ball.xSpeed .. "; ySpeed = " .. ball.ySpeed)
	end
end








