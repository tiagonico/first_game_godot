extends CanvasLayer

var is_paused = false
var button_selected = 1
var number_of_buttons = 2 
var red = Color(1,0,0,1)
var green = Color(0,1,0,1)

@onready var label_seconds = $LabelSeconds
@onready var label_minutes = $LabelMinutes
@onready var label_hours = $LabelHours
@onready var label_difficulty = $LabelDifficulty

@onready var sound_pause = %SoundPause
@onready var sound_unpause = %SoundUnpause
@onready var menu_change = %MenuChange
@onready var menu_back = %MenuBack
@onready var music = %Music

@onready var label_oxygen = $LabelOxygen
@onready var oxygen_bar = $OxygenBar

func _on_lifes_changed(amount):
	get_node("LabelLife").text = "x " + str(amount)

func _on_coins_changed(amount):
	get_node("LabelCoin").text = "x " + str(amount)
	
func change_oxygen(amount):
	oxygen_bar.value = amount
	
func _on_ready():
	get_node("ButtonResume").hide()
	get_node("ButtonQuit").hide()
	label_difficulty.hide()
	
	if PlayerVariables.player_level != 3:
		oxygen_bar.visible = false
		label_oxygen.visible = false
	else:
		oxygen_bar.visible = true
		label_oxygen.visible = true
	
	if Global.is_hardcore:
		label_difficulty.text = "HARDCORE"
		label_difficulty.set("theme_override_colors/font_color",red)
	else:
		label_difficulty.text = "NORMAL"
		label_difficulty.set("theme_override_colors/font_color",green)

func _on_toggle_menu():
	if is_paused:
		sound_unpause.play()
		music.stream_paused = false
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Engine.time_scale=1
		label_difficulty.hide()
		get_node("ButtonResume").hide()
		get_node("ButtonQuit").hide()	
	else:
		sound_pause.play()
		music.stream_paused = true
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Engine.time_scale=0
		label_difficulty.show()
		get_node("ButtonResume").show()
		get_node("ButtonQuit").show()
		get_node("ButtonResume").grab_focus()

	is_paused = !is_paused
	
func _on_button_resume_pressed():
	_on_toggle_menu() 

func _on_button_quit_pressed():
	_on_toggle_menu()
	PlayerVariables.reset_variables(true)
	Global.go_to_main_menu(true)
	
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
		
func button_pressed(option):
	if option == "up":
		menu_change.play()
		button_selected-=1
		if button_selected == 0:
			button_selected = number_of_buttons	
		focus_button()
	elif option == "down":
		menu_change.play()
		button_selected+=1
		if button_selected > number_of_buttons:
			button_selected = 1
		focus_button()	
	elif option == "select":
		press_button()

func _on_button_resume_mouse_entered():
	menu_change.play()
	button_selected = 1
	focus_button()

func _on_button_quit_mouse_entered():
	menu_change.play()
	button_selected = 2
	focus_button()
	
func change_time(seconds,minutes,hours):
	label_seconds.text = ":%02d" % seconds
	label_minutes.text = ":%02d" % minutes
	label_hours.text = "%02d" % hours
