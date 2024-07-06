extends Node

@onready var player = %Player

var is_dead = false
var level_pass = false

signal lifes_changed
signal coins_changed
signal toggle_menu

func add_coin_number():
	PlayerVariables.coins_number += 1
	if PlayerVariables.coins_number == 3:
		PlayerVariables.lifes_number += 1
		PlayerVariables.coins_number = 0
		lifes_changed.emit(PlayerVariables.lifes_number)
	coins_changed.emit(PlayerVariables.coins_number)

func _on_ready():
	SignalManager.player_died.connect(player_dead)
	SignalManager.toggle_level_passed.connect(toggle_level_passed)
	lifes_changed.emit(PlayerVariables.lifes_number)
	coins_changed.emit(PlayerVariables.coins_number)

func toggle_level_passed():
	level_pass = !level_pass

func player_dead():
	is_dead = true
	PlayerVariables.lifes_number -= 1
	if PlayerVariables.lifes_number < 0:
		Engine.time_scale = 1
		PlayerVariables.player_level = 1
		Global.go_to_main_menu()
	PlayerVariables.coins_number = 0
	
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		toggle_menu.emit()
		

