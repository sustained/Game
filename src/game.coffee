require [
	'client/game'
	
	'game/screens/main'
], (Game, SMain) ->
	game = new Game url:'http://192.168.0.2/Private/JS/Game/'
	
	game.event.on 'ready', ->
		game.screen.add 'main', SMain, true
		game.loop.start()
		console.log window.game = game
