extends Node

@onready var player = %Player
@onready var transition = %Transition

var is_dead = false
var level_pass = false

signal lifes_changed
signal coins_changed
signal toggle_menu

func add_coin_number():
	PlayerVariables.coins_number += 1
	if PlayerVariables.coins_number == Global.coins_to_life:
		PlayerVariables.lifes_number += 1
		PlayerVariables.coins_number = 0
		lifes_changed.emit(PlayerVariables.lifes_number)
	coins_changed.emit(PlayerVariables.coins_number)

func _on_ready():
	transition.play("fade_in")
	SignalManager.player_died.connect(player_dead)
	SignalManager.toggle_level_passed.connect(toggle_level_passed)
	lifes_changed.emit(PlayerVariables.lifes_number)
	coins_changed.emit(PlayerVariables.coins_number)
	

func toggle_level_passed():
	level_pass = !level_pass

func player_dead():
	is_dead = true
	PlayerVariables.lose_life()
	if !PlayerVariables.has_lifes():
		Engine.time_scale = 1
	
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		toggle_menu.emit()
