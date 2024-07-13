extends Node

@onready var button_fullscreen = $CanvasLayer/Panel/ButtonFullscreen
@onready var button_back = $CanvasLayer/Panel/ButtonBack

var button_selected = 1
var number_of_buttons = 2
var mouse_position
var locked = false

func _ready():
	focus_button()
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		button_fullscreen.button_pressed = true
		
func _process(_delta):
	if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	if mouse_position != get_viewport().get_mouse_position():
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_position = get_viewport().get_mouse_position()
	

	if !locked:
		if Input.is_action_just_pressed("up"):
			button_pressed("up")
			SoundManager.play_menu_change()
		elif Input.is_action_just_pressed("down"):
			button_pressed("down")
			SoundManager.play_menu_change()
		elif Input.is_action_just_pressed("jump_joy"):
			button_pressed("select_joy")
		elif Input.is_action_just_pressed("jump"):
			button_pressed("select")
		elif Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("walk"):
			button_pressed("back")

func focus_button():
	if button_selected == 1:
		button_fullscreen.grab_focus()
		button_back.release_focus()
	elif button_selected == 2:
		button_fullscreen.release_focus()
		button_back.grab_focus()

func press_button(joy):
	if button_selected == 1:
		if joy:
			button_fullscreen.button_pressed = !button_fullscreen.button_pressed	
	elif button_selected == 2:
		_on_button_pressed()
		
func button_pressed(option):
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
	elif option == "back":
		_on_button_pressed()
	elif option == "select_joy":
		press_button(true)
	elif option == "select":
		press_button(false)

func _on_button_fullscreen_toggled(toggled_on):
	Global.change_to_fullscreen(toggled_on)

func _on_button_pressed():
	Global.is_last_scene_settings = true
	Global.go_to_main_menu(false)

func _on_button_fullscreen_mouse_entered():
	if button_selected != 1:
		SoundManager.play_menu_change()
		button_selected = 1
		focus_button()

func _on_button_back_mouse_entered():
	if button_selected != 2:
		SoundManager.play_menu_change()
		button_selected = 2
		focus_button()
