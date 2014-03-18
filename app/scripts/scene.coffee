class Scene
  initialize: () ->
    canvas = document.getElementById('scene')
    @processing = new Processing(canvas, @sketch.bind(@))

    @animalsLayer = []
    @plantsLayer = []
    @controllers = []

  addAnimal: (type, location, config) ->
    p = @processing
    @animalsLayer.push(new type(p, location, @, config))

  addPlant: (type, location, config) ->
    p = @processing
    @plantsLayer.push(new type(p, location, @, config))

    # sort plants layer by y
    @plantsLayer.sort((a,b) ->
      a.location.y - b.location.y
    )

  registerController: (controller) ->
    @controllers.push(controller)

  setup: (p) ->
    # set global settings
    # -------------------

    p.colorMode(p.HSB, 360, 100, 100, 1)

    # set size of canvas
    p.size($(window).width(), $(window).height())

    # add elements to screen
    @background = new Background(p)

    p.preloadAliveShapes()

    @lastUpdate = p.millis()

  draw: (p) ->
    # background
    @background.draw(p)

    # update objects
    dt = p.millis() - @lastUpdate
    for controller in @controllers
      controller.update(p, p.millis(), dt)
    for animal in @animalsLayer
      animal.update(p, p.millis(), dt)
    for plant in @plantsLayer
      plant.update(p, p.millis(), dt)

    # draw objects
    for controller in @controllers
      controller.draw(p)
    for animal in @animalsLayer
      animal.draw(p)
    for plant in @plantsLayer
      plant.draw(p)

    @lastUpdate = p.millis()

  sketch: (p) ->
    # extend processing
    $.extend(p, DrawingUtil)

    p.setup = @setup.bind(@, p)
    p.draw = @draw.bind(@, p)

  unload: ->
    @processing.exit()
