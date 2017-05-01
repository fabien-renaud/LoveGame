function createObstacle(x, y)
    Obstacle = {}
    Obstacle.width = 25
    Obstacle.height = 25
    Obstacle.posX = love.math.random(0, x - Obstacle.width)
    Obstacle.posY = love.math.random(0, y - Obstacle.height)
    end
