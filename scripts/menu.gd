extends Node2D

var mouse_position
var button_selected = 1
var number_of_buttons = 3 

var panel_button_selected = 1
var panel_number_of_buttons = 2
var locked = false

@onready var button_play = $CanvasLayer/ButtonPlay
@onready var button_quit = $CanvasLayer/ButtonQuit
@onready var transition = %Transition
@onready var panel = $CanvasLayer/Panel
@onready var button_settings = $CanvasLayer/ButtonSettings
@onready var button_normal = $CanvasLayer/Panel/ButtonNormal
@onready var button_hardcore = $CanvasLayer/Panel/ButtonHardcore

@onready var menu_change = $CanvasLayer/MenuChange
@onready var menu_choose = $CanvasLayer/MenuChoose
@onready var menu_back = $CanvasLayer/MenuBack

func _ready():
	mouse_position = get_viewport().get_mouse_position()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	panel.visible = false
	focus_button()

func _process(_delta):
	if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		
	if Input.is_action_just_pressed("fullscreen"):
		Global.toggle_fullscreen()
	
	if mouse_position != get_viewport().get_mouse_position():
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_position = get_viewport().get_mouse_position()
	
	if !locked:
		if Input.is_action_just_pressed("up"):
			button_pressed("up")
			menu_change.play()
		elif Input.is_action_just_pressed("down"):
			button_pressed("down")
			menu_change.play()
		elif Input.is_action_just_pressed("jump"):
			button_pressed("select")
			menu_choose.play()
		elif Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("walk"):
			button_pressed("back")

func focus_button():
	if button_selected == 1:
		button_play.grab_focus()
		button_settings.release_focus()
		button_quit.release_focus()
	elif button_selected == 2:
		button_play.release_focus()
		button_settings.grab_focus()
		button_quit.release_focus()
	elif button_selected == 3:
		button_play.release_focus()
		button_settings.release_focus()
		button_quit.grab_focus()
		
func focus_button_panel():
	if panel_button_selected == 1:
		button_normal.grab_focus()
		button_hardcore.release_focus()
	elif panel_button_selected == 2:
		button_normal.release_focus()
		button_hardcore.grab_focus()
		
func release_focus_all():
	button_quit.release_focus()
	button_play.release_focus()
	button_settings.release_focus()

func press_button():
	if !panel.visible:
		if button_selected == 1:
			_on_button_play_pressed()
		elif button_selected == 2:
			_on_button_settings_pressed()
		elif button_selected == 3:
			_on_button_quit_pressed()
	else:
		if panel_button_selected == 1:
			_on_button_normal_pressed()
		elif panel_button_selected == 2:
			_on_button_hardcore_pressed()
		
func button_pressed(option):
	if !panel.visible:
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
	else:
		if option == "up":
			panel_button_selected-=1
			if panel_button_selected == 0:
				panel_button_selected = panel_number_of_buttons	
			focus_button_panel()
		elif option == "down":
			panel_button_selected+=1
			if panel_button_selected > panel_number_of_buttons:
				panel_button_selected = 1
			focus_button_panel()
		elif option == "back":
			menu_back.play()
			panel.visible = false
			enable_main_buttons()
			focus_button()	
		elif option == "select":
			press_button()

func disable_main_buttons():
	button_play.visible = false
	button_settings.visible = false
	button_quit.visible = false

func enable_main_buttons():	
	button_play.visible = true
	button_settings.visible = true
	button_quit.visible = true
	
func disable_panel_buttons():
	button_normal.disabled = true
	button_hardcore.disabled = true

func _on_button_play_mouse_entered():
	if !panel.visible:
		button_selected = 1
		focus_button()
	
func _on_button_settings_mouse_entered():
	if !panel.visible:
		button_selected = 2
		focus_button()
	
func _on_button_quit_mouse_entered():
	if !panel.visible:
		button_selected = 3
		focus_button()
	
func _on_button_normal_mouse_entered():
	if !locked:
		panel_button_selected = 1
		focus_button_panel()
	
func _on_button_hardcore_mouse_entered():
	if !locked:
		panel_button_selected = 2
		focus_button_panel()

func _on_transition_animation_finished(_anim_name):
	PlayerVariables.reset_variables()
	Global.reset_time()
	Global.go_to_current_level_loading()
	
func _on_button_play_pressed():
	panel.visible = true
	disable_main_buttons()
	release_focus_all()
	focus_button_panel()
	
func _on_button_quit_pressed():
	get_tree().quit()

func _on_button_settings_pressed():
	pass # Replace with function body.
	
func _on_button_normal_pressed():
	locked = true
	Global.is_hardcore = false
	transition.play("fade_out")

func _on_button_hardcore_pressed():
	locked = true
	Global.is_hardcore = true
	transition.play("fade_out")
