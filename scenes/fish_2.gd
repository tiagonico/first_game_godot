extends Node2D

var SPEED = 80.0
var direction = 1
var slow = false
var fast = false
@onready var timer_slow = $TimerSlow
@onready var timer_fast = $TimerFast
@onready var timer_change_direction = $TimerChangeDirection
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	timer_change_direction.start()

func _process(delta):
	if slow:
		SPEED -= delta * 50
		animated_sprite_2d.speed_scale -= delta * 0.5
	if fast:
		SPEED += delta * 50
		animated_sprite_2d.speed_scale += delta * 0.5

	position.x += SPEED * delta * direction

func _on_timer_change_direction_timeout():
	slow = true
	timer_slow.start()

func _on_timer_slow_timeout():
	direction *= -1
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	slow = false
	fast = true
	timer_fast.start()

func _on_timer_fast_timeout():
	fast = false
	timer_change_direction.start()
