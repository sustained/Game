require [
	'shared/core'

	'client/loop'
	'client/screen/manager'
	'client/screen/screen'
	'client/graphics/canvas'

	'shared/state/state'
], (Motion, Loop, ScreenManager, Screen, Canvas, State) ->
	gloop = new Loop
	#sched  = new ScheduleManager gloop
	state = new ScreenManager
	state.autoPause = false

	canvas = new Canvas

	state.register gloop

	require [
		'app/states/load'
		'app/states/title'
		'app/states/test'
	], (SLoad, STitle, STest) ->
		state.add 'loadAudio',  SLoad
		state.add 'loadImage',  SLoad
		state.add 'loadVideo',  SLoad
		#state.add 'title', STitle
		state.add 'test1', STest
		state.add 'test2', STest
		state.add 'test3', STest

		jQuery ->
			state.forEach ((state) -> state.render = state.render.bind state, canvas.context), true

		audio = state.$ 'loadAudio'
		image = state.$ 'loadImage'
		video = state.$ 'loadVideo'

		audio.__setup toLoad: 10, loading: 'sounds'
		image.__setup toLoad: 20, loading: 'images'
		video.__setup toLoad:  5, loading: 'videos'

		audio.loaded = -> audio.toggle 'loadImage'
		image.loaded = -> image.toggle 'loadVideo'
		video.loaded = ->
			video.disable()
			state.enable 'test1'
			state.enable 'test2'
			state.enable 'test3'

		state.enable 'loadAudio'

	jQuery ->
		canvas.create()
		state.play()

		console.log window.gloop = gloop
		console.log window.state = state
		console.log window.canvas = canvas
