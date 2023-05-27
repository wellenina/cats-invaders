function love.conf(t)
    t.identity = 'Cats_Invaders'
    t.version = '11.4'
    t.console = false
    t.window.title = 'Cats Invaders'
    t.window.icon = 'images/icon.png'
    t.modules.joystick = false
    t.modules.mouse = false
    t.modules.physics = false
    t.externalstorage = true
    t.window.width = 480
    t.window.height = 270
end