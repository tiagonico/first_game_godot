extends CharacterBody2D

var firstLoop = true
var SPEED = 100.0
var JUMP_VELOCITY = -280.0
var walk = 1
var in_water = false
var in_oxygen_area = false
var last_velocity_y = 0
var fall_velocity_kill = 600
var water_position_y = 1243
var oxygen_velocity = 5
var oxygen_level = 100

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var game_manager = %GameManager
@onready var jump_audio = $JumpAudio
@onready var death_audio = $DeathAudio
@onready var killzone = $"../Killzone"
@onready var hud = %HUD

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if velocity.y == 0 and last_velocity_y > fall_velocity_kill:
		killzone._on_body_entered(self)

	if PlayerVariables.player_level == 3:
		if position.y > water_position_y:
			# Decrease velocity when hits the water
			if !in_water:
				velocity.y /= 10
			in_water = true
		else:
			in_water = false

		if in_water:
			SPEED = 70
			JUMP_VELOCITY = -100
			gravity = 100
			
			if oxygen_level>0 and !in_oxygen_area:
				decrease_oxygen(delta)
			if oxygen_level<100 and in_oxygen_area:
				raise_oxygen(delta)
				
			if oxygen_level < 0:
				oxygen_level = 0
				killzone._on_body_entered(self)			
		else:
			SPEED = 100
			JUMP_VELOCITY = -280
			gravity = ProjectSettings.get_setting("physics/2d/default_gravity")			
			if oxygen_level<100:
				raise_oxygen(delta)
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
	
	last_velocity_y = velocity.y
	move_and_slide()

func decrease_oxygen(delta):
	oxygen_level -= delta * oxygen_velocity
	hud.change_oxygen(oxygen_level)
	
func raise_oxygen(delta):
	oxygen_level += delta * oxygen_velocity * 5
	hud.change_oxygen(oxygen_level)		
