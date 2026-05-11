extends Node2D

var SPEED = 150.0
var direction = 0
var go_to_right = true

@onready var timer_idle = $TimerIdle
@onready var timer_fly = $TimerFly
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	timer_idle.start()

func _on_timer_idle_timeout():
	if go_to_right:
		animated_sprite_2d.play("move_right")
		direction = 1
	else:
		animated_sprite_2d.play("move_left")
		direction = -1
		
	timer_fly.start()

func _on_timer_fly_timeout():
	animated_sprite_2d.play("idle")
	direction = 0
	go_to_right = !go_to_right
	timer_idle.start();
	
func _process(delta):
	position.x += SPEED * delta * direction
