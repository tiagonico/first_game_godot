extends Node2D

@onready var timer = $CanvasLayer/Timer

func _on_timer_timeout():
	Global.go_to_after_loading()

func _on_ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	timer.start()
