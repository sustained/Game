require [
	'core'

	'client/loop'
	'client/input/keyboard'
	'client/assets/image'
	'client/screen/manager'
	'client/screen/screen'
	'client/screen/loader'
	'client/graphics/canvas'

	'state/state'
], (Motion, Loop, Keyboard, Image, ScreenManager, Screen, SLoader, Canvas, State) ->
	gloop = new Loop
	#sched  = new ScheduleManager gloop
	state = new ScreenManager
	state.autoPause = false

	canvas = new Canvas

	#gloop.register _.bindAll state, {enter, leave, update}
	state.register gloop

	Image.setUrl 'assets/image/'

	require [
		'app/states/title'
		'app/states/main'
	], (STitle, SMain) ->
		state.add 'loader', SLoader
		state.add 'title', STitle
		state.add 'main', SMain

		jQuery ->
			state.forEach ((state) -> state.render = state.render.bind state, canvas.context), true

		images = state.$ 'loader'
		images.setAssets image: {
			"blob": "tilesets/characters/blob/blob"
			"ninja": "tilesets/accessories/ninja-suit"
			"walls": "tilesets/brick_walls"
			"pistolN": "sprites/weapons/pistol/n"
			"pistolE": "sprites/weapons/pistol/e"
			"pistolS": "sprites/weapons/pistol/s"
			"pistolW": "sprites/weapons/pistol/w"
		}
		images.loaded = ->
			console.log 'images loaded'
			images.toggle 'title'

		state.enable 'loader'

	jQuery ->
		canvas.create()
		state.play()

		console.log window.gloop = gloop
		console.log window.state = state
		console.log window.canvas = canvas
