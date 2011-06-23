define [
	'client/screen/screen'
	
	'assets/batch'
], (Screen, Batch) ->
	class Load extends Screen
		# loading bar, not foo bar
		bar       = width: 200, height: 30
		bar.drawX = (1024 / 2) - (bar.width  / 2)
		bar.drawY = ( 768 / 2) - (bar.height / 2)
		
		constructor: ->
			super

			@assets = new Batch
			
			@assets.add @game.config.preload.image, 'image'

			@magicNumber = bar.width / @assets.length

			@assets.event.on 'loaded', => @toggle 'main'
			@assets.load()
		
		update: ->
		
		render: (g) ->
			g.clearRect 0, 0, 1024, 768
			
			g.lineWidth = 2

			g.beginPath()
			g.strokeStyle = '#202020'
			g.strokeRect bar.drawX, bar.drawY, bar.width, bar.height
			g.closePath()
			
			percentWidth = Math.round @magicNumber * @assets.isLoad
			
			g.beginPath()
			g.fillStyle = '#404040'
			g.fillRect bar.drawX, bar.drawY, percentWidth, bar.height
			g.closePath()

			g.lineWidth = 1