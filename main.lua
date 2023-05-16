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

push = require 'push'
WINDOW_WIDTH = 1280 
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
    --love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.draw()
    push:apply('start')
    
    love.graphics.printf(
        'Hello Pong!',
        0,
        --WINDOW_HEIGHT / 2-6,
        --WINDOW_WIDTH,
        VIRTUAL_HEIGHT / 2-6,
        VIRTUAL_WIDTH,
        'center'
    )

    push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    end
end