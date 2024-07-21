@tool
extends PathFollow2D

@export var process: bool = false
@export var factor: int = 80
@onready var animated_sprite_2d = $AnimatedSprite2D

func _on_ready():
	animated_sprite_2d.flip_h = true

func _process(delta):
	if process:
		progress += delta * factor
		if progress > 280 and progress < 610:
			animated_sprite_2d.flip_h = false
		else: 
			animated_sprite_2d.flip_h = true
