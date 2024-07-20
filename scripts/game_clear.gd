extends Node2D

@onready var winning = $CanvasLayer/Winning
@onready var timer = $CanvasLayer/Timer
@onready var time = $CanvasLayer/Time

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_labels()
	timer.start()
	winning.play()

func set_labels():
	var seconds = "%02d" % Global.get_seconds()
	var minutes = "%02d" % Global.get_minutes()
	var hours = "%02d" % Global.get_hours()
	if hours == "00":
		time.text = minutes+":"+seconds
	else:
		time.text = hours+":"+minutes+":"+seconds

func _on_timer_timeout():
	PlayerVariables.reset_variables(false)
	Global.go_to_main_menu(true)
