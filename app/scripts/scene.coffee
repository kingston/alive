class Scene
  initialize: () ->
    canvas = document.getElementById('scene')
    @processing = new Processing(canvas, @sketch.bind(@))
    # extend processing
    $.extend(@processing, DrawingUtil)

    @animalsLayer = []
    @controllers = []

  addAnimal: (type, location, config) ->
    p = @processing
    @animalsLayer.push(new type(p, location, config))

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

    # draw objects
    for controller in @controllers
      controller.draw(p)
    for animal in @animalsLayer
      animal.draw(p)

    @lastUpdate = p.millis()

  sketch: (p) ->
    p.setup = @setup.bind(@, p)
    p.draw = @draw.bind(@, p)

  unload: ->
    @processing.exit()
