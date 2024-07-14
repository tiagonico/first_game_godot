extends Area2D

@onready var timer = $Timer

func _on_body_entered(_body):
	if !Global.player_dead:
		Engine.time_scale = 0.5
		Global.player_dead = true
		SignalManager.player_died.emit()
		timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1
	Global.player_dead = false
	if PlayerVariables.has_lifes():
		Global.go_to_current_level()
	else:
		if Global.is_hardcore:
			Global.go_to_game_over()
		else:
			PlayerVariables.reset_variables(false)
			Global.go_to_current_level()
