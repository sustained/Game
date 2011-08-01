define [
	'client/screen/screen'
], (Screen) ->
	{Vector} = Math

	class Test extends Screen
		@COLOURS = ['red', 'green', 'blue', 'orange', 'purple']

		constructor: ->
			super

			@el = jQuery('<p />')
				.css(
					display: 'block', 'font-size': '30px', 'font-weight': 'bold'
					'background-color': Test.COLOURS[Math.round Math.random() * 4], color: 'white'
					width: '1024px', height: '768px', 'line-height': '768px', 'text-align': 'center'
					position: 'absolute', top:'0px', left:'0px', 'z-index': @zIndex
				)
				.html(@name)
				.hide()
				.appendTo('body')
		
		focus: -> @el.show()
		blur:  -> @el.hide()
		
		input: (kb, ms, dt, t) ->
			#if kb.down('space') and kb.life('space') > 0.25
			#	@manager.disable 'title'
			#	@manager.enable  'main'
		
		update: (dt, t) ->
		
		render: (g) ->
