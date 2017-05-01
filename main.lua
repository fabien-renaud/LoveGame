require('Lover')
require('Obstacle')
require('Arena')
instances = 4
score = 0
screen = {}
screenX = 0
screenY = 0
timer = 10
onTheWall = false
gameOver = false
font = love.graphics.newFont(14)

function love.load()
    love.window.setTitle("SNIR")
    love.window.setMode(800,800)
    buildArena()
    createLover()
    createObstacle(Arena.width, Arena.height)
    screen[0] = 0
    screen[1]= 400
    end

function hit(m, e)
    if m.posX >= e.posX and m.posX <= e.posX + e.width and m.posY >= e.posY and m.posY <= e.posY + e.height
    or m.posX >= e.posX and m.posX <= e.posX + e.width and m.posY + m.height >= e.posY and m.posY + m.height <= e.posY + e.height
    or m.posX + m.width >= e.posX and m.posX + m.width <= e.posX + e.width and m.posY >= e.posY and m.posY <= e.posY + e.height
    or m.posX + m.width >= e.posX and m.posX + m.width <= e.posX + e.width and m.posY + m.height >= e.posY and m.posY + m.height <= e.posY + e.height then
        score = score + 3
        if timer + 5 < 10 then
            timer = timer + 5
        else
            timer = 10
            end
        createObstacle(Arena.width, Arena.height)
        screenX = screen[love.math.random(0, 1)]
        screenY = screen[love.math.random(0, 1)]
        end
    end

function love.update(dt)
    -- reset game
    if love.keyboard.isDown("r") then
        gameOver = false
        timer = 10
        score = 0
        createLover()
        createObstacle(Arena.width, Arena.height)
        end

    if gameOver == false then
        -- timer
        if timer > 0 then
            timer = timer - dt
        else
            timer = 0
            gameOver = true
            end

        -- to not leave area
        if love.keyboard.isDown("left", "q") then
            if Lover.posX - (Lover.speed * dt) > Arena.posX then
                Lover.posX = Lover.posX - (Lover.speed * dt)
            else
                LoverposX = Arena.posX
                onTheWall = true
                if score > 0 then
                    score = score - 1
                else
                    gameOver = true
                    end
                end
            end
        if love.keyboard.isDown("right", "d") then
            if Lover.posX + Lover.width + (Lover.speed * dt) < Arena.posX + Arena.width then
                Lover.posX = Lover.posX + (Lover.speed * dt)
            else
                Lover.posX = Arena.posX + Arena.width - Lover.width
                onTheWall = true
                if score > 0 then
                    score = score - 1
                else
                    gameOver = true
                    end
                end
            end
        if love.keyboard.isDown("up", "z") then
            if Lover.posY - (Lover.speed * dt) > Arena.posY then
                Lover.posY = Lover.posY - (Lover.speed * dt)
            else
                Lover.posY = Arena.posY
                onTheWall = true
                if score > 0 then
                    score = score - 1
                else
                    gameOver = true
                    end
                end
            end
        if love.keyboard.isDown("down", "s") then
            if Lover.posY + Lover.height + (Lover.speed * dt) < Arena.posY + Arena.height then
                Lover.posY = Lover.posY + (Lover.speed * dt)
            else
                Lover.posY = Arena.posY + Arena.height - Lover.height
                onTheWall = true
                if score > 0 then
                    score = score - 1
                else
                    gameOver = true
                    end
                end
            end

        -- try if Lover touch Obstacle
        hit(Lover, Obstacle)

        -- speed up
        if love.keyboard.isDown("space") then
            Lover.speed = 800
        else
            Lover.speed = 200
            end
        end
    end

function love.draw()
    -- print informations
    love.graphics.setColor(255,255,255)
    love.graphics.print("COMMANDS - z,q,s,d : move - space : speed up - r : reset", 0 , 0)
    love.graphics.print("Temps restant : "..tostring(timer), 0 , font:getHeight("X"))
    love.graphics.print("Score : "..tostring(score), 0 , font:getHeight("X") * 2)
    love.graphics.print("(c) KOREANPLAYER", 0, love.graphics:getHeight() - font:getHeight("X"))
    if gameOver == true then
        love.graphics.setColor(255,0,0)
        love.graphics.print("GAME OVER", love.graphics:getWidth() / 2 - font:getWidth("GAME OVER") / 2, love.graphics:getHeight() / 2 - font:getHeight("GAME OVER"))
        love.graphics.setColor(255,255,255)
        love.graphics.print("Score : "..tostring(score), love.graphics:getWidth() / 2 - font:getWidth("Score : "..tostring(score)) / 2, love.graphics:getHeight() / 2 + font:getHeight("Score : "..tostring(score)))
        end

    -- draw arenas
    love.graphics.rectangle("line", Arena.posX, Arena.posY, Arena.width, Arena.height)
    love.graphics.rectangle("line", Arena.posX + 400, Arena.posY, Arena.width, Arena.height)
    love.graphics.rectangle("line", Arena.posX, Arena.posY + 400, Arena.width, Arena.height)
    love.graphics.rectangle("line", Arena.posX + 400, Arena.posY + 400, Arena.width, Arena.height)

    -- speed up exception
    if love.keyboard.isDown("space") then
        love.graphics.setColor(0,255,255)
        end

    -- arena block exception
    if onTheWall == true then
        love.graphics.setColor(255,0,0)
        onTheWall = false
        end

    -- draw characters
    love.graphics.rectangle("fill", Lover.posX, Lover.posY, Lover.width, Lover.height)
    love.graphics.rectangle("fill", Lover.posX + 400, Lover.posY, Lover.width, Lover.height)
    love.graphics.rectangle("fill", Lover.posX, Lover.posY + 400, Lover.width, Lover.height)
    love.graphics.rectangle("fill", Lover.posX + 400, Lover.posY + 400, Lover.width, Lover.height)

    -- draw obstacle
    love.graphics.setColor(158,207,141)
    love.graphics.rectangle("fill", Obstacle.posX + screenX, Obstacle.posY + screenY, Obstacle.width, Obstacle.height)
    end
