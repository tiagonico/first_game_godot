extends Node2D

@onready var timer = $Timer
@onready var pass_level_sound = $PassLevelSound

func _on_body_entered(_body):
	SignalManager.toggle_level_passed.emit()
	pass_level_sound.play()
	timer.start()

func _on_timer_timeout():
	SignalManager.toggle_level_passed.emit()
	Global.go_to_next_level()
