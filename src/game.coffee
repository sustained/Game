require [
	'client/game'
], (Game) ->
	require [
		'game/screens/main'
	], (Main) ->
		game = new Game url:'http://192.168.0.2/Private/JS/Game/'
		
		#inside  = new Img 'inside'
		#outside = new Img 'outside'
		
		Motion.event.on 'load', ->
			game.screen.add 'main', Main, true
			game.screen.register()
			
			game.loop.start()
			
			console.log window.game = game
