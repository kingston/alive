#_require animal.coffee

class Bird extends Animal
  constructor: (p, spawnLocation, config) ->
    super p, spawnLocation

    @bodyColor = p.color(8, 38, 99)
    @strokeColor = p.color(0,0,0)
    @width = 50
    @height = 30

  update: (p, time, dt) ->
    #
  
  draw: (p) ->
    p.pushMatrix()
    p.translate(@location.x, @location.y)
    p.fill(@bodyColor)
    p.stroke(@strokeColor)
    p.strokeWeight(2)

    p.ellipse(-@width/2,-@height/2,@width,@height)

    p.popMatrix()
