extends Node2D

var mouse_position
var button_selected = 1
var number_of_buttons = 2 

@onready var button_play = $CanvasLayer/ButtonPlay
@onready var button_quit = $CanvasLayer/ButtonQuit
@onready var transition = %Transition

func _ready():
	mouse_position = get_viewport().get_mouse_position()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	focus_button()

func _process(_delta):
	if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		
	if mouse_position != get_viewport().get_mouse_position():
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_position = get_viewport().get_mouse_position()
	
	if Input.is_action_just_pressed("up"):
		button_pressed("up")
	elif Input.is_action_just_pressed("down"):
		button_pressed("down")
	elif Input.is_action_just_pressed("jump"):
		button_pressed("select")

func focus_button():
	if button_selected == 1:
		button_play.grab_focus()
		button_quit.release_focus()
	elif button_selected == 2:
		button_play.release_focus()
		button_quit.grab_focus()

func press_button():
	if button_selected == 1:
		_on_button_play_pressed()
	elif button_selected == 2:
		_on_button_quit_pressed()
		
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
	elif option == "select":
		press_button()

func _on_button_play_mouse_entered():
	button_selected = 1
	focus_button()
	
func _on_button_quit_mouse_entered():
	button_selected = 2
	focus_button()

func _on_button_play_pressed():
	transition.play("fade_out")

func _on_transition_animation_finished(_anim_name):
	PlayerVariables.reset_variables()
	Global.reset_time()
	Global.go_to_current_level()

func _on_button_quit_pressed():
	get_tree().quit()
