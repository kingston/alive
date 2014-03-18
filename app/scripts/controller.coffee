class Controller
  moveSpeed: 400 # pixels per second
  moveLeft: false
  moveRight: false

  initialize: (scene) ->
    @scene = scene
    p = scene.processing
    @x = p.width / 2
    @y = p.height / 2

    @color = p.color(60, 48, 92,0.05)
    @radius = 200

    # register ourselves
    scene.registerController(@)

  update: (p, time, dt) ->
    if @moveLeft
      @x -= dt * @moveSpeed / 1000.0
    if @moveRight
      @x += dt * @moveSpeed / 1000.0

    if @x < @radius
      @x = @radius
    else if @x > p.width - @radius
      @x = p.width - @radius


  draw: (p) ->
    p.pushMatrix()
    p.translate(@x, @y)

    p.drawRadialTransparency(-@width/2,-@height/2,@radius, @color, 1, 0)
    p.popMatrix()
