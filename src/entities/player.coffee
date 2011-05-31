define [
	'graphics/tileset'

	'animation/tileset'
], (TileSet, TileSetAnim) ->
	MOVEMENT = 
		none:  0 << 1
		up:    1 << 1
		right: 2 << 1
		down:  3 << 1
		left:  4 << 1
	
	class Player
		anim: null
		position: null
		animations: null

		constructor: (@game) ->
			@position = [1024 / 2, 768 / 2]
			
			animOptsWalk = duration: 0.2, tileset: @game.world.walkrun
			animOptsRun  = duration: 0.1, tileset: @game.world.walkrun

			walk = (seq) -> new TileSetAnim Object.extend animOptsWalk, sequence: seq
			run  = (seq) -> new TileSetAnim Object.extend animOptsRun,  sequence: seq

			@animations =
				walk:
					up:    walk [ 1,  2,  1,  3]
					right: walk [ 4,  5,  4,  6]
					down:  walk [ 7,  8,  7,  9]
					left:  walk [10, 11, 10, 12]
				run:
					up:    run [13, 14, 13, 15]
					right: run [16, 17, 16, 18]
					down:  run [19, 20, 19, 21]
					left:  run [22, 23, 22, 24]
			
			@anim  = @animations.walk.down
			@input = @input.bind @, @game.keyboard, @game.mouse
		
		input: (kb, ms, dt) ->
			running  = kb.shiftKey is true
			change   = 32 * dt #(if running then 128 else 64) * dt
			movement = false
			
			if kb.keys.left
				movement = true
				@anim = if running then @animations.run.left else @animations.walk.left
				@position[0] -= change
			else if kb.keys.right
				movement = true
				@anim = if running then @animations.run.right else @animations.walk.right
				@position[0] += change
			else if kb.keys.up
				movement = true
				@anim = if running then @animations.run.up else @animations.walk.up
				@position[1] -= change
			else if kb.keys.down
				movement = true
				@anim = if running then @animations.run.down else @animations.walk.down
				@position[1] += change
			
			if @anim
				if movement is false
					@anim.reset()
					@anim.pause()
				else
					@anim.play() if @anim.paused is true
			
				@anim.position = @position
		
		update: (dt, t) ->
			@input dt
			@anim.update dt, t
		
		render: (g) ->
			@anim.render g
