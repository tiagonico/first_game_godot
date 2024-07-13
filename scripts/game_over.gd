extends Node2D

@onready var game_over = $CanvasLayer/GameOver
@onready var timer = $CanvasLayer/Timer
@onready var max_level = $CanvasLayer/MaxLevel
@onready var time = $CanvasLayer/Time

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_labels()
	timer.start()
	game_over.play()

func set_labels():
	var seconds = "%02d" % Global.get_seconds()
	var minutes = "%02d" % Global.get_minutes()
	var hours = "%02d" % Global.get_hours()
	if hours == "00":
		time.text = minutes+":"+seconds
	else:
		time.text = hours+":"+minutes+":"+seconds
	max_level.text = str(PlayerVariables.player_level)

func _on_timer_timeout():
	PlayerVariables.reset_variables(false)
	Global.go_to_main_menu(true)
