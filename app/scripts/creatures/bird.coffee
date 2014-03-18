#_require animal.coffee

class Bird extends Animal
  flapRate: 2 # flaps per second

  constructor: (p, spawnLocation, scene, config) ->
    super p, spawnLocation, scene

    @bodyColor = p.color(8, 38, 99)
    @strokeColor = p.color(0,0,0)
    @width = 120
    @height = 60

    shape = p.getShape("bird")
    @fixedShape = shape.getChild('fixed')
    @body = shape.getChild('body')
    @body.disableStyle()
    @frontWing = shape.getChild('frontWing')
    @frontWing.disableStyle()
    @backWing = shape.getChild('backWing')
    @backWing.disableStyle()

    @offset = Math.random() * 100

    @idealHeight = Util.randInt(50, 200)

    @speed = 100 # pixels / second

  setWingHeight: (wing, height) ->
    for i in [2..4]
      wing.vertices[i][1] = height

  update: (p, time, dt) ->
    t = Util.cycle(time, @flapRate, @offset)
    @backHeight = p.map(t, -1, 1, 40, 170)
    @frontHeight = p.map(t, -1, 1, 20, 190)

    @calculateVelocity()

    @location.x += dt / 1000.0 * @speed * @dx
    @location.y += dt / 1000.0 * @speed * @dy

    @location.y = Util.bound(@location.y, 0, p.height)
    @location.x = Util.loop(@location.x, 0 - @width, @width * 2 + p.width)

  calculateVelocity: ->
    @dx = 1
    @dy = Math.max(-1, Math.min(1, (@idealHeight - @location.y)/200.0))
  
  draw: (p) ->
    p.pushMatrix()
    p.translate(@location.x - @width/2, @location.y - @width/2)
    
    if @dx > 0
      direction = 1
    else
      direction = -1

    p.scale(direction * @width / 200, @height / 100)
    p.fill(@bodyColor)
    p.stroke(@strokeColor)
    p.strokeWeight(2)

    @setWingHeight(@backWing, @backHeight)
    @setWingHeight(@frontWing, @frontHeight)

    p.shape(@backWing, 0,0,200,100)

    p.shape(@body, 0,0,200,100)
    p.shape(@fixedShape, 0,0,200,100)

    p.shape(@frontWing, 0,0,200,100)

    p.popMatrix()
