require [
	'client/game'

	'core/loop'

	'graphics/canvas'
], (CGame, Loop, Canvas) ->
	game = new CGame {
		url: 'http://192.168.0.2/Private/JS/Game/',
		ready: ->
			@canvas = new Canvas
			@canvas.create()

			for name, state of @state.states
				state.bind 'update', null, [@loop.delta]
				state.bind 'render', null, [@canvas.context]
			
			@state.enable 'load'
			@state.register()

			Loop.INTERVAL_WAIT = 5
			
			@loop.showFps()
			@loop.start()
	}
