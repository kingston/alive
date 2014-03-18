class window.AliveApplication
  run: ->
    # run through initializaiton steps
    @scene = new Scene()
    @scene.initialize()

    # create keyboard controller
    @controller = new KeyboardController()
    @controller.initialize(@scene)

    # fade out opener
    window.setTimeout(->
      $("#overlay").fadeOut(500)
    , 1000)
