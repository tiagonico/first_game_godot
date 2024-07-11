extends Node

var lifes_number = 3
var coins_number = 0
var player_level = 1
var checkpoint = 0

func reset_variables(quit):
	coins_number = 0
	lifes_number = 3
	checkpoint = 0
	if quit:
		player_level = 1	
	if Global.is_hardcore:
		player_level = 1
		lifes_number = 0	
	
func lose_life():
	lifes_number-=1

func has_lifes():
	return lifes_number >= 0
	
func get_checkpoint_position():
	if player_level == 1:
		return Vector2(-315,17)
	elif player_level == 2:
		if checkpoint == 0:
			return Vector2(-1023,-555)
		elif checkpoint == 1:
			return Vector2(2516,-603)
	elif player_level == 3:
		if checkpoint == 0:
			return Vector2(488,1230)
		elif checkpoint == 1:
			return Vector2(488,1230)
		



