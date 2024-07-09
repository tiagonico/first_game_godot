extends CharacterBody2D

var firstLoop = true
const SPEED = 100.0
const JUMP_VELOCITY = -280.0
var walk = 1
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var game_manager = %GameManager
@onready var jump_audio = $JumpAudio
@onready var death_audio = $DeathAudio

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y < -50 and Input.is_action_just_released("jump"):
			velocity.y = -50

	if Engine.time_scale == 0:
		pass
	elif game_manager.level_pass:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite_2d.play("idle")
	elif game_manager.is_dead:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if firstLoop:
			animated_sprite_2d.play("death")
			death_audio.play()
			firstLoop = false
	else:
		
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_audio.play()

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("move_left", "move_right")
		
		if Input.is_action_just_pressed("walk"):
			walk = 0.2
		if Input.is_action_just_released("walk"):
			walk = 1
		
		if direction:
			velocity.x = direction * SPEED * walk
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		# Flip the sprite
		if direction < 0:
			animated_sprite_2d.flip_h = true
		elif direction > 0:
			animated_sprite_2d.flip_h = false
	
		# Play animations
		if !is_on_floor():
			animated_sprite_2d.play("jump")
		else:
			if direction == 0:
				animated_sprite_2d.play("idle")
			elif walk < 1:
				animated_sprite_2d.play("walk")
			else: 
				animated_sprite_2d.play("run")

	move_and_slide()
