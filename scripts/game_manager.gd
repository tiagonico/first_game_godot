extends Node

@onready var player = %Player
@onready var transition = %Transition
@onready var hud = %HUD
@onready var camera_2d = $"../Player/Camera2D"
@onready var music = %Music

var is_dead = false
var level_pass = false
var mouse_position

signal lifes_changed
signal coins_changed
signal toggle_menu
signal button_pressed

func add_coin_number():
	PlayerVariables.coins_number += 1
	if PlayerVariables.coins_number == Global.coins_to_life:
		PlayerVariables.lifes_number += 1
		PlayerVariables.coins_number = 0
		lifes_changed.emit(PlayerVariables.lifes_number)
	coins_changed.emit(PlayerVariables.coins_number)

func _on_ready():
	if !Global.is_hardcore:
		camera_2d.position_smoothing_enabled = false
		player.position = PlayerVariables.get_checkpoint_position()
	
	music.play(Global.music_time_on_kill)
	transition.play("fade_in")
	mouse_position = get_viewport().get_mouse_position()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	SignalManager.player_died.connect(player_dead)
	SignalManager.toggle_level_passed.connect(toggle_level_passed)
	lifes_changed.emit(PlayerVariables.lifes_number)
	coins_changed.emit(PlayerVariables.coins_number)

func toggle_level_passed():
	level_pass = !level_pass
	
func player_dead():
	is_dead = true
	Global.music_time_on_kill = music.get_playback_position()
	music.stop()
	PlayerVariables.lose_life()
	if !PlayerVariables.has_lifes():
		Engine.time_scale = 1
	
func _process(delta):
	mouse_position = get_viewport().get_mouse_position()
	camera_2d.position_smoothing_enabled = true
	
	if !level_pass:
		Global.time += delta
		hud.change_time(Global.get_seconds(),Global.get_minutes(),Global.get_hours())
	
	if Input.is_action_just_pressed("fullscreen"):
		Global.toggle_fullscreen()

	if Input.is_action_just_pressed("pause"):
		toggle_menu.emit()
		
	if hud.is_paused:
		if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down"):
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			
		if mouse_position != get_viewport().get_mouse_position():
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		if Input.is_action_just_pressed("up"):
			hud.button_pressed("up")
		elif Input.is_action_just_pressed("down"):
			hud.button_pressed("down")
		elif Input.is_action_just_pressed("jump"):
			hud.button_pressed("select")
