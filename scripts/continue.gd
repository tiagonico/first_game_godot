extends Node2D

var mouse_position
var button_selected = 1
var number_of_buttons = 2 

var locked = false

@onready var button_yes = $CanvasLayer/ButtonYes
@onready var button_no = $CanvasLayer/ButtonNo
@onready var animated_sprite = $CanvasLayer/AnimatedSprite2D
@onready var timer = $CanvasLayer/Timer

func _ready():
	mouse_position = get_viewport().get_mouse_position()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	focus_button()
	animated_sprite.frame = 6

func _process(_delta):
	if Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_left"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	if mouse_position != get_viewport().get_mouse_position():
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_position = get_viewport().get_mouse_position()
	
	if !locked:
		if Input.is_action_just_pressed("move_right"):
			button_pressed("right")
			SoundManager.play_menu_change()
		elif Input.is_action_just_pressed("move_left"):
			button_pressed("left")
			SoundManager.play_menu_change()
		elif Input.is_action_just_pressed("jump"):
			button_pressed("select")

func focus_button():
	if button_selected == 1:
		button_yes.grab_focus()
		button_no.release_focus()
	elif button_selected == 2:
		button_no.grab_focus()
		button_yes.release_focus()
		

func release_focus_all():
	button_yes.release_focus()
	button_no.release_focus()

func press_button():
	if button_selected == 1:
		_on_button_yes_pressed()
	elif button_selected == 2:
		_on_button_no_pressed()
		
func button_pressed(option):
	if option == "left":
		button_selected-=1
		if button_selected == 0:
			button_selected = number_of_buttons	
		focus_button()
	elif option == "right":
		button_selected+=1
		if button_selected > number_of_buttons:
			button_selected = 1
		focus_button()
	elif option == "select":
		press_button()

func _on_button_yes_pressed():
	SoundManager.play_level_clear()
	timer.start()
	locked = true
	animated_sprite.play_backwards("new_animation")

func _on_button_no_pressed():
	SoundManager.play_menu_choose()
	PlayerVariables.reset_variables(true)
	Global.go_to_main_menu(true)

func _on_timer_timeout():
	PlayerVariables.reset_variables(false)
	Global.go_to_current_level()

func _on_button_yes_mouse_entered():
	if !locked and button_selected != 1:
		SoundManager.play_menu_change()
		button_selected = 1
		focus_button()


func _on_button_no_mouse_entered():
	if !locked and button_selected != 2:
		SoundManager.play_menu_change()
		button_selected = 2
		focus_button()
