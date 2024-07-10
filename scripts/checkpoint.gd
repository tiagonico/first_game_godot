extends Node2D

func _on_ready():
	if Global.is_hardcore:
		visible = false
		
func _on_body_entered(body):
	PlayerVariables.checkpoint = 1
