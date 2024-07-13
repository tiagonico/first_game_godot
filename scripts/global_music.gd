extends Node2D

@onready var menu_music = $MenuMusic
@onready var menu_change = $MenuChange
@onready var menu_choose = $MenuChoose
@onready var menu_back = $MenuBack
@onready var animation_player = $AnimationPlayer


func stop_menu_music():
	animation_player.play("fade_out")
	
func _on_animation_player_animation_finished(_anim_name):
	menu_music.stop()

func play_menu_music():
	menu_music.play()
	menu_music.volume_db = -20

func play_menu_change():
	menu_change.play()
		
func play_menu_choose():
	menu_choose.play()
	
func play_menu_back():
	menu_back.play()
