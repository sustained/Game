require [
	'client/game'
	
	'assets/image'
], (Game, Image) ->
	require [
		'game/screens/load'
		'game/screens/main'
	], (ScreenLoad, ScreenMain) ->
		game = new Game url:'http://192.168.0.2/Private/JS/Game/'
		
		Image.setUrl Image.getUrl() + 'naughty/'
		
		ScreenLoad.assets.image =
			inside:  'tilesets/inside'
			outside: 'tilesets/outside'
			
			playerUp:    'sprites/animated/player_up'
			playerDown:  'sprites/animated/player_down'
			playerLeft:  'sprites/animated/player_left'
			playerRight: 'sprites/animated/player_right'
		
		Motion.event.on 'load', ->
			game.screen.add 'load', ScreenLoad, enable: true
			game.screen.add 'main', ScreenMain
			
			game.screen.register()
			game.loop.start()
			
			Motion.root.game = game
