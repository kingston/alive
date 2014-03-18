#_require controller.coffee

class LeapController extends Controller
  movementThreshold: 0.05

  initialize: (scene) ->
    super scene

    p = scene.processing
    @color = p.color(20, 48, 92,0.05)
    @controller = new Leap.Controller({frameEventName: "deviceFrame", enableGestures: true })
    @controller.on('connect', =>
      console.log("Leap connected!")
      @color = p.color(60, 48, 92, 0.05)
    )
    @controller.on('deviceConnected', =>
      console.log("Leap device connected!")
      @color = p.color(101, 48, 92, 0.05)
    )
    @controller.on('frame', (frame) =>
      @processFrame(frame)
    )

    @controller.connect()

  onCircle: (frame, gesture) ->
    if gesture.state != "stop" then return
    if gesture.duration < 1000 * 500 then return
    if gesture.progress < 1 then return
    @scene.addAnimal(Bird, Util.pt(@x, @y), {})

  onSwipe: (frame, gesture) ->
    if gesture.state != "stop" then return
    start = @leapToScene(frame, gesture.startPosition)
    end = @leapToScene(frame, gesture.position)

    for i in [0..Util.randInt(1,5)]
      @scene.addPlant(Grass, Util.pt(@x, @y), {})

  processFrame: (frame) ->
    # check for gestures
    for gesture in frame.gestures
      switch gesture.type
        when "circle"
          @onCircle(frame, gesture)
        when "swipe"
          @onSwipe(frame, gesture)

    # check for 5 fingered movement
    movement = false
    if frame.hands.length == 1
      hand = frame.hands[0]
      len = hand.fingers.length
      if len > 2
        y1 = @leapToScene(frame, hand.fingers[0].tipPosition)[1]
        y2 = @leapToScene(frame, hand.fingers[len - 1].tipPosition)[1]
        if y1 > y2 + @movementThreshold
          @moveLeft = true
          movement = true
        else if y2 > y1 + @movementThreshold
          @moveRight = true
          movement = true

    if movement
      return
    else
      @moveLeft = false
      @moveRight = false

  leapToScene: (frame, leapPos) ->
    iBox = frame.interactionBox
    left = iBox.center[0] - iBox.size[0] / 2
    top = iBox.center[1] + iBox.size[1] / 2
    x = leapPos[0] - left
    y = leapPos[1] - top
    x /= iBox.size[0]
    y /= iBox.size[1]
    x *= 1
    y *= 1
    return [ x, -y ]
