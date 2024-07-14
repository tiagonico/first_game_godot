extends Node2D

const SPEED = 100.0
var direction = 1
var rng = RandomNumberGenerator.new()

@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var animated_sprite_2d = $AnimatedSprite2D

func _on_ready():
	var random_number = rng.randi_range(0,1)
	if random_number == 1:
		direction = -1
		animated_sprite_2d.flip_h = true

func _process(delta):
	if ray_cast_right.is_colliding() or ray_cast_left.is_colliding():
		direction *= -1
		animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h

	position.x += delta * SPEED * direction
