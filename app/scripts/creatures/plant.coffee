#_require creature.coffee

class Plant extends Creature
  constructor: (p, spawnLocation, scene) ->
    # find a good place on the ground
    if Math.random() > 0.5
      sign = 1
    else
      sign = -1
    spawnLocation.x += Math.exp(-Util.rand(0,4)) * 200 * sign
    spawnLocation.y = p.height - Util.rand(10, scene.background.groundHeight)
    super p, spawnLocation, scene
