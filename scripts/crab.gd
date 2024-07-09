extends Node2D

@onready var player = %Player
@onready var exausted_timer = $ExaustedTimer
@onready var running_timer = $RunningTimer
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var game_manager = %GameManager
@onready var collision_shape_2d = $Killzone/CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D

const RANGE = 100
const SPEED = 70.0
var direction 
var running = false
var exausted = false

func _process(delta):
	var distance = player.position.x - position.x
	if distance < 0:
		direction = -1
	else:
		direction = 1
		
	if direction < 0 and !animated_sprite_2d.flip_h:
		animated_sprite_2d.flip_h = true
	elif direction > 0 and animated_sprite_2d.flip_h:
		animated_sprite_2d.flip_h = false			

	if abs(distance) < RANGE and !exausted and !game_manager.is_dead:
		if !(ray_cast_right.is_colliding() and direction == 1) and !(ray_cast_left.is_colliding() and direction == -1):
			position.x += delta * SPEED * direction
		if !running and !exausted:
			running = true
			animated_sprite_2d.play("running")
			running_timer.start()
	elif abs(distance) >= RANGE:
		running = false
		exausted = false
		running_timer.stop()		
		exausted_timer.stop()
		animated_sprite_2d.play("idle")

func _on_running_timer_timeout():
	running = false
	exausted = true
	animated_sprite_2d.play("exausted")
	collision_shape_2d.shape.size = Vector2(14,13)
	collision_shape_2d.position = Vector2(0,5)
	exausted_timer.start()

func _on_exausted_timer_timeout():
	exausted = false
	running = true
	animated_sprite_2d.play("running")
	collision_shape_2d.shape.size = Vector2(14,13)
	collision_shape_2d.position = Vector2(0,5)
	#collision_shape_2d.shape.size = Vector2(14,25)
	#collision_shape_2d.position = Vector2(0,0)
	running_timer.start()
