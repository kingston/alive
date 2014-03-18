#_require controller.coffee

class KeyboardController extends Controller
  leftKey: 65 # a
  rightKey: 68 # d

  initialize: (scene) ->
    super scene
    $(window).keydown((e) =>
      if e.which == @leftKey
        @moveLeft = true
        e.preventDefault()
      else if e.which == @rightKey
        @moveRight = true
        e.preventDefault()
    )
    $(window).keyup((e) =>
      if e.which == @leftKey
        @moveLeft = false
        e.preventDefault()
      else if e.which == @rightKey
        @moveRight = false
        e.preventDefault()
    )

    $(window).keypress((e) =>
      switch e.which
        when 'b'.charCodeAt(0)
          @createBird()
          e.preventDefault()
    )

  createBird: ->
    @scene.addAnimal(Bird, Util.pt(@x, @y), {})
