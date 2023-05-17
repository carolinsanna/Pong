--[[
    GD50 - Pong Remake

    -- Programa principal --
    Autora: Carolina Dias 
    @carolinsanna
    carolina.dias@one.com.br

    Originalmente desenvolvido pela Atari em 1972.
    Consiste em duas raquetes controladas por dois jogadores,
    cujo objetivo é fazer pontos na quadra do adversário,
    rebatendo a bola de forma que o adversário não consiga rebate-la de volta.
    O primeiro a atingir a pontuação 10, vence!

    Esta versão foi desenvolvida mais próxima do sistema NES do que 
    do sistema original do Atari 2600 em termos de resolução.
]]

-- push é uma lib que permite renderizar uma resolução virtual menor do que a 
-- que é realmente, utilizada para dar um aspecto mais retrô.

push = require 'push'

Class = require 'class'
require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280 
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest') --esse método impede o efeito de blur na renderização

    --utilizando a hora atual do sistema permite que o valor sempre varie na inicialização
    --aliado com o método randomseed, garante que a randomizaçao seja mesmo aleatória
    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    love.graphics.setFont(smallFont)

    --love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { --seria assim sem utilizar a lib push
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    playerOneScore = 0
    playerTwoScore = 0

    playerOneY = 30 
    playerTwoY = VIRTUAL_HEIGHT - 50

    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50,50)

    gameState = 'start'
end

function love.update(dt) --dt é reservado da linguagem para delta time
    --movimento do player 1 
    if love.keyboard.isDown('w') then
        playerOneY = math.max(0, playerOneY + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then 
        playerOneY = math.min(VIRTUAL_HEIGHT - 20, playerOneY + PADDLE_SPEED * dt)
    end

    --movimento do player 2 
    if love.keyboard.isDown('up') then
        playerTwoY = math.max(0, playerTwoY + -PADDLE_SPEED * dt )
    elseif love.keyboard.isDown('down') then 
        playerTwoY = math.min(VIRTUAL_HEIGHT - 20, playerTwoY + PADDLE_SPEED * dt)
    end 

    --movimento da bola DX e DY * dt, apenas se o game estiver em estado play
    if gameState == 'play' then 
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end

end

function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then 
            gameState = 'play'
        else 
            gameState = 'start'

            --reinicia a bola no meio da tela
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 - 2 

            --determina um a velocidade da bola com um parametro aleatório
            --or é um operator ternário da ling Lua
            ballDX = math.random(2) == 1 and 100 or - 100
            ballDY = math.random(-50, 50) * 1.5
        end
    end

end

function love.draw()
    push:apply('start')

    love.graphics.clear(40/225, 45/225, 52/255, 255/255)
    
    --[[   love.graphics.printf(
        'Hello Pong!',
        0,
        --WINDOW_HEIGHT / 2-6,
        --WINDOW_WIDTH,
        VIRTUAL_HEIGHT / 2-6,
        VIRTUAL_WIDTH,
        'center'
    )]]
    
    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf('Press start', 0, 20, VIRTUAL_WIDTH, 'center')
    else 
        love.graphics.printf('Go!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(playerOneScore), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(playerTwoScore), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    love.graphics.rectangle('fill', 10, playerOneY, 5, 20) --('preenchido', x-axis, y-axis, width, heigth)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 15, playerTwoY, 5, 20)
    love.graphics.rectangle('fill', ballX, ballY, 4, 4)


    push:apply('end')
end
