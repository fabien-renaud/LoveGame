require('Lover')
require('Arena')
instances = 4

function love.load()
    love.window.setTitle("SNIR")
    love.window.setMode(800,800)
    createLover()
    buildArena()
    end

function love.update(dt)
    if love.keyboard.isDown("left", "q") then
        if Lover.posX > Arena.posX then
            Lover.posX = Lover.posX - (Lover.speed * dt)
            end
        end
    if love.keyboard.isDown("right", "d") then
        if Lover.posX + Lover.width  < Arena.posX + Arena.width then
            Lover.posX = Lover.posX + (Lover.speed * dt)
            end
        end
    if love.keyboard.isDown("up", "z") then
        if Lover.posY > Arena.posY then
            Lover.posY = Lover.posY - (Lover.speed * dt)
            end
        end
    if love.keyboard.isDown("down", "s") then
        if Lover.posY + Lover.height < Arena.posY + Arena.height then
            Lover.posY = Lover.posY + (Lover.speed* dt)
            end
        end

    -- speed up
    if love.keyboard.isDown("space") then
        Lover.speed = 800
    else
        Lover.speed = 200
        end
    end

function love.draw()
    -- color speed up mode
    if love.keyboard.isDown("space") then
        love.graphics.setColor(0,255,255)
    else
        love.graphics.setColor(255,255,255)
        end

    -- Ecrans :
    -- [1,2]
    -- [3,4]
    -- display screen 1
    love.graphics.rectangle("fill", Lover.posX, Lover.posY, Lover.width, Lover.height)
    love.graphics.rectangle("line", Arena.posX, Arena.posY, Arena.width, Arena.height)

    -- display screen 2
    love.graphics.rectangle("fill", Lover.posX + 400, Lover.posY, Lover.width, Lover.height)
    love.graphics.rectangle("line", Arena.posX + 400, Arena.posY, Arena.width, Arena.height)

    -- display screen 3
    love.graphics.rectangle("fill", Lover.posX, Lover.posY + 400, Lover.width, Lover.height)
    love.graphics.rectangle("line", Arena.posX, Arena.posY + 400, Arena.width, Arena.height)

    -- display screen 4
    love.graphics.rectangle("fill", Lover.posX + 400, Lover.posY + 400, Lover.width, Lover.height)
    love.graphics.rectangle("line", Arena.posX + 400, Arena.posY + 400, Arena.width, Arena.height)
    end
