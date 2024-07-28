extends Node2D

const JUMP_ACCURACY = 0.2

func _on_area_2d_body_entered(body):
	if Global.get_time_from_last_jump() < JUMP_ACCURACY:
		body.velocity.y = -130
	else:
		body.velocity.y = -70
		
	Global.is_boosted = true
