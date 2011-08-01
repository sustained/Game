###'client/assets/batch'
'shared/animation/tween'
'shared/animation/easing'###
define [
	'client/screen/screen'
], (Screen, Batch, Tween, Easing) ->
	{Vector} = Math
	{defaults} = _

	class Load extends Screen
		@defaults = {
			width: 1024 / 4
			height: 768 / 8
			toLoad: 0
			loading: 'assets'
		}

		constructor: ->
			super
		
		setup: (options = {}) ->
			@bar =
				w: options.width  or Load.defaults.width
				h: options.height or Load.defaults.height
			@bar.x = (1024 / 2) - (@bar.w / 2)
			@bar.y = ( 768 / 2) - (@bar.h / 2)

			@_number = 0
			@isLoad  = 0
			@toLoad  = options.toLoad  or Load.defaults.toLoad
			@loading = options.loading or Load.defaults.loading
			@magicNumber = @bar.w / @toLoad

			@_loadText = jQuery('<p>Loading <span>-1</span> of <span>Infinite</span> <span>Monkeys</span></p>')
				.css(
					display: 'block', width: '1024px', height: '768px', 'line-height': '768px'
					position: 'absolute', top: 0, left: 0, 'z-index': 1000
					color: 'white', 'font-size': '10px', 'text-align': 'center'
				)
				.hide()
				.appendTo('body')
			
			spans = jQuery 'span', @_loadText
			@textLoaded  = spans.eq 0
			@textToLoad  = spans.eq 1
			@textLoading = spans.eq 2
			
			@textLoaded.text  @isLoad
			@textToLoad.text  @toLoad
			@textLoading.text @loading

			#@assets = new Batch
			#@assets.add @game.config.preload.image, 'image'

			#@input = @input.bind @, @game.keyboard, @game.mouse

		focus: ->
			@_loadText.fadeIn 'fast'
		
		blur: ->
			@_loadText.fadeOut 'fast'
		
		load: ->
			#@assets.load()
		
		loaded: ->
			
		
		update: (delta) ->
			@manager.loop.fps()

			if @isLoad < @toLoad
				@_number += Math.min 0.25, Math.rand()
				isLoad = Math.floor @_number
				if isLoad > @isLoad
					@textLoaded.text (@isLoad = isLoad)
			else
				console.log 'done'
				@loaded()

		render: (g) ->
			g.clearRect 0, 0, 1024, 768

			g.lineWidth = 2

			g.beginPath()
			g.strokeStyle = '#101010'
			g.strokeRect @bar.x, @bar.y, @bar.w, @bar.h
			g.closePath()

			percentWidth = Math.round @magicNumber * @isLoad

			g.beginPath()
			g.fillStyle = '#202020'
			g.fillRect @bar.x, @bar.y, percentWidth, @bar.h
			g.closePath()

			g.lineWidth = 1
