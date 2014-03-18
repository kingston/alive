#mixin
DrawingUtil = {
  drawRadial: (x, y, radius, centerColor, extremeColor) ->
    for r in [radius...0]
      inter = @map(r, 0, radius, 0, 1)
      color = @lerpColor(centerColor, extremeColor, inter)
      @fill(color)
      @ellipse(x, y, r, r)

  drawRadialTransparency: (x, y, radius, color, start, end) ->
    for r in [radius...0]
      inter = @map(r, 0, radius, start, end)
      @stroke(color, inter)
      @strokeWeight(1)
      @noFill()
      @ellipse(x, y, r, r)
}
