define [
	'core/screen'
	
	'assets/asset'
	'assets/image'
	
	'graphics/sprite'
	'graphics/tileset'
	'graphics/tilemap'
], (Screen, Asset, Image, Sprite, TileSet, TileMap) ->
	{Colour} = Motion
	{Vector} = Math
	
	class Main extends Screen
		constructor: ->
			super
		
		load: ->
			console.log 'Screen_Main - load'
			
			@inside  = new TileSet 'inside',  size: 16
			@outside = new TileSet 'outside', size: 16
			
			@ground = new TileMap @outside, [
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
				[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
			]
			
			@trees = new TileMap @outside, [
				
			]
			
			#@tilemap.prerender() vvv
		
		unload: ->
			console.log 'Screen_Main - unload'
		
		focus: ->
			console.log 'Screen_Main - focus'
		
		blur: ->
			console.log 'Screen_Main - blur'
		
		update: (dt, t) ->
		
		render: (g) ->
			g.clearRect 0, 0, 1024, 768
			
			g.drawImage @draw, 0, 0, 1024, 768
			
			#g.drawImage @inside.image.domOb,    0, 0
			#g.drawImage @outside.image.domOb, 256, 0
