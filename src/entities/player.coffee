define [
	'animation/tween'

	'client/assets/image'
	'client/graphics/tileset'
	'client/animation/tileset'
	'client/input/keyboard'
], (TweenAnim, Image, TileSet, TileSetAnim, Keyboard) ->
	{Vector} = Math
	{extend} = _
	{clone} = Motion.Utils.Object

	MOVEMENT = 
		none:  1 << 0
		up:    1 << 1
		right: 1 << 2
		down:  1 << 3
		left:  1 << 4

	class Blob
		anim: null
		animations: null

		constructor: ->
			@pos     = new Vector 1024 / 2, 768 / 2
			@posAnim = new Vector().copy(@pos).floor()

			animOptsWalk = duration: 0.4, tileset: TileSet.get 'blob'
			#animOptsRun  = duration: 0.125, tileset: TileSet.get 'walkrun'

			walk = (seq) -> new TileSetAnim extend animOptsWalk, sequence: seq
			#run  = (seq) -> new TileSetAnim extend animOptsRun,  sequence: seq

			# tweener for movement
			#@mover = new TweenAnim object: @, property: 'pos', active: false, duration: 1.0
			#@mover.setKeyFrames @pos.clone()

			#@mover.listener = =>
			#	@movement = MOVEMENT.none
			#	@mover.pause()
			#	@anim.reset()
			#	@anim.pause()

			@gunPositions =
				pistolN: [5, 6]
				pistolE: [22, 12]
				pistolS: [22, 15]
				pistolW: [0, 12]

			@setWeapon 'pistolS'

			@animations =
				n: walk [3]#[1, 2, 3, 4]
				e: walk [7]#[5, 6, 7, 8]
				s: walk [11]#[9, 10, 11, 12]
				w: walk [15]#[13, 14, 15, 16]
				###walk:
					up:    walk [ 1,  2,  1,  3]
					right: walk [ 4,  5,  4,  6]
					down:  walk [ 7,  8,  7,  9]
					left:  walk [10, 11, 10, 12]
				run:
					up:    run [13, 14, 13, 15]
					right: run [16, 17, 16, 18]
					down:  run [19, 20, 19, 21]
					left:  run [22, 23, 22, 24]###
			
			@input = @input.bind @, Keyboard.instance()

			@anim = @animations.s ; @anim.position = @pos
			#@anim.play()
			@facing = MOVEMENT.none
			@movement = MOVEMENT.none
			@target = new Vector
			#@change = new Vector
		
		setWeapon: (weapon) ->
			@currentGun = weapon
			@gunPos = @gunPositions[@currentGun]
			@gunImage = Image.get(@currentGun)

		input: (kb, dt, t) ->
			lifeL = 1#kb.life 'd'
			lifeR = 1#kb.life 'a'
			lifeU = 1#kb.life 'w'
			lifeD = 1#kb.life 's'

			if true #@movement is MOVEMENT.none
				#@anim.reset()
				#@anim.pause()

				running = false #kb.shiftKey is true
				#@mover.setDuration (if running then 0.05 else 1.0)
				#@change.set()
				#@target.copy(@pos).floor()

				if kb.down 'd'
					if lifeL > 0.2
						@anim = @animations.e
						@setWeapon 'pistolE'
						@pos.i += 1
						#if running then @animations.run.left else @animations.walk.left
						#@target.i -= 16
						#@facing = @movement = MOVEMENT.left
					else if @facing isnt MOVEMENT.left
						@anim.reset() ; @anim = @animations.e
					#	@facing = MOVEMENT.left
				else if kb.down 'a'
					if lifeR > 0.2
						@anim = @animations.w
						@setWeapon 'pistolW'
						@pos.i -= 1
						#if running then @animations.run.right else @animations.walk.right
						#@target.i += 16
						#@facing = @movement = MOVEMENT.right
					else if @facing isnt MOVEMENT.right
						@anim.reset() ; @anim = @animations.w
					#	@facing = MOVEMENT.right	
				else if kb.down 'w'
					if lifeU > 0.2
						@anim = @animations.n
						@setWeapon 'pistolN'
						@pos.j -= 1
						#if running then @animations.run.up else @animations.walk.up
						#@target.j -= 16
						#@facing = @movement = MOVEMENT.up
					else if @facing isnt MOVEMENT.up
						@anim.reset() ; @anim = @animations.n
					#	@facing = MOVEMENT.up
				else if kb.down 's'
					if lifeD > 0.2
						@anim = @animations.s
						@setWeapon 'pistolS'
						@pos.j += 1
						#if running then @animations.run.down else @animations.walk.down
						#@target.j += 16
						#@facing = @movement = MOVEMENT.down
					else if @facing isnt MOVEMENT.down
						@anim.reset() ; @anim = @animations.s
					#	@facing = MOVEMENT.down
				
				#if @movement isnt MOVEMENT.none
				#	console.log "position is #{@pos.debug()}"
				#	console.log "target is #{@target.debug()}"
				#	console.log "animation is ", @anim
				#	console.log "direction is #{@movement}"
				#	console.log "running is #{running}"
				#	x = Math.floor @target.i / 16
				#	y = Math.floor @target.j / 16
				#	if @game.world.collision[y][x] is 0
				#		@mover.setKeyFrames @pos.clone(), @target
				#		@anim.position.copy(@pos)
				#	else
				#		@movement = MOVEMENT.none
				
				#if not @target.isZero()
				#	console.log @pos.i, @pos.j, null, @target.i, @target.j
				#	x = Math.floor @target.i / 16
				#	y = Math.floor @target.j / 16
				#	@movement = MOVEMENT.none if @game.world.collision[y][x] isnt 0
				#@anim.play()
				@anim.position.copy @pos
			else
				#@mover.play()
				#@pos.add @change
				#@mover.update dt, t
				###if @movement is MOVEMENT.left
					#console.log 'l'
					@pos.i -= @change
				else if @movement is MOVEMENT.right
					#console.log 'r'
					@pos.i += @change
				else if @movement is MOVEMENT.up
					#console.log 'u'
					@pos.j -= @change
				else if @movement is MOVEMENT.down
					#console.log 'd'
					@pos.j += @change###
				
				#@posAnim.copy(@pos).floor()
				#console.log pos.j, @target.j
				#if @posAnim.i is @target.i and @posAnim.j is @target.j
					#console.log 'at target'
				#	@movement = MOVEMENT.none
					#@anim.pause()
					#@anim.reset()

		update: (dt, t) ->
			@input dt, t
			@anim.update dt, t

			#if @movement isnt MOVEMENT.none
			#	@mover.update dt, t
		
		render: (g) ->
			if @currentGun is 'pistolS'
				g.globalCompositeOperation = 'destination-over'

			g.drawImage @gunImage.domOb, @pos.i + @gunPos[0], @pos.j + @gunPos[1], @gunImage.width, @gunImage.height
			@anim.position.copy @pos
			@anim.render g
			g.globalCompositeOperation = 'source-over'
			return

			g.beginPath()
			g.arc @pos.i, @pos.j, 5, 0, Math.TAU, false
			g.closePath()

			g.strokeStyle = 'rgb(0, 0, 200)'
			g.stroke()

			#g.beginPath()
			#g.arc @target.i, @target.j, 5, 0, Math.TAU, false
			#g.closePath()

			#g.strokeStyle = 'rgb(200, 0, 0)'
			#g.stroke()

