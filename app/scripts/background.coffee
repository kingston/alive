class Background
  constructor: (p) ->
    @skyColor = p.color(211, 26, 95)

    @groundHeight = 150
    @groundColor = p.color(15, 52, 60)

  draw: (p) ->
    # draw sky
    p.background(@skyColor)

    # draw ground
    p.fill(@groundColor)
    p.noStroke()
    p.rect(0,p.height-@groundHeight,p.width,@groundHeight)
