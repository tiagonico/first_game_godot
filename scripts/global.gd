extends Node

var current_scene = null
var max_level = 3
var coins_to_life = 20
var time = 0
var last_time_jump_pressed = 0
var is_hardcore = false
var after_loading_scene
var is_boosted = false
var music_time_on_kill = 0
var is_last_scene_settings = false
var player_dead = false

func get_seconds():
	return fmod(time, 60)
func get_minutes():
	return fmod(time, 3600) / 60
func get_hours():
	return get_minutes() / 60
func reset_time():
	time = 0
	
func get_time_from_last_jump():
	return time - last_time_jump_pressed

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	go_to_main_menu(false)
	
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()

	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene

func go_to_next_level():
	var next_level = PlayerVariables.player_level + 1
	if next_level <= max_level:
		PlayerVariables.player_level += 1
		PlayerVariables.checkpoint = 0
		goto_scene("res://scenes/level_"+str(next_level)+".tscn")
	else:
		go_to_game_clear()
		
func go_to_next_level_loading():
	var next_level = PlayerVariables.player_level + 1
	if next_level <= max_level:
		PlayerVariables.player_level += 1
		after_loading_scene = "res://scenes/level_"+str(next_level)+".tscn"
		goto_scene("res://scenes/loading.tscn")
	else:
		PlayerVariables.reset_variables(false)
		after_loading_scene = "res://scenes/menu.tscn"
		goto_scene("res://scenes/loading.tscn")
		
func go_to_current_level_loading():
	after_loading_scene = "res://scenes/level_"+str(PlayerVariables.player_level)+".tscn"
	goto_scene("res://scenes/loading.tscn")
	
func go_to_current_level():
	goto_scene("res://scenes/level_"+str(PlayerVariables.player_level)+".tscn")	
	
func go_to_after_loading():
	goto_scene(after_loading_scene)
	
func go_to_game_over():
	goto_scene("res://scenes/game_over.tscn")
	
func go_to_game_clear():
	goto_scene("res://scenes/game_clear.tscn")
	
func go_to_main_menu(play_music):
	goto_scene("res://scenes/menu.tscn")
	if play_music:
		SoundManager.play_menu_music()
	
func go_to_settings():
	goto_scene("res://scenes/settings.tscn")
	
func change_to_fullscreen(fullscreen):
	if fullscreen:
		if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
