define [
	'client/screen/screen'
	'client/input/keyboard'

	'animation/tween'
	'animation/easing'
], (Screen, Keyboard, Tween, Easing) ->
	keyboard = Keyboard.instance()
	{Vector} = Math

	class Title extends Screen
		constructor: ->
			super

			@el = jQuery('<div>')
				.css(
					'background-color': 'red'
					width: '1024px', height: '768px', 'line-height': '768px'
					position: 'absolute', top:'-768px', left:'-1024px', zIndex: 100
				)
				.appendTo('body')
			
			jQuery('<p>')
				.text('Press Space')
				.css(
					color: 'white', 'font-family': 'sans-serif', 'font-size': '40px', 'text-align': 'center'
				)
				.appendTo(@el)

			start = new Vector -1024, -768
			end   = new Vector 0, 0

			@pos = start.clone()

			#listener = =>
			#	@pos = start.clone()
			#	@tween.tim
			
			@input = @input.bind @, keyboard

			@tween = new Tween {
				object: [@, 'pos'], start: start, end: end,
				duration: 1, easing: 'quintic.inOut', "loop": "repeat"}
		
		focus: -> @el.show()
		blur:  -> @el.hide()
		
		input: (kb) ->
			if kb.down('space') and kb.life('space') > 0.25
				@manager.disable 'title'
				@manager.enable  'main'
		
		update: (dt, t) ->
			keyboard.update dt, t
			@input()

			@tween.update dt, t
			@el.css 'left', @pos.i
			@el.css 'top',  @pos.j
		
		render: (g) ->
			g.clearRect 0, 0, 1024, 768
