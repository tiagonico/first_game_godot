extends Node

var current_scene = null
var max_level = 2
var coins_to_life = 20
var time = 0
var is_hardcore = false

func get_seconds():
	return fmod(time, 60)
func get_minutes():
	return fmod(time, 3600) / 60
func get_hours():
	return get_minutes() / 60
func reset_time():
	time = 0

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	go_to_main_menu()
	
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
		goto_scene("res://scenes/level_"+str(next_level)+".tscn")
	else:
		PlayerVariables.reset_variables()
		go_to_main_menu()
		
func go_to_current_level():
	goto_scene("res://scenes/level_"+str(PlayerVariables.player_level)+".tscn")
	
func go_to_main_menu():
	goto_scene("res://scenes/menu.tscn")
	
func toggle_fullscreen():
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
