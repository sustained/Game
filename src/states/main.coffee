define [
	'client/screen/screen'

	'client/input/keyboard'

	'client/graphics/sprite'
	'client/graphics/tileset'
	'client/graphics/tilemap'

	'client/animation/tileset'

	'app/entities/player'

	'world/tiled'
	'utilities/astar'
], (Screen, Keyboard, Sprite, TileSet, TileMap, TileSetAnim, Player, TWorld, AStar) ->
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
			@tsBlob  = new TileSet 'blob',  size: 32
			@tsNinja = new TileSet 'ninja', size: 32
			@tsWalls = new TileSet 'walls', size: 32

			###wallsTilemap = [
				[40,  1,  3,  7,  3,  3,  7,  3,  5, 48]
				[40,  9, 11, 15, 11, 11, 15, 11, 13, 48]
				[40,  0,  0,  0,  0,  0,  0,  0,  0, 48]
				[40,  0,  0,  0,  0,  0,  0,  0,  0, 48]
				[40,  0,  0,  0,  0,  0,  0,  0,  0, 48]
				[40,  0,  0,  0,  0,  0,  0,  0,  0, 48]
				[37, 19, 19, 23,  0,  0, 23, 19, 19, 39]
				[45, 27, 27, 31,  0,  0, 31, 27, 27, 47]
			]###
			wallsTilemap = []
			collisionMap = []
			mapNumTilesX = (1024 * 2) / 16
			mapNumTilesY = ( 768 * 2) / 16

			j = 0 ; while j < mapNumTilesY
				wallsTilemap.push []
				collisionMap.push []
				i = 0 ; while i < mapNumTilesX
					wall = Math.random() > 0.90
					wallsTilemap[j].push(if wall then 1 else 0)
					collisionMap[j].push(if wall then 1 else 0)
					i++
				j++

			@walls = new TileMap @tsWalls, wallsTilemap
			@walls.prerender()

			@collision = collisionMap

			#@astar = new AStar @collision
			@player = new Player @game
			#@renderer = new CRenderer @game.canvas, bind: @
			#@renderer.add @draw

		update: (dt, t) ->
			keyboard.update dt
			@player.update dt, t
			@input()

			@walls.prerendered.style.left = "#{-@cam.pos[0]}px"
			@walls.prerendered.style.top = "#{-@cam.pos[1]}px"

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

			#g.drawImage @walls.prerendered, 0, 0
			#g.drawImage @bushes.prerendered, 0, 0
			#g.drawImage @walls.prerendered, 0, 0

			@player.render g

			g.translate Math.round(@cam.pos[0]), Math.round(@cam.pos[1])
