class Util
  @pt: (x, y) -> {x: x, y: y}

  @randInt: (min, max) -> Math.floor(Math.random() * (max - min)) + min

  @rand: (min, max) -> Math.random() * (max - min) + min

  @bound: (val, min, max) ->
    if val < min
      min
    else if val > max
      max
    else
      val

  @loop: (val, min, max) ->
    if val < min
      max
    else if val > max
      min
    else
      val

  @cycle: (time, frequency, offset) ->
    offset = offset || 0
    Math.sin(time * Math.PI * 2 / 1000.0 * frequency + offset)
