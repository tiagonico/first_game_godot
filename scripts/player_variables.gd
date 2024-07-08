extends Node

var lifes_number = 2
var coins_number = 0
var player_level = 2

func reset_variables():
	lifes_number = 2
	coins_number = 0
	
func lose_life():
	lifes_number-=1

func has_lifes():
	return lifes_number >= 0



