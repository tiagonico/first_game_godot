extends Area2D

@onready var timer = $Timer

func _on_body_entered(_body):
	Engine.time_scale = 0.5
	SignalManager.player_died.emit()
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1
	if PlayerVariables.has_lifes():
		Global.go_to_current_level()
	else:
		PlayerVariables.reset_variables(false)
		if Global.is_hardcore:
			Global.go_to_main_menu()
		else:
			Global.go_to_current_level()
