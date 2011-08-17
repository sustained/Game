define [
	'client/screen/screen'

	'client/input/keyboard'

	'client/graphics/sprite'
	'client/graphics/tileset'
	'client/graphics/tilemap'

	'client/animation/tileset'

	#'app/entities/player'

	'shared/world/tiled'
	'shared/utilities/astar'
], (Screen, Keyboard, Sprite, TileSet, TileMap, TileSetAnim, TWorld, AStar) ->
	{Vector} = Math
	keyboard = Keyboard.instance()

	class Main extends Screen
		anim: null

		constructor: ->
			super

			@cam = {
				pos: [0, 0]
				top: 0
				left: 0
				right: 0
				bottom: 0
			}
			@input = @input.bind @, keyboard
		
		input: (kb) ->
			if kb.down 'up'
				@cam.pos[1] -= 4
			else if kb.down 'down'
				@cam.pos[1] += 4
			if kb.down 'left'
				@cam.pos[0] -= 4
			else if kb.down 'right'
				@cam.pos[0] += 4

		load: ->
			@inside  = new TileSet 'inside',  size: 16
			@outside = new TileSet 'outside', size: 16
			#@walkrun = new TileSet 'walkRun', size: [16, 20]

			groundTilemap = []
			bushesTilemap = []
			collisionMap  = []

			mapNumTilesX    = (1024 * 2) / 16
			mapNumTilesY    = ( 768 * 2) / 16

			screenNumTilesX = (1024 * 2) / 16
			screenNumTilesY = ( 768 * 2) / 16

			groundLayerTiles = [2, 5, 9, 10, 17, 18]
			bushesLayerTiles = [0, 0, 0, 0, 0, 0, 6]

			j = 0 ;; while j < mapNumTilesY
				groundTilemap.push []
				bushesTilemap.push []
				collisionMap.push  []

				i = 0 ;; while i < mapNumTilesX
					groundTile = groundLayerTiles[Math.floor Math.rand() * groundLayerTiles.length]
					bushesTile = bushesLayerTiles[Math.floor Math.rand() * bushesLayerTiles.length]

					groundTilemap[j].push groundTile
					bushesTilemap[j].push bushesTile
					collisionMap[j].push if bushesTile is 0 then 0 else 1

					i++
				j++

			@ground = new TileMap @outside, groundTilemap
			@bushes = new TileMap @outside, bushesTilemap

			@ground.prerender()
			@bushes.prerender()

			@collision = collisionMap

			@astar = new AStar @collision
			#@player = new Player @game
			#@renderer = new CRenderer @game.canvas, bind: @
			#@renderer.add @draw

		update: (dt, t) ->
			#@game.keyboard.update dt
			#@player.update dt, t
			@input()

			###@cam.top    = @cam.pos[1]
			@cam.bottom = @cam.pos[1] + 768
			@cam.left   = @cam.pos[0]
			@cam.right  = @cam.pos[0] + 1024

			pX = @player.pos.i
			pY = @player.pos.j
			hW = 1024 / 2
			hH =  768 / 2

			if pX - hW < 0
				@cam.pos[0] = 0
			else if pX + hW > @world.size[0]
				@cam.pos[0] = @world.size[0] - 1024
			else
				@cam.pos[0] = pX - hW

			if pY - hH < 0
				@cam.pos[1] = 0
			else if pY + hH > @world.size[1]
				@cam.pos[1] = @world.size[1] - 768
			else
				@cam.pos[1] = pY - hH###

		render: (g) ->
			g.clearRect 0, 0, 1024, 768

			g.translate -Math.round(@cam.pos[0]), -Math.round(@cam.pos[1])

			g.globalCompositeOperation = 'source-over'

			g.drawImage @ground.prerendered, 0, 0
			g.drawImage @bushes.prerendered, 0, 0

			#@player.render g

			g.translate Math.round(@cam.pos[0]), Math.round(@cam.pos[1])
