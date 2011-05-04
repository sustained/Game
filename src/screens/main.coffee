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
			
			tilemap = new TileMap
			
			@images = new Image.Batch {
				inside:  'tilesets/inside'
				outside: 'tilesets/outside'
				
				playerUp:    'sprites/animated/player_up'
				playerRight: 'sprites/animated/player_right'
				playerDown:  'sprites/animated/player_down'
				playerLeft:  'sprites/animated/player_left'
			}
			
			@images.event.on 'loaded', =>
				#@tree = new Sprite 'tree', new TileSet 'outside'
				#@tree.position.set 1024 / 2, 768 / 2
				
				
				
				@enable()
			
			@images.load()
		
		update: (dt, t) ->
			
		
		render: (gfx) ->
			#@tree.render gfx, [1024 / 2, 768 / 2]
