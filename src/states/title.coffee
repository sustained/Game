define [
	'client/screen/screen'

	'shared/animation/tween'
	'shared/animation/easing'
], (Screen, Tween, Easing) ->
	{Vector} = Math

	class Title extends Screen
		constructor: ->
			super

			@el = jQuery('<div>').css {
				color: 'white'
				width: '1024px', height: '768px', lineHeight: '768px'
				position: 'absolute', top:'-768px', left:'-1024px', zIndex: 100
				#opacity: 0
				fontFamily: 'sans-serif', fontSize: '20px', textAlign: 'center'
			}
			@el.html(
				jQuery('<p>')
				.text('Press Space to Start!')
				.css({
					backgroundColor: 'red'
				})
			).appendTo('body').hide()

			@input = @input.bind @, @game.keyboard, @game.mouse

			@pos2 = new Vector(-1024, -768)
			@tween = new Tween {
				object: @, property: 'pos2'
				duration: 10, loop: 'cycle'
				start: new Vector(-1024, -768), end: new Vector(1024, 768)
				easing: 'smooth'
			}
		
		focus: -> @el.show() ; console.log @game.state.enabled
		blur:  -> @el.hide()
		
		input: (kb, ms, dt, t) ->
			if kb.down('space') and kb.life('space') > 0.25
				@game.state.disable 'title'
				@game.state.enable  'main'
		
		update: (dt, t) ->
			@game.keyboard.update dt, t
			@input dt, t

			@tween.update dt, t
			@el.css 'left', @pos2.i
			@el.css 'top',  @pos2.j
		
		render: (g) ->
			g.clearRect 0, 0, 1024, 768
