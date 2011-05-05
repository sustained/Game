define [
	'core/screen'
	
	'assets/batch'
], (Screen, Batch) ->
	class Load extends Screen
		@assets:
			audio: null
			image: null
			video: null
		
		# loading bar, not foo bar
		bar =
			width:  200
			height: 30
			
		bar.drawX = (1024 / 2) - (bar.width  / 2)
		bar.drawY = ( 768 / 2) - (bar.height / 2)
		
		load:   -> console.log 'Screen_Load - load'
		unload: -> console.log 'Screen_Load - unload'
		focus:  -> console.log 'Screen_Load - focus'
		blur:   -> console.log 'Screen_Load - blur'
		
		constructor: ->
			super
			
			@assets = new Batch
			
			@assets.add Load.assets.image, 'image'
			#@assets.add Load.assets.audio, 'audio'
			#@assets.add Load.assets.video, 'video'
			
			@magicNumber = bar.width / @assets.length
			
			@assets.event.on 'loaded', => @game.screen.toggle 'load', 'main'
			@assets.load()
		
		render: (g) ->
			g.clearRect 0, 0, 1024, 768
			
			g.beginPath()
			g.lineWidth   = 2
			g.strokeStyle = '#202020'
			g.strokeRect bar.drawX, bar.drawY, bar.width, bar.height
			g.closePath()
			
			percentWidth = Math.round @magicNumber * @assets.isLoad
			
			g.beginPath()
			g.fillStyle = 'gray'
			g.fillRect bar.drawX, bar.drawY, percentWidth, bar.height
			g.closePath()
