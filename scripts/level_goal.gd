extends Node2D

@onready var timer = $Timer
@onready var timer_text = $TimerText
@onready var pass_level_sound = $PassLevelSound
@onready var label = $Label

const red = Color(1,0,0,1)
const yellow = Color(1,1,0,1)
var aux = 0

func _on_body_entered(_body):
	SignalManager.toggle_level_passed.emit()
	label.show()
	pass_level_sound.play()
	timer_text.start()
	timer.start()

func _on_timer_timeout():
	SignalManager.toggle_level_passed.emit()
	Global.go_to_next_level()	

func _on_timer_text_timeout():
	if(aux%2):
		label.set("theme_override_colors/font_color",red)
	else:
		label.set("theme_override_colors/font_color",yellow)
	aux+=1
	timer_text.start()
	
func _on_ready():
	label.hide()
