extends CanvasLayer

var is_paused = false
var button_selected = 1
var number_of_buttons = 2 

func _on_lifes_changed(amount):
	get_node("LabelLife").text = "x " + str(amount)

func _on_coins_changed(amount):
	get_node("LabelCoin").text = "x " + str(amount)
	
func _on_ready():
	get_node("ButtonResume").hide()
	get_node("ButtonQuit").hide() 

func _on_toggle_menu():
	if is_paused:
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Engine.time_scale=1
		get_node("ButtonResume").hide()
		get_node("ButtonQuit").hide()
	else:
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Engine.time_scale=0
		get_node("ButtonResume").show()
		get_node("ButtonQuit").show()
		get_node("ButtonResume").grab_focus()
	is_paused = !is_paused
		
func _on_button_resume_pressed():
	_on_toggle_menu() 

func _on_button_quit_pressed():
	_on_toggle_menu()
	PlayerVariables.player_level = 1
	Global.go_to_main_menu()

func focus_button():
	if button_selected == 1:
		get_node("ButtonResume").grab_focus()
		get_node("ButtonQuit").release_focus()
	elif button_selected == 2:
		get_node("ButtonResume").release_focus()
		get_node("ButtonQuit").grab_focus()

func press_button():
	if button_selected == 1:
		_on_button_resume_pressed()
	elif button_selected == 2:
		_on_button_quit_pressed()
		
func _on_game_manager_button_pressed(option):
	if option == "up":
		button_selected-=1
		if button_selected == 0:
			button_selected = number_of_buttons	
		focus_button()
	elif option == "down":
		button_selected+=1
		if button_selected > number_of_buttons:
			button_selected = 1
		focus_button()	
	elif option == "select":
		press_button()

func _on_button_resume_mouse_entered():
	button_selected = 1
	focus_button()

func _on_button_quit_mouse_entered():
	button_selected = 2
	focus_button()
