require [
	'shared/core'

	'client/loop'
	'client/assets/image'
	'client/screen/manager'
	'client/screen/screen'
	'client/screen/loader'
	'client/graphics/canvas'

	'shared/state/state'
], (Motion, Loop, Image, ScreenManager, Screen, SLoader, Canvas, State) ->
	gloop = new Loop
	#sched  = new ScheduleManager gloop
	state = new ScreenManager
	state.autoPause = false

	canvas = new Canvas

	state.register gloop
	
	Image.setUrl 'assets/image/'

	require [
		'app/states/title'
		'app/states/main'
	], (STitle, SMain) ->
		#state.add 'loadAudio', SLoad
		state.add 'loader', SLoader
		state.add 'main', SMain
		#state.add 'loadVideo', SLoad
		#state.add 'title', STitle
		#state.add 'main', SMain
		#state.add 'test1', STest
		#state.add 'test2', STest
		#state.add 'test3', STest

		jQuery ->
			state.forEach ((state) -> state.render = state.render.bind state, canvas.context), true

		images = state.$ 'loader'
		images.setAssets image: {
			"inside": "naughty/tilesets/inside"
			"outside": "naughty/tilesets/outside"
			"frog": "frog.jpg"
			"accept": "accept"
			"arrowRefresh": "arrow_refresh"
			"cog": "cog"
			"delete": "delete"
			"help": "help"
			"information": "information"
			#"inside": "tilesets/inside"
			#"outside": "tilesets/outside"
			#"walkRun": "sprites/animated/hero/walking and running"
		}
		images.loaded = ->
			console.log 'images loaded'
			images.toggle 'main'

		state.enable 'loader'

	jQuery ->
		canvas.create()
		state.play()

		console.log window.gloop = gloop
		console.log window.state = state
		console.log window.canvas = canvas
