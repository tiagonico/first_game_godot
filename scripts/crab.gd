extends Node2D

@onready var player = %Player
@onready var exausted_timer = $ExaustedTimer
@onready var running_timer = $RunningTimer
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var game_manager = %GameManager

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

	if abs(distance) < RANGE and !exausted and !game_manager.is_dead:
		if !(ray_cast_right.is_colliding() and direction == 1) and !(ray_cast_left.is_colliding() and direction == -1):
			position.x += delta * SPEED * direction
		if !running and !exausted:
			running = true
			running_timer.start()

func _on_running_timer_timeout():
	running = false
	exausted = true
	exausted_timer.start()

func _on_exausted_timer_timeout():
	exausted = false
	running = true
	running_timer.start()
