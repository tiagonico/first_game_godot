extends Area2D

@onready var game_manager = %GameManager
@onready var collision_shape_2d = $CollisionShape2D
@onready var pickup_sound = $PickupSound
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer

func _on_body_entered(_body):
	game_manager.add_coin_number()
	collision_shape_2d.queue_free()
	animated_sprite_2d.queue_free()
	pickup_sound.play()
	
func _on_timer_timeout():
	queue_free()
