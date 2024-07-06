extends CanvasLayer

var is_paused = false

func _on_lifes_changed(amount):
	get_node("LabelLife").text = "x " + str(amount)

func _on_coins_changed(amount):
	get_node("LabelCoin").text = "x " + str(amount)
	
func _on_ready():
	get_node("ButtonResume").hide()
	get_node("ButtonQuit").hide()

func _on_toggle_menu():
	if is_paused:
		Engine.time_scale = 1
		get_node("ButtonResume").hide()
		get_node("ButtonQuit").hide()
	else:
		Engine.time_scale = 0
		get_node("ButtonResume").show()
		get_node("ButtonQuit").show()
	is_paused = !is_paused
		
func _on_button_resume_pressed():
	_on_toggle_menu() 

func _on_button_quit_pressed():
	_on_toggle_menu()
	PlayerVariables.player_level = 1
	Global.go_to_main_menu()
