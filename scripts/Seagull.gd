extends Node2D

const SPEED = 50.0
var direction = 1
@onready var timer = $Timer
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	timer.start()

func _process(delta):
	position.x += delta * SPEED * direction

func _on_timer_timeout():
	direction *= -1
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	timer.start()


