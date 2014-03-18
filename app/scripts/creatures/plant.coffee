#_require creature.coffee

class Plant extends Creature
  constructor: (p, spawnLocation, scene) ->
    # find a good place on the ground
    spawnLocation.x += Util.rand(-50, 50)
    spawnLocation.y = p.height - Util.rand(10, scene.background.groundHeight)
    super p, spawnLocation, scene
