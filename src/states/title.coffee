define [
	'client/screen/screen'

	'shared/animation/tween'
	'shared/animation/easing'
], (Screen, Tween, Easing) ->
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

			start = new Vector 0, -(768 * 2)
			end   = new Vector 0, 0

			@pos = start.clone()

			#listener = =>
			#	@pos = start.clone()
			#	@tween.tim
				
			@tween = new Tween {
				object: [@, 'pos'], start: start, end: end,
				duration: 5, easing: 'quintic.out'}
		
		focus: -> @el.show()
		blur:  -> @el.hide()
		
		input: (kb, ms, dt, t) ->
			#if kb.down('space') and kb.life('space') > 0.25
			#	@manager.disable 'title'
			#	@manager.enable  'main'
		
		update: (dt, t) ->
			#@game.keyboard.update dt, t
			#@input dt, t

			@tween.update dt, t
			@el.css 'left', @pos.i
			@el.css 'top',  @pos.j
		
		render: (g) ->
			g.clearRect 0, 0, 1024, 768
