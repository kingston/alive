#_require plant.coffee

class Grass extends Plant
  swayRate: 0.01

  constructor: (p, spawnLocation, scene) ->
    super p, spawnLocation, scene
    b = Util.randInt(50, 80)
    @color = p.color(100, 54, b)
    @width = 10

    @height = 100
    @grassShape = p.getShape('grass').getChild('stem')
    @grassShape.disableStyle()

    @tipX = Util.randInt(-10, 30)
    @tipY = Util.randInt(-70, 50)

    @scale = 0

  setGrassTip: (shape, x, y) ->
    for i in [2..4]
      shape.vertices[i][0] = x
      shape.vertices[i][1] = y

  update: (p, time, dt) ->
    if @scale < 1
      @scale += (1-@scale) * dt / 500.0
    #@tiltedTipX = @tipX + 10 * Util.cycle(time, @swayRate)

  draw: (p) ->
    p.pushMatrix()
    p.translate(@location.x-@width/2, @location.y)
    p.scale(1, @scale)
    p.stroke(p.color(0,0,0))
    p.fill(@color)
    @setGrassTip(@grassShape, @tipX, @tipY)
    p.shape(@grassShape,0,-100,10,100)
    p.popMatrix()
