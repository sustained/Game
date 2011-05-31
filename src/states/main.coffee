define [
	'client/screen/screen'
	'client/renderer/canvas'

	'assets/asset'
	'assets/image'
	
	'graphics/canvas'
	'graphics/sprite'
	'graphics/tileset'
	'graphics/tilemap'
	
	'animation/tileset'
	
	'world/tiled'
], (Screen, CRenderer, Asset, Canvas, Image, Sprite, TileSet, TileMap, TileSetAnim, TWorld) ->
	{Colour} = Motion
	{Vector} = Math
	
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
		
		update: (dt, t) ->
			@player.update dt, t

			@cam.top    = @cam.pos[1]
			@cam.bottom = @cam.pos[1] + 768
			@cam.left   = @cam.pos[0]
			@cam.right  = @cam.pos[0] + 1024

			pX = @player.position[0]
			pY = @player.position[1]
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
				@cam.pos[1] = pY - hH
		
		render: (g) ->
			g.clearRect 0, 0, 1024, 768

			g.translate -Math.round(@cam.pos[0]), -Math.round(@cam.pos[1])

			g.globalCompositeOperation = 'source-over'

			g.drawImage @ground.prerendered, 0, 0
			g.drawImage @bushes.prerendered, 0, 0
			@player.render g

			g.translate Math.round(@cam.pos[0]), Math.round(@cam.pos[1])

		load: ->
			@world = @game.world = new TWorld [1024 * 4, 768 * 4]
			@world.inside  = new TileSet 'inside',  size: 16
			@world.outside = new TileSet 'outside', size: 16
			@world.walkrun = new TileSet 'walkRun', size: [16, 20]

			@player = new @game.entities[0](@game)

			groundTilemap = []
			bushesTilemap = []
			collisionMap  = []
			
			mapNumTilesX    = @world.size[0] / 16
			mapNumTilesY    = @world.size[1] / 16
			screenNumTilesX = 1024 / 16
			screenNumTilesY =  768 / 16
			
			groundLayerTiles = [2, 5, 9, 10, 17, 18]
			bushesLayerTiles = [0, 0, 0, 0, 0, 0, 6]

			j = 0 ;; while j < mapNumTilesY
				groundTilemap.push []
				bushesTilemap.push []
				collisionMap.push  []

				i = 0 ;; while i < mapNumTilesX
					groundTile = Array.random groundLayerTiles
					bushesTile = Array.random bushesLayerTiles

					groundTilemap[j].push groundTile
					bushesTilemap[j].push bushesTile
					collisionMap[j].push if bushesTile is 0 then 0 else 1

					i++
				j++
			
			@ground = new TileMap @world.outside, groundTilemap
			@bushes = new TileMap @world.outside, bushesTilemap

			@ground.prerender()
			@bushes.prerender()

			#@renderer = new CRenderer @game.canvas, bind: @
			#@renderer.add @draw
