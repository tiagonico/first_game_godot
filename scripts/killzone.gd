extends Area2D

@onready var timer = $Timer

func _on_body_entered(_body):
	Engine.time_scale = 0.5
	SignalManager.player_died.emit()
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1
	Global.go_to_current_level()
