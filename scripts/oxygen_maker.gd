extends Node2D

func _on_area_2d_body_entered(body):
	body.in_oxygen_area = true

func _on_area_2d_body_exited(body):
	body.in_oxygen_area = false
