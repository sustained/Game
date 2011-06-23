require [
	'client/game'
	'client/graphics/canvas'
], (Game, Canvas) ->
	window.g = game = new Game {
		url: 'http://localhost/Private/JS/Game/'
		setup: ->
			console.log 'setup fn'
		ready: ->
			console.log 'ready fn'

			@canvas = new Canvas
			@canvas.create()

			for name, state of @state.states
				state.bind 'update', null, [@loop.delta]
				state.bind 'render', null, [@canvas.context]

			@state.register()
			
			@loop.showFps()
			@loop.play()

			@state.enable 'load'
	}
